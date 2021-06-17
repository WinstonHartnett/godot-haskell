{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Core.AudioEffectCapture
       (Godot.Core.AudioEffectCapture.can_get_buffer,
        Godot.Core.AudioEffectCapture.clear_buffer,
        Godot.Core.AudioEffectCapture.get_buffer,
        Godot.Core.AudioEffectCapture.get_buffer_length,
        Godot.Core.AudioEffectCapture.get_buffer_length_frames,
        Godot.Core.AudioEffectCapture.get_discarded_frames,
        Godot.Core.AudioEffectCapture.get_frames_available,
        Godot.Core.AudioEffectCapture.get_pushed_frames,
        Godot.Core.AudioEffectCapture.set_buffer_length)
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
import Godot.Core.AudioEffect()

instance NodeProperty AudioEffectCapture "buffer_length" Float
           'False
         where
        nodeProperty
          = (get_buffer_length, wrapDroppingSetter set_buffer_length,
             Nothing)

{-# NOINLINE bindAudioEffectCapture_can_get_buffer #-}

-- | Returns @true@ if at least @frames@ audio frames are available to read in the internal ring buffer.
bindAudioEffectCapture_can_get_buffer :: MethodBind
bindAudioEffectCapture_can_get_buffer
  = unsafePerformIO $
      withCString "AudioEffectCapture" $
        \ clsNamePtr ->
          withCString "can_get_buffer" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns @true@ if at least @frames@ audio frames are available to read in the internal ring buffer.
can_get_buffer ::
                 (AudioEffectCapture :< cls, Object :< cls) => cls -> Int -> IO Bool
can_get_buffer cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAudioEffectCapture_can_get_buffer
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AudioEffectCapture "can_get_buffer" '[Int]
           (IO Bool)
         where
        nodeMethod = Godot.Core.AudioEffectCapture.can_get_buffer

{-# NOINLINE bindAudioEffectCapture_clear_buffer #-}

-- | Clears the internal ring buffer.
bindAudioEffectCapture_clear_buffer :: MethodBind
bindAudioEffectCapture_clear_buffer
  = unsafePerformIO $
      withCString "AudioEffectCapture" $
        \ clsNamePtr ->
          withCString "clear_buffer" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Clears the internal ring buffer.
clear_buffer ::
               (AudioEffectCapture :< cls, Object :< cls) => cls -> IO ()
clear_buffer cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAudioEffectCapture_clear_buffer
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AudioEffectCapture "clear_buffer" '[] (IO ())
         where
        nodeMethod = Godot.Core.AudioEffectCapture.clear_buffer

{-# NOINLINE bindAudioEffectCapture_get_buffer #-}

-- | Gets the next @frames@ audio samples from the internal ring buffer.
--   				Returns a @PoolVector2Array@ containing exactly @frames@ audio samples if available, or an empty @PoolVector2Array@ if insufficient data was available.
bindAudioEffectCapture_get_buffer :: MethodBind
bindAudioEffectCapture_get_buffer
  = unsafePerformIO $
      withCString "AudioEffectCapture" $
        \ clsNamePtr ->
          withCString "get_buffer" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Gets the next @frames@ audio samples from the internal ring buffer.
--   				Returns a @PoolVector2Array@ containing exactly @frames@ audio samples if available, or an empty @PoolVector2Array@ if insufficient data was available.
get_buffer ::
             (AudioEffectCapture :< cls, Object :< cls) =>
             cls -> Int -> IO PoolVector2Array
get_buffer cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAudioEffectCapture_get_buffer
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AudioEffectCapture "get_buffer" '[Int]
           (IO PoolVector2Array)
         where
        nodeMethod = Godot.Core.AudioEffectCapture.get_buffer

{-# NOINLINE bindAudioEffectCapture_get_buffer_length #-}

-- | Length of the internal ring buffer, in seconds. Setting the buffer length will have no effect if already initialized.
bindAudioEffectCapture_get_buffer_length :: MethodBind
bindAudioEffectCapture_get_buffer_length
  = unsafePerformIO $
      withCString "AudioEffectCapture" $
        \ clsNamePtr ->
          withCString "get_buffer_length" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Length of the internal ring buffer, in seconds. Setting the buffer length will have no effect if already initialized.
get_buffer_length ::
                    (AudioEffectCapture :< cls, Object :< cls) => cls -> IO Float
get_buffer_length cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAudioEffectCapture_get_buffer_length
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AudioEffectCapture "get_buffer_length" '[]
           (IO Float)
         where
        nodeMethod = Godot.Core.AudioEffectCapture.get_buffer_length

{-# NOINLINE bindAudioEffectCapture_get_buffer_length_frames #-}

-- | Returns the total size of the internal ring buffer in frames.
bindAudioEffectCapture_get_buffer_length_frames :: MethodBind
bindAudioEffectCapture_get_buffer_length_frames
  = unsafePerformIO $
      withCString "AudioEffectCapture" $
        \ clsNamePtr ->
          withCString "get_buffer_length_frames" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the total size of the internal ring buffer in frames.
get_buffer_length_frames ::
                           (AudioEffectCapture :< cls, Object :< cls) => cls -> IO Int
get_buffer_length_frames cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindAudioEffectCapture_get_buffer_length_frames
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AudioEffectCapture "get_buffer_length_frames"
           '[]
           (IO Int)
         where
        nodeMethod = Godot.Core.AudioEffectCapture.get_buffer_length_frames

{-# NOINLINE bindAudioEffectCapture_get_discarded_frames #-}

-- | Returns the number of audio frames discarded from the audio bus due to full buffer.
bindAudioEffectCapture_get_discarded_frames :: MethodBind
bindAudioEffectCapture_get_discarded_frames
  = unsafePerformIO $
      withCString "AudioEffectCapture" $
        \ clsNamePtr ->
          withCString "get_discarded_frames" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the number of audio frames discarded from the audio bus due to full buffer.
get_discarded_frames ::
                       (AudioEffectCapture :< cls, Object :< cls) => cls -> IO Int
get_discarded_frames cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAudioEffectCapture_get_discarded_frames
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AudioEffectCapture "get_discarded_frames" '[]
           (IO Int)
         where
        nodeMethod = Godot.Core.AudioEffectCapture.get_discarded_frames

{-# NOINLINE bindAudioEffectCapture_get_frames_available #-}

-- | Returns the number of frames available to read using @method get_buffer@.
bindAudioEffectCapture_get_frames_available :: MethodBind
bindAudioEffectCapture_get_frames_available
  = unsafePerformIO $
      withCString "AudioEffectCapture" $
        \ clsNamePtr ->
          withCString "get_frames_available" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the number of frames available to read using @method get_buffer@.
get_frames_available ::
                       (AudioEffectCapture :< cls, Object :< cls) => cls -> IO Int
get_frames_available cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAudioEffectCapture_get_frames_available
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AudioEffectCapture "get_frames_available" '[]
           (IO Int)
         where
        nodeMethod = Godot.Core.AudioEffectCapture.get_frames_available

{-# NOINLINE bindAudioEffectCapture_get_pushed_frames #-}

-- | Returns the number of audio frames inserted from the audio bus.
bindAudioEffectCapture_get_pushed_frames :: MethodBind
bindAudioEffectCapture_get_pushed_frames
  = unsafePerformIO $
      withCString "AudioEffectCapture" $
        \ clsNamePtr ->
          withCString "get_pushed_frames" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the number of audio frames inserted from the audio bus.
get_pushed_frames ::
                    (AudioEffectCapture :< cls, Object :< cls) => cls -> IO Int
get_pushed_frames cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAudioEffectCapture_get_pushed_frames
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AudioEffectCapture "get_pushed_frames" '[]
           (IO Int)
         where
        nodeMethod = Godot.Core.AudioEffectCapture.get_pushed_frames

{-# NOINLINE bindAudioEffectCapture_set_buffer_length #-}

-- | Length of the internal ring buffer, in seconds. Setting the buffer length will have no effect if already initialized.
bindAudioEffectCapture_set_buffer_length :: MethodBind
bindAudioEffectCapture_set_buffer_length
  = unsafePerformIO $
      withCString "AudioEffectCapture" $
        \ clsNamePtr ->
          withCString "set_buffer_length" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Length of the internal ring buffer, in seconds. Setting the buffer length will have no effect if already initialized.
set_buffer_length ::
                    (AudioEffectCapture :< cls, Object :< cls) => cls -> Float -> IO ()
set_buffer_length cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindAudioEffectCapture_set_buffer_length
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod AudioEffectCapture "set_buffer_length" '[Float]
           (IO ())
         where
        nodeMethod = Godot.Core.AudioEffectCapture.set_buffer_length