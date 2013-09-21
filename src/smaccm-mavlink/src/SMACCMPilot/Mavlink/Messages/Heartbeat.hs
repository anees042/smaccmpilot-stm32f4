{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.Heartbeat where

import SMACCMPilot.Mavlink.Pack
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send

import Ivory.Language
import Ivory.Stdlib

heartbeatMsgId :: Uint8
heartbeatMsgId = 0

heartbeatCrcExtra :: Uint8
heartbeatCrcExtra = 50

heartbeatModule :: Module
heartbeatModule = package "mavlink_heartbeat_msg" $ do
  depend packModule
  depend mavlinkSendModule
  incl mkHeartbeatSender
  incl heartbeatUnpack
  defStruct (Proxy :: Proxy "heartbeat_msg")

[ivory|
struct heartbeat_msg
  { custom_mode :: Stored Uint32
  ; mavtype :: Stored Uint8
  ; autopilot :: Stored Uint8
  ; base_mode :: Stored Uint8
  ; system_status :: Stored Uint8
  ; mavlink_version :: Stored Uint8
  }
|]

mkHeartbeatSender ::
  Def ('[ ConstRef s0 (Struct "heartbeat_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Array 128 (Stored Uint8)) -- tx buffer
        ] :-> ())
mkHeartbeatSender =
  proc "mavlink_heartbeat_msg_send"
  $ \msg seqNum sendArr -> body
  $ do
  arr <- local (iarray [] :: Init (Array 9 (Stored Uint8)))
  let buf = toCArray arr
  call_ pack buf 0 =<< deref (msg ~> custom_mode)
  call_ pack buf 4 =<< deref (msg ~> mavtype)
  call_ pack buf 5 =<< deref (msg ~> autopilot)
  call_ pack buf 6 =<< deref (msg ~> base_mode)
  call_ pack buf 7 =<< deref (msg ~> system_status)
  call_ pack buf 8 =<< deref (msg ~> mavlink_version)
  -- 6: header len, 2: CRC len
  if arrayLen sendArr < (6 + 9 + 2 :: Integer)
    then error "heartbeat payload is too large for 9 sender!"
    else do -- Copy, leaving room for the payload
            _ <- arrCopy sendArr arr 6
            call_ mavlinkSendWithWriter
                    heartbeatMsgId
                    heartbeatCrcExtra
                    9
                    seqNum
                    sendArr
            retVoid

instance MavlinkUnpackableMsg "heartbeat_msg" where
    unpackMsg = ( heartbeatUnpack , heartbeatMsgId )

heartbeatUnpack :: Def ('[ Ref s1 (Struct "heartbeat_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
heartbeatUnpack = proc "mavlink_heartbeat_unpack" $ \ msg buf -> body $ do
  store (msg ~> custom_mode) =<< call unpack buf 0
  store (msg ~> mavtype) =<< call unpack buf 4
  store (msg ~> autopilot) =<< call unpack buf 5
  store (msg ~> base_mode) =<< call unpack buf 6
  store (msg ~> system_status) =<< call unpack buf 7
  store (msg ~> mavlink_version) =<< call unpack buf 8

