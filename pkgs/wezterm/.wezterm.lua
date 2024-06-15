-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
	h = 'Left',
	j = 'Down',
	k = 'Up',
	l = 'Right',
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == 'resize' and 'META' or 'CTRL',
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
				}, pane)
			else
				if resize_or_move == 'resize' then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end


config.keys = {
	-- move between split panes
	split_nav('move', 'h'),
	split_nav('move', 'j'),
	split_nav('move', 'k'),
	split_nav('move', 'l'),
	-- resize panes
	split_nav('resize', 'h'),
	split_nav('resize', 'j'),
	split_nav('resize', 'k'),
	split_nav('resize', 'l'),
	{
		key = "h",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
}

config.enable_wayland = false

-- This is where you actually apply your config choices

-- config.font = wezterm.font 'Berkeley Mono'
-- config.font = wezterm.font("Monaspace Neon")
config.font = wezterm.font("Maple Mono")
-- config.font = wezterm.font("Lotion")

-- config.font = wezterm.font("Sophistry Sans Roguelike")
-- config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

-- 'CaskaydiaCove Nerd Font Mono'
config.font_size = 15
config.window_background_opacity = 0.8

-- For example, changing the color scheme:
config.enable_tab_bar = false
config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 20,
};

-- config.color_scheme = 'Argonaut'
-- config.color_scheme              = 'nord'
--
config.force_reverse_video_cursor = true;
config.colors = {
	foreground = "#dcd7ba",
	background = "#1f1f28",

	cursor_bg = "#c8c093",
	cursor_fg = "#c8c093",
	cursor_border = "#c8c093",

	selection_fg = "#c8c093",
	selection_bg = "#2d4f67",

	scrollbar_thumb = "#16161d",
	split = "#16161d",

	ansi = {
		"#090618",
		"#c34043",
		"#76946a",
		"#c0a36e",
		"#7e9cd8",
		"#957fb8",
		"#6a9589",
		"#c8c093"
	},
	brights = {
		"#727169",
		"#e82424",
		"#98bb6c",
		"#e6c384",
		"#7fb4ca",
		"#938aa9",
		"#7aa89f",
		"#dcd7ba"
	},
	indexed = {
		[16] = "#ffa066",
		[17] = "#ff5d62"
	},
};

return config
