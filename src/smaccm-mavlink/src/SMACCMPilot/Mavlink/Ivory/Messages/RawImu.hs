{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Ivory.Messages.RawImu where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Ivory.Send
import SMACCMPilot.Mavlink.Ivory.Unpack

rawImuMsgId :: Uint8
rawImuMsgId = 27

rawImuCrcExtra :: Uint8
rawImuCrcExtra = 144

rawImuModule :: Module
rawImuModule = package "mavlink_raw_imu_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkRawImuSender
  incl rawImuUnpack
  defStruct (Proxy :: Proxy "raw_imu_msg")
  wrappedPackMod rawImuWrapper

[ivory|
struct raw_imu_msg
  { time_usec :: Stored Uint64
  ; xacc :: Stored Sint16
  ; yacc :: Stored Sint16
  ; zacc :: Stored Sint16
  ; xgyro :: Stored Sint16
  ; ygyro :: Stored Sint16
  ; zgyro :: Stored Sint16
  ; xmag :: Stored Sint16
  ; ymag :: Stored Sint16
  ; zmag :: Stored Sint16
  }
|]

mkRawImuSender ::
  Def ('[ ConstRef s0 (Struct "raw_imu_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkRawImuSender = makeMavlinkSender "raw_imu_msg" rawImuMsgId rawImuCrcExtra

instance MavlinkUnpackableMsg "raw_imu_msg" where
    unpackMsg = ( rawImuUnpack , rawImuMsgId )

rawImuUnpack :: Def ('[ Ref s1 (Struct "raw_imu_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
rawImuUnpack = proc "mavlink_raw_imu_unpack" $ \ msg buf -> body $ packGet packRep buf 0 msg

rawImuWrapper :: WrappedPackRep (Struct "raw_imu_msg")
rawImuWrapper = wrapPackRep "mavlink_raw_imu" $ packStruct
  [ packLabel time_usec
  , packLabel xacc
  , packLabel yacc
  , packLabel zacc
  , packLabel xgyro
  , packLabel ygyro
  , packLabel zgyro
  , packLabel xmag
  , packLabel ymag
  , packLabel zmag
  ]

instance Packable (Struct "raw_imu_msg") where
  packRep = wrappedPackRep rawImuWrapper
