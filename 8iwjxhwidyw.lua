getgenv().GG = {
    Language = {
        Title = "Nexus",
        ButtonClick = "Click Me!",
        CheckboxToggle = "Toggle Me!",
        DropdownSelect = "Select an option",
        SliderAdjust = "Adjust Me!",
        KeybindPress = "Press a key...",
        NotificationTitle = "Notification",
        NotificationText = "This is a notification!"
    }
}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local Library = {}
local dragging, dragInput, dragStart, startPos
local TweenSpeed = 0.3
local Utility = {}

function Utility:Tween(instance, properties, speed, tween_type)
    tween_type = tween_type or Enum.EasingStyle.Sine
    local tween = TweenService:Create(instance, TweenInfo.new(speed or TweenSpeed, tween_type), properties)
    tween:Play()
    return tween
end

function Library.new()
    local GUI = Instance.new("ScreenGui")
    GUI.Name = "Nexus"
    GUI.IgnoreGuiInset = true
    GUI.Parent = CoreGui

    local Main = Instance.new("Frame")
    Main.Size = UDim2.fromOffset(600, 400)
    Main.Position = UDim2.fromScale(0.5, 0.5)
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(24, 26, 36)
    Main.BorderSizePixel = 0
    Main.Parent = GUI

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Main

    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    TopBar.BackgroundColor3 = Color3.fromRGB(32, 38, 51)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = Main

    local UICorner_2 = Instance.new("UICorner")
    UICorner_2.CornerRadius = UDim.new(0, 6)
    UICorner_2.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Position = UDim2.fromOffset(10, 0)
    Title.BackgroundTransparency = 1
    Title.Text = GG.Language.Title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    local Close = Instance.new("TextButton")
    Close.Size = UDim2.fromOffset(24, 24)
    Close.Position = UDim2.new(1, -28, 0, 3)
    Close.BackgroundTransparency = 1
    Close.Text = "✕"
    Close.TextColor3 = Color3.fromRGB(255, 255, 255)
    Close.TextSize = 14
    Close.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
    Close.Parent = TopBar

    local Tabs = Instance.new("Frame")
    Tabs.Size = UDim2.new(0, 120, 1, -30)
    Tabs.Position = UDim2.fromOffset(0, 30)
    Tabs.BackgroundColor3 = Color3.fromRGB(28, 31, 43)
    Tabs.BorderSizePixel = 0
    Tabs.Parent = Main

    local UICorner_3 = Instance.new("UICorner")
    UICorner_3.CornerRadius = UDim.new(0, 6)
    UICorner_3.Parent = Tabs

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 5)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Tabs

    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 10)
    UIPadding.Parent = Tabs

    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -120, 1, -30)
    Content.Position = UDim2.fromOffset(120, 30)
    Content.BackgroundTransparency = 1
    Content.Parent = Main

    local TabManager = {
        _tabs = {},
        _current_tab = nil
    }

    function TabManager:create_tab(name, icon)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, -10, 0, 30)
        TabButton.Position = UDim2.fromOffset(5, 0)
        TabButton.BackgroundColor3 = Color3.fromRGB(32, 38, 51)
        TabButton.Text = "  " .. name
        TabButton.TextColor3 = Color3.fromRGB(210, 210, 210)
        TabButton.TextSize = 12
        TabButton.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.AutoButtonColor = false
        TabButton.Parent = Tabs

        local UICorner_4 = Instance.new("UICorner")
        UICorner_4.CornerRadius = UDim.new(0, 4)
        UICorner_4.Parent = TabButton

        local Icon = Instance.new("ImageLabel")
        Icon.Size = UDim2.fromOffset(16, 16)
        Icon.Position = UDim2.fromOffset(8, 7)
        Icon.BackgroundTransparency = 1
        Icon.Image = icon or "rbxassetid://6034837796"
        Icon.Parent = TabButton

        local TabContent = Instance.new("Frame")
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false
        TabContent.Parent = Content

        local LeftSection = Instance.new("Frame")
        LeftSection.Size = UDim2.new(0.5, -5, 1, 0)
        LeftSection.BackgroundTransparency = 1
        LeftSection.Parent = TabContent

        local RightSection = Instance.new("Frame")
        RightSection.Size = UDim2.new(0.5, -5, 1, 0)
        RightSection.Position = UDim2.new(0.5, 5, 0, 0)
        RightSection.BackgroundTransparency = 1
        RightSection.Parent = TabContent

        local UIListLayout_2 = Instance.new("UIListLayout")
        UIListLayout_2.Padding = UDim.new(0, 10)
        UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_2.Parent = LeftSection

        local UIListLayout_3 = Instance.new("UIListLayout")
        UIListLayout_3.Padding = UDim.new(0, 10)
        UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_3.Parent = RightSection

        local UIPadding_2 = Instance.new("UIPadding")
        UIPadding_2.PaddingTop = UDim.new(0, 10)
        UIPadding_2.Parent = LeftSection

        local UIPadding_3 = Instance.new("UIPadding")
        UIPadding_3.PaddingTop = UDim.new(0, 10)
        UIPadding_3.Parent = RightSection

        local tab = {
            _button = TabButton,
            _content = TabContent,
            _left = LeftSection,
            _right = RightSection
        }

        TabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(TabManager._tabs) do
                t._content.Visible = false
                Utility:Tween(t._button, {BackgroundColor3 = Color3.fromRGB(32, 38, 51), TextColor3 = Color3.fromRGB(210, 210, 210)})
            end
            TabContent.Visible = true
            Utility:Tween(TabButton, {BackgroundColor3 = Color3.fromRGB(0, 162, 255), TextColor3 = Color3.fromRGB(255, 255, 255)})
            TabManager._current_tab = tab
        end)

        TabButton.MouseEnter:Connect(function()
            if TabManager._current_tab ~= tab then
                Utility:Tween(TabButton, {BackgroundColor3 = Color3.fromRGB(42, 50, 66)})
            end
        end)

        TabButton.MouseLeave:Connect(function()
            if TabManager._current_tab ~= tab then
                Utility:Tween(TabButton, {BackgroundColor3 = Color3.fromRGB(32, 38, 51)})
            end
        end)

        table.insert(TabManager._tabs, tab)

        if #TabManager._tabs == 1 then
            TabButton:SimulateClick()
        end

        function tab:create_module(settings)
            local Module = Instance.new("Frame")
            Module.Size = UDim2.fromOffset(241, 93)
            Module.BackgroundColor3 = Color3.fromRGB(32, 38, 51)
            Module.Parent = settings.section == "left" and LeftSection or RightSection

            local UICorner_5 = Instance.new("UICorner")
            UICorner_5.CornerRadius = UDim.new(0, 6)
            UICorner_5.Parent = Module

            local Title_2 = Instance.new("TextLabel")
            Title_2.Size = UDim2.new(1, 0, 0, 30)
            Title_2.BackgroundColor3 = Color3.fromRGB(28, 31, 43)
            Title_2.Text = settings.title or "Module"
            Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title_2.TextSize = 12
            Title_2.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
            Title_2.TextXAlignment = Enum.TextXAlignment.Left
            Title_2.TextXAlignment = Enum.TextXAlignment.Left
            Title_2.Parent = Module

            local UICorner_6 = Instance.new("UICorner")
            UICorner_6.CornerRadius = UDim.new(0, 6)
            UICorner_6.Parent = Title_2

            local UIPadding_4 = Instance.new("UIPadding")
            UIPadding_4.PaddingLeft = UDim.new(0, 10)
            UIPadding_4.Parent = Title_2

            local Options = Instance.new("Frame")
            Options.Size = UDim2.new(1, 0, 1, -30)
            Options.Position = UDim2.fromOffset(0, 30)
            Options.BackgroundTransparency = 1
            Options.Parent = Module

            local UIListLayout_4 = Instance.new("UIListLayout")
            UIListLayout_4.Padding = UDim.new(0, 5)
            UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_4.Parent = Options

            local UIPadding_5 = Instance.new("UIPadding")
            UIPadding_5.PaddingTop = UDim.new(0, 5)
            UIPadding_5.PaddingLeft = UDim.new(0, 10)
            UIPadding_5.Parent = Options

            local LayoutOrderModule = 0
            local ModuleManager = {
                _size = 0,
                _state = settings.state or false
            }

            Library._config = Library._config or {}
            Library._config._flags = Library._config._flags or {}

            if settings.flag then
                Library._config._flags[settings.flag] = settings.state or false
            end

            function ModuleManager:create_paragraph(settings)
                LayoutOrderModule = LayoutOrderModule + 1

                if self._size == 0 then
                    self._size = 11
                end

                local text_size = game:GetService("TextService"):GetTextSize(
                    settings.text or "",
                    11,
                    Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal),
                    Vector2.new(207, math.huge)
                )

                self._size += text_size.Y + 10

                if ModuleManager._state then
                    Module.Size = UDim2.fromOffset(241, 93 + self._size)
                end

                Options.Size = UDim2.fromOffset(241, self._size)

                local ParagraphContainer = Instance.new("Frame")
                ParagraphContainer.Size = UDim2.new(0, 207, 0, text_size.Y)
                ParagraphContainer.BackgroundTransparency = 1
                ParagraphContainer.Parent = Options
                ParagraphContainer.LayoutOrder = LayoutOrderModule

                local Paragraph = Instance.new("TextLabel")
                Paragraph.Size = UDim2.new(1, 0, 1, 0)
                Paragraph.BackgroundTransparency = 1
                Paragraph.Text = settings.text or ""
                Paragraph.TextColor3 = Color3.fromRGB(210, 210, 210)
                Paragraph.TextSize = 11
                Paragraph.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                Paragraph.TextXAlignment = Enum.TextXAlignment.Left
                Paragraph.TextYAlignment = Enum.TextYAlignment.Top
                Paragraph.TextWrapped = true
                Paragraph.Parent = ParagraphContainer
            end

            function ModuleManager:create_checkbox(settings)
                LayoutOrderModule = LayoutOrderModule + 1

                local CheckboxManager = {}

                if self._size == 0 then
                    self._size = 11
                end

                self._size += 20

                if ModuleManager._state then
                    Module.Size = UDim2.fromOffset(241, 93 + self._size)
                end

                Options.Size = UDim2.fromOffset(241, self._size)

                local CheckboxContainer = Instance.new("Frame")
                CheckboxContainer.Size = UDim2.new(0, 207, 0, 16)
                CheckboxContainer.BackgroundTransparency = 1
                CheckboxContainer.Parent = Options
                CheckboxContainer.LayoutOrder = LayoutOrderModule

                local UIListLayout_5 = Instance.new("UIListLayout")
                UIListLayout_5.FillDirection = Enum.FillDirection.Horizontal
                UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout_5.Parent = CheckboxContainer

                local Checkbox = Instance.new("TextButton")
                Checkbox.Size = UDim2.fromOffset(16, 16)
                Checkbox.BackgroundColor3 = Color3.fromRGB(32, 38, 51)
                Checkbox.Text = ""
                Checkbox.AutoButtonColor = false
                Checkbox.Parent = CheckboxContainer

                local UICorner_7 = Instance.new("UICorner")
                UICorner_7.CornerRadius = UDim.new(0, 4)
                UICorner_7.Parent = Checkbox

                local UIStroke = Instance.new("UIStroke")
                UIStroke.Color = Color3.fromRGB(0, 162, 255)
                UIStroke.Thickness = 1
                UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                UIStroke.Parent = Checkbox

                local Checkmark = Instance.new("ImageLabel")
                Checkmark.Size = UDim2.fromOffset(12, 12)
                Checkmark.Position = UDim2.fromOffset(2, 2)
                Checkmark.BackgroundTransparency = 1
                Checkmark.Image = "rbxassetid://6031068421"
                Checkmark.ImageTransparency = settings.state and 0 or 1
                Checkmark.Parent = Checkbox

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(0, 175, 0, 16)
                Label.BackgroundTransparency = 1
                Label.Text = settings.title or GG.Language.CheckboxToggle
                Label.TextColor3 = Color3.fromRGB(210, 210, 210)
                Label.TextSize = 11
                Label.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.TextTransparency = 0.2
                Label.Parent = CheckboxContainer

                if settings.flag then
                    Library._config._flags[settings.flag] = settings.state or false
                end

                Checkbox.MouseButton1Click:Connect(function()
                    local state = not Library._config._flags[settings.flag]
                    Library._config._flags[settings.flag] = state
                    Utility:Tween(Checkmark, {ImageTransparency = state and 0 or 1})
                    if settings.callback then
                        settings.callback(state)
                    end
                end)

                Checkbox.MouseEnter:Connect(function()
                    Utility:Tween(Checkbox, {BackgroundColor3 = Color3.fromRGB(42, 50, 66)})
                end)

                Checkbox.MouseLeave:Connect(function()
                    Utility:Tween(Checkbox, {BackgroundColor3 = Color3.fromRGB(32, 38, 51)})
                end)

                return CheckboxManager
            end

            function ModuleManager:create_dropdown(settings)
                LayoutOrderModule = LayoutOrderModule + 1

                local DropdownManager = {
                    _value = settings.value or settings.options[1] or "",
                    _open = false
                }

                if self._size == 0 then
                    self._size = 11
                end

                self._size += 20

                if ModuleManager._state then
                    Module.Size = UDim2.fromOffset(241, 93 + self._size)
                end

                Options.Size = UDim2.fromOffset(241, self._size)

                local DropdownContainer = Instance.new("Frame")
                DropdownContainer.Size = UDim2.new(0, 207, 0, 16)
                DropdownContainer.BackgroundTransparency = 1
                DropdownContainer.Parent = Options
                DropdownContainer.LayoutOrder = LayoutOrderModule

                local Dropdown = Instance.new("TextButton")
                Dropdown.Size = UDim2.fromOffset(207, 16)
                Dropdown.BackgroundColor3 = Color3.fromRGB(32, 38, 51)
                Dropdown.Text = "    " .. (settings.value or settings.options[1] or GG.Language.DropdownSelect)
                Dropdown.TextColor3 = Color3.fromRGB(210, 210, 210)
                Dropdown.TextSize = 11
                Dropdown.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
                Dropdown.TextXAlignment = Enum.TextXAlignment.Left
                Dropdown.TextTransparency = 0.2
                Dropdown.AutoButtonColor = false
                Dropdown.Parent = DropdownContainer

                local UICorner_8 = Instance.new("UICorner")
                UICorner_8.CornerRadius = UDim.new(0, 4)
                UICorner_8.Parent = Dropdown

                local UIStroke_2 = Instance.new("UIStroke")
                UIStroke_2.Color = Color3.fromRGB(0, 162, 255)
                UIStroke_2.Thickness = 1
                UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                UIStroke_2.Parent = Dropdown

                local Arrow = Instance.new("ImageLabel")
                Arrow.Size = UDim2.fromOffset(12, 12)
                Arrow.Position = UDim2.new(1, -16, 0, 2)
                Arrow.BackgroundTransparency = 1
                Arrow.Image = "rbxassetid://6034818372"
                Arrow.Parent = Dropdown

                local OptionList = Instance.new("Frame")
                OptionList.Size = UDim2.new(0, 207, 0, 0)
                OptionList.Position = UDim2.fromOffset(0, 20)
                OptionList.BackgroundColor3 = Color3.fromRGB(32, 38, 51)
                OptionList.Visible = false
                OptionList.Parent = DropdownContainer

                local UICorner_9 = Instance.new("UICorner")
                UICorner_9.CornerRadius = UDim.new(0, 4)
                UICorner_9.Parent = OptionList

                local UIStroke_3 = Instance.new("UIStroke")
                UIStroke_3.Color = Color3.fromRGB(0, 162, 255)
                UIStroke_3.Thickness = 1
                UIStroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                UIStroke_3.Parent = OptionList

                local UIListLayout_6 = Instance.new("UIListLayout")
                UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout_6.Parent = OptionList

                local UIPadding_6 = Instance.new("UIPadding")
                UIPadding_6.PaddingTop = UDim.new(0, 5)
                UIPadding_6.Parent = OptionList

                local function update_option_list()
                    OptionList.Size = UDim2.new(0, 207, 0, 0)
                    for _, child in pairs(OptionList:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end

                    local size = 0
                    for i, option in ipairs(settings.options) do
                        local Option = Instance.new("TextButton")
                        Option.Size = UDim2.fromOffset(207, 16)
                        Option.BackgroundColor3 = Color3.fromRGB(32, 38, 51)
                        Option.Text = "    " .. option
                        Option.TextColor3 = Color3.fromRGB(210, 210, 210)
                        Option.TextSize = 11
                        Option.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
                        Option.TextXAlignment = Enum.TextXAlignment.Left
                        Option.TextTransparency = 0.2
                        Option.AutoButtonColor = false
                        Option.Parent = OptionList
                        size += 16

                        Option.MouseButton1Click:Connect(function()
                            DropdownManager._value = option
                            Dropdown.Text = "    " .. option
                            OptionList.Visible = false
                            DropdownManager._open = false
                            Utility:Tween(Arrow, {Rotation = 0})
                            if settings.callback then
                                settings.callback(option)
                            end
                        end)

                        Option.MouseEnter:Connect(function()
                            Utility:Tween(Option, {BackgroundColor3 = Color3.fromRGB(42, 50, 66)})
                        end)

                        Option.MouseLeave:Connect(function()
                            Utility:Tween(Option, {BackgroundColor3 = Color3.fromRGB(32, 38, 51)})
                        end)
                    end
                    OptionList.Size = UDim2.fromOffset(207, size)
                end

                update_option_list()

                Dropdown.MouseButton1Click:Connect(function()
                    DropdownManager._open = not DropdownManager._open
                    OptionList.Visible = DropdownManager._open
                    Utility:Tween(Arrow, {Rotation = DropdownManager._open and 180 or 0})
                end)

                Dropdown.MouseEnter:Connect(function()
                    Utility:Tween(Dropdown, {BackgroundColor3 = Color3.fromRGB(42, 50, 66)})
                end)

                Dropdown.MouseLeave:Connect(function()
                    Utility:Tween(Dropdown, {BackgroundColor3 = Color3.fromRGB(32, 38, 51)})
                end)

                if settings.flag then
                    Library._config._flags[settings.flag] = DropdownManager._value
                end

                return DropdownManager
            end

            function ModuleManager:create_button(settings)
                LayoutOrderModule = LayoutOrderModule + 1

                local ButtonManager = {}

                if self._size == 0 then
                    self._size = 11
                end

                self._size += 20

                if ModuleManager._state then
                    Module.Size = UDim2.fromOffset(241, 93 + self._size)
                end

                Options.Size = UDim2.fromOffset(241, self._size)

                -- Button Container
                local ButtonContainer = Instance.new("Frame")
                ButtonContainer.Size = UDim2.new(0, 207, 0, 16)
                ButtonContainer.BackgroundTransparency = 1
                ButtonContainer.Parent = Options
                ButtonContainer.LayoutOrder = LayoutOrderModule

                local UIListLayout = Instance.new("UIListLayout")
                UIListLayout.FillDirection = Enum.FillDirection.Horizontal
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Parent = ButtonContainer

                -- Button
                local Button = Instance.new("TextButton")
                Button.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
                Button.TextSize = 11
                Button.Size = UDim2.new(0, 207, 0, 16)
                Button.BackgroundColor3 = Color3.fromRGB(32, 38, 51)
                Button.TextColor3 = Color3.fromRGB(210, 210, 210)
                Button.Text = "    " .. (settings.title or GG.Language.ButtonClick)
                Button.AutoButtonColor = false
                Button.TextXAlignment = Enum.TextXAlignment.Left
                Button.TextTransparency = 0.2
                Button.BorderSizePixel = 0
                Button.Parent = ButtonContainer

                local UICorner = Instance.new("UICorner")
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = Button

                local UIStroke = Instance.new("UIStroke")
                UIStroke.Color = Color3.fromRGB(0, 162, 255)
                UIStroke.Thickness = 1
                UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                UIStroke.Parent = Button

                -- Hover Effect
                Button.MouseEnter:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(42, 50, 66)
                    }):Play()
                end)

                Button.MouseLeave:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(32, 38, 51)
                    }):Play()
                end)

                -- Click Effect
                Button.MouseButton1Down:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(22, 28, 38)
                    }):Play()
                end)

                Button.MouseButton1Up:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(32, 38, 51)
                    }):Play()
                end)

                -- Click Handler
                Button.MouseButton1Click:Connect(function()
                    if settings.callback then
                        settings.callback()
                    end
                    Library:SendNotification({
                        title = settings.title or GG.Language.ButtonClick,
                        text = "Button clicked!",
                        duration = 2
                    })
                end)

                return ButtonManager
            end

            return ModuleManager
        end

        return tab
    end

    Close.MouseButton1Click:Connect(function()
        GUI:Destroy()
    end)

    local function updateInput(input)
        local delta = input.Position - dragStart
        local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        Utility:Tween(Main, {Position = position})
    end

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)

    function Library:SendNotification(settings)
        local Notification = Instance.new("Frame")
        Notification.Size = UDim2.fromOffset(250, 60)
        Notification.Position = UDim2.fromScale(1, 1)
        Notification.AnchorPoint = Vector2.new(1, 1)
        Notification.BackgroundColor3 = Color3.fromRGB(24, 26, 36)
        Notification.BorderSizePixel = 0
        Notification.Parent = GUI

        local UICorner_10 = Instance.new("UICorner")
        UICorner_10.CornerRadius = UDim.new(0, 6)
        UICorner_10.Parent = Notification

        local Title_3 = Instance.new("TextLabel")
        Title_3.Size = UDim2.new(1, 0, 0, 20)
        Title_3.BackgroundTransparency = 1
        Title_3.Text = settings.title or GG.Language.NotificationTitle
        Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title_3.TextSize = 12
        Title_3.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
        Title_3.TextXAlignment = Enum.TextXAlignment.Left
        Title_3.Parent = Notification

        local UIPadding_7 = Instance.new("UIPadding")
        UIPadding_7.PaddingLeft = UDim.new(0, 10)
        UIPadding_7.Parent = Title_3

        local Description = Instance.new("TextLabel")
        Description.Size = UDim2.new(1, 0, 0, 40)
        Description.Position = UDim2.fromOffset(0, 20)
        Description.BackgroundTransparency = 1
        Description.Text = settings.text or GG.Language.NotificationText
        Description.TextColor3 = Color3.fromRGB(210, 210, 210)
        Description.TextSize = 11
        Description.FontFace = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        Description.TextXAlignment = Enum.TextXAlignment.Left
        Description.TextYAlignment = Enum.TextYAlignment.Top
        Description.TextWrapped = true
        Description.Parent = Notification

        local UIPadding_8 = Instance.new("UIPadding")
        UIPadding_8.PaddingLeft = UDim.new(0, 10)
        UIPadding_8.PaddingTop = UDim.new(0, 5)
        UIPadding_8.Parent = Description

        Utility:Tween(Notification, {Position = UDim2.new(1, -10, 1, -10)})

        task.spawn(function()
            task.wait(settings.duration or 3)
            Utility:Tween(Notification, {Position = UDim2.fromScale(1, 1)}, 0.5)
            task.wait(0.5)
            Notification:Destroy()
        end)
    end

    function Library:load()
        Utility:Tween(Main, {BackgroundTransparency = 0})
        Utility:Tween(TopBar, {BackgroundTransparency = 0})
        Utility:Tween(Tabs, {BackgroundTransparency = 0})
        for _, tab in pairs(TabManager._tabs) do
            Utility:Tween(tab._button, {BackgroundTransparency = 0, TextTransparency = 0})
        end
    end

    return TabManager
end

return Library
