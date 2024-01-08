local WealthAudit = select(2, ...)

WealthAudit.CONST = {}

WealthAudit.CONST.FRAMES = {
    AUDIT_FRAME = "AUDIT_FRAME",
}

WealthAudit.CONST.DEFAULT_BACKDROP_OPTIONS = {
    bgFile = "Interface\\CharacterFrame\\UI-Party-Background",
    borderOptions = {
        edgeFile = "Interface\\PVPFrame\\UI-Character-PVP-Highlight", -- this one is neat
        edgeSize = 16,
        insets = { left = 8, right = 6, top = 8, bottom = 8 },
    }
}