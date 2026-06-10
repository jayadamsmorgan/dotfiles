local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.enable_wayland = true
config.default_prog = { "/usr/bin/zsh" }

local act = wezterm.action
config.keys = {
	{
		key = "|",
		mods = "CTRL|SHIFT",
		action = act.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "_",
		mods = "CTRL|SHIFT",
		action = act.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "W",
		mods = "CTRL|SHIFT",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "W",
		mods = "CTRL|SHIFT|ALT",
		action = act.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "H",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "L",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "J",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "DownArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "K",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "UpArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "{",
		mods = "CTRL|SHIFT|ALT",
		action = act.MoveTabRelative(-1),
	},
	{
		key = "}",
		mods = "CTRL|SHIFT|ALT",
		action = act.MoveTabRelative(1),
	},
	{
		key = "H",
		mods = "CTRL|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Left", 1 }),
	},
	{
		key = "J",
		mods = "CTRL|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Down", 1 }),
	},
	{
		key = "K",
		mods = "CTRL|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Up", 1 }),
	},
	{
		key = "L",
		mods = "CTRL|SHIFT|ALT",
		action = act.AdjustPaneSize({ "Right", 1 }),
	},
	{
		key = "D",
		mods = "CTRL|SHIFT",
		action = act.ShowDebugOverlay,
	},
}

local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

config.window_background_opacity = 0.95
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_decorations = "NONE"

config.color_scheme = "Dracula (Official)"
config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })

local handle = io.popen("/usr/bin/hyprctl monitors -j", "r")

local success = false

if handle then
	local result = tostring(handle:read("*a"))
	local suc, _, code = handle:close()
	if suc and code == 0 then
		local decoded = wezterm.json_parse(result)
		local main_monitor
		for _, monitor in ipairs(decoded) do
			if monitor.id == 0 then
				main_monitor = monitor
			end
		end
		if main_monitor then
			local size = main_monitor.height / 90 / main_monitor.scale
			wezterm.log_info("Using font_size " .. size)
			config.font_size = size
			success = true
		end
	end
end

if success == false then
	-- Using 16 as fallback
	config.font_size = 16
end

return config
