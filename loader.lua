local function M()
    return game.PlaceId==17625359962 or game.PlaceId==71874690745115 or game.PlaceId==117398147513099
end

local N=false
local A={hover=false,text=""}

local function O()
    if N==true then return end
    N=true
    if M() then
        script_key=script_key or A.text
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e35dfe3721a4a57029cc101d8ec43cbe.lua"))()
    end
end

if script_key and script_key~="" then
    O()
    return
end
