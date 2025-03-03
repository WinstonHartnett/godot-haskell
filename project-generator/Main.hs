{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE MultiWayIf #-}

{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TupleSections #-}

module Main where

import           Control.Applicative         ((<|>),Applicative(liftA2))
import           Control.Concurrent          (threadDelay)
import           Control.Lens                hiding (from)
import           Control.Lens.TH
import           Control.Monad

import qualified Data.Attoparsec.Text        as P
import           Data.Char
import           Data.Either                 (fromRight)
import           Data.Functor                (($>))
import qualified Data.HashMap.Lazy           as M
import           Data.List
import           Data.Maybe
import qualified Data.Set                    as S
import           Data.String.Interpolate
import qualified Data.Text                   as T
import qualified Data.Text.Encoding          as T
import qualified Data.Text.IO                as T
import qualified Data.Vector                 as V
import qualified Data.Vector.Algorithms.Heap as V

import           Godot.Parser.Resource       as P
import           Godot.Parser.Resource.Lens  as P

import qualified Language.Haskell.TH.Syntax  as TH

import           Path.Text

import           Prelude                     hiding (id)

import qualified RawFilePath                 as FP

import           System.Directory
import           System.Environment
import           System.FSNotify
import           System.FilePath.Text        hiding ((<.>),(</>))

-- newtype Id =
--   Id
--   { unId :: T.Text
--   }
--   deriving (Eq,Ord)
--   deriving newtype (Show)
-- newtype Name =
--   Name
--   { unName :: T.Text
--   }
--   deriving (Eq,Ord)
--   deriving newtype (Show)
-- newtype Method =
--   Method
--   { unMethod :: T.Text
--   }
--   deriving (Eq,Ord)
--   deriving newtype (Show)
-- newtype Signal =
--   Signal
--   { unSignal :: T.Text
--   }
--   deriving (Eq,Ord)
--   deriving newtype (Show)
-- newtype Ty =
--   Ty
--   { unTy :: T.Text
--   }
--   deriving (Eq,Ord)
--   deriving newtype (Show)
-- newtype NodePath =
--   NodePath
--   { unNodePath :: T.Text
--   }
--   deriving (Eq,Ord)
--   deriving newtype (Show)
data Generator =
  Generator
  { -- | Scenes with Haskell root nodes
    _generatorTscnFiles         :: M.HashMap (Path Rel File) P.TscnParsed
    -- | Gdnative files pointing to Haskell libs
  , _generatorGdnsFiles         :: M.HashMap (Path Rel File) P.GdnsParsed
    -- | Haskell libraries
  , _generatorRegisteredGdnlibs :: S.Set T.Text
  , _generatorProjectFolder     :: Path Abs Dir
  , _generatorGameFolder        :: Path Abs Dir
  }
  deriving Show

makeLenses ''Generator

allByExtension :: T.Text -> Path Abs Dir -> IO [Path Abs File]
allByExtension ext dir = do
  let bytePath = T.encodeUtf8 $ toFilePath dir
  b <- FP.doesDirectoryExist bytePath
  if b
    then do
      entries <- FP.listDirectory bytePath
      files <- convertToPath parseRelFile <$> filterM FP.doesFileExist entries
      dirs <- convertToPath parseRelDir <$> filterM FP.doesDirectoryExist entries
      let tscns = filter (\f -> fromRight "" (fileExtension f) == ".tscn") files
      (tscns ++) . concat <$> mapM (allByExtension ext) dirs
    else pure []
  where
    convertToPath
      :: (T.Text -> Either PathError (Path Rel t)) -> [FP.RawFilePath] -> [Path Abs t]
    convertToPath convFunc =
      map (dir </>) . mapMaybe (either (const Nothing) Just . convFunc . T.decodeUtf8)

main :: IO ()
main = do
  args <- getArgs
  unless (length args == 2)
    (error "Usage: godot-haskell-project-generator <project directory> <output directory>")
  let [inDir, outDir] = args
      regenerate      = do
        tscns <- allByExtension ".tscn" (T.pack inDir)
        gdnss <- allByExtension ".gdns" (T.pack inDir)
        pure ()
        -- TODO ByteString path
  pure ()

support =
  [i|
{-# OPTIONS_GHC -Wno-name-shadowing #-}
{-# LANGUAGE LambdaCase #-}

module Glue.Support where

import           Prelude
import           Control.Lens
import           Control.Monad

import           Data.Coerce
import           Data.List
import qualified Data.Map                      as M
import           Data.Maybe
import qualified Data.Text                     as T
import           Data.Typeable

import           GHC.TypeLits

import           Godot
import           Godot.Core.Object
import           Godot.Core.PackedScene
import           Godot.Core.ResourceLoader
import           Godot.Gdnative
import           Godot.Gdnative.Internal.Types
import           Godot.Internal.Dispatch       as D

import           Language.Haskell.TH
import           Language.Haskell.TH.Datatype

-- * Helper to keep Haskell types in sync with the Godot project.
newtype PackedScene' (scene :: Symbol) = PackedScene' PackedScene
  deriving newtype AsVariant

instance HasBaseClass (PackedScene' scene) where
  type BaseClass (PackedScene' scene) = PackedScene

  super = coerce

deriveBase ''PackedScene'

-- | Use this to register all of your classes, it makes sure that you don't
-- forget a class that Godot needs.
--
-- exports :: GdnativeHandle -> IO ()
-- exports desc = registerAll' @Nodes @'[HUD, Main, Mob, Player] desc
registerAll'
  :: forall (res :: [*]) (ns :: [*]). ImplementedInHaskell res ns => GdnativeHandle -> IO ()
registerAll' = fill @res @ns

-- | A safe version of getNode; gives you back the Godot object
-- getNode' @"MobPath/MobSpawnLocation" self
getNode' :: forall label b cls scene name.
         ( Object :< cls
         , Node :< cls
         , Node :< b
         , NodeInScene scene name cls
         , SceneNode scene label
         , SceneNodeType scene label ~ b
         , KnownSymbol label)
         => cls
         -> IO b
getNode' o = getNode @(SceneNodeType scene label) o (T.pack $ symbolVal (Proxy @label))

-- | A safe version of getNodeNativeScript; gives you back the Haskell object
-- getNodeNativeScript' @"HUD" self
getNodeNativeScript'
  :: forall label b cls scene name scene' label'.
  ( NativeScript b
  , Node :< cls
  , Object :< cls
  , NodeInScene scene name cls
  , SceneNodeIsHaskell scene label ~ 'Just '(scene', label')
  , NodeInScene scene' label' b
  , KnownSymbol label)
  => cls
  -> IO b
getNodeNativeScript' cls = getNodeNativeScript @b cls (T.pack $ symbolVal (Proxy @label))

-- | A safe version of emit_signal; will error at compile time if the signal doesn't exist
-- emit_signal' @"hit" self []
-- TODO We don't check arguments yet!
emit_signal' :: forall label args cls.
             (Object :< cls, Object :< cls, NodeSignal cls label args, KnownSymbol label)
             => cls
             -> [Variant 'GodotTy]
             -> IO ()
emit_signal' cls args = do
  name <- toLowLevel (T.pack $ symbolVal (Proxy @label))
  emit_signal cls name args

-- | A safe version of await; will error at compile time if the signal and nodes don't exist
-- await' @"MessageTimer" @"timeout" self $ \\self' -> pure ()
await' :: forall (label :: Symbol) (signal :: Symbol) a b cls scene name.
       ( NodeInScene scene name cls
       , NativeScript cls
       , KnownSymbol label
       , KnownSymbol signal
       , SceneNode scene label
       , Node :< cls
       , AsVariant a
       , Node :< SceneNodeType scene label
       , NodeSignal b signal '[]
       , SceneNodeType scene label ~ b)
       => cls
       -> (cls -> IO a)
       -> IO ()
await' o f = do
  n <- getNode' @label o
  await o n (T.pack $ symbolVal (Proxy @signal)) f

-- | Preload a scene so you can instantiate it later.
-- Use this when the scene is known ahead of time. Store scenes in as @PackedScene' "SceneName"@
preloadScene
  :: forall scene. (KnownSymbol scene, SceneResourcePath scene) => IO (PackedScene' scene)
preloadScene = do
  Just r <- getSingleton @ResourceLoader
  path <- toLowLevel $ sceneResourcePath @scene
  PackedScene' <$> (tryCast' =<< load r path Nothing Nothing)

-- | Create an instance of a scene from a @PackedScene' "SceneName"@
-- Makes sure that you are getting the type of the scene root.
sceneInstance :: forall scene o.
              (Node :< o, Typeable o, AsVariant o, SceneNodeType scene (SceneRootNode scene) ~ o)
              => PackedScene' scene
              -> IO o
sceneInstance e = tryCast' =<< instance' e Nothing

-- | Combines nodeMethod with getNode' to call functions in a type-safe way
-- Provides no additional safety compared to using the two separately, but does clean up code a bit.
-- For example: fn @"MyNode" @"hide" self
fn :: forall (node :: Symbol) (func :: Symbol) scene name cls args ret b.
   ( Object :< cls
   , Node :< cls
   , Node :< SceneNodeType scene node
   , NodeInScene scene name cls
   , SceneNode scene node
   , NodeMethodSuper (SceneNodeType scene node) func args ret
   , ListToFun args ret ~ IO b
   , KnownSymbol node)
   => cls
   -> IO b
fn self = nodeMethod' @_ @func =<< getNode' @node self

-- | Get the file path to the scene
class SceneResourcePath (scene :: Symbol) where
  sceneResourcePath :: forall scene. T.Text

-- * Internal helpers: You won't use these
-- | The root node of a scene
class SceneRoot (scene :: Symbol) where
  type SceneRootNode scene :: Symbol

-- | A node in the scene, we know its type and its name, @s@ is the path relate
-- to the scene
class ( Typeable (SceneNodeType scene s)
      , AsVariant (SceneNodeType scene s)
      , Object :< SceneNodeType scene s) => SceneNode (scene :: Symbol) (s :: Symbol) where
  type SceneNodeType scene s :: *

  type SceneNodeName scene s :: Symbol

  type SceneNodeIsHaskell scene s :: Maybe (Symbol, Symbol)

-- | You declare this for your types. You offer up a haskell type, @n@, for the
-- node. This class verifies that your base class is correct.
class (HasBaseClass n, BaseClass n ~ SceneNodeType scene s)
  => NodeInScene (scene :: Symbol) (s :: Symbol) n | scene s -> n, n -> scene s

-- | A connection between nodes in a scene. @from@ and @to@ are paths.
-- It connects @signal@ in @from@ to @method@ in @to@.
class SceneConnection (scene
                       :: Symbol) (from
                                   :: Symbol) (signal :: Symbol) (to :: Symbol) (method :: Symbol)

-- | Internal, just for convenience
data OneResourceNode (resource :: Symbol) (name :: Symbol)

-- | Internal. Don't touch this and don't make instances of it. It's the
-- workhorse for making sure that you are implementing all of the classes that
-- Godot needs, nothing more and nothing less.
class ImplementedInHaskell (a :: [*]) (b :: [*]) where
  fill :: GdnativeHandle -> IO ()

instance ImplementedInHaskell '[] '[] where
  fill _ = pure ()

registerOne :: forall ty. (NativeScript ty, AsVariant (BaseClass ty)) => GdnativeHandle -> IO ()
registerOne desc = registerClass $ RegClass desc $ classInit @ty

instance ( NodeInScene scene name n
         , NativeScript n
         , AsVariant (BaseClass n)
         , ImplementedInHaskell t t'
         , SceneNodeIsHaskell scene name ~ 'Just '(resource, name))
  => ImplementedInHaskell (OneResourceNode resource name ': t) (n ': t') where
  fill handle = do
    registerOne @n handle
    fill @t @t' handle

-- | Create a signal
-- TODO args ~ '[] is temproary, we need signeltons to reflect this into a runtime value
signal' :: forall cls label args.
        (NodeSignal cls label args, KnownSymbol label, args ~ '[])
        => (Text, [SignalArgument])
signal' = signal (T.pack $ symbolVal (Proxy @label)) []

createMVarProperty'
  :: (Typeable ty, AsVariant ty)
  => Text
  -> (node -> MVar ty)
  -- ^ We typically can't do IO (for initialisation) when calling this, in
  -- which case we need to annotate the type without providing a value.
  -> Either VariantType ty
  -> ( node
       -> IO ty
     , node
       -> ty
       -> IO ()
     , Maybe ( Object
               -> node
               -> IO GodotVariant
             , Object
               -> node
               -> GodotVariant
               -> IO ()
             , PropertyAttributes))
createMVarProperty' name fieldName tyOrVal = (readMVar . fieldName, \\c t -> propertySetter p
  undefined c
  =<< toGodotVariant t, Just (propertyGetter p, propertySetter p, propertyAttrs p))
  where
    p = createMVarProperty name fieldName tyOrVal

appsT :: Type -> [Type] -> Type
appsT t []     = t
appsT t (x:xs) = appsT (AppT t x) xs

-- | Verify that the signal connects to an endpoint that exists and has the right type.
witnessConnection
  :: forall (scene
             :: Symbol) (from
                         :: Symbol) (signal
                                     :: Symbol) (to :: Symbol) (method :: Symbol) parent sigTy hTy.
  ( SceneNode scene to
  , NodeSignal parent signal sigTy
    -- TODO This the check unsound, but SceneNodeType isn't right for this constraint. What is?
    -- The warning produced because 'from' is not used is a reminder of this issue.
    -- parent :< SceneNodeType scene from,
  , NodeMethod hTy method sigTy (IO ())
  , NodeInScene scene to hTy)
  => ()
witnessConnection = ()

-- | Sets up a class
class NodeInit n where
  init :: BaseClass n -> IO n

-- | You never implement this. It's a helper so that we can have a more
-- polymorphic call to nodeMethod which will work when the method is implemneted
-- for any parent of the current node.
class NodeMethodSuper node (name :: Symbol) (args :: [*]) (ret :: *)
  | node name -> args, node name -> ret where
  nodeMethod' :: node -> ListToFun args ret

-- | An instance that supports calling nodeMethod' on your parents This can lead
-- to infinite loops in the type checker on error, so we isolate it in
-- NodeMethodSuper instead of NodeMethod.
instance {-# OVERLAPPABLE #-}(NodeMethod (BaseClass node) name arg ret, HasBaseClass node)
  => NodeMethodSuper node name arg ret where
  nodeMethod' = nodeMethod' @node @name @arg @ret

mkProperty' :: forall node (name :: Symbol) ty.
            (NodeProperty node name ty 'False, KnownSymbol name)
            => ClassProperty node
mkProperty' = ClassProperty (T.pack $ symbolVal (Proxy @name)) a s g
  where
    (_, _, Just (g, s, a)) = nodeProperty @node @name @ty @'False

deriveInheritance :: Name -> String -> String -> Q [Dec]
deriveInheritance ty scene sceneNode = do
  inh <- deriveBase ty
  sin <- [d|instance NodeInScene $(pure
                                 $ LitT
                                 $ StrTyLit scene) $(pure
                                                   $ LitT
                                                   $ StrTyLit sceneNode) $(pure $ PromotedT ty)#{end}
  pure $ inh <> sin

deriveHasBase :: Name -> Q [Dec]
deriveHasBase ty = do
  rdt <- reifyDatatype ty
  let base = case datatypeCons rdt of
        (c:_) -> case (constructorFields c, constructorVariant c) of
          (ConT baseTy:_, RecordConstructor (baseFn:_)) -> Just (baseTy, baseFn)
          _ -> Nothing
        _     -> Nothing
  case base of
    Just (baseTy, baseFn)
      -> [d|instance HasBaseClass $(pure $ PromotedT ty) where
              type BaseClass $(pure $ PromotedT ty) = $(pure $ PromotedT baseTy)

              super = $(pure $ VarE baseFn)#{end}
    _ -> error "deriveHasBase can only handle records whose first field is the Godot base class. You can still interface with Godot, but you will need to set things up manually."

-- | You should use this as:
--   deriveHasBase ''Ty
--   deriveBase ''Ty
--   setupNode ''Ty
-- This will instantiate everything that your Object needs
setupNode :: Name -> Q [Dec]
setupNode ty = do
  -- Collect information about all scenes
  tree <- map unTree . classInstances <$> reify ''(:<)
  sceneRoots <- M.fromList . map unSceneRootNode . familyInstances <$> reify ''SceneRootNode
  sceneNodes <- map unSceneNodeType . familyInstances <$> reify ''SceneNodeType
  haskellNodes <- map unNodeInScene . classInstances <$> reify ''NodeInScene
  allSignals <- map unNodeSignal . classInstances <$> reify ''NodeSignal
  -- Collect information about our node
  rdt <- reifyDatatype ty
  let (scene, sceneNode, _) = head $ filter (\\i -> i ^. _3 == ty) haskellNodes
  --
  methods <- filter (\\i -> i ^. _1 == ty) . mapMaybe unNodeMethod . classInstances
    <$> reify ''NodeMethod
  properties <- filter (\\i -> i ^. _1 == ty) . mapMaybe unNodeProperty . classInstances
    <$> reify ''NodeProperty
  let signals = filter (\\i -> i ^. _1 == ty) allSignals
  connections
    <- filter (\\i -> i ^. _1 == scene && i ^. _4 == sceneNode) . map unConnect . classInstances
    <$> reify ''SceneConnection
  -- Helpers
  let parentsOf cls = map snd $ filter (\\(c, _) -> cls == c) tree
  let nodeToType :: String -> String -> Name
      nodeToType scene node = case (hty, ty ^. _4) of
        (Just t, _)      -> t
        (_, Nothing)     -> ty ^. _3
        (_, Just scene') -> case M.lookup scene' sceneRoots of
          Nothing    -> error
            $ "Looking up the root of a scene that is lacking one. This is a bug. "
            ++ show (scene', scene, node)
          Just node' -> nodeToType scene' node'
        where
          ty  = fromJust $ find (\\n -> n ^. _1 == scene && n ^. _2 == node) sceneNodes

          hty = (^. _3) <$> find (\\n -> n ^. _1 == scene && n ^. _2 == node) haskellNodes
  let resolveSignalActualClass scene from signal =
        case mapMaybe (\\p -> (p, ) <$> find (\\s -> s ^. _2 == signal && s ^. _1 == p) allSignals)
        $ parentsOf (nodeToType scene from) of
          -- The root issue is that the signal might not yet exist.
          -- If witnessConnection was not unsound, this would not be needed as the error would happen later.
          []    -> error
            $ "Class "
            ++ show from
            ++ " used in scene "
            ++ show scene
            ++ " is lacking a signal named "
            ++ show signal
            ++ "\\n"
            ++ show (nodeToType scene from)
            ++ "\\n"
            ++ show (parentsOf (nodeToType scene from))
          (h:_) -> h ^. _1

  -- Debug
  when False $ runIO $ do
    putStrLn "Regenerating .."
    print rdt
    putStrLn "\\nScene roots:"
    print sceneRoots
    putStrLn "\\nScene nodes types:"
    mapM_ print sceneNodes
    putStrLn "\\nMethods:"
    mapM_ print methods
    putStrLn "\\nProperties:"
    mapM_ print properties
    putStrLn "\\nSignals:"
    mapM_ print allSignals
    mapM_ print signals
    putStrLn "\\nConnections:"
    mapM_ print connections
    putStrLn "\\nHaskell nodes:"
    mapM_ print haskellNodes

  -- Generate code
  ns <- [d|instance NativeScript $(pure $ PromotedT ty) where
             classInit       = Glue.Support.init

             classMethods    =
               $(ListE
               <$> mapM
               (\\(t, n, argTy, _)
                -> let m = case nrArguments argTy of
                         0 -> [|method0#{end}
                         1 -> [|method1#{end}
                         2 -> [|method2#{end}
                         3 -> [|method3#{end}
                         4 -> [|method4#{end}
                         5 -> [|method5#{end}
                         n -> error
                           $ "More arguments than we currently impelement, look for 'method5' for more info "
                           ++ show n
                   in [|$m $(pure $ LitE $ StringL n)
                      (nodeMethod @($(pure $ PromotedT t)) @($(pure $ LitT $ StrTyLit n)))#{end})
               methods)

             classProperties =
               $(ListE
               <$> mapM (\\(name, prop, _, _) -> [|mkProperty' @($(pure $ PromotedT name))
                                                @($(pure $ LitT $ StrTyLit prop))#{end}) properties)

             classSignals    =
               $(ListE <$> mapM (\\(ty, name, _) -> [|signal' @($(pure $ PromotedT ty))
                                                   @($(pure $ LitT $ StrTyLit name))#{end}) signals)#{end}
  let cn = mkName $ "witness_connections_" ++ nameBase ty
  ws <- (:) <$> (cn `sigD` [t|[()]#{end})
    <*> [d|$(varP cn) =
             $(ListE
             <$> mapM (\\(scene, from, signal, to, method)
                       -> [|witnessConnection @($(pure $ LitT $ StrTyLit scene))
                          @($(pure $ LitT $ StrTyLit from)) @($(pure $ LitT $ StrTyLit signal))
                          @($(pure $ LitT $ StrTyLit to)) @($(pure $ LitT $ StrTyLit method))
                          @($(pure $ PromotedT $ resolveSignalActualClass scene from signal))#{end})
             connections)#{end}
  pure $ ns <> ws
  where
    unTree (InstanceD Nothing [] (AppT (AppT _ parent) child) []) = (unName child, unName parent)
    unTree p = error $ "I don't understand this parent " ++ show p

    unName (ConT x) = x
    unName (AppT (ConT x) _) = x
    unName x = error $ "I don't know how to extract the name of this type: " ++ show x

    unSceneRootNode (TySynInstD (TySynEqn Nothing (AppT _ (LitT (StrTyLit scene)))
                                 (LitT (StrTyLit node)))) = (scene, node)
    unSceneRootNode x = error $ "Don't know how unpack this SceneRootNode: " ++ show x

    unSceneNodeType (TySynInstD (TySynEqn Nothing (AppT (AppT _ (LitT (StrTyLit scene)))
                                                   (LitT (StrTyLit node))) ty)) =
      (scene, node, unName ty, unpackScene ty)
    unSceneNodeType x = error $ "Don't know how unpack this SceneNodeType: " ++ show x

    unpackScene (ConT _) = Nothing
    unpackScene (AppT (ConT _) (LitT (StrTyLit scene))) = Just scene
    unpackScene x = error $ "Don't know how unpack this Scene: " ++ show x

    unNodeMethod (InstanceD Nothing []
                  (AppT (AppT (AppT (AppT (ConT _) (ConT cls)) (LitT (StrTyLit name))) arg) ret) []) =
      Just (cls, name, arg, ret)
    unNodeMethod _ = Nothing

    unNodeProperty (InstanceD Nothing []
                    (AppT (AppT (AppT (AppT (ConT _) (ConT cls)) (LitT (StrTyLit name))) arg) ret)
                    []) = Just (cls, name, arg, ret)
    unNodeProperty x = error $ show x

    unNodeInScene (InstanceD Nothing [] (AppT (AppT (AppT (ConT _) (LitT (StrTyLit scene)))
                                               (LitT (StrTyLit node))) (ConT hty)) []) =
      (scene, node, hty)
    unNodeInScene x = error $ show x

    unNodeSignal
      (InstanceD Nothing [] (AppT (AppT (AppT (ConT _) (ConT cls)) (LitT (StrTyLit name))) arg) []) =
      (cls, name, arg)
    unNodeSignal _ = error "Bad signal"

    unConnect
      (InstanceD Nothing []
       (AppT (AppT (AppT (AppT (AppT _ (LitT (StrTyLit scene))) (LitT (StrTyLit from)))
                    (LitT (StrTyLit signal))) (LitT (StrTyLit to))) (LitT (StrTyLit method))) []) =
      (scene, from, signal, to, method)
    unConnect x = error $ "Bad signal" ++ show x

    nrArguments :: Type -> Int
    nrArguments (AppT _ r) = 1 + nrArguments r
    nrArguments (SigT PromotedNilT (AppT ListT StarT)) = 0
    nrArguments _ = error "Can't compute # of arguments"

    classInstances :: Info -> [InstanceDec]
    classInstances (ClassI _ is) = is
    classInstances _ = error "Bad class"

    familyInstances :: Info -> [InstanceDec]
    familyInstances (FamilyI _ is) = is
    familyInstances _ = error "Bad class"

|]
  where
    end = "|]"

language =
  T.pack [i|{-# LANGUAGE FlexibleContexts, FunctionalDependencies, MultiParamTypeClasses,
  UndecidableInstances, OverloadedStrings, TemplateHaskell, TypeApplications,
  TypeFamilies, TupleSections, DataKinds, TypeOperators, FlexibleInstances, RankNTypes,
  AllowAmbiguousTypes, ScopedTypeVariables, DerivingStrategies,
  GeneralizedNewtypeDeriving, LambdaCase #-}
|]

mkModule qualifiedName =
  T.pack [i|module Glue.Scenes.#{qualifiedName} where
import Prelude
import Glue.Support
import Godot
import GHC.TypeLits
|]

mkSceneRoot scene name =
  T.pack
  [i|
instance SceneRoot "#{scene}" where
  type SceneRootNode "#{scene}" = "#{name}"
  |]

mkScenePath scene filepath =
  T.pack [i|
instance SceneResourcePath "#{scene}" where
  sceneResourcePath = "res://#{filepath}"
  |]

mkSceneNode scene name path ty ty' isHaskell =
  ( T.pack [i|import Godot.Core.#{ty}()|]
  , T.pack [i|
instance SceneNode        "#{scene}" "#{path}" where
  type SceneNodeType      "#{scene}" "#{path}" = #{ty'}
  type SceneNodeName      "#{scene}" "#{path}" = "#{name}"
  type SceneNodeIsHaskell "#{scene}" "#{path}" = #{isHaskell}
|])

  -- where
  --   hsNode = case isHaskell of
  --     Nothing -> "'Nothing"
  --     Just (Name s, Name n) -> "'Just '(\"" <> s <> "\", \"" <> n <> "\")"
mkSceneConnection scene from signal to method =
  T.pack
  [i|
instance SceneConnection "#{scene}" "#{from}" "#{signal}" "#{to}" "#{method}"
|]

-- after x = T.drop (T.length x) . snd . T.breakOn x
-- rowType = Ty . T.takeWhile (/= '\"') . after "type=\""
-- rowPath = T.takeWhile (/= '\"') . after "path=\"res://"
-- rowName = Name . T.takeWhile (/= '\"') . after "name=\""
-- rowParent t =
--   NodePath
--   <$> if T.isInfixOf " parent=\"" t
--     then Just $ T.takeWhile (/= '\"') $ after "parent=\"" t
--     else Nothing
-- rowId = Id . T.takeWhile isNumber . after "id="
-- rowInstance t =
--   Id
--   <$> if T.isInfixOf " instance=ExtResource( " t
--     then Just $ T.takeWhile isNumber $ after " instance=ExtResource( " t
--     else Nothing
-- resClassName = Name . T.takeWhile (/= '\"') . after "class_name = \""
-- resScript = Id . T.takeWhile isNumber . after "script = ExtResource( "
-- resLibrary = Id . T.takeWhile isNumber . after "library = ExtResource( "
-- rowSignal = Signal . T.takeWhile (/= '\"') . after "signal=\""
-- rowMethod = Method . T.takeWhile (/= '\"') . after "method=\""
-- rowFrom current = resolve current . NodePath . T.takeWhile (/= '\"') . after "from=\""
-- rowTo current = resolve current . NodePath . T.takeWhile (/= '\"') . after "to=\""
-- resolve :: Maybe Name -> NodePath -> NodePath
-- resolve (Just (Name n)) (NodePath ".") = NodePath n
-- resolve _ (NodePath ".") = error "Relative node path without a current node"
-- resolve _ p = p
-- readTscn fn relFile = do
--   b <- doesFileExist fn
--   let tscnName = Name $ T.pack $ takeBaseName fn
--   if b
--     then do
--       f <- T.lines <$> T.readFile fn
--       case f of
--         (h:l) -> do
--           if T.isPrefixOf "[gd_scene " h
--             then pure
--               $ fillRoot
--               $ foldl'
--               (\(s, current, root) t -> if
--                  | T.isPrefixOf "[ext_resource " (Name <$>) . t
--                    -> ( s & resources . at (rowId t) ?~ Resource (rowType t) (rowPath t)
--                       , current
--                       , root)
--                  -- TODO Add subresource parsing here?
--                  | T.isPrefixOf "[node " t
--                    -> ( s
--                         & nodes . at (rowName t)
--                         ?~ TscnNode (rowType t) (rowParent t) (rowInstance t) Nothing
--                       , Just $ rowName t
--                       , case rowParent t of
--                           Nothing -> Just $ rowName t
--                           _       -> root)
--                  | T.isPrefixOf "[connection " t
--                    -> ( s
--                         & connections
--                         %~ (TscnConnection (rowSignal t) (rowFrom root t) (rowTo root t)
--                             (rowMethod t) :)
--                       , current
--                       , root)
--                  | T.isPrefixOf "script = ExtResource( " t -> case current of
--                    Just name
--                      -> (s & nodes . ix name . script ?~ resScript t, current, root)
--                  | otherwise -> (s, current, root))
--               (Tscn tscnName M.empty M.empty [] Nothing relFile, Nothing, Nothing) l
--             else pure $ Tscn tscnName M.empty M.empty [] Nothing relFile
--     else pure $ Tscn tscnName M.empty M.empty [] Nothing relFile
--   where
--     fillRoot (tscn, _, root) = tscn & rootNode .~ root
-- readTscn fn relFile = do
--   b <- doesFileExist fn
--   let tscnName    = Name $ T.pack $ takeBaseName fn
--       defaultTscn = Tscn tscnName M.empty M.empty [] Nothing relFile
--   if b
--     then do
--       conts <- T.readFile fn
--       let parsed = case P.parseOnly tscnParser conts of
--             Right p  -> p ^. sections
--             Left err -> error $ "Couldn't parse " <> fn <> ": " <> err
--           updateTscn tscnData section = case section of
--             ExtResourceSection path ty id' _ _ -> tscnData
--               & resources . at (Id . T.pack . show $ id')
--               ?~ Resource (Ty ty) (fromJust $ T.stripPrefix "res://" path)
--             NodeSection ty name parent inst _ _ _ _ _ entries
--               -> let script = do
--                        scriptEntry <- M.lookup "script" entries
--                        case unTscnConstructor scriptEntry of
--                          ("SubResource", [TscnInt i]) -> Just
--                            . head
--                            . mapMaybe
--                            (\case
--                               SubResourceSection _ id' _ entries -> if id' == i
--                                 then Id
--                                   . T.pack
--                                   . show
--                                   . unTscnInt
--                                   . head
--                                   . snd
--                                   . unTscnConstructor
--                                   <$> M.lookup "library" entries
--                                 else Nothing
--                               _ -> Nothing)
--                            $ parsed
--                          _ -> error "Invalid `script` entry in node body!"
--                  in tscnData
--                     & nodes . at (Name name)
--                     ?~ TscnNode (maybe (Ty "") (Ty) ty) (NodePath <$> parent)
--                     (Id . T.pack . show <$> inst) script
--             ConnectionSection signal from to mthd _ _ -> tscnData
--               & connections
--               %~ (TscnConnection (Signal signal) (NodePath from) (NodePath to)
--                   (Method mthd) :)
--             _ -> tscnData
--           rootNode' =
--             (Name <$>) . foldl' (<|>) Nothing . map (\case
--                                                        NodeSection _ name parent _ _ _ _ _
--                                                          _ _ -> maybe (Just name)
--                                                          (const Nothing) parent
--                                                        _ -> Nothing) $ parsed
--       let res = foldl' updateTscn defaultTscn parsed & rootNode .~ rootNode'
--       pPrint res
--       pure res
--     else pure defaultTscn
-- readGdns fn = do
--   b <- doesFileExist fn
--   if b
--     then do
--       f <- T.lines <$> T.readFile fn
--       case f of
--         (h:l) -> do
--           if T.isPrefixOf "[gd_resource type=\"NativeScript\" " h
--             then pure
--               $ fst
--               $ foldl'
--               (\(s, current) t -> if
--                  | T.isPrefixOf "[ext_resource " t
--                    -> ( s
--                         & extResources . at (rowId t) ?~ Resource (rowType t) (rowPath t)
--                       , current)
--                  | T.isPrefixOf "[" t -> (s, Nothing) -- Reset on any new heading
--                  | T.isPrefixOf "class_name =" t -> (s, Just $ resClassName t)
--                  | T.isPrefixOf "library = " t
--                    -> (s & resources . at (fromJust current) ?~ resLibrary t, current)
--                  | otherwise -> (s, current)) (Gdns M.empty M.empty, Nothing) l
--             else pure $ Gdns M.empty M.empty
--     else pure $ Gdns M.empty M.empty
-- outputSupport dir =
--   createAndWriteFile (dir </> "Glue" </> "Support.hs") (T.pack $ language ++ support)
-- main :: IO ()
-- main = do
--   args <- getArgs
--   case args of
--     [inDir, outDir] -> do
--       let regenerate = do
--             putStrLn "Regenerating ..."
--             print =<< allByExtension ".gdns" inDir
--             print =<< allByExtension ".tscn" inDir
--             b <- doesDirectoryExist (outDir </> "Glue")
--             when b $ removeDirectoryRecursive (outDir </> "Glue")
--             createDirectoryIfMissing True (outDir </> "Glue" </> "Scenes")
--             outputSupport outDir
--             --
--             tscns <- M.fromList
--               <$> (mapM (\f -> let relFile = makeRelative inDir f
--                                in (T.pack relFile, ) <$> readTscn f relFile)
--                    =<< allByExtension ".tscn" inDir)
--             gdnss <- M.fromList
--               <$> (mapM (\f -> (T.pack $ makeRelative inDir f, ) <$> readGdns f)
--                    =<< allByExtension ".gdns" inDir)
--             --
--             mapM_ (\(fn, t) -> outputTscn (segmentsName inDir fn) (moduleName inDir fn)
--                    outDir t tscns gdnss) $ M.toList tscns
--             outputCombined inDir outDir tscns
--             outputGdnss inDir outDir gdnss
--             putStrLn "Generatd!"
--             putStrLn "Watching ... ctrl+c to stop"
--       regenerate
--       withManager $ \mgr -> do
--         watchDir mgr inDir (\e -> let ext = takeExtension (eventPath e)
--                                   in ext == ".gdns" || ext == ".tscn")
--           (\a -> do
--              regenerate
--              print a)
--         forever $ threadDelay 1000000
--     _ -> error
--       "Usage: godot-haskell-parse-game <godot-project-directory> <output-directory>"
-- segmentsName :: FilePath -> T.Text -> [[Char]]
-- segmentsName inDir tscnFilepath =
--   map (filter (/= '/') . mangle)
--   $ filter (/= ".")
--   $ splitPath
--   $ takeDirectory
--   $ T.unpack tscnFilepath
-- moduleName :: FilePath -> T.Text -> [Char]
-- moduleName inDir tscnFilepath = mangle $ takeBaseName $ T.unpack tscnFilepath
-- outputTscn :: [FilePath]
--            -> FilePath
--            -> FilePath
--            -> Tscn
--            -> M.Map T.Text Tscn
--            -> M.Map T.Text Gdns
--            -> IO ()
-- outputTscn segmentsTscnName sceneName outDir tscn tscns gdnss = do
--   createAndWriteFile
--     (normalise
--      $ outDir </> "Glue" </> "Scenes" </> joinPath segmentsTscnName </> sceneName
--      <> ".hs")
--     $ T.unlines
--     ([ T.pack language
--      , mkModule
--        (intercalate "." ((map (filter (/= '/')) segmentsTscnName) <> [sceneName]))]
--      ++ nub (map fst sceneNodes)
--      ++ [ mkScenePath (_tscnSceneName tscn) (tscn ^. filepath)
--         , mkSceneRoot (_tscnSceneName tscn) (tscn ^. rootNode)]
--      ++ map snd sceneNodes
--      ++ map (\conn -> mkSceneConnection sceneName (conn ^. from) (conn ^. signal)
--              (conn ^. to) (conn ^. method)) (tscn ^. connections))
--   where
--     sceneNodes =
--       map (\(name, node) -> mkSceneNode sceneName (T.unpack $ unName name)
--            (case node ^. parent of
--               Nothing -> unName name
--               Just (NodePath ".") -> unName name
--               Just (NodePath p') -> p' <> "/" <> unName name)
--            (case (node ^. ty, node ^. instanceof) of
--               (Ty "", Just i) -> case M.lookup i (tscn ^. resources) of
--                 Just r  -> r ^. ty
--                 Nothing -> error $ "Can't look up type of " ++ show (name, node)
--               (t, _)          -> t)
--            (annotatePackedScene node $ case (node ^. ty, node ^. instanceof) of
--               (Ty "", Just i) -> case M.lookup i (tscn ^. resources) of
--                 Just r  -> r ^. ty
--                 Nothing -> error $ "Can't look up type of " ++ show (name, node)
--               (t, _)          -> t) (isHaskellNode name node tscn tscns gdnss))
--       (M.toList $ tscn ^. nodes)
--     annotatePackedScene node (Ty "PackedScene") =
--       Ty $ "PackedScene' \"" <> unName (fromJust $ do
--                                           i <- node ^. instanceof
--                                           r <- M.lookup i (tscn ^. resources)
--                                           t <- M.lookup (r ^. path) tscns
--                                           t ^. rootNode) <> "\""
--     annotatePackedScene node ty = ty
stripResPrefix :: T.Text -> T.Text
stripResPrefix = fromJust . T.stripPrefix "res://"

findSceneRoot :: TscnParsed -> Node
findSceneRoot tscn = go (tscn ^. P.tscnParsedSections)
  where
    go (x:xs) = case x of
      NodeSection n' -> if isNothing (n' ^. P.nodeParent)
        then n'
        else go xs
      _ -> go xs
    go []     = error "Invalid scene: scene has no root node!"

indexedSections
  :: Ord b => (GodotSection -> Maybe a) -> Lens' a b -> TscnParsed -> V.Vector a
indexedSections select ordLens tscn =
  V.modify (V.sortBy (\a1 a2 -> (a1 ^. ordLens) `compare` (a2 ^. ordLens)))
  . V.mapMaybe select
  . V.fromList
  $ (tscn ^. P.tscnParsedSections)

outputTscn :: Generator -> Path Rel File -> IO ()
outputTscn gen fname = do
  let 
    -- Metadata collection
    tscn = fromJust $ M.lookup fname (gen ^. generatorTscnFiles)
    currSceneName = fromJust $ ".tscn" `T.stripPrefix` toFilePath fname
    segments = splitPath . toFilePath $ fname
    sceneModule = T.intercalate "." . V.toList . V.filter (/= "/") $ segments
    isExtResource (ExtResourceSection _) = True
    isExtResource _ = False
    tscnResources = indexedSections (\case
                                       ExtResourceSection e' -> Just e'
                                       _ -> Nothing) extResourceId tscn
    tscnSubResources = indexedSections (\case
                                          SubResourceSection s' -> Just s'
                                          _ -> Nothing) subResourceId tscn
    rootNode = findSceneRoot tscn
    -- Output generation
    scenePath = mkScenePath currSceneName ("res://" <> toFilePath fname)
    sceneRoot = mkSceneRoot currSceneName (rootNode ^. P.nodeName)
    sceneNodes =
      map
      (\s
       -> let scene'    = toFilePath $ filename fname
              name'     = s ^. P.nodeName
              path'     =
                maybe (rootNode ^. P.nodeName) (T.replace "." (rootNode ^. P.nodeName))
                (s ^. P.nodeParent)
              ty        =
                fromMaybe ((tscnResources V.! fromJust (s ^. P.nodeInst))
                           ^. P.extResourceTy) (s ^. P.nodeTy)
              ty'       = case s ^. P.nodeTy of
                Just ty -> ty
                Nothing -> "PackedScene' "
                  <> T.takeWhileEnd (/= '/')
                  ((tscnResources V.! fromJust (s ^. P.nodeInst)) ^. P.extResourceTy)
              isHaskell = case s ^. P.nodeInst of
                -- Node has attached instance, may refer to Haskell packed scene
                Just i
                  -> let path           =
                           fromRight undefined . parseRelFile . stripResPrefix
                           $ (tscnResources V.! (i - 1)) ^. P.extResourcePath
                         targetTscn     =
                           fromJust $ M.lookup path (gen ^. generatorTscnFiles)
                         targetRootNode = findSceneRoot targetTscn ^. P.nodeName
                     in "'Just '("
                        <> fromJust (".tscn" `T.stripSuffix` toFilePath (filename path))
                        <> ", "
                        <> targetRootNode
                        <> ")"
                -- Node has no instance, may have Haskell script attached
                Nothing -> case M.lookup "script" (s ^. P.nodeEntries) of
                  -- Points to library as a sub-resource
                  Just (GodotConstructor ("SubResource", [GodotInt scriptSubResId]))
                    -> let targetSubRes = tscnSubResources V.! (scriptSubResId - 1)
                           (GodotConstructor ("ExtResource", [GodotInt extResId])) =
                             fromJust . M.lookup "library"
                             $ targetSubRes ^. P.subResourceEntries
                           targetExtRes = tscnResources V.! (extResId - 1)
                           (GodotString className) =
                             fromJust . M.lookup "class_name"
                             $ targetSubRes ^. P.subResourceEntries
                       in if S.member (targetExtRes ^. P.extResourcePath)
                            (gen ^. generatorRegisteredGdnlibs)
                            then 
                              -- Target gdnlib is a Haskell library
                              "'Just '("
                              <> fromJust
                              -- TODO This may not point to the scene root's name
                              (".tscn" `T.stripSuffix` toFilePath (filename fname))
                              <> ", "
                              <> (s ^. P.nodeName)
                              <> ")"
                            else "'Nothing"
                  -- Points to `gdns` file
                  Just (GodotConstructor ("ExtResource", [GodotInt scriptExtResId]))
                    -> undefined
                  Nothing -> "'Nothing"
          in mkSceneNode scene' name' path' ty ty' isHaskell)
      (mapMaybe (\case
                   NodeSection n' -> Just n'
                   _ -> Nothing) $ tscn ^. P.tscnParsedSections)
    sceneConnections =
      map (\c -> mkSceneConnection currSceneName (c ^. connectionFrom)
           (c ^. P.connectionSignal) (c ^. P.connectionTo) (c ^. P.connectionMethod))
      $ mapMaybe (\case
                    ConnectionSection c' -> Just c'
                    _ -> Nothing)
      $ tscn ^. P.tscnParsedSections
  -- Write files
  createDirectoryIfMissing True $ T.unpack $ toFilePath fname
  T.writeFile (T.unpack $ toFilePath fname)
    (T.unlines
     $ [language, sceneModule]
     ++ map fst sceneNodes
     ++ [scenePath, sceneRoot]
     ++ map snd sceneNodes
     ++ sceneConnections)
-- isHaskellNode :: Name
--               -> TscnNode
--               -> Tscn
--               -> M.Map T.Text Tscn
--               -> M.Map T.Text Gdns
--               -> Maybe (Name, Name)
-- isHaskellNode name node tscn tscns gdnss =
--   case ( (\f -> tscn ^? resources . at f . _Just . path) =<< (node ^. script)
--        , node ^. instanceof) of
--     (Just p, _) -> case gdnss ^. at p of
--       Just g -> if isHaskellGdns name g
--         then Just (Name $ T.pack $ dropExtension $ T.unpack p, name)
--         else Nothing
--     (_, Just i) -> let t = tscns ^. at (tscn ^. resources . at i . _Just . path)
--                    in case (t, rootNodeTscn (fromJust t)) of
--                         (Just t', Just (n, r)) -> isHaskellNode n r t' tscns gdnss
--                         _ -> Nothing
--     _           -> Nothing
-- isHaskellGdns :: Name -> Gdns -> Bool
-- isHaskellGdns n gdns =
--   maybe False (\f -> maybe False isHaskellResource (gdns ^. extResources . at f))
--   (gdns ^. resources . at n)
-- isHaskellResource :: Resource -> Bool
-- isHaskellResource r = T.isSuffixOf ".gdnlib" $ r ^. path
-- rootNodeTscn :: Tscn -> Maybe (Name, TscnNode)
-- rootNodeTscn tscn =
--   find (\(name, node) -> isNothing (node ^. parent)) $ M.toList $ tscn ^. nodes
-- outputCombined inDir outDir tscns =
--   createAndWriteFile (outDir </> "Glue" </> "Scenes.hs")
--   $ T.pack [i|module Glue.Scenes #{exports} where
-- #{imports}
-- |]
--   where
--     imports =
--       unlines
--       $ map (\(fn, t)
--              -> let f = intercalate "." $ segmentsName inDir fn <> [moduleName inDir fn]
--                 in [i|import qualified Glue.Scenes.#{f} as M|])
--       $ M.toList tscns
--     exports =
--       if null imports
--         then ""
--         else "(module M)"
-- mkRequirementsModule inDir gdnss =
--   T.pack [i|{-# LANGUAGE DataKinds #-}
-- module Glue.Requirements where
-- import Glue.Support
-- type Nodes = '[#{reqs}]
-- |]
--   where
--     reqs = intercalate ", " $ map one $ sort $ concatMap (mkRequirement inDir) gdnss
--     one (resource, name) = [i|OneResourceNode "#{resource}" "#{name}"|]
-- outputGdnss :: FilePath -> FilePath -> M.Map T.Text Gdns -> IO ()
-- outputGdnss inDir dir gdnss =
--   createAndWriteFile (dir </> "Glue" </> "Requirements.hs")
--   $ mkRequirementsModule inDir
--   $ M.toList gdnss
-- mkRequirement :: FilePath -> (T.Text, Gdns) -> [(String, T.Text)]
-- mkRequirement inDir (fn, gdns) =
--   trace ("\n\noutput: " <> show inDir <> show (fn, gdns))
--   (mapMaybe (\(n, i) -> case M.lookup i (gdns ^. extResources) of
--                Just r -> if T.isInfixOf ".gdnlib" (r ^. path)
--                  && unTy (r ^. ty) == "GDNativeLibrary"
--                  then Just (moduleName inDir fn, unName n)
--                  else Nothing
--                _      -> Nothing) $ M.toList $ gdns ^. resources)
