-- dh buffs

-- 常驻
-- 203513 恶魔结界 -20%

-- 通用天赋
-- 389696 伊利达雷的知识 魔法-5%

-- 专精天赋
-- 391171 钙化尖刺 变化 389720 天赋
-- 212988 痛苦使者 变化 207387 天赋
-- 389705 强固邪焰 魔法-10% 相关 258920 献祭光环

-- dh debuffs

-- 通用天赋
-- 394933 恶魔笼头 魔法-8% 388111 天赋

-- 专精天赋
-- 207771 烈火烙印 204021 天赋
-- 268175 虚空掠夺者 4%每层 相关 247456 脆弱 389985 灵魂重碾

local function DHReduction()
    local damageFactor = 1.0;
    AuraUtil.ForEachAura("player", "HELPFUL", nil, function (name, icon, _, _, _, _, _, _, _, spellId, _, _, _, _, _, attr1, attr2, ...)
        -- print(name, attr1, attr2)
        local reduceRate = 0
        if spellId == 391171 then -- 钙化尖刺
            reduceRate = abs(attr1)/100
        elseif spellId == 212988 then -- 痛苦使者
            reduceRate = abs(attr1)/100
        end
        damageFactor = damageFactor*(1-reduceRate)
    end)


    AuraUtil.ForEachAura("target", "HARMFUL", nil, function (name, icon, _, _, _, _, _, _, _, spellId, _, _, _, _, _, attr1, attr2, ...)
        local reduceRate = 0
        if spellId == 207771 then --烈火烙印
            reduceRate = 40/100
            damageFactor = damageFactor*(1-reduceRate)
        end
    end)
    return damageFactor
end

local function PalReduction()
    local damageFactor = 1.0;
    AuraUtil.ForEachAura("player", "HELPFUL", nil, function (name, _, count, _, _, _, _, _, _, spellId, _, _, _, _, _, attr1, attr2, ...)
        print(name, attr1, attr2)
        local reduceRate = 0
        if spellId == 188370 then -- 奉献
            reduceRate = abs(attr1)/100
        elseif spellId == 31850 then -- 炽热防御者
            reduceRate = 0.2
        elseif spellId == 86659 then -- 远古列王守卫
            reduceRate = 0.5
        elseif spellId == 389539 then --戒卫
            reduceRate = count/100
        elseif spellId == 385126 then --黄昏祝福
            reduceRate = 0.05
        elseif spellId == 424616 then --2T31
            reduceRate = count*2/100
        end
        damageFactor = damageFactor*(1-reduceRate)
    end)
    return damageFactor
end