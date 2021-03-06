{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RecordWildCards #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_haskell.py

module SMACCMPilot.Mavlink.Native.Messages.Attitude where

import Data.Word
import Data.Int
import Data.Sized.Matrix (Vector)
import Data.Serialize
import SMACCMPilot.Mavlink.Native.Serialize

attitudeMsgId :: Word8
attitudeMsgId = 30

attitudeCrcExtra :: Word8
attitudeCrcExtra = 39

data AttitudeMsg =
  AttitudeMsg
    { time_boot_ms :: Word32
    , roll :: Float
    , pitch :: Float
    , yaw :: Float
    , rollspeed :: Float
    , pitchspeed :: Float
    , yawspeed :: Float
    }

getAttitudeMsg :: Get AttitudeMsg
getAttitudeMsg = do
  time_boot_ms <- get
  roll <- get
  pitch <- get
  yaw <- get
  rollspeed <- get
  pitchspeed <- get
  yawspeed <- get
  return AttitudeMsg{..}

putAttitudeMsg :: AttitudeMsg -> Put
putAttitudeMsg AttitudeMsg{..} = do
  put time_boot_ms
  put roll
  put pitch
  put yaw
  put rollspeed
  put pitchspeed
  put yawspeed

