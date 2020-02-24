# Kinesis Advantage setup

## Preparations

1. Reset keyboard by holding `F7` while attaching keyboard to PC
1. Set minimal number of macroses by pressing `Program+Shift+F2`
1. Toggle state-change tones by pressing `Program+-`
1. Toggle key clicks by pressing `Program+\`
1. Enter Mac mode by pressing `=m`
1. Add 'x' mode flag to get 2 Alt's and 2 Ctlr's by pressing `=x`
1. Ensure this is printed when you press `=s`: `v3.2[x ]`

## Keys mapping

> - To remap keys, press `Program+F12`, then press desired target key, then press new location for it
> - To record a macro, press `Program+F11`, then press trigger key, then record a macro, then press `Program+F11`
> - In Keypad mode, `PrintScr` is `Super_L=Mod3` and `ScrollLock` is `Super_R=Mod4`

```toml
[macro]
"1"       = "?"
"2"       = "~"
"3"       = "_"
"4"       = "^"
"5"       = "&"
"6"       = "'"
"shift+6" = "\""
"7"       = "{"
"shift+7" = "}"
"8"       = "("
"shift+8" = ")"
"9"       = "<"
"shift+9" = ">"
"0"       = "["
"shift+0" = "]"

[remap]
"up"      = "down"
"down"    = "up"
"esc"     = "del"
"del"     = "esc"
"tab"     = "caps"
"windows" = "tab"
"/"       = "'"

[thumb_keys]
"ctrl"       = "ctrl_l"
"alt"        = "alt_l"
"windows"    = "mod3"
"option_alt" = "mod4"

# Reassign for both keypad = ON and OFF
# Exact sequence to press:
# keypad=ON Program+F12 PrintScr Windows PrintScr Keypad=OFF Windows Program+F12
# keypad=ON Program+F12 ScrollLock OptionAlt ScrollLock Keypad=OFF OptionAlt Program+F12

[macro]
"?"         = "backslash"
"backslash" = "*"
```
