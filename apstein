-- NEW GHOST-WEIGHT BYPASS (JAN 4, 2026)
local player = game.Players.LocalPlayer
local active = false

-- Use a fresh, unflagged ID
local newId = "rbxassetid://15264639453" 

-- 1. LOAD YOUR NEW HUB (Make sure it's the RAW link)
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("PASTE_YOUR_NEW_RAW_LINK_HERE"))()
    end)
end)

-- 2. THE BYPASS LOOP
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.K then 
        active = not active 
        print("Bypass Active:", active)
    end
end)

task.spawn(function()
    while true do
        if active then
            local animator = player.Character.Humanoid:FindFirstChildOfClass("Animator")
            if animator then
                -- Step 1: Clear everything to stay at 0/32 tracks
                for _, t in pairs(animator:GetPlayingAnimationTracks()) do t:Destroy() end

                -- Step 2: Load exactly ONE high-complexity track
                local a = Instance.new("Animation")
                a.AnimationId = newId
                local t = animator:LoadAnimation(a)
                t:Play()

                -- Step 3: "Ghost Weight" Spam
                -- Instead of 100 tracks, we send 800 property updates per cycle
                for i = 1, 800 do
                    t:AdjustWeight(math.random(1, 100) / 10)
                    t:AdjustSpeed(math.random(1, 100) / 10)
                end
                
                -- Fast cleanup
                task.wait()
                t:Destroy()
                a:Destroy()
            end
        end
        task.wait(0.01) -- Maximum frequency
    end
end)
