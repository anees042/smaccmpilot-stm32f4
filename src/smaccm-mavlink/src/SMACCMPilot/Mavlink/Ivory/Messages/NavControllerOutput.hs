{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Ivory.Messages.NavControllerOutput where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Ivory.Send
import SMACCMPilot.Mavlink.Ivory.Unpack

navControllerOutputMsgId :: Uint8
navControllerOutputMsgId = 62

navControllerOutputCrcExtra :: Uint8
navControllerOutputCrcExtra = 183

navControllerOutputModule :: Module
navControllerOutputModule = package "mavlink_nav_controller_output_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkNavControllerOutputSender
  incl navControllerOutputUnpack
  defStruct (Proxy :: Proxy "nav_controller_output_msg")
  wrappedPackMod navControllerOutputWrapper

[ivory|
struct nav_controller_output_msg
  { nav_roll :: Stored IFloat
  ; nav_pitch :: Stored IFloat
  ; alt_error :: Stored IFloat
  ; aspd_error :: Stored IFloat
  ; xtrack_error :: Stored IFloat
  ; nav_bearing :: Stored Sint16
  ; target_bearing :: Stored Sint16
  ; wp_dist :: Stored Uint16
  }
|]

mkNavControllerOutputSender ::
  Def ('[ ConstRef s0 (Struct "nav_controller_output_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkNavControllerOutputSender = makeMavlinkSender "nav_controller_output_msg" navControllerOutputMsgId navControllerOutputCrcExtra

instance MavlinkUnpackableMsg "nav_controller_output_msg" where
    unpackMsg = ( navControllerOutputUnpack , navControllerOutputMsgId )

navControllerOutputUnpack :: Def ('[ Ref s1 (Struct "nav_controller_output_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
navControllerOutputUnpack = proc "mavlink_nav_controller_output_unpack" $ \ msg buf -> body $ packGet packRep buf 0 msg

navControllerOutputWrapper :: WrappedPackRep (Struct "nav_controller_output_msg")
navControllerOutputWrapper = wrapPackRep "mavlink_nav_controller_output" $ packStruct
  [ packLabel nav_roll
  , packLabel nav_pitch
  , packLabel alt_error
  , packLabel aspd_error
  , packLabel xtrack_error
  , packLabel nav_bearing
  , packLabel target_bearing
  , packLabel wp_dist
  ]

instance Packable (Struct "nav_controller_output_msg") where
  packRep = wrappedPackRep navControllerOutputWrapper