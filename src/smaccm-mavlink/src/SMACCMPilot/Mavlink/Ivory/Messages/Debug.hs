{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Ivory.Messages.Debug where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Ivory.Send
import SMACCMPilot.Mavlink.Ivory.Unpack

debugMsgId :: Uint8
debugMsgId = 254

debugCrcExtra :: Uint8
debugCrcExtra = 46

debugModule :: Module
debugModule = package "mavlink_debug_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkDebugSender
  incl debugUnpack
  defStruct (Proxy :: Proxy "debug_msg")
  wrappedPackMod debugWrapper

[ivory|
struct debug_msg
  { time_boot_ms :: Stored Uint32
  ; value :: Stored IFloat
  ; ind :: Stored Uint8
  }
|]

mkDebugSender ::
  Def ('[ ConstRef s0 (Struct "debug_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkDebugSender = makeMavlinkSender "debug_msg" debugMsgId debugCrcExtra

instance MavlinkUnpackableMsg "debug_msg" where
    unpackMsg = ( debugUnpack , debugMsgId )

debugUnpack :: Def ('[ Ref s1 (Struct "debug_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
debugUnpack = proc "mavlink_debug_unpack" $ \ msg buf -> body $ packGet packRep buf 0 msg

debugWrapper :: WrappedPackRep (Struct "debug_msg")
debugWrapper = wrapPackRep "mavlink_debug" $ packStruct
  [ packLabel time_boot_ms
  , packLabel value
  , packLabel ind
  ]

instance Packable (Struct "debug_msg") where
  packRep = wrappedPackRep debugWrapper
