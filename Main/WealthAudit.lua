local WealthAuditAddonName = select(1, ...)
---@class WealthAudit
local WealthAudit = select(2, ...)

local GUTIL = WealthAudit.GUTIL

---@class WealthAudit.MAIN : Frame
WealthAudit.MAIN = GUTIL:CreateRegistreeForEvents { "ADDON_LOADED" }

WealthAudit.MAIN.FRAMES = {}

WealthAuditGGUIConfig = WealthAuditGGUIConfig or {}

function WealthAudit.MAIN:Init()
	WealthAudit.MAIN:InitializeSlashCommands()
	WealthAudit.OPTIONS:Init()
	WealthAudit.TOOLTIP:Init()
	-- force initialize achievement stat tab to prevent errors
	AchievementFrameBaseTab_OnClick(3) -- 3 is the stat tab index
end

function WealthAudit.MAIN:ADDON_LOADED(addon_name)
	if addon_name ~= WealthAuditAddonName then
		return
	end
	-- init as soon as player specialization is available -- polling
	WealthAudit.MAIN:Init()
end

function WealthAudit.MAIN:InitializeSlashCommands()
	SLASH_WEALTHAUDIT1 = "/wealthaudit"
	SLASH_WEALTHAUDIT2 = "/wau"
	SlashCmdList["WEALTHAUDIT"] = function(input)
		input = SecureCmdOptionParse(input)
		if not input then return end

		local command, rest = input:match("^(%S*)%s*(.-)$")
		command = command and command:lower()
		rest = (rest and rest ~= "") and rest:trim() or nil

		if command == "config" then
			InterfaceOptionsFrame_OpenToCategory(WealthAudit.OPTIONS.optionsPanel)
		end
	end
end
