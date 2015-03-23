{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Ivory.Messages.MissionItemReached where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Ivory.Send
import SMACCMPilot.Mavlink.Ivory.Unpack

missionItemReachedMsgId :: Uint8
missionItemReachedMsgId = 46

missionItemReachedCrcExtra :: Uint8
missionItemReachedCrcExtra = 11

missionItemReachedModule :: Module
missionItemReachedModule = package "mavlink_mission_item_reached_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkMissionItemReachedSender
  incl missionItemReachedUnpack
  defStruct (Proxy :: Proxy "mission_item_reached_msg")
  wrappedPackMod missionItemReachedWrapper

[ivory|
struct mission_item_reached_msg
  { mission_item_reached_seq :: Stored Uint16
  }
|]

mkMissionItemReachedSender ::
  Def ('[ ConstRef s0 (Struct "mission_item_reached_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkMissionItemReachedSender = makeMavlinkSender "mission_item_reached_msg" missionItemReachedMsgId missionItemReachedCrcExtra

instance MavlinkUnpackableMsg "mission_item_reached_msg" where
    unpackMsg = ( missionItemReachedUnpack , missionItemReachedMsgId )

missionItemReachedUnpack :: Def ('[ Ref s1 (Struct "mission_item_reached_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
missionItemReachedUnpack = proc "mavlink_mission_item_reached_unpack" $ \ msg buf -> body $ packGet packRep buf 0 msg

missionItemReachedWrapper :: WrappedPackRep (Struct "mission_item_reached_msg")
missionItemReachedWrapper = wrapPackRep "mavlink_mission_item_reached" $ packStruct
  [ packLabel mission_item_reached_seq
  ]

instance Packable (Struct "mission_item_reached_msg") where
  packRep = wrappedPackRep missionItemReachedWrapper