--[[
Addon.lua
@Author  : DengSir (tdaddon@163.com)
@Link    : https://dengsir.github.io
]]

local ACHIEVEMENTS = {
    { id = 9686, type = 9,  },
    { id = 9687, type = 8,  },
    { id = 9688, type = 5,  },
    { id = 9689, type = 2,  },
    { id = 9690, type = 7,  },
    { id = 9691, type = 3,  },
    { id = 9692, type = 1,  },
    { id = 9693, type = 6,  },
    { id = 9694, type = 10, },
    { id = 9695, type = 4,  },
}

local NPCS = {
    ['104553'] = true,
    ['104970'] = true,
    ['105250'] = true,
    ['105455'] = true,
    ['105674'] = true,
    ['106552'] = true,
    ['107489'] = true,
    ['97709'] = true,
    ['97804'] = true,
    ['98270'] = true,
    ['99035'] = true,
    ['99077'] = true,
    ['99150'] = true,
    ['99182'] = true,
    ['99210'] = true,
}

local function isFinished(id, name)
    for i = 1, GetAchievementNumCriteria(id) do
        local criteriaString, _, completed = GetAchievementCriteriaInfo(id, i)
        if criteriaString == name then
            return completed
        end
    end
    return true
end

local function getUnFinished(npcId, npcName)
    local list = {}
    for _, v in ipairs(ACHIEVEMENTS) do
        if not isFinished(v.id, npcName) then
            tinsert(list, v)
        end
    end
    return list
end

GameTooltip:HookScript('OnTooltipSetUnit', function(self, ...)
    local guid = UnitGUID('mouseover')
    if not guid then
        return
    end
    local npcId = guid:match('.-%-%d+%-%d+%-%d+%-%d+%-(%d+)')
    if not NPCS[npcId] then
        return
    end

    local unfinished = getUnFinished(npcId, UnitName('mouseover'))
    if not #unfinished == 0 then
        return
    end

    GameTooltip:AddLine(' ')
    GameTooltip:AddLine(select(2, GetAchievementInfo(9696)), NORMAL_FONT_COLOR:GetRGB())
    for _, v in ipairs(unfinished) do
        GameTooltip:AddLine(format([[|TInterface\TARGETINGFRAME\PetBadge-%s:16|t %s]], PET_TYPE_SUFFIX[v.type], select(2, GetAchievementInfo(v.id))), RED_FONT_COLOR:GetRGB())
    end
    GameTooltip:Show()
end)
