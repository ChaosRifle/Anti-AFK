#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
;setting defaults, dont poke at these, they basically only do things once, if at all. Just sanitizing.
sw = 2
macroOn = 0
forward = w
backward = s

;possibly save selection from GUI into a config file and read it back in a version 2/3?
;AFKTypeSelection:New     find a way to make it work? unsure if AHK conflicts with other running instances. Probably fine.
Gui, New , -MinimizeBox, test
Gui, Add, Text, -Center, Please choose anti-afk method for this session:
Gui, Add, Button, Default -Wrap w80, &Jump
; create button, set as default selection, word wrap so it works on all systems with no weirdness(only works on one line buttons), width 80px, enable first character keystroke to confrim, set text to Jump.
Gui, Add, Button, -Wrap x+0 w80, &W and S
Gui, Add, Button, -Wrap y+0 w80, &E and D
Gui, Add, Button, -Wrap xp-80 yp w80, &Arrow keys
Gui, Show
Return

ButtonEandD:
  forward = e
  backward = d
  sw = 0
  MsgBox, Cool! I like more buttons too!
  Gui, Hide
  Gosub, mainSubroutine
Return

ButtonArrowKeys:
  forward = up
  backward = down
  sw = 0
  MsgBox, Please switch to WASD eLguL. For your own sanity.
    Gui, Hide
  Gosub, mainSubroutine
Return

ButtonJump:
  sw = 2
  Gui, Hide
  Gosub, mainSubroutine
Return

ButtonWandS:
  forward = w
  backward = s
  sw = 0
  Gui, Hide
  Gosub, mainSubroutine
Return

GuiClose:
  Gui, Hide
  MsgBox, Bye!
ExitApp
Return

^numpad0:: ; keybind is CTRL+numpad 0. useful for editing the script quickly. This reloads the code from the saved .ahk file
  reload
return

F8:: ; enable/disable the afk code
  if ( macroOn = 1 ) {
    macroOn = 0
  } else {
    macroOn = 1
  }
  ;MsgBox, %macroOn%
return

mainSubroutine:
  Loop {
    random, s , 15321, 32730
    sleep s
    if ( macroOn = 0 ) {
      continue
    }

    switch sw {
    case 0: ; forward - toggles between here and reverse
      sw = 1
      random, i1, 43, 102
      Sendinput {%forward% down}
      sleep i1
      Sendinput {%forward% up}
    case 1: ; reverse - toggles between here and forward
      sw = 0
      random, i2, 42, 101
      Sendinput {%backward% down}
      sleep i2
      Sendinput {%backward% up}
    case 2: ; jumpmode instead of toggling walking
      random, i3, 36, 76
      Sendinput {space down}
      sleep i3
      Sendinput {space up}
    }
  }