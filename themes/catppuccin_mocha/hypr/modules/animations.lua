hl.curve("easeOutExpo",  { type = "bezier", points = { {0.16, 1}, {0.3, 1} } })
hl.curve("easeOutQuint", { type = "bezier", points = { {0.22, 1}, {0.36, 1} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 6, bezier = "easeOutQuint", style = "popin 80%" })
hl.animation({ leaf = "fade",        enabled = true, speed = 5, bezier = "easeOutExpo" })
hl.animation({ leaf = "border",      enabled = true, speed = 6, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 6, bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" })
