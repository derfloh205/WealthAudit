---@class WealthAudit
local WealthAudit = select(2, ...)

local GUTIL = WealthAudit.GUTIL

---@class WealthAudit.TOOLTIP : Frame
WealthAudit.TOOLTIP = GUTIL:CreateRegistreeForEvents({ "INSPECT_ACHIEVEMENT_READY" })
WealthAudit.TOOLTIP.isLoading = false
WealthAudit.TOOLTIP.loadingPlayer = nil

function WealthAudit.TOOLTIP:Init()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(_, data)
        local unit = select(2, GameTooltip:GetUnit())
        if unit and UnitIsPlayer(unit) then
            WealthAudit.TOOLTIP.isLoading = true
            WealthAudit.TOOLTIP.loadingPlayer = UnitName(unit)
            SetAchievementComparisonUnit(unit)
        end
    end)
end

function WealthAudit.TOOLTIP:INSPECT_ACHIEVEMENT_READY()
    if GameTooltip:IsVisible() and WealthAudit.TOOLTIP.isLoading then
        local unit = select(2, GameTooltip:GetUnit())
        if unit and UnitIsPlayer(unit) then
            local name = UnitName(unit)
            if name == WealthAudit.TOOLTIP.loadingPlayer then
                local tooltipText = WealthAudit.TOOLTIP:GetTooltipText(unit)
                GameTooltip:AddLine(GUTIL:ColorizeText("WealthAudit:", GUTIL.COLORS.GREEN))
                GameTooltip:AddLine(tooltipText)
                GameTooltip:Show() -- update
            end
        end

        WealthAudit.TOOLTIP.isLoading = false
        WealthAudit.TOOLTIP.loadingPlayer = nil
    end
end

local lastStatsMap = {}
local lastPlayer = nil
function WealthAudit.TOOLTIP:GetTooltipText(unit)
    local mostGoldEverOwned = WealthAudit.UTIL:ExtractCopperFromMoneyString(GetComparisonStatistic(WealthAudit.CONST
        .STATISTIC_IDS.MOST_GOLD_EVER_OWNED))
    local goldFromAuctions = WealthAudit.UTIL:ExtractCopperFromMoneyString(GetComparisonStatistic(WealthAudit.CONST
        .STATISTIC_IDS.GOLD_FROM_AUCTIONS))
    local hasBruto, month, day, year = GetAchievementComparisonInfo(WealthAudit.CONST
        .ACHIEVEMENT_IDS.BRUTO)
    local playerName = UnitName(unit)
    local brutoID = tostring(hasBruto) .. tostring(day) .. tostring(month) .. tostring(year)

    if mostGoldEverOwned == lastStatsMap["mostGoldEverOwned"] and lastPlayer ~= playerName then
        mostGoldEverOwned = nil
    end
    if goldFromAuctions == lastStatsMap["goldFromAuctions"] and lastPlayer ~= playerName then
        goldFromAuctions = nil
    end
    if brutoID == lastStatsMap["hasBruto"] and lastPlayer ~= playerName then
        hasBruto = false
    end

    -- this is because if a player does not have any stat, the api gives us the last stat checked...
    lastPlayer = playerName
    lastStatsMap["mostGoldEverOwned"] = mostGoldEverOwned
    lastStatsMap["goldFromAuctions"] = goldFromAuctions
    lastStatsMap["hasBruto"] = brutoID
    --local playerStat = GetStatistic(334)

    local tooltipText = "Most Gold Ever Owned: "

    if mostGoldEverOwned then
        tooltipText = tooltipText .. GUTIL:FormatMoney(mostGoldEverOwned, false, nil, true)
    else
        tooltipText = tooltipText .. GUTIL:FormatMoney(0, false)
    end

    tooltipText = tooltipText .. "\nGold From Auctions: "

    if goldFromAuctions then
        tooltipText = tooltipText .. GUTIL:FormatMoney(goldFromAuctions, false, nil, true)
    else
        tooltipText = tooltipText .. GUTIL:FormatMoney(0, false)
    end

    tooltipText = tooltipText .. "\nBruto: "
    if hasBruto then
        tooltipText = tooltipText ..
            GUTIL:ColorizeText("Yes", GUTIL.COLORS.GREEN) .. " (" .. day .. "." .. month .. ".20" .. year .. ")"
    else
        tooltipText = tooltipText .. GUTIL:ColorizeText("No", GUTIL.COLORS.RED)
    end

    return tooltipText
end
