{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RecordWildCards #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_haskell.py

module SMACCMPilot.Mavlink.Native.Messages.MissionCurrent where

import Data.Word
import Data.Int
import Data.Sized.Matrix (Vector)
import Data.Serialize
import SMACCMPilot.Mavlink.Native.Serialize

missionCurrentMsgId :: Word8
missionCurrentMsgId = 42

missionCurrentCrcExtra :: Word8
missionCurrentCrcExtra = 28

data MissionCurrentMsg =
  MissionCurrentMsg
    { mission_current_seq :: Word16
    }

getMissionCurrentMsg :: Get MissionCurrentMsg
getMissionCurrentMsg = do
  mission_current_seq <- get
  return MissionCurrentMsg{..}

putMissionCurrentMsg :: MissionCurrentMsg -> Put
putMissionCurrentMsg MissionCurrentMsg{..} = do
  put mission_current_seq

