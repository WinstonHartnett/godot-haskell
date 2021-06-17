{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Core.PacketPeerDTLS
       (Godot.Core.PacketPeerDTLS._STATUS_CONNECTED,
        Godot.Core.PacketPeerDTLS._STATUS_ERROR,
        Godot.Core.PacketPeerDTLS._STATUS_DISCONNECTED,
        Godot.Core.PacketPeerDTLS._STATUS_ERROR_HOSTNAME_MISMATCH,
        Godot.Core.PacketPeerDTLS._STATUS_HANDSHAKING,
        Godot.Core.PacketPeerDTLS.connect_to_peer,
        Godot.Core.PacketPeerDTLS.disconnect_from_peer,
        Godot.Core.PacketPeerDTLS.get_status,
        Godot.Core.PacketPeerDTLS.poll)
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

_STATUS_CONNECTED :: Int
_STATUS_CONNECTED = 2

_STATUS_ERROR :: Int
_STATUS_ERROR = 3

_STATUS_DISCONNECTED :: Int
_STATUS_DISCONNECTED = 0

_STATUS_ERROR_HOSTNAME_MISMATCH :: Int
_STATUS_ERROR_HOSTNAME_MISMATCH = 4

_STATUS_HANDSHAKING :: Int
_STATUS_HANDSHAKING = 1

{-# NOINLINE bindPacketPeerDTLS_connect_to_peer #-}

-- | Connects a @peer@ beginning the DTLS handshake using the underlying @PacketPeerUDP@ which must be connected (see @method PacketPeerUDP.connect_to_host@). If @validate_certs@ is @true@, @PacketPeerDTLS@ will validate that the certificate presented by the remote peer and match it with the @for_hostname@ argument. You can specify a custom @X509Certificate@ to use for validation via the @valid_certificate@ argument.
bindPacketPeerDTLS_connect_to_peer :: MethodBind
bindPacketPeerDTLS_connect_to_peer
  = unsafePerformIO $
      withCString "PacketPeerDTLS" $
        \ clsNamePtr ->
          withCString "connect_to_peer" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Connects a @peer@ beginning the DTLS handshake using the underlying @PacketPeerUDP@ which must be connected (see @method PacketPeerUDP.connect_to_host@). If @validate_certs@ is @true@, @PacketPeerDTLS@ will validate that the certificate presented by the remote peer and match it with the @for_hostname@ argument. You can specify a custom @X509Certificate@ to use for validation via the @valid_certificate@ argument.
connect_to_peer ::
                  (PacketPeerDTLS :< cls, Object :< cls) =>
                  cls ->
                    PacketPeerUDP ->
                      Maybe Bool -> Maybe GodotString -> Maybe X509Certificate -> IO Int
connect_to_peer cls arg1 arg2 arg3 arg4
  = withVariantArray
      [toVariant arg1, maybe (VariantBool True) toVariant arg2,
       defaultedVariant VariantString "" arg3,
       maybe VariantNil toVariant arg4]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindPacketPeerDTLS_connect_to_peer
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod PacketPeerDTLS "connect_to_peer"
           '[PacketPeerUDP, Maybe Bool, Maybe GodotString,
             Maybe X509Certificate]
           (IO Int)
         where
        nodeMethod = Godot.Core.PacketPeerDTLS.connect_to_peer

{-# NOINLINE bindPacketPeerDTLS_disconnect_from_peer #-}

-- | Disconnects this peer, terminating the DTLS session.
bindPacketPeerDTLS_disconnect_from_peer :: MethodBind
bindPacketPeerDTLS_disconnect_from_peer
  = unsafePerformIO $
      withCString "PacketPeerDTLS" $
        \ clsNamePtr ->
          withCString "disconnect_from_peer" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Disconnects this peer, terminating the DTLS session.
disconnect_from_peer ::
                       (PacketPeerDTLS :< cls, Object :< cls) => cls -> IO ()
disconnect_from_peer cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindPacketPeerDTLS_disconnect_from_peer
           (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod PacketPeerDTLS "disconnect_from_peer" '[]
           (IO ())
         where
        nodeMethod = Godot.Core.PacketPeerDTLS.disconnect_from_peer

{-# NOINLINE bindPacketPeerDTLS_get_status #-}

-- | Returns the status of the connection. See @enum Status@ for values.
bindPacketPeerDTLS_get_status :: MethodBind
bindPacketPeerDTLS_get_status
  = unsafePerformIO $
      withCString "PacketPeerDTLS" $
        \ clsNamePtr ->
          withCString "get_status" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Returns the status of the connection. See @enum Status@ for values.
get_status ::
             (PacketPeerDTLS :< cls, Object :< cls) => cls -> IO Int
get_status cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindPacketPeerDTLS_get_status (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod PacketPeerDTLS "get_status" '[] (IO Int) where
        nodeMethod = Godot.Core.PacketPeerDTLS.get_status

{-# NOINLINE bindPacketPeerDTLS_poll #-}

-- | Poll the connection to check for incoming packets. Call this frequently to update the status and keep the connection working.
bindPacketPeerDTLS_poll :: MethodBind
bindPacketPeerDTLS_poll
  = unsafePerformIO $
      withCString "PacketPeerDTLS" $
        \ clsNamePtr ->
          withCString "poll" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Poll the connection to check for incoming packets. Call this frequently to update the status and keep the connection working.
poll :: (PacketPeerDTLS :< cls, Object :< cls) => cls -> IO ()
poll cls
  = withVariantArray []
      (\ (arrPtr, len) ->
         godot_method_bind_call bindPacketPeerDTLS_poll (upcast cls) arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod PacketPeerDTLS "poll" '[] (IO ()) where
        nodeMethod = Godot.Core.PacketPeerDTLS.poll