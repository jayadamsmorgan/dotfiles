local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local act = wezterm.action
config.keys = {
	{
		key = "K",
		mods = "CMD|SHIFT",
		action = act.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "J",
		mods = "CMD|SHIFT",
		action = act.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "w",
		mods = "CMD",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "W",
		mods = "CMD|SHIFT",
		action = act.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "H",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "LeftArrow",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "L",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "RightArrow",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
	-- {
	-- 	key = "J",
	-- 	mods = "CMD|SHIFT",
	-- 	action = act.ActivatePaneDirection("Down"),
	-- },
	{
		key = "DownArrow",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Down"),
	},
	-- {
	-- 	key = "K",
	-- 	mods = "CMD|SHIFT",
	-- 	action = act.ActivatePaneDirection("Up"),
	-- },
	{
		key = "UpArrow",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "{",
		mods = "CMD|SHIFT|ALT",
		action = act.MoveTabRelative(-1),
	},
	{
		key = "}",
		mods = "CMD|SHIFT|ALT",
		action = act.MoveTabRelative(1),
	},
	{
		key = "H",
		mods = "CMD|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Left", 1 }),
	},
	{
		key = "J",
		mods = "CMD|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Down", 1 }),
	},
	{
		key = "K",
		mods = "CMD|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Up", 1 }),
	},
	{
		key = "L",
		mods = "CMD|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Right", 1 }),
	},
}

local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"

config.color_scheme = "Dracula (Official)"
config.font = wezterm.font("JetBrains Mono", { weight = "DemiBold" })
config.font_size = 16

return config
