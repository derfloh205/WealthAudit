---@class WealthAudit
local WealthAudit = select(2, ...)

---@class WealthAudit.AUDIT_FRAME
WealthAudit.AUDIT_FRAME = WealthAudit.AUDIT_FRAME

---@class WealthAudit.AUDIT_FRAME.FRAMES
WealthAudit.AUDIT_FRAME.FRAMES = {}

local GGUI = WealthAudit.GGUI
local GUTIL = WealthAudit.GUTIL

function WealthAudit.AUDIT_FRAME.FRAMES:Init()
    local sizeX = 320
    local sizeY = 200
    local offsetX = -10
    local offsetY = 30

    local goldIconText = GUTIL:IconToText("Interface\\Icons\\inv_misc_coin_02", 15, 15)

    --- @type GGUI.Frame | GGUI.Widget
    local frame = GGUI.Frame({
        parent=UIParent, 
        anchorParent=UIParent,
        anchorA="CENTER",anchorB="CENTER",
        sizeX=sizeX,sizeY=sizeY,
        offsetX=offsetX,offsetY=offsetY,
        frameID=WealthAudit.CONST.FRAMES.AUDIT_FRAME, 
        title=goldIconText .. " WealthAudit " .. goldIconText,
        closeable=true,
        moveable=true,
        backdropOptions=WealthAudit.CONST.DEFAULT_BACKDROP_OPTIONS, 
        frameConfigTable=WealthAuditGGUIConfig,
        frameTable=WealthAudit.MAIN.FRAMES,
    })

    local function createContent(frame)
        ---@class WealthAudit.AuditFrame.Content : Frame
        frame.content = frame.content
        frame.content.mostGoldOwnedTitle = GGUI.Text{
            parent=frame.content, anchorParent=frame.title.frame, anchorA="TOP", anchorB="TOP", offsetY = -50,
            text="Most Gold Ever Owned",
        }
        frame.content.mostGoldOwnedValue = GGUI.Text{
            parent=frame.content, anchorParent=frame.content.mostGoldOwnedTitle.frame, 
            anchorA="TOP", anchorB="BOTTOM", offsetY=-10, text=GUTIL:FormatMoney(0, false)
        }
        frame.content.playerName = GGUI.Text{
            parent=frame.content, anchorParent = frame.content.mostGoldOwnedTitle.frame, anchorA="BOTTOM", anchorB="TOP", offsetY=10, scale = 1.2,
        }

        frame.content.goldFromAuctionsTitle = GGUI.Text{
            parent=frame.content, anchorParent=frame.content.mostGoldOwnedTitle.frame,anchorA="TOP", anchorB="BOTTOM", offsetY=-40,
            text="Gold earned from Auctions", 
        }
        frame.content.goldFromAuctionsValue = GGUI.Text{
            parent=frame.content, anchorParent=frame.content.goldFromAuctionsTitle.frame, 
            anchorA="TOP", anchorB="BOTTOM", offsetY=-10, text=GUTIL:FormatMoney(0, false)
        }
        frame:Hide()
    end

    createContent(frame)

    WealthAudit.AUDIT_FRAME.frame = frame
end

local lastStatsMap = {}
local lastTarget = nil
function WealthAudit.AUDIT_FRAME.FRAMES:UpdateDisplay()    
    local mostGoldEverOwned = GetComparisonStatistic(WealthAudit.CONST.STATISTIC_IDS.MOST_GOLD_EVER_OWNED)
    local goldFromAuctions = GetComparisonStatistic(WealthAudit.CONST.STATISTIC_IDS.GOLD_FROM_AUCTIONS)
    local target = UnitName("target")
    
    if mostGoldEverOwned == lastStatsMap["mostGoldEverOwned"] and lastTarget ~= target then
        mostGoldEverOwned = nil
    end
    if goldFromAuctions == lastStatsMap["goldFromAuctions"] and lastTarget ~= target then
        goldFromAuctions = nil
    end

    -- this is because if a player does not have any stat, the api gives us the last stat checked...
    lastTarget = target
    lastStatsMap["mostGoldEverOwned"] = mostGoldEverOwned
    lastStatsMap["goldFromAuctions"] = goldFromAuctions
    --local playerStat = GetStatistic(334)

    local auditFrame = WealthAudit.AUDIT_FRAME.frame

    auditFrame.content.mostGoldOwnedValue:SetText(mostGoldEverOwned or GUTIL:FormatMoney(0, false))
    auditFrame.content.goldFromAuctionsValue:SetText(goldFromAuctions or GUTIL:FormatMoney(0, false))
    auditFrame.content.playerName:SetText(UnitNameUnmodified("target"))
end