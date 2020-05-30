-- IMPORTS
import           XMonad
import           System.Exit

import           XMonad.Config.Desktop

import XMonad.Util.EZConfig (additionalKeysP)

import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageHelpers

import           XMonad.Prompt
import           XMonad.Prompt.Shell
import					 XMonad.Layout.WindowArranger
import           XMonad.Layout.LimitWindows
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.Renamed
import           XMonad.Layout.Spacing
import           XMonad.Layout.SimplestFloat
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), Toggle(..), (??))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.Reflect (REFLECTX(..), REFLECTY(..))

import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.SinkAll
import XMonad.Actions.NoBorders

import           XMonad.Util.SpawnOnce
import           XMonad.Util.Run

import qualified XMonad.StackSet               as W


import Data.Monoid
import qualified Data.Map                      as M

myFont :: String
myFont = ""

myModMask :: KeyMask
myModMask = mod4Mask -- Sets modkey to super

myTerminal :: String
myTerminal = "kitty" -- Sets default terminal

myTextEditor :: String
myTextEditor = "" -- Sets default text editor

myBorderWidth :: Dimension
myBorderWidth = 2

myNormalBorderColor :: String
myNormalBorderColor = "#dddddd"

myFocusedBorderColor :: String
myFocusedBorderColor = "#ff0000"

main :: IO ()
main = do
  -- Launching xmobar on monitor 0 and 1
  _ <- spawnPipe "xmobar -x 0 /home/mclancy/.config/xmobar/xmobarrc"
  _ <- spawnPipe "xmobar -x 1 /home/mclancy/.config/xmobar/xmobarrc"
  xmonad $ ewmh desktopConfig { manageHook         = myManageHook
                              , logHook            = myLogHook
                              , modMask            = myModMask
                              , terminal           = myTerminal
                              , startupHook        = myStartupHook
                              , layoutHook         = myLayoutHook
                              , workspaces         = myWorkspaces
                              , borderWidth        = myBorderWidth
                              , normalBorderColor  = myNormalBorderColor
                              , focusedBorderColor = myFocusedBorderColor
                              , focusFollowsMouse  = myFocusFollowsMouse
                              , clickJustFocuses   = myClickJustFocuses
                              } `additionalKeysP` myKeys

------------------------------------------------------------------------
-- AUTOSTART

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "nitrogen --restore &"
  spawnOnce "picom &"

------------------------------------------------------------------------
-- WORKSPACES

myWorkspaces :: [String]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myManageHook :: Query (Data.Monoid.Endo WindowSet)
myManageHook =
  ( isFullscreen --> doFullFloat ) 
  <+> composeAll
  [className =? "virt-manager" --> doFloat
      ] 
      <+> manageHook desktopConfig
      <+> manageDocks

------------------------------------------------------------------------
-- LAYOUTS

myLayoutHook = avoidStruts myDefaultLayout
  where myDefaultLayout = tall ||| monocle ||| floats


tall = renamed [Replace "tall"] $ limitWindows 12 $ spacing 6 $ ResizableTall nmaster delta ratio []
monocle = renamed [Replace "monocle"] $ limitWindows 20 Full
floats = renamed [Replace "floats"] $ limitWindows 20 simplestFloat

nmaster = 1      -- The default number of windows in the master pane

ratio = 1 / 2    -- Default proportion of screen occupied by master pane

delta = 3 / 100  -- Percent of screen to increment by when resizing panes

------------------------------------------------------------------------
-- STATUS BAR & LOGGING

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- KEYS

conf = def 
  { XMonad.modMask = mod4Mask
  } 

