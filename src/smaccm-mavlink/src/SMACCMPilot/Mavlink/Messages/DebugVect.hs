{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Autogenerated Mavlink v1.0 implementation: see smavgen_ivory.py

module SMACCMPilot.Mavlink.Messages.DebugVect where

import SMACCMPilot.Mavlink.Pack
import SMACCMPilot.Mavlink.Unpack
import SMACCMPilot.Mavlink.Send

import Ivory.Language
import Ivory.Stdlib

debugVectMsgId :: Uint8
debugVectMsgId = 250

debugVectCrcExtra :: Uint8
debugVectCrcExtra = 49

debugVectModule :: Module
debugVectModule = package "mavlink_debug_vect_msg" $ do
  depend packModule
  depend mavlinkSendModule
  incl mkDebugVectSender
  incl debugVectUnpack
  defStruct (Proxy :: Proxy "debug_vect_msg")

[ivory|
struct debug_vect_msg
  { time_usec :: Stored Uint64
  ; x :: Stored IFloat
  ; y :: Stored IFloat
  ; z :: Stored IFloat
  ; name :: Array 10 (Stored Uint8)
  }
|]

mkDebugVectSender ::
  Def ('[ ConstRef s0 (Struct "debug_vect_msg")
        , Ref s1 (Stored Uint8) -- seqNum
        , Ref s1 (Array 128 (Stored Uint8)) -- tx buffer
        ] :-> ())
mkDebugVectSender =
  proc "mavlink_debug_vect_msg_send"
  $ \msg seqNum sendArr -> body
  $ do
  arr <- local (iarray [] :: Init (Array 30 (Stored Uint8)))
  let buf = toCArray arr
  call_ pack buf 0 =<< deref (msg ~> time_usec)
  call_ pack buf 8 =<< deref (msg ~> x)
  call_ pack buf 12 =<< deref (msg ~> y)
  call_ pack buf 16 =<< deref (msg ~> z)
  arrayPack buf 20 (msg ~> name)
  -- 6: header len, 2: CRC len
  if arrayLen sendArr < (6 + 30 + 2 :: Integer)
    then error "debugVect payload is too large for 30 sender!"
    else do -- Copy, leaving room for the payload
            _ <- arrCopy sendArr arr 6
            call_ mavlinkSendWithWriter
                    debugVectMsgId
                    debugVectCrcExtra
                    30
                    seqNum
                    sendArr
            retVoid

instance MavlinkUnpackableMsg "debug_vect_msg" where
    unpackMsg = ( debugVectUnpack , debugVectMsgId )

debugVectUnpack :: Def ('[ Ref s1 (Struct "debug_vect_msg")
                             , ConstRef s2 (CArray (Stored Uint8))
                             ] :-> () )
debugVectUnpack = proc "mavlink_debug_vect_unpack" $ \ msg buf -> body $ do
  store (msg ~> time_usec) =<< call unpack buf 0
  store (msg ~> x) =<< call unpack buf 8
  store (msg ~> y) =<< call unpack buf 12
  store (msg ~> z) =<< call unpack buf 16
  arrayUnpack buf 20 (msg ~> name)

