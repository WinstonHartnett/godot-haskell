{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving,
  TypeFamilies, TypeOperators, FlexibleContexts, DataKinds,
  MultiParamTypeClasses #-}
module Godot.Core.DTLSServer
       (Godot.Core.DTLSServer.setup,
        Godot.Core.DTLSServer.take_connection)
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

{-# NOINLINE bindDTLSServer_setup #-}

-- | Setup the DTLS server to use the given @private_key@ and provide the given @certificate@ to clients. You can pass the optional @chain@ parameter to provide additional CA chain information along with the certificate.
bindDTLSServer_setup :: MethodBind
bindDTLSServer_setup
  = unsafePerformIO $
      withCString "DTLSServer" $
        \ clsNamePtr ->
          withCString "setup" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Setup the DTLS server to use the given @private_key@ and provide the given @certificate@ to clients. You can pass the optional @chain@ parameter to provide additional CA chain information along with the certificate.
setup ::
        (DTLSServer :< cls, Object :< cls) =>
        cls ->
          CryptoKey -> X509Certificate -> Maybe X509Certificate -> IO Int
setup cls arg1 arg2 arg3
  = withVariantArray
      [toVariant arg1, toVariant arg2, maybe VariantNil toVariant arg3]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindDTLSServer_setup (upcast cls) arrPtr len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod DTLSServer "setup"
           '[CryptoKey, X509Certificate, Maybe X509Certificate]
           (IO Int)
         where
        nodeMethod = Godot.Core.DTLSServer.setup

{-# NOINLINE bindDTLSServer_take_connection #-}

-- | Try to initiate the DTLS handshake with the given @udp_peer@ which must be already connected (see @method PacketPeerUDP.connect_to_host@).
--   				__Note__: You must check that the state of the return PacketPeerUDP is @PacketPeerDTLS.STATUS_HANDSHAKING@, as it is normal that 50% of the new connections will be invalid due to cookie exchange.
bindDTLSServer_take_connection :: MethodBind
bindDTLSServer_take_connection
  = unsafePerformIO $
      withCString "DTLSServer" $
        \ clsNamePtr ->
          withCString "take_connection" $
            \ methodNamePtr ->
              godot_method_bind_get_method clsNamePtr methodNamePtr

-- | Try to initiate the DTLS handshake with the given @udp_peer@ which must be already connected (see @method PacketPeerUDP.connect_to_host@).
--   				__Note__: You must check that the state of the return PacketPeerUDP is @PacketPeerDTLS.STATUS_HANDSHAKING@, as it is normal that 50% of the new connections will be invalid due to cookie exchange.
take_connection ::
                  (DTLSServer :< cls, Object :< cls) =>
                  cls -> PacketPeerUDP -> IO PacketPeerDTLS
take_connection cls arg1
  = withVariantArray [toVariant arg1]
      (\ (arrPtr, len) ->
         godot_method_bind_call bindDTLSServer_take_connection (upcast cls)
           arrPtr
           len
           >>= \ (err, res) -> throwIfErr err >> fromGodotVariant res)

instance NodeMethod DTLSServer "take_connection" '[PacketPeerUDP]
           (IO PacketPeerDTLS)
         where
        nodeMethod = Godot.Core.DTLSServer.take_connection