---@class WealthAudit
local WealthAudit = select(2, ...)

---@class WealthAudit.UTIL
WealthAudit.UTIL = {}

function WealthAudit.UTIL:ExtractCopperFromMoneyString(moneyString)
        local sub1 = string.gsub(moneyString, "|T.-|t ", ",", 2)
        sub1 = string.gsub(sub1, "|T.-|t", ",")
		local moneyTable = strsplittable(",", sub1)
		local gold = tonumber(moneyTable[1])
		local silver = tonumber(moneyTable[2])
		local copper = tonumber(moneyTable[3])

        if gold and silver and copper then
            local totalCopper = (tonumber(gold) * 10000) + (tonumber(silver) * 100) + tonumber(copper)
            return totalCopper
        else
            return 0
        end
end

