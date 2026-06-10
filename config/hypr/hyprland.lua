-- LG display
hl.monitor({
	output = "DP-2",
	mode = "2560x1440@143.97",
	position = "0x0",
	scale = "1.25",
})

-- MacBook display
hl.monitor({
	output = "eDP-1",
	mode = "3456x2234@48",
	position = "0x0",
	scale = "2",
})

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hyprlock")

	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
	general = {
		gaps_in = 10,
		gaps_out = 20,
		border_size = 2,
		col = {
			active_border = "rgb(bd93f9)",
			inactive_border = "rgb(21222c)",
		},
		resize_on_border = true,
		extend_border_grab_area = 20,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 20,
		active_opacity = 1,
		inactive_opacity = 0.8,
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
	animations = {
		enabled = false,
	},
	dwindle = {
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
	input = {
		repeat_rate = 50,
		repeat_delay = 200,

		kb_layout = "us,ru",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:win_space_toggle",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0,

		touchpad = {
			clickfinger_behavior = true,
		},
	},
	xwayland = {
		force_zero_scaling = true,
	},
})

hl.device({
	name = "apple-spi-trackpad",
	natural_scroll = true,
	disable_while_typing = true,
	sensitivity = 0.3,
})

local mod = "SUPER"
local function bind(keys, fn, opts)
	local keys_str = table.concat(keys, " + ")
	hl.bind(keys_str, fn, opts)
end

bind({ mod, "Q" }, hl.dsp.window.close())
bind({ mod, "SHIFT", "ALT", "Q" }, hl.dsp.exec_cmd("shutdown -h now"))
bind({ mod, "R" }, hl.dsp.exec_cmd("TERMINAL=wezterm fuzzel --list-executables-in-path"))
bind({ mod, "B" }, hl.dsp.exec_cmd("firefox"))
bind({ mod, "T" }, hl.dsp.exec_cmd("Telegram"))
bind({ mod, "E" }, hl.dsp.exec_cmd("nemo"))

-- Wifi reboot
bind({ mod, "W" }, hl.dsp.exec_cmd("/home/hermanberdnikov/dotfiles/misc/scripts/wifi-reboot.sh"))

-- hyprshot
bind({ mod, "P" }, hl.dsp.exec_cmd("hyprshot -m output --clipboard-only"))
bind({ mod, "ALT", "P" }, hl.dsp.exec_cmd('HYPRSHOT_DIR="Screenshots" hyprshot -m output'))
bind({ mod, "SHIFT", "P" }, hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
bind({ mod, "SHIFT", "ALT", "P" }, hl.dsp.exec_cmd('HYPRSHOT_DIR="Screenshots" hyprshot -m region'))

-- Move focus
bind({ mod, "H" }, hl.dsp.focus({ direction = "left" }))
bind({ mod, "J" }, hl.dsp.focus({ direction = "down" }))
bind({ mod, "K" }, hl.dsp.focus({ direction = "up" }))
bind({ mod, "L" }, hl.dsp.focus({ direction = "right" }))

-- Move windows
bind({ mod, "SHIFT", "H" }, hl.dsp.window.move({ direction = "left" }))
bind({ mod, "SHIFT", "J" }, hl.dsp.window.move({ direction = "down" }))
bind({ mod, "SHIFT", "K" }, hl.dsp.window.move({ direction = "up" }))
bind({ mod, "SHIFT", "L" }, hl.dsp.window.move({ direction = "right" }))

for i = 1, 10, 1 do
	local key = i % 10
	bind({ mod, tostring(key) }, hl.dsp.focus({ workspace = i }))
	bind({ mod, "SHIFT", tostring(key) }, hl.dsp.window.move({ workspace = i }))
end
bind({ mod, "TAB" }, hl.dsp.focus({ workspace = "previous" }))

bind({ "XF86AudioNext" }, hl.dsp.exec_cmd("playerctl next"), { locked = true })
bind({ "XF86AudioPause" }, hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
bind({ "XF86AudioPlay" }, hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
bind({ "XF86AudioPrev" }, hl.dsp.exec_cmd("playerctl previous"), { locked = true })

bind({ "XF86MonBrightnessUp" }, hl.dsp.exec_cmd("brightnessctl s +10%"), { locked = true, repeating = true })
bind({ "XF86MonBrightnessDown" }, hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

bind({ "XF86Search" }, hl.dsp.exec_cmd("brightnessctl -d kbd_backlight s +10%"), { locked = true, repeating = true })
bind({ "XF86LaunchA" }, hl.dsp.exec_cmd("brightnessctl -d kbd_backlight s 10%-"), { locked = true, repeating = true })

bind({ "XF86AudioRaiseVolume" }, hl.dsp.exec_cmd("wpctl set-volume -l 0.80 @DEFAULT_AUDIO_SINK@ 5%+"))
bind({ "XF86AudioLowerVolume" }, hl.dsp.exec_cmd("wpctl set-volume -l 0.80 @DEFAULT_AUDIO_SINK@ 5%-"))
bind({ "XF86AudioMute" }, hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

bind({ "switch:on:Apple SMC power/lid events" }, hl.dsp.exec_cmd("hyprlock & systemctl suspend"))
bind({ "XF86PowerOff" }, hl.dsp.exec_cmd("hyprlock & systemctl suspend"))
