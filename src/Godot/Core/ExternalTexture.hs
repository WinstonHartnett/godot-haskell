{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Core.ExternalTexture
       (Godot.Core.ExternalTexture.get_size,
        Godot.Core.ExternalTexture.get_external_texture_id,
        Godot.Core.ExternalTexture.set_size)
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
import Godot.Core.Texture()

{-# NOINLINE bindExternalTexture_get_size #-}

-- | External texture size.
bindExternalTexture_get_size :: MethodBind
bindExternalTexture_get_size
  = unsafePerformIO $
      withCString "ExternalTexture" $
        \ clsNamePtr ->
          withCString "get_size" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | External texture size.
get_size ::
           (ExternalTexture :< cls, Object :< cls) => cls -> IO Vector2
get_size cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindExternalTexture_get_size (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod ExternalTexture "get_size" '[] (IO Vector2)
         where
        nodeMethod = Godot.Core.ExternalTexture.get_size

instance NodeProperty ExternalTexture "size" Vector2 'False where
        nodeProperty = (get_size, wrapDroppingSetter set_size, Nothing)

{-# NOINLINE bindExternalTexture_get_external_texture_id #-}

-- | Returns the external texture name.
bindExternalTexture_get_external_texture_id :: MethodBind
bindExternalTexture_get_external_texture_id
  = unsafePerformIO $
      withCString "ExternalTexture" $
        \ clsNamePtr ->
          withCString "get_external_texture_id" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the external texture name.
get_external_texture_id ::
                          (ExternalTexture :< cls, Object :< cls) => cls -> IO Int
get_external_texture_id cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindExternalTexture_get_external_texture_id
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod ExternalTexture "get_external_texture_id" '[]
           (IO Int)
         where
        nodeMethod = Godot.Core.ExternalTexture.get_external_texture_id

{-# NOINLINE bindExternalTexture_set_size #-}

-- | External texture size.
bindExternalTexture_set_size :: MethodBind
bindExternalTexture_set_size
  = unsafePerformIO $
      withCString "ExternalTexture" $
        \ clsNamePtr ->
          withCString "set_size" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | External texture size.
set_size ::
           (ExternalTexture :< cls, Object :< cls) => cls -> Vector2 -> IO ()
set_size cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindExternalTexture_set_size (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod ExternalTexture "set_size" '[Vector2] (IO ())
         where
        nodeMethod = Godot.Core.ExternalTexture.set_size