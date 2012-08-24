module Model where

import Data.Time.Clock

data Game = Game {
	  active :: Bool,
	  lastLogicTick :: UTCTime,
	  lastPaintTick :: UTCTime,
	  constants :: GameConstans
	}

data GameConstans = GameConstans {
	  millisBetweenLogic :: Int,
	  millisBetweenPaint :: Int
	}
