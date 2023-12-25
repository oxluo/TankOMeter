local ui = require("ui")
local specs = require("specs")

-- local a,ar,k =select(2,UnitArmor("player")),C_PaperDollInfo.GetArmorEffectivenessAgainstTarget(select(2,UnitArmor("player"))) if ar then k = a/ar-a print(k) end
-- ui.button:SetText(tostring(k))

local playerSpec = UnitClassBase("player")
local specsTable = {}
specsTable["DEMONHUNTER"] = specs.DHReduction()
specsTable["PALADIN"] = specs.PalReduction()

local function BaseReduction()
    local damageFactor = 1.0
    local _, effectiveArmor = UnitArmor("player")
    local armorReduceRate = C_PaperDollInfo.GetArmorEffectivenessAgainstTarget(effectiveArmor)
    if armorReduceRate == nil then armorReduceRate = C_PaperDollInfo.GetArmorEffectiveness(effectiveArmor, UnitEffectiveLevel("player")) end
    local dodgeChance = GetDodgeChance()/100
    local parryChance = GetParryChance()/100
    --local versatility = GetVersatilityBonus()

    damageFactor = damageFactor*(1-armorReduceRate)*(1-parryChance)*(1-dodgeChance)
    return damageFactor
end

local function UpdateReduceRate()
    local damageFactor = 1.0
    damageFactor = damageFactor*specsTable[playerSpec]
    damageFactor = damageFactor*BaseReduction()
    ui.button:SetText(tostring(damageFactor))
end

local listener = CreateFrame("Frame")
listener:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
listener:SetScript("OnEvent", UpdateReduceRate)
