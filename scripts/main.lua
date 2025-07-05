-- Load configuration from external file
local config = require("config")

local lastShockTime = 0
local debounceSeconds = config.DebounceSeconds
    -- Convert testMode boolean to Op value (true = 1, false = 0)
    local opValue = config.TestMode and "1" or "0"
    
    local jsonPayload = string.format([[
{
    "Username":"%s",
    "Name":"ReadyOrNot_Mod",
    "Code":"%s",
    "Intensity":"%s",
    "Duration":"%s",
    "Apikey":"%s",
    "Op":"%s"
}]], config.Username, config.PishockCode, config.Intensity, config.Duration, config.Apikey, opValue)
    --print(jsonPayload)
    local escapedJson = jsonPayload:gsub('"', '\\"'):gsub("\n", "")
    local curlCommand = string.format(
        [[curl -X POST -H "Content-Type: application/json" -d "%s" https://do.pishock.com/api/apioperate]],
        escapedJson
    )

function send_pishock()
    --print("Running debounce\n")
    local now = os.time()
    if now - lastShockTime < debounceSeconds then
        print("Debounced PiShock trigger - this bullet will not trigger a pishock event\n")
        return
    end
    lastShockTime = now
    
    local startTime = os.clock()
    os.execute(curlCommand)
    print("Zap executed\n")
end

function hook_logic(self, BulletImpact)
    --print("Player has been shot! Executing callback\n")
    ExecuteAsync(function()
        send_pishock()
    end)
end

-- Register the hook
RegisterHook("/Script/ReadyOrNot.PlayerCharacter:Client_BulletHit", function(self, BulletImpact)
    hook_logic(self, BulletImpact)
    return true -- allow the original function to run
end)