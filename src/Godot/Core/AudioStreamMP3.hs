{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Core.AudioStreamMP3
       (Godot.Core.AudioStreamMP3.get_data,
        Godot.Core.AudioStreamMP3.get_loop_offset,
        Godot.Core.AudioStreamMP3.has_loop,
        Godot.Core.AudioStreamMP3.set_data,
        Godot.Core.AudioStreamMP3.set_loop,
        Godot.Core.AudioStreamMP3.set_loop_offset)
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
import Godot.Core.AudioStream()

instance NodeProperty AudioStreamMP3 "data" PoolByteArray 'False
         where
        nodeProperty = (get_data, wrapDroppingSetter set_data, Nothing)

instance NodeProperty AudioStreamMP3 "loop" Bool 'False where
        nodeProperty = (has_loop, wrapDroppingSetter set_loop, Nothing)

instance NodeProperty AudioStreamMP3 "loop_offset" Float 'False
         where
        nodeProperty
          = (get_loop_offset, wrapDroppingSetter set_loop_offset, Nothing)

{-# NOINLINE bindAudioStreamMP3_get_data #-}

bindAudioStreamMP3_get_data :: MethodBind
bindAudioStreamMP3_get_data
  = unsafePerformIO $
      withCString "AudioStreamMP3" $
        \ clsNamePtr ->
          withCString "get_data" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

get_data ::
           (AudioStreamMP3 :< cls, Object :< cls) => cls -> IO PoolByteArray
get_data cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAudioStreamMP3_get_data (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AudioStreamMP3 "get_data" '[]
           (IO PoolByteArray)
         where
        nodeMethod = Godot.Core.AudioStreamMP3.get_data

{-# NOINLINE bindAudioStreamMP3_get_loop_offset #-}

bindAudioStreamMP3_get_loop_offset :: MethodBind
bindAudioStreamMP3_get_loop_offset
  = unsafePerformIO $
      withCString "AudioStreamMP3" $
        \ clsNamePtr ->
          withCString "get_loop_offset" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

get_loop_offset ::
                  (AudioStreamMP3 :< cls, Object :< cls) => cls -> IO Float
get_loop_offset cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAudioStreamMP3_get_loop_offset
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AudioStreamMP3 "get_loop_offset" '[] (IO Float)
         where
        nodeMethod = Godot.Core.AudioStreamMP3.get_loop_offset

{-# NOINLINE bindAudioStreamMP3_has_loop #-}

bindAudioStreamMP3_has_loop :: MethodBind
bindAudioStreamMP3_has_loop
  = unsafePerformIO $
      withCString "AudioStreamMP3" $
        \ clsNamePtr ->
          withCString "has_loop" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

has_loop ::
           (AudioStreamMP3 :< cls, Object :< cls) => cls -> IO Bool
has_loop cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAudioStreamMP3_has_loop (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AudioStreamMP3 "has_loop" '[] (IO Bool) where
        nodeMethod = Godot.Core.AudioStreamMP3.has_loop

{-# NOINLINE bindAudioStreamMP3_set_data #-}

bindAudioStreamMP3_set_data :: MethodBind
bindAudioStreamMP3_set_data
  = unsafePerformIO $
      withCString "AudioStreamMP3" $
        \ clsNamePtr ->
          withCString "set_data" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

set_data ::
           (AudioStreamMP3 :< cls, Object :< cls) =>
           cls -> PoolByteArray -> IO ()
set_data cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAudioStreamMP3_set_data (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AudioStreamMP3 "set_data" '[PoolByteArray]
           (IO ())
         where
        nodeMethod = Godot.Core.AudioStreamMP3.set_data

{-# NOINLINE bindAudioStreamMP3_set_loop #-}

bindAudioStreamMP3_set_loop :: MethodBind
bindAudioStreamMP3_set_loop
  = unsafePerformIO $
      withCString "AudioStreamMP3" $
        \ clsNamePtr ->
          withCString "set_loop" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

set_loop ::
           (AudioStreamMP3 :< cls, Object :< cls) => cls -> Bool -> IO ()
set_loop cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAudioStreamMP3_set_loop (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AudioStreamMP3 "set_loop" '[Bool] (IO ()) where
        nodeMethod = Godot.Core.AudioStreamMP3.set_loop

{-# NOINLINE bindAudioStreamMP3_set_loop_offset #-}

bindAudioStreamMP3_set_loop_offset :: MethodBind
bindAudioStreamMP3_set_loop_offset
  = unsafePerformIO $
      withCString "AudioStreamMP3" $
        \ clsNamePtr ->
          withCString "set_loop_offset" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

set_loop_offset ::
                  (AudioStreamMP3 :< cls, Object :< cls) => cls -> Float -> IO ()
set_loop_offset cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAudioStreamMP3_set_loop_offset
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AudioStreamMP3 "set_loop_offset" '[Float]
           (IO ())
         where
        nodeMethod = Godot.Core.AudioStreamMP3.set_loop_offset