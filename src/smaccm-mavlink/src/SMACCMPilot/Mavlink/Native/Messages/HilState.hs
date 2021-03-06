{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RecordWildCards #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_haskell.py

module SMACCMPilot.Mavlink.Native.Messages.HilState where

import Data.Word
import Data.Int
import Data.Sized.Matrix (Vector)
import Data.Serialize
import SMACCMPilot.Mavlink.Native.Serialize

hilStateMsgId :: Word8
hilStateMsgId = 90

hilStateCrcExtra :: Word8
hilStateCrcExtra = 183

data HilStateMsg =
  HilStateMsg
    { time_usec :: Word64
    , roll :: Float
    , pitch :: Float
    , yaw :: Float
    , rollspeed :: Float
    , pitchspeed :: Float
    , yawspeed :: Float
    , lat :: Int16
    , lon :: Int16
    , alt :: Int16
    , vx :: Int16
    , vy :: Int16
    , vz :: Int16
    , xacc :: Int16
    , yacc :: Int16
    , zacc :: Int16
    }

getHilStateMsg :: Get HilStateMsg
getHilStateMsg = do
  time_usec <- get
  roll <- get
  pitch <- get
  yaw <- get
  rollspeed <- get
  pitchspeed <- get
  yawspeed <- get
  lat <- get
  lon <- get
  alt <- get
  vx <- get
  vy <- get
  vz <- get
  xacc <- get
  yacc <- get
  zacc <- get
  return HilStateMsg{..}

putHilStateMsg :: HilStateMsg -> Put
putHilStateMsg HilStateMsg{..} = do
  put time_usec
  put roll
  put pitch
  put yaw
  put rollspeed
  put pitchspeed
  put yawspeed
  put lat
  put lon
  put alt
  put vx
  put vy
  put vz
  put xacc
  put yacc
  put zacc

