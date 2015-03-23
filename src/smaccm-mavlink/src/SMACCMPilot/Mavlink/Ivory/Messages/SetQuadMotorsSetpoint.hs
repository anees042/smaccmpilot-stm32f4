{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Ivory.Messages.SetQuadMotorsSetpoint where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Ivory.Send
import SMACCMPilot.Mavlink.Ivory.Unpack

setQuadMotorsSetpointMsgId :: Uint8
setQuadMotorsSetpointMsgId = 60

setQuadMotorsSetpointCrcExtra :: Uint8
setQuadMotorsSetpointCrcExtra = 30

setQuadMotorsSetpointModule :: Module
setQuadMotorsSetpointModule = package "mavlink_set_quad_motors_setpoint_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkSetQuadMotorsSetpointSender
  incl setQuadMotorsSetpointUnpack
  defStruct (Proxy :: Proxy "set_quad_motors_setpoint_msg")
  wrappedPackMod setQuadMotorsSetpointWrapper

[ivory|
struct set_quad_motors_setpoint_msg
  { motor_front_nw :: Stored Uint16
  ; motor_right_ne :: Stored Uint16
  ; motor_back_se :: Stored Uint16
  ; motor_left_sw :: Stored Uint16
  ; target_system :: Stored Uint8
  }
|]

mkSetQuadMotorsSetpointSender ::
  Def ('[ ConstRef s0 (Struct "set_quad_motors_setpoint_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkSetQuadMotorsSetpointSender = makeMavlinkSender "set_quad_motors_setpoint_msg" setQuadMotorsSetpointMsgId setQuadMotorsSetpointCrcExtra

instance MavlinkUnpackableMsg "set_quad_motors_setpoint_msg" where
    unpackMsg = ( setQuadMotorsSetpointUnpack , setQuadMotorsSetpointMsgId )

setQuadMotorsSetpointUnpack :: Def ('[ Ref s1 (Struct "set_quad_motors_setpoint_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
setQuadMotorsSetpointUnpack = proc "mavlink_set_quad_motors_setpoint_unpack" $ \ msg buf -> body $ packGet packRep buf 0 msg

setQuadMotorsSetpointWrapper :: WrappedPackRep (Struct "set_quad_motors_setpoint_msg")
setQuadMotorsSetpointWrapper = wrapPackRep "mavlink_set_quad_motors_setpoint" $ packStruct
  [ packLabel motor_front_nw
  , packLabel motor_right_ne
  , packLabel motor_back_se
  , packLabel motor_left_sw
  , packLabel target_system
  ]

instance Packable (Struct "set_quad_motors_setpoint_msg") where
  packRep = wrappedPackRep setQuadMotorsSetpointWrapper