local Players          = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local RunService       = game:GetService("RunService")
local lp               = Players.LocalPlayer
local C = {
    bg0    = Color3.fromRGB(6,   6,   6),
    bg1    = Color3.fromRGB(12,  12,  12),
    bg2    = Color3.fromRGB(20,  20,  20),
    bg3    = Color3.fromRGB(28,  28,  28),
    bg4    = Color3.fromRGB(38,  38,  38),
    white  = Color3.fromRGB(255, 255, 255),
    whiteA = Color3.fromRGB(210, 210, 210),
    whiteB = Color3.fromRGB(140, 140, 140),
    whiteC = Color3.fromRGB(60,  60,  60),
    line   = Color3.fromRGB(40,  40,  40),
    lineHi = Color3.fromRGB(180, 180, 180),
    black  = Color3.fromRGB(0,   0,   0),
    green  = Color3.fromRGB(80,  200, 120),
    greenD = Color3.fromRGB(30,  80,  50),
    red    = Color3.fromRGB(200, 60,  60),
    redD   = Color3.fromRGB(80,  20,  20),
    blue   = Color3.fromRGB(80,  140, 220),
    blueD  = Color3.fromRGB(20,  40,  90),
}
local ICON_FONT = "rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json"
local function ico(name)
    return '<font family="' .. ICON_FONT .. '">' .. name .. '</font>'
end
local WIN_W      = 300
local WIN_H      = 380
local HEADER_H   = 36
local FOOTER_H   = 18
local CARD_W     = 118
local CARD_H     = 82
local CARD_GAP   = 8
local COLS       = 2
local MAX_WP     = 10
local gui
do
    local ok = pcall(function()
        gui = Instance.new("ScreenGui")
        gui.Name           = "SetTP_Pro"
        gui.ResetOnSpawn   = false
        gui.DisplayOrder   = 998
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
        gui.IgnoreGuiInset = true
        gui.Parent         = game:GetService("CoreGui")
    end)
    if not ok then
        gui = Instance.new("ScreenGui", lp.PlayerGui)
        gui.Name           = "SetTP_Pro"
        gui.ResetOnSpawn   = false
        gui.DisplayOrder   = 998
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
        gui.IgnoreGuiInset = true
    end
end
local main = Instance.new("Frame", gui)
main.Size             = UDim2.new(0, WIN_W, 0, WIN_H)
main.Position         = UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2)
main.BackgroundColor3 = C.bg0
main.BorderSizePixel  = 0
main.ClipsDescendants = true
main.ZIndex           = 2
local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0, 14)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color     = C.line
mainStroke.Thickness = 1
local header = Instance.new("Frame", main)
header.Size             = UDim2.new(1, 0, 0, HEADER_H)
header.BackgroundColor3 = C.bg1
header.BorderSizePixel  = 0
header.ZIndex           = 10
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 14)
local hFix = Instance.new("Frame", header)
hFix.Size             = UDim2.new(1, 0, 0.5, 0)
hFix.Position         = UDim2.new(0, 0, 0.5, 0)
hFix.BackgroundColor3 = C.bg1
hFix.BorderSizePixel  = 0
hFix.ZIndex           = 10
local hLine = Instance.new("Frame", header)
hLine.Size             = UDim2.new(1, 0, 0, 1)
hLine.Position         = UDim2.new(0, 0, 1, -1)
hLine.BackgroundColor3 = C.line
hLine.BorderSizePixel  = 0
hLine.ZIndex           = 11
local hGrad = Instance.new("UIGradient", hLine)
hGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,    C.bg1),
    ColorSequenceKeypoint.new(0.25, C.whiteC),
    ColorSequenceKeypoint.new(0.5,  C.lineHi),
    ColorSequenceKeypoint.new(0.75, C.whiteC),
    ColorSequenceKeypoint.new(1,    C.bg1),
})
hGrad.Offset = Vector2.new(-1, 0)
task.spawn(function()
    local dir = 1
    while main.Parent do
        TweenService:Create(hGrad,
            TweenInfo.new(2.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Offset = Vector2.new(dir, 0)}):Play()
        task.wait(2.8)
        dir = -dir
    end
end)
local headerIco = Instance.new("TextLabel", header)
headerIco.Size               = UDim2.new(0, 24, 1, 0)
headerIco.Position           = UDim2.new(0, 12, 0, 0)
headerIco.BackgroundTransparency = 1
headerIco.RichText           = true
headerIco.Text               = ico("teleport")
headerIco.TextColor3         = C.whiteA
headerIco.TextSize           = 15
headerIco.Font               = Enum.Font.Legacy
headerIco.ZIndex             = 11
local headerTitle = Instance.new("TextLabel", header)
headerTitle.Size               = UDim2.new(1, -120, 1, 0)
headerTitle.Position           = UDim2.new(0, 38, 0, 0)
headerTitle.BackgroundTransparency = 1
headerTitle.Text               = "SET / TP"
headerTitle.TextColor3         = C.white
headerTitle.TextSize           = 13
headerTitle.Font               = Enum.Font.GothamBold
headerTitle.TextXAlignment     = Enum.TextXAlignment.Left
headerTitle.ZIndex             = 11
local function makeHBtn(iconName, offsetX)
    local btn = Instance.new("TextButton", header)
    btn.Size                 = UDim2.new(0, 26, 0, 26)
    btn.Position             = UDim2.new(1, offsetX, 0.5, -13)
    btn.BackgroundTransparency = 1
    btn.BorderSizePixel      = 0
    btn.RichText             = true
    btn.Text                 = ico(iconName)
    btn.TextColor3           = C.whiteB
    btn.TextSize             = 15
    btn.Font                 = Enum.Font.Legacy
    btn.ZIndex               = 12
    btn.AutoButtonColor      = false
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {TextColor3 = C.white}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {TextColor3 = C.whiteB}):Play()
    end)
    return btn
