---@class WealthAudit
local WealthAudit = select(2, ...)

---@class WealthAudit.UTIL
WealthAudit.UTIL = {}

function WealthAudit.UTIL:ExtractCopperFromMoneyString(moneyString)
        -- local gold, silver, copper = string.match(moneyString, "(%d+)|TInterface\\MoneyFrame\\UI-GoldIcon:0:0:2:0|t (%d+)|TInterface\\MoneyFrame\\UI-SilverIcon:0:0:2:0|t (%d+)|TInterface\\MoneyFrame\\UI-CopperIcon:0:0:2:0|t")
        local sub1 = string.gsub(moneyString, "|T.-|t ", ",", 2)
        sub1 = string.gsub(sub1, "|T.-|t", ",")
		local moneyTable = strsplittable(",", sub1, 3)
		local gold = tonumber(moneyTable[1])
		local silver = tonumber(moneyTable[2])
		local copper = tonumber(moneyTable[3])

		print("gold: " .. gold)
		print("silver: " .. silver)
		print("copper: " .. copper)
        if gold and silver and copper then
            local totalCopper = (tonumber(gold) * 10000) + (tonumber(silver) * 100) + tonumber(copper)
            return totalCopper
        else
            return 0
        end
end

