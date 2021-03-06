{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RecordWildCards #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_haskell.py

module SMACCMPilot.Mavlink.Native.Messages.BatteryStatus where

import Data.Word
import Data.Int
import Data.Sized.Matrix (Vector)
import Data.Serialize
import SMACCMPilot.Mavlink.Native.Serialize

batteryStatusMsgId :: Word8
batteryStatusMsgId = 147

batteryStatusCrcExtra :: Word8
batteryStatusCrcExtra = 42

data BatteryStatusMsg =
  BatteryStatusMsg
    { voltage_cell_1 :: Word16
    , voltage_cell_2 :: Word16
    , voltage_cell_3 :: Word16
    , voltage_cell_4 :: Word16
    , voltage_cell_5 :: Word16
    , voltage_cell_6 :: Word16
    , current_battery :: Int16
    , accu_id :: Word8
    , battery_remaining :: Int8
    }

getBatteryStatusMsg :: Get BatteryStatusMsg
getBatteryStatusMsg = do
  voltage_cell_1 <- get
  voltage_cell_2 <- get
  voltage_cell_3 <- get
  voltage_cell_4 <- get
  voltage_cell_5 <- get
  voltage_cell_6 <- get
  current_battery <- get
  accu_id <- get
  battery_remaining <- get
  return BatteryStatusMsg{..}

putBatteryStatusMsg :: BatteryStatusMsg -> Put
putBatteryStatusMsg BatteryStatusMsg{..} = do
  put voltage_cell_1
  put voltage_cell_2
  put voltage_cell_3
  put voltage_cell_4
  put voltage_cell_5
  put voltage_cell_6
  put current_battery
  put accu_id
  put battery_remaining

