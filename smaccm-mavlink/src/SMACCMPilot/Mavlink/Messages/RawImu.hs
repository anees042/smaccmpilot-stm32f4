{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavlink_ivory.py

module SMACCMPilot.Mavlink.Messages.RawImu where

import SMACCMPilot.Mavlink.Pack
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send

import Ivory.Language

rawImuMsgId :: Uint8
rawImuMsgId = 27

rawImuCrcExtra :: Uint8
rawImuCrcExtra = 144

rawImuModule :: Module
rawImuModule = package "mavlink_raw_imu_msg" $ do
  depend packModule
  incl rawImuUnpack
  defStruct (Proxy :: Proxy "raw_imu_msg")

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

mkRawImuSender :: SizedMavlinkSender 26
                       -> Def ('[ ConstRef s (Struct "raw_imu_msg") ] :-> ())
mkRawImuSender sender =
  proc ("mavlink_raw_imu_msg_send" ++ (senderName sender)) $ \msg -> body $ do
    rawImuPack (senderMacro sender) msg

instance MavlinkSendable "raw_imu_msg" 26 where
  mkSender = mkRawImuSender

rawImuPack :: (eff `AllocsIn` s, eff `Returns` ())
                  => SenderMacro eff s 26
                  -> ConstRef s1 (Struct "raw_imu_msg")
                  -> Ivory eff ()
rawImuPack sender msg = do
  arr <- local (iarray [] :: Init (Array 26 (Stored Uint8)))
  let buf = toCArray arr
  call_ pack buf 0 =<< deref (msg ~> time_usec)
  call_ pack buf 8 =<< deref (msg ~> xacc)
  call_ pack buf 10 =<< deref (msg ~> yacc)
  call_ pack buf 12 =<< deref (msg ~> zacc)
  call_ pack buf 14 =<< deref (msg ~> xgyro)
  call_ pack buf 16 =<< deref (msg ~> ygyro)
  call_ pack buf 18 =<< deref (msg ~> zgyro)
  call_ pack buf 20 =<< deref (msg ~> xmag)
  call_ pack buf 22 =<< deref (msg ~> ymag)
  call_ pack buf 24 =<< deref (msg ~> zmag)
  sender rawImuMsgId (constRef arr) rawImuCrcExtra
  retVoid

instance MavlinkUnpackableMsg "raw_imu_msg" where
    unpackMsg = ( rawImuUnpack , rawImuMsgId )

rawImuUnpack :: Def ('[ Ref s1 (Struct "raw_imu_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
rawImuUnpack = proc "mavlink_raw_imu_unpack" $ \ msg buf -> body $ do
  store (msg ~> time_usec) =<< call unpack buf 0
  store (msg ~> xacc) =<< call unpack buf 8
  store (msg ~> yacc) =<< call unpack buf 10
  store (msg ~> zacc) =<< call unpack buf 12
  store (msg ~> xgyro) =<< call unpack buf 14
  store (msg ~> ygyro) =<< call unpack buf 16
  store (msg ~> zgyro) =<< call unpack buf 18
  store (msg ~> xmag) =<< call unpack buf 20
  store (msg ~> ymag) =<< call unpack buf 22
  store (msg ~> zmag) =<< call unpack buf 24
