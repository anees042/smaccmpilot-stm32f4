{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Ivory.Messages.SetGlobalPositionSetpointInt where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Ivory.Send
import SMACCMPilot.Mavlink.Ivory.Unpack

setGlobalPositionSetpointIntMsgId :: Uint8
setGlobalPositionSetpointIntMsgId = 53

setGlobalPositionSetpointIntCrcExtra :: Uint8
setGlobalPositionSetpointIntCrcExtra = 33

setGlobalPositionSetpointIntModule :: Module
setGlobalPositionSetpointIntModule = package "mavlink_set_global_position_setpoint_int_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkSetGlobalPositionSetpointIntSender
  incl setGlobalPositionSetpointIntUnpack
  defStruct (Proxy :: Proxy "set_global_position_setpoint_int_msg")
  wrappedPackMod setGlobalPositionSetpointIntWrapper

[ivory|
struct set_global_position_setpoint_int_msg
  { latitude :: Stored Sint32
  ; longitude :: Stored Sint32
  ; altitude :: Stored Sint32
  ; yaw :: Stored Sint16
  ; coordinate_frame :: Stored Uint8
  }
|]

mkSetGlobalPositionSetpointIntSender ::
  Def ('[ ConstRef s0 (Struct "set_global_position_setpoint_int_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkSetGlobalPositionSetpointIntSender = makeMavlinkSender "set_global_position_setpoint_int_msg" setGlobalPositionSetpointIntMsgId setGlobalPositionSetpointIntCrcExtra

instance MavlinkUnpackableMsg "set_global_position_setpoint_int_msg" where
    unpackMsg = ( setGlobalPositionSetpointIntUnpack , setGlobalPositionSetpointIntMsgId )

setGlobalPositionSetpointIntUnpack :: Def ('[ Ref s1 (Struct "set_global_position_setpoint_int_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
setGlobalPositionSetpointIntUnpack = proc "mavlink_set_global_position_setpoint_int_unpack" $ \ msg buf -> body $ packGet packRep buf 0 msg

setGlobalPositionSetpointIntWrapper :: WrappedPackRep (Struct "set_global_position_setpoint_int_msg")
setGlobalPositionSetpointIntWrapper = wrapPackRep "mavlink_set_global_position_setpoint_int" $ packStruct
  [ packLabel latitude
  , packLabel longitude
  , packLabel altitude
  , packLabel yaw
  , packLabel coordinate_frame
  ]

instance Packable (Struct "set_global_position_setpoint_int_msg") where
  packRep = wrappedPackRep setGlobalPositionSetpointIntWrapper