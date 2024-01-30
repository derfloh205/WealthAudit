---@class WealthAudit
local WealthAudit = select(2, ...)

---@class WealthAudit.CONST
WealthAudit.CONST = {}

WealthAudit.CONST.STATISTIC_IDS = {
    MOST_GOLD_EVER_OWNED = 334,
    GOLD_FROM_AUCTIONS = 919,
}
WealthAudit.CONST.ACHIEVEMENT_IDS = {
    BRUTO = 14183,
}

WealthAudit.CONST.FRAMES = {
    AUDIT_FRAME = "AUDIT_FRAME",
}

WealthAudit.CONST.DEFAULT_BACKDROP_OPTIONS = {
    bgFile = "Interface\\PaperDollInfoFrame\\UI-Character-Reputation-DetailBackground",
    borderOptions = {
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border", -- this one is neat
        edgeSize = 32,
        insets = { left = 5, right = -110, top = 5, bottom = 5 },
        colorR = 1,
        colorG = 1,
        colorB = 1,
        colorA = 1,
    },
    colorR = 1,
    colorG = 1,
    colorB = 1,
    colorA = 1,
}
