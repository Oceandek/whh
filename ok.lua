local HttpService = game:GetService("HttpService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local player = game.Players.LocalPlayer
local username = player.Name
local leaderstats = player.leaderstats



local hugecount = 0


local function abbreviateNumber(value)
    local absValue = math.abs(value)
    
    if absValue >= 1e9 then
        return string.format("%.1fB", value / 1e9)  -- Billion
    elseif absValue >= 1e6 then
        return string.format("%.1fM", value / 1e6)  -- Million
    elseif absValue >= 1e3 then
        return string.format("%.1fK", value / 1e3)  -- Thousand
    else
        return tostring(value)  -- Less than 1K, no notation needed
    end
end

local function updateUser()
    
    local formattedGemCount = leaderstats.Diamonds.Value
    local gemCount = abbreviateNumber(formattedGemCount)
    for _,pet in pairs(saveMod.Get()["Inventory"]["Pet"]) do
        if string.find(pet.id,"Huge") then
            hugecount = hugecount + 1
        end
    local url = "http://192.168.0.117:8080/update-user"
    local data = {
        Url = url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode({ username = username, gems = gemCount, status = "online", huges = hugecount })
    }



updateUser()

while wait(60) do
    updateUser()
end

