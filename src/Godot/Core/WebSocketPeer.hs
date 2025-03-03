{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Core.WebSocketPeer
       (Godot.Core.WebSocketPeer._WRITE_MODE_BINARY,
        Godot.Core.WebSocketPeer._WRITE_MODE_TEXT,
        Godot.Core.WebSocketPeer.close,
        Godot.Core.WebSocketPeer.get_connected_host,
        Godot.Core.WebSocketPeer.get_connected_port,
        Godot.Core.WebSocketPeer.get_current_outbound_buffered_amount,
        Godot.Core.WebSocketPeer.get_write_mode,
        Godot.Core.WebSocketPeer.is_connected_to_host,
        Godot.Core.WebSocketPeer.set_no_delay,
        Godot.Core.WebSocketPeer.set_write_mode,
        Godot.Core.WebSocketPeer.was_string_packet)
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
import Godot.Core.PacketPeer()

_WRITE_MODE_BINARY :: Int
_WRITE_MODE_BINARY = 1

_WRITE_MODE_TEXT :: Int
_WRITE_MODE_TEXT = 0

{-# NOINLINE bindWebSocketPeer_close #-}

bindWebSocketPeer_close :: MethodBind
bindWebSocketPeer_close
  = unsafePerformIO $
      withCString "WebSocketPeer" $
        \ clsNamePtr ->
          withCString "close" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

close ::
        (WebSocketPeer :< cls, Object :< cls) =>
        cls -> Maybe Int -> Maybe GodotString -> IO ()
close cls arg1 arg2
  = withVariantArray
      [maybe (VariantInt (1000)) toVariant arg1,
       defaultedVariant VariantString "" arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebSocketPeer_close (upcast cls) arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebSocketPeer "close"
           '[Maybe Int, Maybe GodotString]
           (IO ())
         where
        nodeMethod = Godot.Core.WebSocketPeer.close

{-# NOINLINE bindWebSocketPeer_get_connected_host #-}

bindWebSocketPeer_get_connected_host :: MethodBind
bindWebSocketPeer_get_connected_host
  = unsafePerformIO $
      withCString "WebSocketPeer" $
        \ clsNamePtr ->
          withCString "get_connected_host" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

get_connected_host ::
                     (WebSocketPeer :< cls, Object :< cls) => cls -> IO GodotString
get_connected_host cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebSocketPeer_get_connected_host
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebSocketPeer "get_connected_host" '[]
           (IO GodotString)
         where
        nodeMethod = Godot.Core.WebSocketPeer.get_connected_host

{-# NOINLINE bindWebSocketPeer_get_connected_port #-}

bindWebSocketPeer_get_connected_port :: MethodBind
bindWebSocketPeer_get_connected_port
  = unsafePerformIO $
      withCString "WebSocketPeer" $
        \ clsNamePtr ->
          withCString "get_connected_port" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

get_connected_port ::
                     (WebSocketPeer :< cls, Object :< cls) => cls -> IO Int
get_connected_port cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebSocketPeer_get_connected_port
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebSocketPeer "get_connected_port" '[] (IO Int)
         where
        nodeMethod = Godot.Core.WebSocketPeer.get_connected_port

{-# NOINLINE bindWebSocketPeer_get_current_outbound_buffered_amount
             #-}

bindWebSocketPeer_get_current_outbound_buffered_amount ::
                                                       MethodBind
bindWebSocketPeer_get_current_outbound_buffered_amount
  = unsafePerformIO $
      withCString "WebSocketPeer" $
        \ clsNamePtr ->
          withCString "get_current_outbound_buffered_amount" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

get_current_outbound_buffered_amount ::
                                       (WebSocketPeer :< cls, Object :< cls) => cls -> IO Int
get_current_outbound_buffered_amount cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call
           bindWebSocketPeer_get_current_outbound_buffered_amount
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebSocketPeer
           "get_current_outbound_buffered_amount"
           '[]
           (IO Int)
         where
        nodeMethod
          = Godot.Core.WebSocketPeer.get_current_outbound_buffered_amount

{-# NOINLINE bindWebSocketPeer_get_write_mode #-}

bindWebSocketPeer_get_write_mode :: MethodBind
bindWebSocketPeer_get_write_mode
  = unsafePerformIO $
      withCString "WebSocketPeer" $
        \ clsNamePtr ->
          withCString "get_write_mode" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

get_write_mode ::
                 (WebSocketPeer :< cls, Object :< cls) => cls -> IO Int
get_write_mode cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebSocketPeer_get_write_mode
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebSocketPeer "get_write_mode" '[] (IO Int)
         where
        nodeMethod = Godot.Core.WebSocketPeer.get_write_mode

{-# NOINLINE bindWebSocketPeer_is_connected_to_host #-}

bindWebSocketPeer_is_connected_to_host :: MethodBind
bindWebSocketPeer_is_connected_to_host
  = unsafePerformIO $
      withCString "WebSocketPeer" $
        \ clsNamePtr ->
          withCString "is_connected_to_host" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

is_connected_to_host ::
                       (WebSocketPeer :< cls, Object :< cls) => cls -> IO Bool
is_connected_to_host cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebSocketPeer_is_connected_to_host
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebSocketPeer "is_connected_to_host" '[]
           (IO Bool)
         where
        nodeMethod = Godot.Core.WebSocketPeer.is_connected_to_host

{-# NOINLINE bindWebSocketPeer_set_no_delay #-}

bindWebSocketPeer_set_no_delay :: MethodBind
bindWebSocketPeer_set_no_delay
  = unsafePerformIO $
      withCString "WebSocketPeer" $
        \ clsNamePtr ->
          withCString "set_no_delay" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

set_no_delay ::
               (WebSocketPeer :< cls, Object :< cls) => cls -> Bool -> IO ()
set_no_delay cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebSocketPeer_set_no_delay (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebSocketPeer "set_no_delay" '[Bool] (IO ())
         where
        nodeMethod = Godot.Core.WebSocketPeer.set_no_delay

{-# NOINLINE bindWebSocketPeer_set_write_mode #-}

bindWebSocketPeer_set_write_mode :: MethodBind
bindWebSocketPeer_set_write_mode
  = unsafePerformIO $
      withCString "WebSocketPeer" $
        \ clsNamePtr ->
          withCString "set_write_mode" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

set_write_mode ::
                 (WebSocketPeer :< cls, Object :< cls) => cls -> Int -> IO ()
set_write_mode cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebSocketPeer_set_write_mode
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebSocketPeer "set_write_mode" '[Int] (IO ())
         where
        nodeMethod = Godot.Core.WebSocketPeer.set_write_mode

{-# NOINLINE bindWebSocketPeer_was_string_packet #-}

bindWebSocketPeer_was_string_packet :: MethodBind
bindWebSocketPeer_was_string_packet
  = unsafePerformIO $
      withCString "WebSocketPeer" $
        \ clsNamePtr ->
          withCString "was_string_packet" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

was_string_packet ::
                    (WebSocketPeer :< cls, Object :< cls) => cls -> IO Bool
was_string_packet cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindWebSocketPeer_was_string_packet
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod WebSocketPeer "was_string_packet" '[] (IO Bool)
         where
        nodeMethod = Godot.Core.WebSocketPeer.was_string_packet