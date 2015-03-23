{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RecordWildCards #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_haskell.py

module SMACCMPilot.Mavlink.Native.Messages.AttitudeQuaternion where

import Data.Word
import Data.Int
import Data.Sized.Matrix (Vector)
import Data.Serialize
import SMACCMPilot.Mavlink.Native.Serialize

attitudeQuaternionMsgId :: Word8
attitudeQuaternionMsgId = 31

attitudeQuaternionCrcExtra :: Word8
attitudeQuaternionCrcExtra = 246

data AttitudeQuaternionMsg =
  AttitudeQuaternionMsg
    { time_boot_ms :: Word32
    , q1 :: Float
    , q2 :: Float
    , q3 :: Float
    , q4 :: Float
    , rollspeed :: Float
    , pitchspeed :: Float
    , yawspeed :: Float
    }

getAttitudeQuaternionMsg :: Get AttitudeQuaternionMsg
getAttitudeQuaternionMsg = do
  time_boot_ms <- get
  q1 <- get
  q2 <- get
  q3 <- get
  q4 <- get
  rollspeed <- get
  pitchspeed <- get
  yawspeed <- get
  return AttitudeQuaternionMsg{..}

putAttitudeQuaternionMsg :: AttitudeQuaternionMsg -> Put
putAttitudeQuaternionMsg AttitudeQuaternionMsg{..} = do
  put time_boot_ms
  put q1
  put q2
  put q3
  put q4
  put rollspeed
  put pitchspeed
  put yawspeed
