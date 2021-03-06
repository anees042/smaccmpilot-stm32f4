{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Ivory.Messages.NamedValueInt where

import Ivory.Language
import Ivory.Serialize
import SMACCMPilot.Mavlink.Ivory.Send
import SMACCMPilot.Mavlink.Ivory.Unpack

namedValueIntMsgId :: Uint8
namedValueIntMsgId = 252

namedValueIntCrcExtra :: Uint8
namedValueIntCrcExtra = 44

namedValueIntModule :: Module
namedValueIntModule = package "mavlink_named_value_int_msg" $ do
  depend serializeModule
  depend mavlinkSendModule
  incl mkNamedValueIntSender
  incl namedValueIntUnpack
  defStruct (Proxy :: Proxy "named_value_int_msg")
  wrappedPackMod namedValueIntWrapper

[ivory|
struct named_value_int_msg
  { time_boot_ms :: Stored Uint32
  ; value :: Stored Sint32
  ; name :: Array 10 (Stored Uint8)
  }
|]

mkNamedValueIntSender ::
  Def ('[ ConstRef s0 (Struct "named_value_int_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Struct "mavlinkPacket") -- tx buffer/length
        ] :-> ())
mkNamedValueIntSender = makeMavlinkSender "named_value_int_msg" namedValueIntMsgId namedValueIntCrcExtra

instance MavlinkUnpackableMsg "named_value_int_msg" where
    unpackMsg = ( namedValueIntUnpack , namedValueIntMsgId )

namedValueIntUnpack :: Def ('[ Ref s1 (Struct "named_value_int_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
namedValueIntUnpack = proc "mavlink_named_value_int_unpack" $ \ msg buf -> body $ packGet packRep buf 0 msg

namedValueIntWrapper :: WrappedPackRep (Struct "named_value_int_msg")
namedValueIntWrapper = wrapPackRep "mavlink_named_value_int" $ packStruct
  [ packLabel time_boot_ms
  , packLabel value
  , packLabel name
  ]

instance Packable (Struct "named_value_int_msg") where
  packRep = wrappedPackRep namedValueIntWrapper
