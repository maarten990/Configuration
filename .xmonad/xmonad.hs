import qualified Data.Map as M

import XMonad

import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.ResizableTile

import XMonad.Hooks.DynamicLog  
import XMonad.Hooks.ManageDocks  

myLayout = tiled ||| Grid ||| noBorders Full
    where
        tiled = ResizableTall 1 (3/100) (1/2) []

main = xmonad =<< xmobar defaultConfig
    { terminal           = "urxvt"
    , modMask            = mod4Mask
    , borderWidth        = 1
    , layoutHook         = myLayout
    , manageHook         = manageDocks <+> manageHook defaultConfig
    , normalBorderColor  = "#444444"
    , focusedBorderColor = "#BAF617"
    , keys               = myKeys <+> keys defaultConfig
    }


myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList
    [ ((modm,               xK_z), sendMessage MirrorShrink)
    , ((modm,               xK_a), sendMessage MirrorExpand)
    ]