end
local closeBtn    = makeHBtn("x",                -28)
local minimizeBtn = makeHBtn("chevron-small-down",-54)
local eyeBtn = Instance.new("TextButton", header)
eyeBtn.Size                 = UDim2.new(0, 26, 0, 26)
eyeBtn.Position             = UDim2.new(1, -80, 0.5, -13)
eyeBtn.BackgroundTransparency = 1
eyeBtn.BorderSizePixel      = 0
eyeBtn.RichText             = true
eyeBtn.Text                 = ico("eye")
eyeBtn.TextColor3           = C.whiteB
eyeBtn.TextSize             = 15
eyeBtn.Font                 = Enum.Font.Legacy
eyeBtn.ZIndex               = 12
eyeBtn.AutoButtonColor      = false
eyeBtn.MouseEnter:Connect(function()
    TweenService:Create(eyeBtn, TweenInfo.new(0.1), {TextColor3 = C.white}):Play()
end)
eyeBtn.MouseLeave:Connect(function()
    TweenService:Create(eyeBtn, TweenInfo.new(0.1), {TextColor3 = C.whiteB}):Play()
end)
do
    local dragging, dragStart, startPos = false, nil, nil
    header.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragStart = i.Position
            startPos  = main.Position
        end
    end)
    header.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
        or  i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - dragStart
            main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
