{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Ivory.Messages.VehCommsec where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Ivory.Send
import SMACCMPilot.Mavlink.Ivory.Unpack

vehCommsecMsgId :: Uint8
vehCommsecMsgId = 185

vehCommsecCrcExtra :: Uint8
vehCommsecCrcExtra = 112

vehCommsecModule :: Module
vehCommsecModule = package "mavlink_veh_commsec_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkVehCommsecSender
  incl vehCommsecUnpack
  defStruct (Proxy :: Proxy "veh_commsec_msg")
  wrappedPackMod vehCommsecWrapper

[ivory|
struct veh_commsec_msg
  { time :: Stored Uint32
  ; good_msgs :: Stored Uint32
  ; bad_msgs :: Stored Uint32
  ; commsec_err :: Stored Uint8
  }
|]

mkVehCommsecSender ::
  Def ('[ ConstRef s0 (Struct "veh_commsec_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkVehCommsecSender = makeMavlinkSender "veh_commsec_msg" vehCommsecMsgId vehCommsecCrcExtra

instance MavlinkUnpackableMsg "veh_commsec_msg" where
    unpackMsg = ( vehCommsecUnpack , vehCommsecMsgId )

vehCommsecUnpack :: Def ('[ Ref s1 (Struct "veh_commsec_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
vehCommsecUnpack = proc "mavlink_veh_commsec_unpack" $ \ msg buf -> body $ packGet packRep buf 0 msg

vehCommsecWrapper :: WrappedPackRep (Struct "veh_commsec_msg")
vehCommsecWrapper = wrapPackRep "mavlink_veh_commsec" $ packStruct
  [ packLabel time
  , packLabel good_msgs
  , packLabel bad_msgs
  , packLabel commsec_err
  ]

instance Packable (Struct "veh_commsec_msg") where
  packRep = wrappedPackRep vehCommsecWrapper