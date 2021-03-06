{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RecordWildCards #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_haskell.py

module SMACCMPilot.Mavlink.Native.Messages.RawImu where

import Data.Word
import Data.Int
import Data.Sized.Matrix (Vector)
import Data.Serialize
import SMACCMPilot.Mavlink.Native.Serialize

rawImuMsgId :: Word8
rawImuMsgId = 27

rawImuCrcExtra :: Word8
rawImuCrcExtra = 144

data RawImuMsg =
  RawImuMsg
    { time_usec :: Word64
    , xacc :: Int16
    , yacc :: Int16
    , zacc :: Int16
    , xgyro :: Int16
    , ygyro :: Int16
    , zgyro :: Int16
    , xmag :: Int16
    , ymag :: Int16
    , zmag :: Int16
    }

getRawImuMsg :: Get RawImuMsg
getRawImuMsg = do
  time_usec <- get
  xacc <- get
  yacc <- get
  zacc <- get
  xgyro <- get
  ygyro <- get
  zgyro <- get
  xmag <- get
  ymag <- get
  zmag <- get
  return RawImuMsg{..}

putRawImuMsg :: RawImuMsg -> Put
putRawImuMsg RawImuMsg{..} = do
  put time_usec
  put xacc
  put yacc
  put zacc
  put xgyro
  put ygyro
  put zgyro
  put xmag
  put ymag
  put zmag