end
local PILL_W, PILL_H = 180, 34
local _minimized  = false
local _normalSize = main.Size
local _normalPos  = main.Position
local pillBorderFrame = Instance.new("Frame", main)
pillBorderFrame.Size             = UDim2.new(1, 4, 1, 4)
pillBorderFrame.Position         = UDim2.new(0, -2, 0, -2)
pillBorderFrame.BackgroundTransparency = 1
pillBorderFrame.BorderSizePixel  = 0
pillBorderFrame.Visible          = false
pillBorderFrame.ZIndex           = 1
Instance.new("UICorner", pillBorderFrame).CornerRadius = UDim.new(1, 0)
local pillBorderStroke = Instance.new("UIStroke", pillBorderFrame)
pillBorderStroke.Color     = C.green
pillBorderStroke.Thickness = 2
local pillDot = Instance.new("Frame", main)
pillDot.Size             = UDim2.new(0, 8, 0, 8)
pillDot.Position         = UDim2.new(0, 14, 0.5, -4)
pillDot.BackgroundColor3 = C.white
pillDot.BorderSizePixel  = 0
pillDot.Visible          = false
pillDot.ZIndex           = 30
Instance.new("UICorner", pillDot).CornerRadius = UDim.new(1, 0)
local pillLbl = Instance.new("TextLabel", main)
pillLbl.Size               = UDim2.new(0, 60, 1, 0)
pillLbl.Position           = UDim2.new(0, 28, 0, 0)
pillLbl.BackgroundTransparency = 1
pillLbl.Text               = "SET / TP"
pillLbl.TextColor3         = C.white
pillLbl.TextSize           = 12
pillLbl.Font               = Enum.Font.GothamBold
pillLbl.TextXAlignment     = Enum.TextXAlignment.Left
pillLbl.Visible            = false
pillLbl.ZIndex             = 30
local pillBtn = Instance.new("TextButton", main)
pillBtn.Size               = UDim2.new(1, 0, 1, 0)
pillBtn.BackgroundTransparency = 1
pillBtn.BorderSizePixel    = 0
pillBtn.Text               = ""
pillBtn.Visible            = false
pillBtn.ZIndex             = 35
task.spawn(function()
    while main.Parent do
        if _minimized then
            TweenService:Create(pillDot,
                TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {BackgroundTransparency = 0.7}):Play()
            task.wait(0.7)
            TweenService:Create(pillDot,
                TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {BackgroundTransparency = 0}):Play()
            task.wait(0.7)
        else
            task.wait(0.5)
        end
    end
end)
task.spawn(function()
    while main.Parent do
        if _minimized and autoTP then
            TweenService:Create(pillBorderStroke,
                TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Transparency = 0.6}):Play()
            task.wait(0.6)
            TweenService:Create(pillBorderStroke,
                TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Transparency = 0}):Play()
            task.wait(0.6)
        else
            pillBorderFrame.Visible = false
            task.wait(0.3)
        end
    end
end)
local contentGroup
local function minimizeToPill()
    if _minimized then return end
    _minimized  = true
    _normalSize = main.Size
    _normalPos  = main.Position
    if contentGroup then
        for _, v in ipairs(contentGroup) do v.Visible = false end
    end
    TweenService:Create(main,
        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, PILL_W, 0, PILL_H),
         Position = UDim2.new(0.5, -PILL_W/2, 0, 18)}):Play()
    task.delay(0.28, function()
        TweenService:Create(mainCorner,
            TweenInfo.new(0.12), {CornerRadius = UDim.new(1, 0)}):Play()
        mainStroke.Thickness = 0.5
        pillDot.Visible     = true
        pillLbl.Visible     = true
        pillBtn.Visible     = true
        if autoTP then
            pillBorderFrame.Visible = true
        end
    end)
    minimizeBtn.Text = ico("chevron-small-up")
end
local function restoreFromPill()
    if not _minimized then return end
    _minimized = false
    pillDot.Visible       = false
    pillLbl.Visible       = false
    pillBtn.Visible       = false
    pillBorderFrame.Visible = false
    mainCorner.CornerRadius = UDim.new(0, 14)
    mainStroke.Thickness    = 1
    TweenService:Create(main,
        TweenInfo.new(0.36, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = _normalSize, Position = _normalPos}):Play()
    task.delay(0.28, function()
        if contentGroup then
            for _, v in ipairs(contentGroup) do v.Visible = true end
        end
        minimizeBtn.Text = ico("chevron-small-down")
    end)
