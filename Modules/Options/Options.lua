local WealthAudit = select(2, ...)

WealthAudit.OPTIONS = {}

function WealthAudit.OPTIONS:Init()

    WealthAudit.OPTIONS.optionsPanel = CreateFrame("Frame", "WealthAuditOptionsPanel")

	WealthAudit.OPTIONS.optionsPanel:HookScript("OnShow", function(self)
		end)

    WealthAudit.OPTIONS.optionsPanel.name = "WealthAudit"
	local title = WealthAudit.OPTIONS.optionsPanel:CreateFontString('optionsTitle', 'OVERLAY', 'GameFontNormal')
    title:SetPoint("TOP", 0, 0)
	title:SetText("WealthAudit Options")

    --InterfaceOptions_AddCategory(self.optionsPanel)
end