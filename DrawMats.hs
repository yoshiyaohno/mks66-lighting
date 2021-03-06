module DrawMats where

import Data.Array.Unboxed
import Line
import Screen
import Solids
import Transform

type Args = [String]
data DrawMats =
     DrawMats { getScreen :: Screen
              , getZBuf   :: ZBuf
              , getTStack :: [Transform Double]
              }

emptyDM :: DrawMats
emptyDM = DrawMats
    { getScreen = emptyScreen blk (1000, 1000)
    , getTStack = [ident]
    , getZBuf   = emptyZB (1000, 1000)
    }

trTris :: DrawMats -> [Triangle Double] -> [Triangle Double]
trTris dm = map (trTriangle $ getTransform dm)

modScreen :: (Screen -> Screen) -> DrawMats -> DrawMats
modScreen f dm = dm { getScreen = f $ getScreen dm }

getTransform :: DrawMats -> Transform Double
getTransform = head . getTStack

popTransform :: DrawMats -> DrawMats
popTransform dm = dm { getTStack = tail $ getTStack dm }

pushTransform :: DrawMats -> DrawMats
pushTransform dm = dm { getTStack = (tf:tf:tfs) }
    where (tf:tfs) = getTStack dm

modTransform :: (Transform Double -> Transform Double) -> DrawMats -> DrawMats
modTransform f dm = dm { getTStack = ((f tf):tfs) }
    where (tf:tfs) = getTStack dm

