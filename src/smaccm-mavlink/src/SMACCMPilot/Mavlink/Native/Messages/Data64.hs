{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RecordWildCards #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_haskell.py

module SMACCMPilot.Mavlink.Native.Messages.Data64 where

import Data.Word
import Data.Int
import Data.Sized.Matrix (Vector)
import Data.Serialize
import SMACCMPilot.Mavlink.Native.Serialize

data64MsgId :: Word8
data64MsgId = 171

data64CrcExtra :: Word8
data64CrcExtra = 170

data Data64Msg =
  Data64Msg
    { data64_type :: Word8
    , len :: Word8
    , data64 :: Vector 64 Word8
    }

getData64Msg :: Get Data64Msg
getData64Msg = do
  data64_type <- get
  len <- get
  data64 <- get
  return Data64Msg{..}

putData64Msg :: Data64Msg -> Put
putData64Msg Data64Msg{..} = do
  put data64_type
  put len
  put data64

