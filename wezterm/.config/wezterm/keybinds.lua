local wezterm = require("wezterm")
local act = wezterm.action

local module = {}

function module.apply_to_config(config)
	config.disable_default_key_bindings = true
	config.keys = {
		{
			key = "r",
			mods = "CMD",
			action = act.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		{
			key = [[\]],
			mods = "CMD",
			action = wezterm.action({
				SplitHorizontal = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = [[\]],
			mods = "CMD|ALT",
			action = wezterm.action({
				SplitVertical = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = "w",
			mods = "CMD",
			action = wezterm.action({ CloseCurrentPane = { confirm = true } }),
		},
		{
			key = "f",
			mods = "CMD",
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			key = "h",
			mods = "CMD|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Left" }),
		},
		{
			key = "l",
			mods = "CMD|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Right" }),
		},
		{
			key = "k",
			mods = "CMD|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Up" }),
		},
		{
			key = "j",
			mods = "CMD|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Down" }),
		},
		{
			key = "h",
			mods = "CMD|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }),
		},
		{
			key = "l",
			mods = "CMD|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }),
		},
		{
			key = "k",
			mods = "CMD|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }),
		},
		{
			key = "j",
			mods = "CMD|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }),
		},
		{
			-- browser-like bindings for tabbing
			key = "t",
			mods = "CMD",
			action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
		},
		{
			key = "w",
			mods = "CMD",
			action = wezterm.action({ CloseCurrentTab = { confirm = false } }),
		},
		{
			key = "Tab",
			mods = "CTRL",
			action = wezterm.action({ ActivateTabRelative = 1 }),
		},
		{
			key = "Tab",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivateTabRelative = -1 }),
		},
		{ key = "LeftArrow", mods = "CMD|SHIFT", action = wezterm.action.MoveTabRelative(-1) },
		{ key = "RightArrow", mods = "CMD|SHIFT", action = wezterm.action.MoveTabRelative(1) },
		{ key = "1", mods = "CMD", action = wezterm.action({ ActivateTab = 0 }) },
		{ key = "2", mods = "CMD", action = wezterm.action({ ActivateTab = 1 }) },
		{ key = "3", mods = "CMD", action = wezterm.action({ ActivateTab = 2 }) },
		{ key = "4", mods = "CMD", action = wezterm.action({ ActivateTab = 3 }) },
		{ key = "5", mods = "CMD", action = wezterm.action({ ActivateTab = 4 }) },
		{ key = "6", mods = "CMD", action = wezterm.action({ ActivateTab = 5 }) },
		{ key = "7", mods = "CMD", action = wezterm.action({ ActivateTab = 6 }) },
		{ key = "8", mods = "CMD", action = wezterm.action({ ActivateTab = 7 }) },
		{ key = "9", mods = "CMD", action = wezterm.action({ ActivateTab = 8 }) },
		{ key = "0", mods = "CMD", action = wezterm.action({ ActivateTab = 9 }) },
		{
			key = "n",
			mods = "CMD",
			action = wezterm.action({ ActivateTabRelative = 1 }),
		},
		{
			key = "n",
			mods = "CMD|SHIFT",
			action = wezterm.action({ ActivateTabRelative = -1 }),
		}, -- standard copy/paste bindings
		{
			key = "x",
			mods = "CMD",
			action = "ActivateCopyMode",
		},
		{
			key = "v",
			mods = "CMD",
			action = wezterm.action({ PasteFrom = "Clipboard" }),
		},
		{
			key = "c",
			mods = "CMD",
			action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
		},
		{
			key = "R",
			mods = "CMD|SHIFT",
			action = wezterm.action.ReloadConfiguration,
		},
		{
			key = "=",
			mods = "CMD",
			action = wezterm.action.IncreaseFontSize,
		},
		{
			key = "-",
			mods = "CMD",
			action = wezterm.action.DecreaseFontSize,
		},
	}
end

return module
