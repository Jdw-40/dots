--Catpuccin Mocha theme file

hl.config({
    general={
        gaps_in=2,
        gaps_out=4,
        border_size=2,

        col={
            active_border={colors={"#bb9af7", "#7aa2f7"}, angle=45},
            inactive_border={colors={"#565f89"}, angle=45}
        },
        resize_on_border=true
    },
    decoration = {
        rounding = 12,
        rounding_power = 2.0,

        active_opacity = 1.0,
        inactive_opacity = 0.85,
        dim_inactive = true,
        dim_strength = 0.2,

        blur = {
            enabled = true,
            size = 6,
            passes = 3,
            ignore_opacity = true,
            new_optimizations = true,
            xray = false,
            popups = false,
        },
        shadow = {
            enabled = true
        }
    }
})
