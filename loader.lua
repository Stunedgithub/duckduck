if getgenv().duckLoaderLoaded == true then return end
getgenv().duckLoaderLoaded = true

local TweenService = cloneref(game:GetService("TweenService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local CoreGui = cloneref(game:GetService("CoreGui"))

local gui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local topBar = Instance.new("Frame")
local bottomBar = Instance.new("Frame")
local title = Instance.new("TextLabel")
local container = Instance.new("Frame")
local padding = Instance.new("UIPadding")
local contentFrame = Instance.new("Frame")
local infoLabel = Instance.new("TextLabel")
local stroke = Instance.new("UIStroke")
local listLayout = Instance.new("UIListLayout")
local dragEnabled = true

-- Dragging logic
local function makeDraggable(frame)
    local dragging, dragInput, startPos, startInputPos
    local function onInputBegan(input)
        dragging = true
        startInputPos = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end

    local function onInputChanged(input)
        if dragging and dragEnabled then
            local delta = input.Position - startInputPos
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            onInputBegan(input)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            onInputChanged(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            onInputChanged(input)
        end
    end)
end

-- UI setup
gui.Parent = CoreGui
mainFrame.Parent = gui
mainFrame.Active = true
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Size = UDim2.new(0, 300, 0, 100)

makeDraggable(mainFrame)

topBar.Parent = mainFrame
topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
topBar.Size = UDim2.new(1, 0, 0, 20)

bottomBar.Parent = topBar
bottomBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
bottomBar.Position = UDim2.new(0, 0, 0.9, 0)
bottomBar.Size = UDim2.new(1, 0, 0, 1)

title.Parent = topBar
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 1, 0)
title.Text = "Harrisons Hub"
title.TextColor3 = Color3.fromRGB(240, 240, 240)
title.Font = Enum.Font.Gotham
title.TextSize = 13

container.Parent = mainFrame
container.BackgroundTransparency = 1
container.Position = UDim2.new(0, 5, 0, 25)
container.Size = UDim2.new(0.965, 0, 1, -30)

padding.Parent = container
padding.PaddingBottom = UDim.new(0, 5)
padding.PaddingLeft = UDim.new(0, 2)

contentFrame.Parent = container
contentFrame.BackgroundTransparency = 1
contentFrame.Size = UDim2.new(1, 0, 0, 0)
contentFrame.AutomaticSize = Enum.AutomaticSize.Y

stroke.Parent = contentFrame
stroke.Color = Color3.fromRGB(32, 32, 32)

listLayout.Parent = contentFrame
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 4)

infoLabel.Parent = contentFrame
infoLabel.BackgroundTransparency = 1
infoLabel.Size = UDim2.new(1, -6, 0, 20)
infoLabel.Text = "Loading HarriHub..."
infoLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 12

-- Auto load the real script without key check
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e35dfe3721a4a57029cc101d8ec43cbe.lua"))()
