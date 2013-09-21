{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.Setpoint8dof where

import SMACCMPilot.Mavlink.Pack
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send

import Ivory.Language
import Ivory.Stdlib

setpoint8dofMsgId :: Uint8
setpoint8dofMsgId = 148

setpoint8dofCrcExtra :: Uint8
setpoint8dofCrcExtra = 241

setpoint8dofModule :: Module
setpoint8dofModule = package "mavlink_setpoint_8dof_msg" $ do
  depend packModule
  depend mavlinkSendModule
  incl mkSetpoint8dofSender
  incl setpoint8dofUnpack
  defStruct (Proxy :: Proxy "setpoint_8dof_msg")

[ivory|
struct setpoint_8dof_msg
  { val1 :: Stored IFloat
  ; val2 :: Stored IFloat
  ; val3 :: Stored IFloat
  ; val4 :: Stored IFloat
  ; val5 :: Stored IFloat
  ; val6 :: Stored IFloat
  ; val7 :: Stored IFloat
  ; val8 :: Stored IFloat
  ; target_system :: Stored Uint8
  }
|]

mkSetpoint8dofSender ::
  Def ('[ ConstRef s0 (Struct "setpoint_8dof_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Array 128 (Stored Uint8)) -- tx buffer
        ] :-> ())
mkSetpoint8dofSender =
  proc "mavlink_setpoint_8dof_msg_send"
  $ \msg seqNum sendArr -> body
  $ do
  arr <- local (iarray [] :: Init (Array 33 (Stored Uint8)))
  let buf = toCArray arr
  call_ pack buf 0 =<< deref (msg ~> val1)
  call_ pack buf 4 =<< deref (msg ~> val2)
  call_ pack buf 8 =<< deref (msg ~> val3)
  call_ pack buf 12 =<< deref (msg ~> val4)
  call_ pack buf 16 =<< deref (msg ~> val5)
  call_ pack buf 20 =<< deref (msg ~> val6)
  call_ pack buf 24 =<< deref (msg ~> val7)
  call_ pack buf 28 =<< deref (msg ~> val8)
  call_ pack buf 32 =<< deref (msg ~> target_system)
  -- 6: header len, 2: CRC len
  if arrayLen sendArr < (6 + 33 + 2 :: Integer)
    then error "setpoint8dof payload is too large for 33 sender!"
    else do -- Copy, leaving room for the payload
            _ <- arrCopy sendArr arr 6
            call_ mavlinkSendWithWriter
                    setpoint8dofMsgId
                    setpoint8dofCrcExtra
                    33
                    seqNum
                    sendArr
            retVoid

instance MavlinkUnpackableMsg "setpoint_8dof_msg" where
    unpackMsg = ( setpoint8dofUnpack , setpoint8dofMsgId )

setpoint8dofUnpack :: Def ('[ Ref s1 (Struct "setpoint_8dof_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
setpoint8dofUnpack = proc "mavlink_setpoint_8dof_unpack" $ \ msg buf -> body $ do
  store (msg ~> val1) =<< call unpack buf 0
  store (msg ~> val2) =<< call unpack buf 4
  store (msg ~> val3) =<< call unpack buf 8
  store (msg ~> val4) =<< call unpack buf 12
  store (msg ~> val5) =<< call unpack buf 16
  store (msg ~> val6) =<< call unpack buf 20
  store (msg ~> val7) =<< call unpack buf 24
  store (msg ~> val8) =<< call unpack buf 28
  store (msg ~> target_system) =<< call unpack buf 32

