{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RecordWildCards #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_haskell.py

module SMACCMPilot.Mavlink.Native.Messages.MissionRequestList where

import Data.Word
import Data.Int
import Data.Sized.Matrix (Vector)
import Data.Serialize
import SMACCMPilot.Mavlink.Native.Serialize

missionRequestListMsgId :: Word8
missionRequestListMsgId = 43

missionRequestListCrcExtra :: Word8
missionRequestListCrcExtra = 132

data MissionRequestListMsg =
  MissionRequestListMsg
    { target_system :: Word8
    , target_component :: Word8
    }

getMissionRequestListMsg :: Get MissionRequestListMsg
getMissionRequestListMsg = do
  target_system <- get
  target_component <- get
  return MissionRequestListMsg{..}

putMissionRequestListMsg :: MissionRequestListMsg -> Put
putMissionRequestListMsg MissionRequestListMsg{..} = do
  put target_system
  put target_component