end
minimizeBtn.Activated:Connect(minimizeToPill)
pillBtn.Activated:Connect(restoreFromPill)
closeBtn.Activated:Connect(function() main.Visible = false end)
UserInputService.InputBegan:Connect(function(i, gpe)
    if not gpe and i.KeyCode == Enum.KeyCode.RightControl then
        if _minimized then restoreFromPill(); return end
        main.Visible = not main.Visible
    end
end)
local footer = Instance.new("Frame", main)
footer.Size               = UDim2.new(1, 0, 0, FOOTER_H)
footer.Position           = UDim2.new(0, 0, 1, -FOOTER_H)
footer.BackgroundTransparency = 1
footer.ZIndex             = 6
local footerLbl = Instance.new("TextLabel", footer)
footerLbl.Size             = UDim2.new(1, 0, 1, 0)
footerLbl.BackgroundTransparency = 1
footerLbl.Text             = "SET / TP  PRO"
footerLbl.TextSize         = 9
footerLbl.Font             = Enum.Font.GothamBold
footerLbl.ZIndex           = 7
footerLbl.TextXAlignment   = Enum.TextXAlignment.Center
local waveGrad = Instance.new("UIGradient", footerLbl)
waveGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,    C.whiteC),
    ColorSequenceKeypoint.new(0.4,  C.whiteC),
    ColorSequenceKeypoint.new(0.5,  C.white),
    ColorSequenceKeypoint.new(0.6,  C.whiteC),
    ColorSequenceKeypoint.new(1,    C.whiteC),
})
waveGrad.Offset = Vector2.new(-1.5, 0)
task.spawn(function()
    while main.Parent do
        waveGrad.Offset = Vector2.new(-1.5, 0)
        TweenService:Create(waveGrad,
            TweenInfo.new(2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Offset = Vector2.new(1.5, 0)}):Play()
        task.wait(4)
    end
end)
local TOOLBAR_H = 38
local toolbar = Instance.new("Frame", main)
toolbar.Size             = UDim2.new(1, 0, 0, TOOLBAR_H)
toolbar.Position         = UDim2.new(0, 0, 0, HEADER_H)
toolbar.BackgroundColor3 = C.bg1
toolbar.BorderSizePixel  = 0
toolbar.ZIndex           = 8
local tbLine = Instance.new("Frame", toolbar)
tbLine.Size             = UDim2.new(1, 0, 0, 1)
tbLine.Position         = UDim2.new(0, 0, 1, -1)
tbLine.BackgroundColor3 = C.line
tbLine.BorderSizePixel  = 0
tbLine.ZIndex           = 9
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size                 = UDim2.new(1, 0, 1, -(HEADER_H + TOOLBAR_H + FOOTER_H))
scroll.Position             = UDim2.new(0, 0, 0, HEADER_H + TOOLBAR_H)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel      = 0
scroll.ZIndex               = 3
scroll.ScrollBarThickness   = 3
scroll.ScrollBarImageColor3 = C.whiteC
scroll.CanvasSize           = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize  = Enum.AutomaticSize.Y
scroll.ScrollingEnabled     = true
scroll.MouseEnter:Connect(function() scroll.ScrollBarThickness = 4 end)
scroll.MouseLeave:Connect(function() scroll.ScrollBarThickness = 3 end)
local scrollInner = Instance.new("Frame", scroll)
scrollInner.Size             = UDim2.new(1, 0, 0, 0)
scrollInner.BackgroundTransparency = 1
scrollInner.AutomaticSize    = Enum.AutomaticSize.Y
scrollInner.ZIndex           = 3
local gridLayout = Instance.new("UIGridLayout", scrollInner)
gridLayout.CellSize         = UDim2.new(0, CARD_W, 0, CARD_H)
gridLayout.CellPadding      = UDim2.new(0, CARD_GAP, 0, CARD_GAP)
gridLayout.SortOrder        = Enum.SortOrder.LayoutOrder
gridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
local scrollPad = Instance.new("UIPadding", scrollInner)
scrollPad.PaddingTop    = UDim.new(0, 14)
scrollPad.PaddingBottom = UDim.new(0, 14)
scrollPad.PaddingLeft   = UDim.new(0, 14)
scrollPad.PaddingRight  = UDim.new(0, 14)
contentGroup = {toolbar, scroll, footer, header}
local waypoints  = {}
local autoTP     = false
local autoDelay  = 0.15
local autoIndex  = 1
local statusLbl = Instance.new("TextLabel", toolbar)
statusLbl.Size               = UDim2.new(0, 90, 1, 0)
statusLbl.Position           = UDim2.new(0, 14, 0, 0)
statusLbl.BackgroundTransparency = 1
statusLbl.TextColor3         = C.whiteB
statusLbl.TextSize           = 11
statusLbl.Font               = Enum.Font.Gotham
statusLbl.TextXAlignment     = Enum.TextXAlignment.Left
statusLbl.ZIndex             = 9
local function updateStatus()
    local count = 0
    for _, v in pairs(waypoints) do
        if v then count += 1 end
    end
    statusLbl.Text = count .. " / " .. MAX_WP .. " wp"
