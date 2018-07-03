set-face global PwrBrightR   'rgb:a89984,rgb:282828+r'
set-face global PwrBrightIn  'rgb:a89984,rgb:3c3836'
set-face global PwrBrightOut 'rgb:282828,rgb:a89984'
set-face global PwrLightR    'rgb:504945,rgb:a89984+r'
set-face global PwrLightIn   'rgb:504945,rgb:a89984'
set-face global PwrLightOut  'rgb:282828,rgb:504945'
set-face global PwrDarkR     'rgb:3c3836,rgb:a89984+r'
set-face global PwrDarkIn    'rgb:3c3836,default'
set-face global PwrDarkOut   'rgb:282828,rgb:3c3836'

set global modelinefmt '
{PwrDarkIn}{PwrDarkR} %sh{ dirs +0 }
{PwrBrightIn}{PwrBrightR} %val{bufname}
{PwrLightIn}{PwrLightR} %val{opt_filetype} | %val{opt_eolformat} | %val{cursor_line}:%val{cursor_char_column} {PwrLightOut}{default,rgb:282828}
{{context_info}} {{mode_info}}'
