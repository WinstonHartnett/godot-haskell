{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Core.VisualShaderNodeTransformVecMult
       (Godot.Core.VisualShaderNodeTransformVecMult._OP_BxA,
        Godot.Core.VisualShaderNodeTransformVecMult._OP_AxB,
        Godot.Core.VisualShaderNodeTransformVecMult._OP_3x3_AxB,
        Godot.Core.VisualShaderNodeTransformVecMult._OP_3x3_BxA,
        Godot.Core.VisualShaderNodeTransformVecMult.get_operator,
        Godot.Core.VisualShaderNodeTransformVecMult.set_operator)
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

_OP_BxA :: Int
_OP_BxA = 1

_OP_AxB :: Int
_OP_AxB = 0

_OP_3x3_AxB :: Int
_OP_3x3_AxB = 2

_OP_3x3_BxA :: Int
_OP_3x3_BxA = 3

instance NodeProperty VisualShaderNodeTransformVecMult "operator"
           Int
           'False
         where
        nodeProperty
          = (get_operator, wrapDroppingSetter set_operator, Nothing)

{-# NOINLINE bindVisualShaderNodeTransformVecMult_get_operator #-}

-- | The multiplication type to be performed. See @enum Operator@ for options.
bindVisualShaderNodeTransformVecMult_get_operator :: MethodBind
bindVisualShaderNodeTransformVecMult_get_operator
  = unsafePerformIO $
      withCString "VisualShaderNodeTransformVecMult" $
        \ clsNamePtr ->
          withCString "get_operator" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The multiplication type to be performed. See @enum Operator@ for options.
get_operator ::
               (VisualShaderNodeTransformVecMult :< cls, Object :< cls) =>
               cls -> IO Int
get_operator cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindVisualShaderNodeTransformVecMult_get_operator
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod VisualShaderNodeTransformVecMult "get_operator"
           '[]
           (IO Int)
         where
        nodeMethod
          = Godot.Core.VisualShaderNodeTransformVecMult.get_operator

{-# NOINLINE bindVisualShaderNodeTransformVecMult_set_operator #-}

-- | The multiplication type to be performed. See @enum Operator@ for options.
bindVisualShaderNodeTransformVecMult_set_operator :: MethodBind
bindVisualShaderNodeTransformVecMult_set_operator
  = unsafePerformIO $
      withCString "VisualShaderNodeTransformVecMult" $
        \ clsNamePtr ->
          withCString "set_operator" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | The multiplication type to be performed. See @enum Operator@ for options.
set_operator ::
               (VisualShaderNodeTransformVecMult :< cls, Object :< cls) =>
               cls -> Int -> IO ()
set_operator cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindVisualShaderNodeTransformVecMult_set_operator
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod VisualShaderNodeTransformVecMult "set_operator"
           '[Int]
           (IO ())
         where
        nodeMethod
          = Godot.Core.VisualShaderNodeTransformVecMult.set_operator