end
updateStatus()
local delayLbl = Instance.new("TextLabel", toolbar)
delayLbl.Size               = UDim2.new(0, 22, 1, 0)
delayLbl.Position           = UDim2.new(0, 106, 0, 0)
delayLbl.BackgroundTransparency = 1
delayLbl.Text               = "spd"
delayLbl.TextColor3         = C.whiteC
delayLbl.TextSize           = 9
delayLbl.Font               = Enum.Font.GothamBold
delayLbl.TextXAlignment     = Enum.TextXAlignment.Left
delayLbl.ZIndex             = 9
local delayBox = Instance.new("TextBox", toolbar)
delayBox.Size             = UDim2.new(0, 34, 0, 22)
delayBox.Position         = UDim2.new(0, 128, 0.5, -11)
delayBox.BackgroundColor3 = C.bg3
delayBox.BorderSizePixel  = 0
delayBox.Text             = tostring(autoDelay)
delayBox.PlaceholderText  = "0"
delayBox.TextColor3       = C.whiteA
delayBox.PlaceholderColor3 = C.whiteC
delayBox.TextSize         = 10
delayBox.Font             = Enum.Font.Gotham
delayBox.ClearTextOnFocus = false
delayBox.TextXAlignment   = Enum.TextXAlignment.Center
delayBox.ZIndex           = 9
Instance.new("UICorner", delayBox).CornerRadius = UDim.new(0, 6)
local dbStroke = Instance.new("UIStroke", delayBox)
dbStroke.Color = C.line; dbStroke.Thickness = 1
delayBox.Focused:Connect(function()
    TweenService:Create(dbStroke,TweenInfo.new(0.15),{Color=C.lineHi}):Play()
end)
delayBox.FocusLost:Connect(function()
    TweenService:Create(dbStroke,TweenInfo.new(0.15),{Color=C.line}):Play()
    local v = tonumber(delayBox.Text)
    if v and v >= 0 then
        autoDelay = v
        delayBox.Text = tostring(autoDelay)
    else
        delayBox.Text = tostring(autoDelay)
    end
end)
local autoBtn = Instance.new("TextButton", toolbar)
autoBtn.Size             = UDim2.new(0, 76, 0, 28)
autoBtn.Position         = UDim2.new(0, 170, 0.5, -14)
autoBtn.BackgroundColor3 = C.bg3
autoBtn.BorderSizePixel  = 0
autoBtn.RichText         = true
autoBtn.Text             = ico("play-xlarge") .. " Auto"
autoBtn.TextColor3       = C.whiteB
autoBtn.TextSize         = 11
autoBtn.Font             = Enum.Font.Legacy
autoBtn.ZIndex           = 9
autoBtn.AutoButtonColor  = false
Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0, 8)
local autoStroke = Instance.new("UIStroke", autoBtn)
autoStroke.Color     = C.line
autoStroke.Thickness = 1
local function refreshAutoBtn()
    if autoTP then
        TweenService:Create(autoBtn,   TweenInfo.new(0.15), {BackgroundColor3 = C.greenD, TextColor3 = C.green}):Play()
        TweenService:Create(autoStroke,TweenInfo.new(0.15), {Color = C.green}):Play()
        autoBtn.Text = ico("pause-large") .. " Auto"
        if _minimized then
            pillBorderFrame.Visible = true
        end
    else
        TweenService:Create(autoBtn,   TweenInfo.new(0.15), {BackgroundColor3 = C.bg3, TextColor3 = C.whiteB}):Play()
        TweenService:Create(autoStroke,TweenInfo.new(0.15), {Color = C.line}):Play()
        autoBtn.Text = ico("play-xlarge") .. " Auto"
        pillBorderFrame.Visible = false
    end
