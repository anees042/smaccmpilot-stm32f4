{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE RankNTypes #-}

module SMACCMPilot.Flight.Control.StatePID
  ( StatePID(..)
  , taskStatePID
  ) where

import Ivory.Language
import Ivory.Tower

import SMACCMPilot.Param
import SMACCMPilot.Flight.Control.PID
import SMACCMPilot.Flight.Param

data StatePID =
  StatePID
    { spid_init   :: forall eff . Ivory eff ()
    , spid_update :: forall eff . IFloat -- Setpoint
                               -> IFloat -- State Estimate
                               -> IFloat -- dt
                               -> Ivory eff ()
    , spid_output :: forall eff . Ivory eff IFloat
    , spid_reset  :: forall eff . Ivory eff ()
    , spid_debug  :: forall eff . Ivory eff (IFloat, IFloat, IFloat)
    }

taskStatePID :: PIDParams ParamReader -> String -> Task p StatePID
taskStatePID params username = do
  f <- fresh
  valid      <- taskLocal (username ++ "_valid")
  est_prev   <- taskLocal (username ++ "_est_prev")
  integral   <- taskLocal (username ++ "_integral")
  p_out      <- taskLocal (username ++ "_p_out")
  d_out      <- taskLocal (username ++ "_d_out")

  let named n = "statepid_" ++ username ++ "_" ++ n ++ "_" ++ (show f)

      update_proc :: Def ('[ IFloat
                        , IFloat
                        , IFloat
                        ] :-> ())
      update_proc = proc (named "update") $ \setpt state_est dt -> body $ do
        assert (dt >? 0)
        v <- deref valid
        store valid true
        cfg <- allocPIDParams params
        p_gain <-             (deref (cfg ~> pid_pGain))
        i_gain <- fmap (* dt) (deref (cfg ~> pid_iGain))
        d_gain <- fmap (/ dt) (deref (cfg ~> pid_dGain))
        i_max  <- deref (cfg ~> pid_iMax)

        err <- assign (setpt - state_est)

        i_prev <- deref integral
        i <- call fconstrain (-1*i_max) i_max (i_prev + (i_gain * err))
        store integral i

        est_p <- deref est_prev
        store est_prev state_est
        d <- assign (v ? (state_est - est_p, 0))

        store p_out (err * p_gain)
        store d_out (d * d_gain)

      output_proc :: Def ('[]:->IFloat)
      output_proc = proc (named "output") $ body $ do
        p <- deref p_out
        i <- deref integral
        d <- deref d_out
        ret (p + i - d)

      reset_proc :: Def ('[]:->())
      reset_proc = proc (named "reset") $ body $ do
        store valid false
        store integral 0

  taskModuleDef $ do
    incl update_proc
    incl output_proc
    incl reset_proc
    depend controlPIDModule
  return StatePID
    { spid_init   = call_ reset_proc
    , spid_update = call_ update_proc
    , spid_output = call  output_proc
    , spid_reset  = call_ reset_proc
    , spid_debug  = do
        p <- deref p_out
        i <- deref integral
        d <- deref d_out
        return (p,i,d)
    }


