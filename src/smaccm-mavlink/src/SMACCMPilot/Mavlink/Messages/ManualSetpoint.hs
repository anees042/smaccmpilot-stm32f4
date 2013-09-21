{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.ManualSetpoint where

import SMACCMPilot.Mavlink.Pack
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send

import Ivory.Language
import Ivory.Stdlib

manualSetpointMsgId :: Uint8
manualSetpointMsgId = 81

manualSetpointCrcExtra :: Uint8
manualSetpointCrcExtra = 106

manualSetpointModule :: Module
manualSetpointModule = package "mavlink_manual_setpoint_msg" $ do
  depend packModule
  depend mavlinkSendModule
  incl mkManualSetpointSender
  incl manualSetpointUnpack
  defStruct (Proxy :: Proxy "manual_setpoint_msg")

[ivory|
struct manual_setpoint_msg
  { time_boot_ms :: Stored Uint32
  ; roll :: Stored IFloat
  ; pitch :: Stored IFloat
  ; yaw :: Stored IFloat
  ; thrust :: Stored IFloat
  ; mode_switch :: Stored Uint8
  ; manual_override_switch :: Stored Uint8
  }
|]

mkManualSetpointSender ::
  Def ('[ ConstRef s0 (Struct "manual_setpoint_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Array 128 (Stored Uint8)) -- tx buffer
        ] :-> ())
mkManualSetpointSender =
  proc "mavlink_manual_setpoint_msg_send"
  $ \msg seqNum sendArr -> body
  $ do
  arr <- local (iarray [] :: Init (Array 22 (Stored Uint8)))
  let buf = toCArray arr
  call_ pack buf 0 =<< deref (msg ~> time_boot_ms)
  call_ pack buf 4 =<< deref (msg ~> roll)
  call_ pack buf 8 =<< deref (msg ~> pitch)
  call_ pack buf 12 =<< deref (msg ~> yaw)
  call_ pack buf 16 =<< deref (msg ~> thrust)
  call_ pack buf 20 =<< deref (msg ~> mode_switch)
  call_ pack buf 21 =<< deref (msg ~> manual_override_switch)
  -- 6: header len, 2: CRC len
  if arrayLen sendArr < (6 + 22 + 2 :: Integer)
    then error "manualSetpoint payload is too large for 22 sender!"
    else do -- Copy, leaving room for the payload
            _ <- arrCopy sendArr arr 6
            call_ mavlinkSendWithWriter
                    manualSetpointMsgId
                    manualSetpointCrcExtra
                    22
                    seqNum
                    sendArr
            retVoid

instance MavlinkUnpackableMsg "manual_setpoint_msg" where
    unpackMsg = ( manualSetpointUnpack , manualSetpointMsgId )

manualSetpointUnpack :: Def ('[ Ref s1 (Struct "manual_setpoint_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
manualSetpointUnpack = proc "mavlink_manual_setpoint_unpack" $ \ msg buf -> body $ do
  store (msg ~> time_boot_ms) =<< call unpack buf 0
  store (msg ~> roll) =<< call unpack buf 4
  store (msg ~> pitch) =<< call unpack buf 8
  store (msg ~> yaw) =<< call unpack buf 12
  store (msg ~> thrust) =<< call unpack buf 16
  store (msg ~> mode_switch) =<< call unpack buf 20
  store (msg ~> manual_override_switch) =<< call unpack buf 21

