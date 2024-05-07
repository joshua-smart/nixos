import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Layout.Dwindle
import qualified Codec.Binary.UTF8.String as UTF8
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- ############################
-- ##### GENERAL SETTINGS #####
-- ############################
myTerminal = "alacritty"
myBrowser = "firefox"
myEditor = "nvim"
-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False
-- Width of the window border in pixels.
myBorderWidth = 0
-- Set Windows key as modMask
myModMask = mod4Mask
-- Workspace names
myWorkspaces = ["0", "1"]
-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "#13161a"
myFocusedBorderColor = "#7f4991"

-- #######################
-- ##### KEYBINDINGS #####
-- #######################
myKeys conf@XConfig {XMonad.modMask = modm} = M.fromList $
    [ ((modm,               xK_Return               ), spawn myTerminal                                  ) -- Launch terminal
    , ((modm,               xK_numbersign           ), spawn myBrowser                                   ) -- Launch browser
    , ((modm,               xK_n                    ), spawn $ myTerminal ++ " -e node"                  ) -- Launch node in terminal
    , ((modm,               xK_Shift_R              ), spawn $ myTerminal ++ " -e " ++ myEditor          ) -- Launch editor
    , ((modm,               xK_d                    ), spawn "rofi -show drun"                           ) -- Launch drun menu
    , ((modm,               xK_f                    ), spawn "rofi -show run"                            ) -- Launch run menu
    , ((modm,               xK_s                    ), spawn "rofi -show ssh"                            ) -- Launch ssh menu
    , ((modm,               xK_q                    ), kill                                              ) -- Close focused window
    , ((modm,               xK_space                ), sendMessage NextLayout                            ) -- Rotate through layouts
    , ((modm .|. shiftMask, xK_space                ), setLayout $ XMonad.layoutHook conf                ) -- Reset layout
    , ((modm .|. shiftMask, xK_n                    ), refresh                                           ) -- Refresh windows to standard sizes
    , ((modm,               xK_Tab                  ), windows W.focusDown                               ) -- Rotate focus through windows
    , ((modm,               xK_j                    ), windows W.focusDown                               ) -- Move focus to next window
    , ((modm,               xK_k                    ), windows W.focusUp                                 ) -- Move focus to previous window
    , ((modm,               xK_m                    ), windows W.focusMaster                             ) -- Move focus to master window
    , ((modm .|. shiftMask, xK_Return               ), windows W.swapMaster                              ) -- Swap focused window to be the main window
    , ((modm .|. shiftMask, xK_j                    ), windows W.swapDown                                ) -- Swap focused window with next window
    , ((modm .|. shiftMask, xK_k                    ), windows W.swapUp                                  ) -- Swap focused window with previous window
    , ((modm,               xK_h                    ), sendMessage Shrink                                ) -- Shrink master window
    , ((modm,               xK_l                    ), sendMessage Expand                                ) -- Expand master window
    -- , ((modm,               xK_t                    ), withFocused $ windows . W.sink                    ) -- Push window back into tiling
    , ((modm              , xK_comma                ), sendMessage (IncMasterN 1)                        ) -- Increment the number of windows in the master area
    , ((modm              , xK_period               ), sendMessage (IncMasterN (-1))                     ) -- Deincrement the number of windows in the master area
    -- , ((modm,               xK_b                    ), sendMessage ToggleStruts                          ) -- Toggle the status bar gap
    , ((modm .|. shiftMask, xK_p                    ), io exitSuccess                                    ) -- Quit xmonad
    , ((modm,               xK_p                    ), spawn "xmonad --recompile; xmonad --restart"      ) -- Restart xmonad
    , ((0,                  xF86XK_MonBrightnessUp  ), spawn "brightnessctl s +10%"                      ) -- Increment brightness
    , ((0,                  xF86XK_MonBrightnessDown), spawn "brightnessctl s 10%-"                      ) -- Deincrement brightness
    , ((0,                  xF86XK_AudioRaiseVolume ), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%"  ) -- Increment volume
    , ((0,                  xF86XK_AudioLowerVolume ), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%"  ) -- Deincrement volume
    , ((0,                  xF86XK_AudioMute        ), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle" ) -- Mute
    , ((modm,               xK_t                    ), spawn "polybar-msg action \"#date.toggle\""       ) -- Toggle date in statusbar
    , ((0,                  xK_Print                ), spawn "scrot ~/Images/screenshots/%Y-%m-%d-%T.png") -- Take screenshot
    , ((0,                  xF86XK_AudioPlay        ), spawn "playerctl play-pause"                      ) -- Play pause current media
    , ((0,                  xF86XK_AudioNext        ), spawn "playerctl next"                            ) -- Skip to next media
    , ((0,                  xF86XK_AudioPrev        ), spawn "playerctl previous"                        ) -- Previous current media
    ]
    ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9] -- Switch to workspace N
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]] -- Move current window to workspace N
    ++
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..] -- Switch to monitor N
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]] -- Move current window to monitor N

myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster) -- mod-button1, Set the window to floating mode and move by dragging
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster) -- mod-button2, Raise the window to the top of the stack
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster) -- mod-button3, Set the window to floating mode and resize by dragging
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

-- ##################
-- ##### LAYOUT #####
-- ##################
uniformBorder i = Border i i i i
myBorder i = Border i i i i

mySpacing i = spacingRaw True (myBorder i') True (uniformBorder i') True
    where i' = fromIntegral i

myLayout = avoidStruts (mySpacing 10 $ tiled ||| Full)
    where
    tiled   = Tall nmaster delta ratio -- default tiling algorithm partitions the screen into two panes
    nmaster = 1 -- The default number of windows in the master pane
    ratio   = 3/5 -- Default proportion of screen occupied by master pane
    delta   = 3/100 -- Percent of screen to increment by when resizing panes

-- ###########################
-- #### WINDOW MANAGEMENT ####
-- ###########################
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , title     =? "Calculator"     --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

-- ########################
-- #### EVENT HANDLING ####
-- ########################
myEventHook = mempty

-- #################
-- #### LOGGING ####
-- #################
myLogHook = dynamicLog

-- #################
-- #### STARTUP ####
-- #################
myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom &"
    spawnOnce "polybar primary &"
    spawnOnce "unclutter -idle 1 &"
    spawnOnce "udiskie &"
    spawnOnce "nm-applet &"

-- ##############
-- #### MAIN ####
-- ##############
main :: IO ()
main = xmonad . ewmh . docks $ defaults

-- ########################
-- #### DEFAULT CONFIG ####
-- ########################
defaults = def {
    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    clickJustFocuses   = myClickJustFocuses,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,
    -- key bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,
    -- hooks, layouts
    layoutHook         = myLayout,
    manageHook         = myManageHook,
    handleEventHook    = myEventHook,
    -- logHook            = myLogHook,
    startupHook        = myStartupHook
}
