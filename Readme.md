# ReadyShock

## What is This?

Readyshock is a mod written for the game Ready or Not on the UE4SS platform that enables support for the Pishock device.

## Functionality Overview
Once the mod is enabled, any time the user is shot with a bullet that goes through their armor a call is triggered to the Pishock API.  Further shots within the *DebouncePeriod* (customizable) will be discarded to avoid rapid-fire shocking when a series of bullets are taken.

## Super Important Constraints (READ THESE BEFORE USING)
- As calls to the Pishock API are made by spawning a new process, there is an unavoidable 2-3 second delay between bullet impact and the shock being delivered to the user. This may eventually be cut down by using a C-based networking library if I ever get around to implementing it.

- All bullet impacts cause the same level of shock.  Eventually I'd like to add more effects like a lighter shock for flashbangs.

- ***This code is provided as-is with no guarentees that it will function at all, or as specified. You are accepting all risk, including the risk of being zapped uncontrollably, by installing this mod.***

## How to Use
- Install [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS) into your copy of Ready or Not. I recommend doing the full developer-build.
- Run the game and make sure it still works.
- In the Mods folder created during the UE4SS setup, create a new folder called *ReadyShock*. Copy the scripts folder in this repo there
- Create a new Code through the Pishock UI and set up an API Key
- Configure the values in config.lua as follows
    - Username = "YOUR_PISHOCK_USERNAME", --Replace this with your Pishock Username
    - Duration = "1", --Duration of the vibrate or shock
    - PishockCode = "YOUR_PISHOCK'S_CODE", --The code you just created
    - Intensity = "8",  --Intensity to use
    - Apikey = "YOUR_API_KEY", --The API key you just created
    - TestMode = true,  -- True to vibrate, false to shock.
    - DebounceSeconds = 5 -- how long needs to pass after one zap before getting shot again causes another one
- Start the game! You should see a log in the UE4SS debug console saying something like

`Registered native hook (69, 70) for Function /Script/ReadyOrNot.PlayerCharacter:Client_BulletHit`

- Start a match and get shot! Your pishock should be triggered automatically