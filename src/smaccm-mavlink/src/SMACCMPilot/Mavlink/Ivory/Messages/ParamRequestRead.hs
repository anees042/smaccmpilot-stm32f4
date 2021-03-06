{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Ivory.Messages.ParamRequestRead where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Ivory.Send
import SMACCMPilot.Mavlink.Ivory.Unpack

paramRequestReadMsgId :: Uint8
paramRequestReadMsgId = 20

paramRequestReadCrcExtra :: Uint8
paramRequestReadCrcExtra = 214

paramRequestReadModule :: Module
paramRequestReadModule = package "mavlink_param_request_read_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkParamRequestReadSender
  incl paramRequestReadUnpack
  defStruct (Proxy :: Proxy "param_request_read_msg")
  wrappedPackMod paramRequestReadWrapper

[ivory|
struct param_request_read_msg
  { param_index :: Stored Sint16
  ; target_system :: Stored Uint8
  ; target_component :: Stored Uint8
  ; param_id :: Array 16 (Stored Uint8)
  }
|]

mkParamRequestReadSender ::
  Def ('[ ConstRef s0 (Struct "param_request_read_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkParamRequestReadSender = makeMavlinkSender "param_request_read_msg" paramRequestReadMsgId paramRequestReadCrcExtra

instance MavlinkUnpackableMsg "param_request_read_msg" where
    unpackMsg = ( paramRequestReadUnpack , paramRequestReadMsgId )

paramRequestReadUnpack :: Def ('[ Ref s1 (Struct "param_request_read_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
paramRequestReadUnpack = proc "mavlink_param_request_read_unpack" $ \ msg buf -> body $ packGet packRep buf 0 msg

paramRequestReadWrapper :: WrappedPackRep (Struct "param_request_read_msg")
paramRequestReadWrapper = wrapPackRep "mavlink_param_request_read" $ packStruct
  [ packLabel param_index
  , packLabel target_system
  , packLabel target_component
  , packLabel param_id
  ]

instance Packable (Struct "param_request_read_msg") where
  packRep = wrappedPackRep paramRequestReadWrapper
