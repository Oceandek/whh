local requests = http_request or request
local HttpService = game:GetService("HttpService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local player = game.Players.LocalPlayer
local username = player.Name

local function updateUser()
    local diamondsObject = player.leaderstats:FindFirstChild("💎 Diamonds")
    if diamondsObject then
        local gemCount = diamondsObject.Value
        print("Gem Count: " .. gemCount)


    local url = "http://192.168.0.117:8080/update-user"
    local data = {
        Url = url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode({ username = username, gems = gemCount, status = "online" })
    }

    local response = requests(data)
    if response.Success then
        print("User data updated successfully")
    else
        warn("Failed to update user data:", response.StatusMessage)
    end
end

updateUser()

while wait(60) do
    updateUser()
end