end
autoBtn.MouseEnter:Connect(function()
    if not autoTP then
        TweenService:Create(autoBtn,TweenInfo.new(0.1),{BackgroundColor3=C.bg4,TextColor3=C.white}):Play()
    end
end)
autoBtn.MouseLeave:Connect(function()
    if not autoTP then
        TweenService:Create(autoBtn,TweenInfo.new(0.1),{BackgroundColor3=C.bg3,TextColor3=C.whiteB}):Play()
    end
end)
autoBtn.Activated:Connect(function()
    autoTP = not autoTP
    autoIndex = 1
    refreshAutoBtn()
end)
local function makeCard(index)
    local card = Instance.new("Frame", scrollInner)
    card.Size             = UDim2.new(0, CARD_W, 0, CARD_H)
    card.BackgroundColor3 = C.bg2
    card.BorderSizePixel  = 0
    card.LayoutOrder      = index
    card.ZIndex           = 4
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)
    local cardStroke = Instance.new("UIStroke", card)
    cardStroke.Color     = C.line
    cardStroke.Thickness = 1
    card.BackgroundTransparency = 1
    TweenService:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0}):Play()
    local numLbl = Instance.new("TextLabel", card)
    numLbl.Size               = UDim2.new(0, 28, 0, 18)
    numLbl.Position           = UDim2.new(0, 10, 0, 8)
    numLbl.BackgroundTransparency = 1
    numLbl.Text               = tostring(index)
    numLbl.TextColor3         = C.whiteC
    numLbl.TextSize           = 10
    numLbl.Font               = Enum.Font.GothamBold
    numLbl.TextXAlignment     = Enum.TextXAlignment.Left
    numLbl.ZIndex             = 5
    local statusIco = Instance.new("TextLabel", card)
    statusIco.Size               = UDim2.new(0, 22, 0, 18)
    statusIco.Position           = UDim2.new(1, -30, 0, 8)
    statusIco.BackgroundTransparency = 1
    statusIco.RichText           = true
    statusIco.Text               = ""
    statusIco.TextColor3         = C.green
    statusIco.TextSize           = 12
    statusIco.Font               = Enum.Font.Legacy
    statusIco.ZIndex             = 5
    local posLbl = Instance.new("TextLabel", card)
    posLbl.Size               = UDim2.new(1, -16, 0, 22)
    posLbl.Position           = UDim2.new(0, 8, 0, 26)
    posLbl.BackgroundTransparency = 1
    posLbl.Text               = "—"
    posLbl.TextColor3         = C.whiteC
    posLbl.TextSize           = 9
    posLbl.Font               = Enum.Font.Gotham
    posLbl.TextXAlignment     = Enum.TextXAlignment.Center
    posLbl.TextTruncate       = Enum.TextTruncate.AtEnd
    posLbl.ZIndex             = 5
    local function refreshCard()
        local wp = waypoints[index]
        if wp then
            statusIco.Text    = ico("location")
            posLbl.Text       = string.format("%.1f, %.1f, %.1f", wp.X, wp.Y, wp.Z)
            posLbl.TextColor3 = C.whiteB
            TweenService:Create(cardStroke, TweenInfo.new(0.2), {Color = C.greenD}):Play()
            TweenService:Create(card,       TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(14,22,16)}):Play()
        else
            statusIco.Text    = ""
            posLbl.Text       = "—"
            posLbl.TextColor3 = C.whiteC
            TweenService:Create(cardStroke, TweenInfo.new(0.2), {Color = C.line}):Play()
            TweenService:Create(card,       TweenInfo.new(0.2), {BackgroundColor3 = C.bg2}):Play()
        end
        updateStatus()
    end
    local BTN_H   = 26
    local BTN_Y   = CARD_H - BTN_H - 7
    local BTN_PAD = 7
    local BTN_GAP = 3
    local BTN_W   = math.floor((CARD_W - BTN_PAD*2 - BTN_GAP*2) / 3)
    local function makeCardBtn(iconName, x, bgColor, textColor)
        local btn = Instance.new("TextButton", card)
        btn.Size             = UDim2.new(0, BTN_W, 0, BTN_H)
        btn.Position         = UDim2.new(0, x, 0, BTN_Y)
        btn.BackgroundColor3 = bgColor
        btn.BorderSizePixel  = 0
        btn.RichText         = true
        btn.Text             = ico(iconName)
        btn.TextColor3       = textColor
        btn.TextSize         = 13
        btn.Font             = Enum.Font.Legacy
        btn.ZIndex           = 5
        btn.AutoButtonColor  = false
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        return btn
    end
    local setBtn = makeCardBtn("pin",             BTN_PAD,                        C.bg3, C.whiteB)
    local tpBtn  = makeCardBtn("person-teleport", BTN_PAD + BTN_W + BTN_GAP,     C.bg3, C.whiteB)
    local delBtn = makeCardBtn("trash-can",       BTN_PAD + (BTN_W + BTN_GAP)*2, C.bg3, C.whiteB)
    local function hoverIn(btn, tc)
        TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=C.bg4, TextColor3=tc}):Play()
    end
    local function hoverOut(btn)
        TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=C.bg3, TextColor3=C.whiteB}):Play()
    end
    setBtn.MouseEnter:Connect(function()  hoverIn(setBtn, C.green) end)
    setBtn.MouseLeave:Connect(function()  hoverOut(setBtn) end)
    tpBtn.MouseEnter:Connect(function()   hoverIn(tpBtn,  C.blue)  end)
    tpBtn.MouseLeave:Connect(function()   hoverOut(tpBtn) end)
    delBtn.MouseEnter:Connect(function()  hoverIn(delBtn, C.red)   end)
    delBtn.MouseLeave:Connect(function()  hoverOut(delBtn) end)
    delBtn.Activated:Connect(function()
        waypoints[index] = nil
        refreshCard()
        TweenService:Create(delBtn,TweenInfo.new(0.08),{BackgroundColor3 = C.redD}):Play()
        task.delay(0.35, function()
            TweenService:Create(delBtn,TweenInfo.new(0.15),{BackgroundColor3 = C.bg3}):Play()
        end)
    end)
    setBtn.Activated:Connect(function()
        local char = lp.Character
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        waypoints[index] = hrp.Position
        refreshCard()
        TweenService:Create(setBtn,TweenInfo.new(0.08),{BackgroundColor3 = C.greenD}):Play()
        task.delay(0.35, function()
            TweenService:Create(setBtn,TweenInfo.new(0.15),{BackgroundColor3 = C.bg3}):Play()
        end)
    end)
    tpBtn.Activated:Connect(function()
        local wp   = waypoints[index]
        local char = lp.Character
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        if not (wp and hrp) then return end
        hrp.CFrame = CFrame.new(wp)
        TweenService:Create(tpBtn,TweenInfo.new(0.08),{BackgroundColor3 = C.blueD}):Play()
        task.delay(0.35, function()
            TweenService:Create(tpBtn,TweenInfo.new(0.15),{BackgroundColor3 = C.bg3}):Play()
        end)
    end)
    refreshCard()
    return card
