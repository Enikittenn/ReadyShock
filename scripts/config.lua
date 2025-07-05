-- Configuration file for PiShock integration
-- Modify these values according to your setup

return {
    Username = "YOUR_PISHOCK_USERNAME", --Replace this with your Pishock Username
    Duration = "1", --Duration of the vibrate or shock
    PishockCode = "YOUR_PISHOCK'S_CODE", --The code for your shocker
    Intensity = "8",  --Intensity to use
    Apikey = "YOUR_API_KEY", --Your Pishock API Key
    TestMode = true,  -- true to vibrate, false to shock
    DebounceSeconds = 5 -- how long needs to pass after one zap before getting shot again causes another one
}
