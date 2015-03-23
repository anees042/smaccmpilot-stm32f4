{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Ivory.Messages.Ping where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Ivory.Send
import SMACCMPilot.Mavlink.Ivory.Unpack

pingMsgId :: Uint8
pingMsgId = 4

pingCrcExtra :: Uint8
pingCrcExtra = 237

pingModule :: Module
pingModule = package "mavlink_ping_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkPingSender
  incl pingUnpack
  defStruct (Proxy :: Proxy "ping_msg")
  wrappedPackMod pingWrapper

[ivory|
struct ping_msg
  { time_usec :: Stored Uint64
  ; ping_seq :: Stored Uint32
  ; target_system :: Stored Uint8
  ; target_component :: Stored Uint8
  }
|]

mkPingSender ::
  Def ('[ ConstRef s0 (Struct "ping_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkPingSender = makeMavlinkSender "ping_msg" pingMsgId pingCrcExtra

instance MavlinkUnpackableMsg "ping_msg" where
    unpackMsg = ( pingUnpack , pingMsgId )

pingUnpack :: Def ('[ Ref s1 (Struct "ping_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
pingUnpack = proc "mavlink_ping_unpack" $ \ msg buf -> body $ packGet packRep buf 0 msg

pingWrapper :: WrappedPackRep (Struct "ping_msg")
pingWrapper = wrapPackRep "mavlink_ping" $ packStruct
  [ packLabel time_usec
  , packLabel ping_seq
  , packLabel target_system
  , packLabel target_component
  ]

instance Packable (Struct "ping_msg") where
  packRep = wrappedPackRep pingWrapper