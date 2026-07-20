return {
  "kylechui/nvim-surround",
  version = "*", 
  event = "VeryLazy",
  opts = {}, 
}

--       which key doesnt like this plugin so use this
-- ╭─────────────────────────────────────────────────────────────╮
-- │ nvim-surround cheatsheet   (* = cursor position)            │
-- ├─────────────────────────────────────────────────────────────┤
-- │ ADD    ys{motion}{char}                                     │
-- │   ysiw)      surr*ound      -> (surround)                   │
-- │   ysiw(      surr*ound      -> ( surround )   open = spaces │
-- │   yss)       whole *line    -> (whole line)                 │
-- │   yS{motion} same but puts delimiters on their own lines    │
-- │   ys$"       to end of line -> "make strings"               │
-- │   yst,)      till next ,     wrap up to a char              │
-- │                                                             │
-- │ DELETE ds{char}                                             │
-- │   ds"        "text"  -> text                                │
-- │   ds)        (text)  -> text                                │
-- │   dst        <b>x</b> -> x        (t = html tag)            │
-- │   dsf        func(x) -> x         (f = function call)       │
-- │                                                             │
-- │ CHANGE cs{old}{new}                                         │
-- │   cs"'       "text"  -> 'text'                              │
-- │   cs)]       (text)  -> [text]                              │
-- │   cst<h1>    change surrounding html tag                    │
-- │                                                             │
-- │ VISUAL   select then  S{char}   wrap the selection          │
-- │                                                             │
-- │ ALIASES  b=)  B=}  r=]  a=>  q=quotes  t=tag  f=func        │
-- ╰─────────────────────────────────────────────────────────────╯