end
for i = 1, MAX_WP do
    makeCard(i)
end
updateStatus()
task.spawn(function()
    while true do
        if autoTP then
            local list = {}
            for i = 1, MAX_WP do
                if waypoints[i] then
                    table.insert(list, waypoints[i])
                end
            end
            if #list > 0 then
                local wp   = list[((autoIndex - 1) % #list) + 1]
                local char = lp.Character
                local hrp  = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(wp)
                end
                autoIndex += 1
                task.wait(autoDelay)
            else
                task.wait(0.1)
            end
        else
            task.wait(0.05)
        end
    end
end)
local helpGui = Instance.new("Frame", gui)
helpGui.Size             = UDim2.new(0, 280, 0, 0)
helpGui.AutomaticSize    = Enum.AutomaticSize.Y
helpGui.Position         = UDim2.new(0.5, -140, 0.5, -100)
helpGui.BackgroundColor3 = C.bg1
helpGui.BorderSizePixel  = 0
helpGui.Visible          = false
helpGui.ZIndex           = 9999
Instance.new("UICorner", helpGui).CornerRadius = UDim.new(0, 14)
local helpStroke = Instance.new("UIStroke", helpGui)
helpStroke.Color     = C.line
helpStroke.Thickness = 1
local helpHeader = Instance.new("Frame", helpGui)
helpHeader.Size             = UDim2.new(1, 0, 0, 36)
helpHeader.BackgroundColor3 = C.bg2
helpHeader.BorderSizePixel  = 0
helpHeader.ZIndex           = 10000
Instance.new("UICorner", helpHeader).CornerRadius = UDim.new(0, 14)
local hhFix = Instance.new("Frame", helpHeader)
hhFix.Size             = UDim2.new(1, 0, 0.5, 0)
hhFix.Position         = UDim2.new(0, 0, 0.5, 0)
hhFix.BackgroundColor3 = C.bg2
hhFix.BorderSizePixel  = 0
hhFix.ZIndex           = 10000
local helpHeaderLbl = Instance.new("TextLabel", helpHeader)
helpHeaderLbl.Size               = UDim2.new(1, -16, 1, 0)
helpHeaderLbl.Position           = UDim2.new(0, 14, 0, 0)
helpHeaderLbl.BackgroundTransparency = 1
helpHeaderLbl.Text               = "How to use"
helpHeaderLbl.TextColor3         = C.white
helpHeaderLbl.TextSize           = 12
helpHeaderLbl.Font               = Enum.Font.GothamBold
helpHeaderLbl.TextXAlignment     = Enum.TextXAlignment.Left
helpHeaderLbl.ZIndex             = 10001
local helpLine = Instance.new("Frame", helpHeader)
helpLine.Size             = UDim2.new(1, 0, 0, 1)
helpLine.Position         = UDim2.new(0, 0, 1, -1)
helpLine.BackgroundColor3 = C.line
helpLine.BorderSizePixel  = 0
helpLine.ZIndex           = 10001
local helpContent = Instance.new("Frame", helpGui)
helpContent.Size             = UDim2.new(1, 0, 0, 0)
helpContent.Position         = UDim2.new(0, 0, 0, 36)
helpContent.BackgroundTransparency = 1
helpContent.AutomaticSize    = Enum.AutomaticSize.Y
helpContent.BorderSizePixel  = 0
helpContent.ZIndex           = 10000
local helpList = Instance.new("UIListLayout", helpContent)
helpList.SortOrder        = Enum.SortOrder.LayoutOrder
helpList.Padding          = UDim.new(0, 0)
local helpPad = Instance.new("UIPadding", helpContent)
helpPad.PaddingTop    = UDim.new(0, 10)
helpPad.PaddingBottom = UDim.new(0, 12)
helpPad.PaddingLeft   = UDim.new(0, 14)
helpPad.PaddingRight  = UDim.new(0, 14)
local HELP_ENTRIES = {
    { "pin",             "Set — saves your current position to the waypoint" },
    { "person-teleport", "TP — teleports you to the saved position" },
    { "trash-can",       "Delete — clears the saved position from the waypoint" },
    { "play-xlarge",     "Auto — loops through all set waypoints automatically" },
    { "chevron-small-down", "Minimize — collapses the UI into a pill" },
    { "eye",             "Help — shows / hides this panel" },
}
for i, entry in ipairs(HELP_ENTRIES) do
    local row = Instance.new("Frame", helpContent)
    row.Size             = UDim2.new(1, 0, 0, 30)
    row.BackgroundTransparency = 1
    row.BorderSizePixel  = 0
    row.LayoutOrder      = i
    row.ZIndex           = 10001
    local rowIco = Instance.new("TextLabel", row)
    rowIco.Size               = UDim2.new(0, 22, 1, 0)
    rowIco.Position           = UDim2.new(0, 0, 0, 0)
    rowIco.BackgroundTransparency = 1
    rowIco.RichText           = true
    rowIco.Text               = ico(entry[1])
    rowIco.TextColor3         = C.whiteA
    rowIco.TextSize           = 13
    rowIco.Font               = Enum.Font.Legacy
    rowIco.TextXAlignment     = Enum.TextXAlignment.Left
    rowIco.ZIndex             = 10002
    local rowLbl = Instance.new("TextLabel", row)
    rowLbl.Size               = UDim2.new(1, -30, 1, 0)
    rowLbl.Position           = UDim2.new(0, 28, 0, 0)
    rowLbl.BackgroundTransparency = 1
    rowLbl.Text               = entry[2]
    rowLbl.TextColor3         = C.whiteB
    rowLbl.TextSize           = 10
    rowLbl.Font               = Enum.Font.Gotham
    rowLbl.TextXAlignment     = Enum.TextXAlignment.Left
    rowLbl.TextWrapped        = true
    rowLbl.ZIndex             = 10002
    if i < #HELP_ENTRIES then
        local divider = Instance.new("Frame", row)
        divider.Size             = UDim2.new(1, 0, 0, 1)
        divider.Position         = UDim2.new(0, 0, 1, -1)
        divider.BackgroundColor3 = C.line
        divider.BorderSizePixel  = 0
        divider.ZIndex           = 10001
    end
end
local _helpVisible = false
local function showHelp()
    _helpVisible = true
    helpGui.Visible = true
    helpGui.BackgroundTransparency = 1
    TweenService:Create(helpGui, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0}):Play()
    eyeBtn.Text = ico("eye-slash")
end
local function hideHelp()
    _helpVisible = false
    TweenService:Create(helpGui, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
    task.delay(0.15, function() helpGui.Visible = false end)
    eyeBtn.Text = ico("eye")
end
eyeBtn.Activated:Connect(function()
    if _helpVisible then hideHelp() else showHelp() end
end)