myKeys :: [(String, X ())]
myKeys = 
  [ ( "M-S-q", io exitSuccess) 									-- Quit xmonad 
  , ( "M-q", spawn "xmonad --recompile; xmonad --restart") 	-- Recompiles and restarts XMonad
  , ( "M-S-<Return>", spawn myTerminal) 				-- Spawns prompt

  , ( "M-p", spawn "dmenu_run") 														-- launch dmenu
  , ("M-S-c", kill)

    -- Floating windows         
  , ("M-<Delete>", withFocused $ windows . W.sink)          -- Push floating window back to tile.         
  , ("M-S-<Delete>", sinkAll)                               -- Push ALL floating windows back to tile.
 	, ("M-m", windows W.focusMaster)             							-- Move focus to the master window         
	, ("M-j", windows W.focusDown)               							-- Move focus to the next window         
	, ("M-k", windows W.focusUp)                 							-- Move focus to the prev window
	, ("M-S-j", windows W.swapDown)                           -- Swap the focused window with the next window         
	, ("M-S-k", windows W.swapUp)                             -- Swap the focused window with the prev window         
	, ("M-<Backspace>", promote)                              -- Moves focused window to master, all others maintain order         
	, ("M1-S-<Tab>", rotSlavesDown)                           -- Rotate all windows except master and keep focus in place         
	, ("M1-C-<Tab>", rotAllDown)                              -- Rotate all the windows in the current stack

	, ("M-<Up>", sendMessage (MoveUp 10))                     --  Move focused window to up         
	, ("M-<Down>", sendMessage (MoveDown 10))                 --  Move focused window to down         
	, ("M-<Right>", sendMessage (MoveRight 10))               --  Move focused window to right         
	, ("M-<Left>", sendMessage (MoveLeft 10))                 --  Move focused window to left         
	, ("M-S-<Up>", sendMessage (IncreaseUp 10))               --  Increase size of focused window up         
	, ("M-S-<Down>", sendMessage (IncreaseDown 10))           --  Increase size of focused window down         
	, ("M-S-<Right>", sendMessage (IncreaseRight 10))         --  Increase size of focused window right         
	, ("M-S-<Left>", sendMessage (IncreaseLeft 10))           --  Increase size of focused window left         
	, ("M-C-<Up>", sendMessage (DecreaseUp 10))               --  Decrease size of focused window up         
	, ("M-C-<Down>", sendMessage (DecreaseDown 10))           --  Decrease size of focused window down         
	, ("M-C-<Right>", sendMessage (DecreaseRight 10))         --  Decrease size of focused window right         
	, ("M-C-<Left>", sendMessage (DecreaseLeft 10))           --  Decrease size of focused window left	

  -- Layouts
  , ("M-<Space>" , sendMessage NextLayout)                             -- Switches to next layout
  , ("M-S-<Space>", sendMessage ToggleStruts)                          -- Toggles struts
  , ("M-S-n", sendMessage $ Toggle NOBORDERS)                          -- Toggles noborder
  , ("M-S-=", sendMessage (Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full
  , ("M-S-f", sendMessage (T.Toggle "float"))
  , ("M-S-x", sendMessage $ Toggle REFLECTX)
  , ("M-S-y", sendMessage $ Toggle REFLECTY)
  , ("M-<KP_Multiply>", sendMessage (IncMasterN 1))   -- Increase number of clients in the master pane
  , ("M-<KP_Divide>", sendMessage (IncMasterN (-1)))  -- Decrease number of clients in the master pane
  , ("M-S-<KP_Multiply>", increaseLimit)              -- Increase number of windows that can be shown
  , ("M-S-<KP_Divide>", decreaseLimit)                -- Decrease number of windows that can be shown

  , ("M-h", sendMessage Shrink)
  , ("M-l", sendMessage Expand)
  , ("M-C-j", sendMessage MirrorShrink)
  , ("M-C-k", sendMessage MirrorExpand)

  -- Workspaces
  , ("M-.", nextScreen)                           -- Switch focus to next monitor
  , ("M-,", prevScreen)                           -- Switch focus to prev monitor
  ]

------------------------------------------------------------------------
--MOUSE

-- Does window focus follow the cursor
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Is the click to focus on a window not passed through to the window itself
myClickJustFocuses :: Bool
myClickJustFocuses = False

myMouseBindings XConfig { XMonad.modMask = modm } =
  M.fromList
    -- mod-button1, Set the window to floating mode and move by dragging
      [ ( (modm, button1)
        , (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)
        )

    -- mod-button2, Raise the window to the top of the stack
      , ( (modm, button2)
        , (\w -> focus w >> windows W.shiftMaster)
        )

    -- mod-button3, Set the window to floating mode and resize by dragging
      , ( (modm, button3)
        , (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
        )

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
      ]

------------------------------------------------------------------------
