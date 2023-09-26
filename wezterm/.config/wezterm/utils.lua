local wezterm = require("wezterm")
local colors = require("colors.catppuccin").colors
local M = { table = {} }

--- Adds the values from one array to the end of another and returns the result.
---@see https://github.com/premake/premake-core/
function M.table.join(...)
	local result = {}
	local arg = { ... }
	for _, t in ipairs(arg) do
		if type(t) == "table" then
			for _, v in ipairs(t) do
				table.insert(result, v)
			end
		else
			table.insert(result, t)
		end
	end
	return result
end

--- Function equivalent to basename in POSIX systems
function M.basename(str)
	if str then
		return string.gsub(str, "(.*/)(.*)", "%2")
	end
end

---Detect if running inside an editor or not
function M.is_editor(proc_name)
	local editors = { "nvim", "vim", "vi" }
	local name = M.basename(proc_name)
	for _, v in pairs(editors) do
		if name == v then
			return true
		end
	end
	return false
end

--- Get current process' nerdfont icon
--- (credits https://github.com/wez/wezterm/discussions/628#discussioncomment-4632891)
function M.get_process_icon(tab)
	local process_icons = {
		["docker"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = wezterm.nerdfonts.linux_docker },
		},
		["docker-compose"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = wezterm.nerdfonts.linux_docker },
		},
		["nvim"] = {
			{ Foreground = { Color = colors.green } },
			{ Text = wezterm.nerdfonts.custom_vim },
		},
		["vim"] = {
			{ Foreground = { Color = colors.green } },
			{ Text = wezterm.nerdfonts.dev_vim },
		},
		["node"] = {
			{ Foreground = { Color = colors.green } },
			{ Text = wezterm.nerdfonts.md_nodejs },
		},
		["zsh"] = {
			{ Foreground = { Color = colors.peach } },
			{ Text = wezterm.nerdfonts.dev_terminal },
		},
		["bash"] = {
			{ Foreground = { Color = colors.subtext0 } },
			{ Text = wezterm.nerdfonts.cod_terminal_bash },
		},
		["paru"] = {
			{ Foreground = { Color = colors.lavender } },
			{ Text = wezterm.nerdfonts.linux_archlinux },
		},
		["htop"] = {
			{ Foreground = { Color = colors.yellow } },
			{ Text = wezterm.nerdfonts.mdi_chart_donut_variant },
		},
		["cargo"] = {
			{ Foreground = { Color = colors.peach } },
			{ Text = wezterm.nerdfonts.dev_rust },
		},
		["git"] = {
			{ Foreground = { Color = colors.peach } },
			{ Text = wezterm.nerdfonts.dev_git },
		},
    ["lazygit"] = {
			{ Foreground = { Color = colors.mauve } },
			{ Text = wezterm.nerdfonts.dev_git },
		},
		["lua"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = wezterm.nerdfonts.seti_lua },
		},
		["wget"] = {
			{ Foreground = { Color = colors.yellow } },
			{ Text = wezterm.nerdfonts.mdi_arrow_down_box },
		},
		["curl"] = {
			{ Foreground = { Color = colors.yellow } },
			{ Text = wezterm.nerdfonts.mdi_flattr },
		},
		["gh"] = {
			{ Foreground = { Color = colors.mauve } },
			{ Text = wezterm.nerdfonts.dev_github_badge },
		},
	}
	local process_name = M.basename(tab.active_pane.foreground_process_name)
	return wezterm.format(process_icons[process_name] or {
			{ Foreground = { Color = colors.rosewater } },
			{ Text = wezterm.nerdfonts.dev_terminal },
		})
end

function M.get_current_working_dir(tab)
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))
	local current_dir = tab.active_pane.current_working_dir

	if HOME_DIR == current_dir then
		return " ~"
	end

	current_dir = string.gsub(current_dir, HOME_DIR, "~")
	local result = string.format(" %s", string.match(current_dir, "([^/]*)$"))
	-- local current_folder = string.match(result, "/.*")

  -- If the current dir is too long then dont show parent dir
	-- if string.len(current_folder) >= 20 then
		-- return string.match(result, "/.*")
	-- end

	return result
end

return M
