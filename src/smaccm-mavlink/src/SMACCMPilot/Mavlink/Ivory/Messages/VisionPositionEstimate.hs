{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Ivory.Messages.VisionPositionEstimate where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Ivory.Send
import SMACCMPilot.Mavlink.Ivory.Unpack

visionPositionEstimateMsgId :: Uint8
visionPositionEstimateMsgId = 102

visionPositionEstimateCrcExtra :: Uint8
visionPositionEstimateCrcExtra = 158

visionPositionEstimateModule :: Module
visionPositionEstimateModule = package "mavlink_vision_position_estimate_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkVisionPositionEstimateSender
  incl visionPositionEstimateUnpack
  defStruct (Proxy :: Proxy "vision_position_estimate_msg")
  wrappedPackMod visionPositionEstimateWrapper

[ivory|
struct vision_position_estimate_msg
  { usec :: Stored Uint64
  ; x :: Stored IFloat
  ; y :: Stored IFloat
  ; z :: Stored IFloat
  ; roll :: Stored IFloat
  ; pitch :: Stored IFloat
  ; yaw :: Stored IFloat
  }
|]

mkVisionPositionEstimateSender ::
  Def ('[ ConstRef s0 (Struct "vision_position_estimate_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkVisionPositionEstimateSender = makeMavlinkSender "vision_position_estimate_msg" visionPositionEstimateMsgId visionPositionEstimateCrcExtra

instance MavlinkUnpackableMsg "vision_position_estimate_msg" where
    unpackMsg = ( visionPositionEstimateUnpack , visionPositionEstimateMsgId )

visionPositionEstimateUnpack :: Def ('[ Ref s1 (Struct "vision_position_estimate_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
visionPositionEstimateUnpack = proc "mavlink_vision_position_estimate_unpack" $ \ msg buf -> body $ packGet packRep buf 0 msg

visionPositionEstimateWrapper :: WrappedPackRep (Struct "vision_position_estimate_msg")
visionPositionEstimateWrapper = wrapPackRep "mavlink_vision_position_estimate" $ packStruct
  [ packLabel usec
  , packLabel x
  , packLabel y
  , packLabel z
  , packLabel roll
  , packLabel pitch
  , packLabel yaw
  ]

instance Packable (Struct "vision_position_estimate_msg") where
  packRep = wrappedPackRep visionPositionEstimateWrapper