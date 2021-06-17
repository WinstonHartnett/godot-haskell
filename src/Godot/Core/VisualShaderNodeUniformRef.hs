{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Core.VisualShaderNodeUniformRef
       (Godot.Core.VisualShaderNodeUniformRef.get_uniform_name,
        Godot.Core.VisualShaderNodeUniformRef.set_uniform_name)
       where
import Data.Coerce
import Foreign.C
import Godot.Internal.Dispatch
import qualified Data.Vector as V
import Linear(V2(..),V3(..),M22)
import Data.Colour(withOpacity)
import Data.Colour.SRGB(sRGB)
import System.IO.Unsafe
import Godot.Gdnative.Internal
import Godot.Api.Types
import Godot.Core.VisualShaderNode()

instance NodeProperty VisualShaderNodeUniformRef "uniform_name"
           GodotString
           'False
         where
        nodeProperty
          = (get_uniform_name, wrapDroppingSetter set_uniform_name, Nothing)

{-# NOINLINE bindVisualShaderNodeUniformRef_get_uniform_name #-}

-- | The name of the uniform which this reference points to.
bindVisualShaderNodeUniformRef_get_uniform_name :: MethodBind
bindVisualShaderNodeUniformRef_get_uniform_name
  = unsafePerformIO $
      withCString "VisualShaderNodeUniformRef" $
        \ clsNamePtr ->
          withCString "get_uniform_name" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The name of the uniform which this reference points to.
get_uniform_name ::
                   (VisualShaderNodeUniformRef :< cls, Object :< cls) =>
                   cls -> IO GodotString
get_uniform_name cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindVisualShaderNodeUniformRef_get_uniform_name
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod VisualShaderNodeUniformRef "get_uniform_name"
           '[]
           (IO GodotString)
         where
        nodeMethod = Godot.Core.VisualShaderNodeUniformRef.get_uniform_name

{-# NOINLINE bindVisualShaderNodeUniformRef_set_uniform_name #-}

-- | The name of the uniform which this reference points to.
bindVisualShaderNodeUniformRef_set_uniform_name :: MethodBind
bindVisualShaderNodeUniformRef_set_uniform_name
  = unsafePerformIO $
      withCString "VisualShaderNodeUniformRef" $
        \ clsNamePtr ->
          withCString "set_uniform_name" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The name of the uniform which this reference points to.
set_uniform_name ::
                   (VisualShaderNodeUniformRef :< cls, Object :< cls) =>
                   cls -> GodotString -> IO ()
set_uniform_name cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindVisualShaderNodeUniformRef_set_uniform_name
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod VisualShaderNodeUniformRef "set_uniform_name"
           '[GodotString]
           (IO ())
         where
        nodeMethod = Godot.Core.VisualShaderNodeUniformRef.set_uniform_name