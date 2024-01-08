local WealthAuditAddonName = select(1, ...)
local WealthAudit = select(2, ...)

---@class LoadoutReminder.MAIN : Frame
WealthAudit.MAIN = CreateFrame("Frame")
WealthAudit.MAIN:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
WealthAudit.MAIN:RegisterEvent("ADDON_LOADED")
WealthAudit.MAIN:RegisterEvent("PLAYER_TARGET_CHANGED")

WealthAudit.MAIN.FRAMES = {}

WealthAuditGGUIConfig = WealthAuditGGUIConfig or {}

function WealthAudit.MAIN:Init()
	WealthAudit.MAIN:InitializeSlashCommands()
	WealthAudit.OPTIONS:Init()
	WealthAudit.AUDIT_FRAME.FRAMES:Init()	

	-- restore frame positions
	local auditFrame = WealthAudit.GGUI:GetFrame(WealthAudit.MAIN.FRAMES, WealthAudit.CONST.FRAMES.REMINDER_FRAME)
	auditFrame:RestoreSavedConfig(UIParent)
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

		if command == "" then
			WealthAudit.AUDIT_FRAME.frame:Show()
		end
	end
end

-- EVENTS
function WealthAudit.MAIN:PLAYER_TARGET_CHANGED() 
	
end