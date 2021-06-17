{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Core.UDPServer
       (Godot.Core.UDPServer.get_max_pending_connections,
        Godot.Core.UDPServer.is_connection_available,
        Godot.Core.UDPServer.is_listening, Godot.Core.UDPServer.listen,
        Godot.Core.UDPServer.poll,
        Godot.Core.UDPServer.set_max_pending_connections,
        Godot.Core.UDPServer.stop, Godot.Core.UDPServer.take_connection)
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
import Godot.Core.Reference()

instance NodeProperty UDPServer "max_pending_connections" Int
           'False
         where
        nodeProperty
          = (get_max_pending_connections,
             wrapDroppingSetter set_max_pending_connections, Nothing)

{-# NOINLINE bindUDPServer_get_max_pending_connections #-}

-- | Define the maximum number of pending connections, during @method poll@, any new pending connection exceeding that value will be automatically dropped. Setting this value to @0@ effectively prevents any new pending connection to be accepted (e.g. when all your players have connected).
bindUDPServer_get_max_pending_connections :: MethodBind
bindUDPServer_get_max_pending_connections
  = unsafePerformIO $
      withCString "UDPServer" $
        \ clsNamePtr ->
          withCString "get_max_pending_connections" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Define the maximum number of pending connections, during @method poll@, any new pending connection exceeding that value will be automatically dropped. Setting this value to @0@ effectively prevents any new pending connection to be accepted (e.g. when all your players have connected).
get_max_pending_connections ::
                              (UDPServer :< cls, Object :< cls) => cls -> IO Int
get_max_pending_connections cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindUDPServer_get_max_pending_connections
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod UDPServer "get_max_pending_connections" '[]
           (IO Int)
         where
        nodeMethod = Godot.Core.UDPServer.get_max_pending_connections

{-# NOINLINE bindUDPServer_is_connection_available #-}

-- | Returns @true@ if a packet with a new address/port combination was received on the socket.
bindUDPServer_is_connection_available :: MethodBind
bindUDPServer_is_connection_available
  = unsafePerformIO $
      withCString "UDPServer" $
        \ clsNamePtr ->
          withCString "is_connection_available" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns @true@ if a packet with a new address/port combination was received on the socket.
is_connection_available ::
                          (UDPServer :< cls, Object :< cls) => cls -> IO Bool
is_connection_available cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindUDPServer_is_connection_available
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod UDPServer "is_connection_available" '[]
           (IO Bool)
         where
        nodeMethod = Godot.Core.UDPServer.is_connection_available

{-# NOINLINE bindUDPServer_is_listening #-}

-- | Returns @true@ if the socket is open and listening on a port.
bindUDPServer_is_listening :: MethodBind
bindUDPServer_is_listening
  = unsafePerformIO $
      withCString "UDPServer" $
        \ clsNamePtr ->
          withCString "is_listening" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns @true@ if the socket is open and listening on a port.
is_listening :: (UDPServer :< cls, Object :< cls) => cls -> IO Bool
is_listening cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindUDPServer_is_listening (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod UDPServer "is_listening" '[] (IO Bool) where
        nodeMethod = Godot.Core.UDPServer.is_listening

{-# NOINLINE bindUDPServer_listen #-}

-- | Starts the server by opening a UDP socket listening on the given port. You can optionally specify a @bind_address@ to only listen for packets sent to that address. See also @method PacketPeerUDP.listen@.
bindUDPServer_listen :: MethodBind
bindUDPServer_listen
  = unsafePerformIO $
      withCString "UDPServer" $
        \ clsNamePtr ->
          withCString "listen" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Starts the server by opening a UDP socket listening on the given port. You can optionally specify a @bind_address@ to only listen for packets sent to that address. See also @method PacketPeerUDP.listen@.
listen ::
         (UDPServer :< cls, Object :< cls) =>
         cls -> Int -> Maybe GodotString -> IO Int
listen cls arg1 arg2
  = withVariantArray
      [toVariant arg1, defaultedVariant VariantString "*" arg2]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindUDPServer_listen (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod UDPServer "listen" '[Int, Maybe GodotString]
           (IO Int)
         where
        nodeMethod = Godot.Core.UDPServer.listen

{-# NOINLINE bindUDPServer_poll #-}

-- | Call this method at regular intervals (e.g. inside @method Node._process@) to process new packets. And packet from known address/port pair will be delivered to the appropriate @PacketPeerUDP@, any packet received from an unknown address/port pair will be added as a pending connection (see @method is_connection_available@, @method take_connection@). The maximum number of pending connection is defined via @max_pending_connections@.
bindUDPServer_poll :: MethodBind
bindUDPServer_poll
  = unsafePerformIO $
      withCString "UDPServer" $
        \ clsNamePtr ->
          withCString "poll" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Call this method at regular intervals (e.g. inside @method Node._process@) to process new packets. And packet from known address/port pair will be delivered to the appropriate @PacketPeerUDP@, any packet received from an unknown address/port pair will be added as a pending connection (see @method is_connection_available@, @method take_connection@). The maximum number of pending connection is defined via @max_pending_connections@.
poll :: (UDPServer :< cls, Object :< cls) => cls -> IO Int
poll cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindUDPServer_poll (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod UDPServer "poll" '[] (IO Int) where
        nodeMethod = Godot.Core.UDPServer.poll

{-# NOINLINE bindUDPServer_set_max_pending_connections #-}

-- | Define the maximum number of pending connections, during @method poll@, any new pending connection exceeding that value will be automatically dropped. Setting this value to @0@ effectively prevents any new pending connection to be accepted (e.g. when all your players have connected).
bindUDPServer_set_max_pending_connections :: MethodBind
bindUDPServer_set_max_pending_connections
  = unsafePerformIO $
      withCString "UDPServer" $
        \ clsNamePtr ->
          withCString "set_max_pending_connections" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Define the maximum number of pending connections, during @method poll@, any new pending connection exceeding that value will be automatically dropped. Setting this value to @0@ effectively prevents any new pending connection to be accepted (e.g. when all your players have connected).
set_max_pending_connections ::
                              (UDPServer :< cls, Object :< cls) => cls -> Int -> IO ()
set_max_pending_connections cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindUDPServer_set_max_pending_connections
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod UDPServer "set_max_pending_connections" '[Int]
           (IO ())
         where
        nodeMethod = Godot.Core.UDPServer.set_max_pending_connections

{-# NOINLINE bindUDPServer_stop #-}

-- | Stops the server, closing the UDP socket if open. Will close all connected @PacketPeerUDP@ accepted via @method take_connection@ (remote peers will not be notified).
bindUDPServer_stop :: MethodBind
bindUDPServer_stop
  = unsafePerformIO $
      withCString "UDPServer" $
        \ clsNamePtr ->
          withCString "stop" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Stops the server, closing the UDP socket if open. Will close all connected @PacketPeerUDP@ accepted via @method take_connection@ (remote peers will not be notified).
stop :: (UDPServer :< cls, Object :< cls) => cls -> IO ()
stop cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindUDPServer_stop (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod UDPServer "stop" '[] (IO ()) where
        nodeMethod = Godot.Core.UDPServer.stop

{-# NOINLINE bindUDPServer_take_connection #-}

-- | Returns the first pending connection (connected to the appropriate address/port). Will return @null@ if no new connection is available. See also @method is_connection_available@, @method PacketPeerUDP.connect_to_host@.
bindUDPServer_take_connection :: MethodBind
bindUDPServer_take_connection
  = unsafePerformIO $
      withCString "UDPServer" $
        \ clsNamePtr ->
          withCString "take_connection" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the first pending connection (connected to the appropriate address/port). Will return @null@ if no new connection is available. See also @method is_connection_available@, @method PacketPeerUDP.connect_to_host@.
take_connection ::
                  (UDPServer :< cls, Object :< cls) => cls -> IO PacketPeerUDP
take_connection cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindUDPServer_take_connection (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod UDPServer "take_connection" '[]
           (IO PacketPeerUDP)
         where
        nodeMethod = Godot.Core.UDPServer.take_connection