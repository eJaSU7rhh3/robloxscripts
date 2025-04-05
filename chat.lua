local msgRemote = Instance.new("RemoteEvent")

msgRemote.Name = "UpdatePosition"
msgRemote.Parent = game:GetService("ReplicatedStorage")

msgRemote.OnServerEvent:Connect(function(plr, msg)
	msgRemote:FireAllClients(plr.Name, msg)
end)

local code = [[
local function repeat_key(key, length)
	if #key >= length then
		return key:sub(1, length)
	end

	local times = math.floor(length / #key)
	local remain = length % #key

	local result = ''

	for _ = 1, times do
		result = result .. key
	end

	if remain > 0 then
		result = result .. key:sub(1, remain)
	end

	return result
end

local function xor(message, key)
	local rkey = repeat_key(key, #message)
	local result = ''

	for i = 1, #message do
		local m_byte = string.byte(message, i)
		local k_byte = string.byte(rkey, i)

		local xor_byte = bit32.bxor(m_byte, k_byte)
		result = result.. string.char(xor_byte)
	end

	return result
end

local function convertcframe(cframelist)
	local s = ""
	for i,v in pairs(cframelist) do
		local c = (v.X/9 + v.Y/18)/2
		s = s.. string.char(c)
	end
	
	return s
end

local function convertstring(str)
	local charlist = string.split(str, "")
	local cframelist = {}
	
	for i,v in pairs(charlist) do
		local mr = math.random(1111, 9999)
		table.insert(cframelist, CFrame.new((string.byte(v)-mr)*9, (string.byte(v)+mr)*18, 0))
	end
	
	return cframelist
end

game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
local ExperienceChat = Instance.new("ScreenGui")
ExperienceChat.Name = "ExperienceChat"
ExperienceChat.ResetOnSpawn = false
ExperienceChat.DisplayOrder = -1

local appLayout = Instance.new("Frame")
appLayout.Name = "appLayout"
appLayout.Size = UDim2.new(0.4, 0, 0.25, 0)
appLayout.BorderColor3 = Color3.fromRGB(27, 42, 53)
appLayout.BackgroundTransparency = 1
appLayout.Position = UDim2.new(0, 8, 0, 4)
appLayout.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
appLayout.Parent = ExperienceChat

local chatInputBar = Instance.new("Frame")
chatInputBar.Name = "chatInputBar"
chatInputBar.LayoutOrder = 3
chatInputBar.AutomaticSize = Enum.AutomaticSize.Y
chatInputBar.Size = UDim2.new(1, 0, 0, 0)
chatInputBar.BorderColor3 = Color3.fromRGB(27, 42, 53)
chatInputBar.BackgroundTransparency = 0.3
chatInputBar.BorderSizePixel = 0
chatInputBar.BackgroundColor3 = Color3.fromRGB(25, 27, 29)
chatInputBar.Parent = appLayout

local Background = Instance.new("Frame")
Background.Name = "Background"
Background.AutomaticSize = Enum.AutomaticSize.XY
Background.Size = UDim2.new(1, 0, 0, 0)
Background.BorderColor3 = Color3.fromRGB(27, 42, 53)
Background.BackgroundTransparency = 0.2
Background.BackgroundColor3 = Color3.fromRGB(25, 27, 29)
Background.Parent = chatInputBar

local Corner = Instance.new("UICorner")
Corner.Name = "Corner"
Corner.CornerRadius = UDim.new(0, 3)
Corner.Parent = Background

local Border = Instance.new("UIStroke")
Border.Name = "Border"
Border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Border.Transparency = 0.8
Border.Color = Color3.fromRGB(255, 255, 255)
Border.Parent = Background

local Container = Instance.new("Frame")
Container.Name = "Container"
Container.AutomaticSize = Enum.AutomaticSize.Y
Container.Size = UDim2.new(1, 0, 0, 0)
Container.BorderColor3 = Color3.fromRGB(27, 42, 53)
Container.BackgroundTransparency = 1
Container.Parent = Background

local TextContainer = Instance.new("Frame")
TextContainer.Name = "TextContainer"
TextContainer.AutomaticSize = Enum.AutomaticSize.Y
TextContainer.Size = UDim2.new(1, -30, 0, 0)
TextContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
TextContainer.BackgroundTransparency = 1
TextContainer.Parent = Container

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 10)
UIPadding.PaddingBottom = UDim.new(0, 10)
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingRight = UDim.new(0, 10)
UIPadding.Parent = TextContainer

local TextBoxContainer = Instance.new("Frame")
TextBoxContainer.Name = "TextBoxContainer"
TextBoxContainer.AnchorPoint = Vector2.new(1, 0)
TextBoxContainer.AutomaticSize = Enum.AutomaticSize.Y
TextBoxContainer.Size = UDim2.new(1, -8, 0, 0)
TextBoxContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
TextBoxContainer.BackgroundTransparency = 1
TextBoxContainer.Position = UDim2.new(1, 0, 0, 0)
TextBoxContainer.Parent = TextContainer

local TextBox = Instance.new("TextBox")
TextBox.AutomaticSize = Enum.AutomaticSize.XY
TextBox.Size = UDim2.new(1, 0, 0, 0)
TextBox.BorderColor3 = Color3.fromRGB(27, 42, 53)
TextBox.BackgroundTransparency = 1
TextBox.MultiLine = true
TextBox.FontSize = Enum.FontSize.Size14
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.TextStrokeTransparency = 0.5
TextBox.TextWrapped = true
TextBox.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
TextBox.TextWrap = true
TextBox.TextSize = 14
TextBox.TextTransparency = 0.5
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "To chat click here or press / key"
TextBox.Text = ""
TextBox.Font = Enum.Font.GothamMedium
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.ClearTextOnFocus = false
TextBox.Parent = TextBoxContainer

local TargetChannelChip = Instance.new("TextButton")
TargetChannelChip.Name = "TargetChannelChip"
TargetChannelChip.Visible = false
TargetChannelChip.AutomaticSize = Enum.AutomaticSize.XY
TargetChannelChip.Size = UDim2.new(0, 0, 1, 0)
TargetChannelChip.BorderColor3 = Color3.fromRGB(27, 42, 53)
TargetChannelChip.BackgroundTransparency = 1
TargetChannelChip.FontSize = Enum.FontSize.Size14
TargetChannelChip.TextSize = 14
TargetChannelChip.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetChannelChip.Text = ""
TargetChannelChip.TextWrapped = true
TargetChannelChip.TextWrap = true
TargetChannelChip.Font = Enum.Font.GothamMedium
TargetChannelChip.Parent = TextContainer

local SendButton = Instance.new("TextButton")
SendButton.Name = "SendButton"
SendButton.LayoutOrder = 2
SendButton.AnchorPoint = Vector2.new(1, 0)
SendButton.Size = UDim2.new(0, 30, 1, 0)
SendButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
SendButton.BackgroundTransparency = 1
SendButton.Position = UDim2.new(1, 0, 0, 0)
SendButton.Text = ""
SendButton.Parent = Container

local SendIcon = Instance.new("ImageLabel")
SendIcon.Name = "SendIcon"
SendIcon.Size = UDim2.new(0, 30, 0, 30)
SendIcon.BorderColor3 = Color3.fromRGB(27, 42, 53)
SendIcon.BackgroundTransparency = 1
SendIcon.ImageTransparency = 0.5
SendIcon.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_1x_5.png"
SendIcon.ImageRectOffset = Vector2.new(233, 454)
SendIcon.ImageRectSize = Vector2.new(36, 36)
SendIcon.ImageColor3 = Color3.fromRGB(178, 178, 178)
SendIcon.Parent = SendButton

local Layout = Instance.new("UIListLayout")
Layout.Name = "Layout"
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.VerticalAlignment = Enum.VerticalAlignment.Center
Layout.Parent = SendButton

local AutocompleteDropdown = Instance.new("Frame")
AutocompleteDropdown.Name = "AutocompleteDropdown"
AutocompleteDropdown.ZIndex = 2
AutocompleteDropdown.Visible = false
AutocompleteDropdown.AnchorPoint = Vector2.new(0, 1)
AutocompleteDropdown.Size = UDim2.new(0.95, 0, 0, 0)
AutocompleteDropdown.BorderColor3 = Color3.fromRGB(27, 42, 53)
AutocompleteDropdown.BackgroundTransparency = 1
AutocompleteDropdown.Parent = chatInputBar

local UISizeConstraint = Instance.new("UISizeConstraint")
UISizeConstraint.MaxSize = Vector2.new(475, 167.5)
UISizeConstraint.Parent = AutocompleteDropdown

local ScrollBarFrame = Instance.new("Frame")
ScrollBarFrame.Name = "ScrollBarFrame"
ScrollBarFrame.ZIndex = 2
ScrollBarFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollBarFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
ScrollBarFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 29)
ScrollBarFrame.Parent = AutocompleteDropdown

local Corner1 = Instance.new("UICorner")
Corner1.Name = "Corner"
Corner1.CornerRadius = UDim.new(0, 3)
Corner1.Parent = ScrollBarFrame

local Border1 = Instance.new("UIStroke")
Border1.Name = "Border"
Border1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Border1.Transparency = 0.8
Border1.Color = Color3.fromRGB(255, 255, 255)
Border1.Parent = ScrollBarFrame

local ScrollViewFrame = Instance.new("Frame")
ScrollViewFrame.Name = "ScrollViewFrame"
ScrollViewFrame.ZIndex = 2
ScrollViewFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollViewFrame.ClipsDescendants = true
ScrollViewFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
ScrollViewFrame.BackgroundTransparency = 1
ScrollViewFrame.Parent = ScrollBarFrame

local ScrollView = Instance.new("ScrollingFrame")
ScrollView.Name = "ScrollView"
ScrollView.ZIndex = 2
ScrollView.Size = UDim2.new(1, -4, 1, 0)
ScrollView.ClipsDescendants = false
ScrollView.BorderColor3 = Color3.fromRGB(27, 42, 53)
ScrollView.BackgroundTransparency = 1
ScrollView.BorderSizePixel = 0
ScrollView.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollView.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollView.ScrollBarThickness = 4
ScrollView.VerticalScrollBarInset = Enum.ScrollBarInset.Always
ScrollView.Parent = ScrollViewFrame

local OffsetFrame = Instance.new("Frame")
OffsetFrame.Name = "OffsetFrame"
OffsetFrame.Size = UDim2.new(1, 8, 1, 0)
OffsetFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
OffsetFrame.BackgroundTransparency = 1
OffsetFrame.Parent = ScrollView

local layout = Instance.new("UIListLayout")
layout.Name = "$layout"
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = OffsetFrame

local UISizeConstraint1 = Instance.new("UISizeConstraint")
UISizeConstraint1.MaxSize = Vector2.new(475, math.huge)
UISizeConstraint1.Parent = chatInputBar

local UIPadding1 = Instance.new("UIPadding")
UIPadding1.PaddingTop = UDim.new(0, 8)
UIPadding1.PaddingBottom = UDim.new(0, 1)
UIPadding1.PaddingLeft = UDim.new(0, 8)
UIPadding1.PaddingRight = UDim.new(0, 8)
UIPadding1.Parent = chatInputBar

local topBorder = Instance.new("ImageLabel")
topBorder.Name = "topBorder"
topBorder.LayoutOrder = 1
topBorder.Size = UDim2.new(1, 0, 0, 8)
topBorder.BorderColor3 = Color3.fromRGB(27, 42, 53)
topBorder.BackgroundTransparency = 1
topBorder.ScaleType = Enum.ScaleType.Slice
topBorder.ImageTransparency = 0.3
topBorder.Image = "rbxasset://textures/ui/TopRoundedRect8px.png"
topBorder.ImageColor3 = Color3.fromRGB(25, 27, 29)
topBorder.SliceCenter = Rect.new(8, 8, 24, 32)
topBorder.Parent = appLayout

local uiSizeConstraint = Instance.new("UISizeConstraint")
uiSizeConstraint.Name = "uiSizeConstraint"
uiSizeConstraint.MaxSize = Vector2.new(475, math.huge)
uiSizeConstraint.Parent = topBorder

local chatWindow = Instance.new("Frame")
chatWindow.Name = "chatWindow"
chatWindow.LayoutOrder = 2
chatWindow.Size = UDim2.new(1, 0, 1, 0)
chatWindow.BorderColor3 = Color3.fromRGB(27, 42, 53)
chatWindow.BackgroundTransparency = 0.3
chatWindow.BorderSizePixel = 0
chatWindow.BackgroundColor3 = Color3.fromRGB(25, 27, 29)
chatWindow.Parent = appLayout

local uiSizeConstraint1 = Instance.new("UISizeConstraint")
uiSizeConstraint1.Name = "uiSizeConstraint"
uiSizeConstraint1.MaxSize = Vector2.new(475, 275)
uiSizeConstraint1.Parent = chatWindow

local scrollingView = Instance.new("ImageButton")
scrollingView.Name = "scrollingView"
scrollingView.Size = UDim2.new(1, 0, 1, 0)
scrollingView.BorderColor3 = Color3.fromRGB(27, 42, 53)
scrollingView.BackgroundTransparency = 1
scrollingView.Parent = chatWindow

local bottomLockedScrollView = Instance.new("Frame")
bottomLockedScrollView.Name = "bottomLockedScrollView"
bottomLockedScrollView.Size = UDim2.new(1, 0, 1, 0)
bottomLockedScrollView.BorderColor3 = Color3.fromRGB(27, 42, 53)
bottomLockedScrollView.BackgroundTransparency = 1
bottomLockedScrollView.Parent = scrollingView

local RCTScrollView = Instance.new("ScrollingFrame")
RCTScrollView.Name = "RCTScrollView"
RCTScrollView.Size = UDim2.new(1, 0, 1, 0)
RCTScrollView.BorderColor3 = Color3.fromRGB(27, 42, 53)
RCTScrollView.BackgroundTransparency = 1
RCTScrollView.BorderSizePixel = 0
RCTScrollView.AutomaticCanvasSize = Enum.AutomaticSize.XY
RCTScrollView.ScrollingDirection = Enum.ScrollingDirection.Y
RCTScrollView.CanvasSize = UDim2.new(0, 0, 0, 0)
RCTScrollView.ScrollBarThickness = 8
RCTScrollView.Parent = bottomLockedScrollView

local RCTScrollContentView = Instance.new("Frame")
RCTScrollContentView.Name = "RCTScrollContentView"
RCTScrollContentView.AutomaticSize = Enum.AutomaticSize.Y
RCTScrollContentView.Size = UDim2.new(1, 0, 1, 0)
RCTScrollContentView.BorderColor3 = Color3.fromRGB(27, 42, 53)
RCTScrollContentView.BackgroundTransparency = 1
RCTScrollContentView.Parent = RCTScrollView

local VerticalLayout = Instance.new("UIListLayout")
VerticalLayout.Name = "VerticalLayout"
VerticalLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
VerticalLayout.SortOrder = Enum.SortOrder.LayoutOrder
VerticalLayout.Padding = UDim.new(0, -8)
VerticalLayout.Parent = RCTScrollContentView

local layout1 = Instance.new("UIListLayout")
layout1.Name = "$layout"
layout1.SortOrder = Enum.SortOrder.LayoutOrder
layout1.Padding = UDim.new(0, -8)
layout1.Parent = RCTScrollContentView

local padding = Instance.new("UIPadding")
padding.Name = "padding"
padding.PaddingLeft = UDim.new(0, 8)
padding.PaddingRight = UDim.new(0, 8)
padding.Parent = bottomLockedScrollView

local layout2 = Instance.new("UIListLayout")
layout2.Name = "layout"
layout2.SortOrder = Enum.SortOrder.LayoutOrder
layout2.Parent = appLayout

local uiSizeConstraint2 = Instance.new("UISizeConstraint")
uiSizeConstraint2.Name = "uiSizeConstraint"
uiSizeConstraint2.MaxSize = Vector2.new(475, math.huge)
uiSizeConstraint2.Parent = appLayout

local bottomBorder = Instance.new("ImageLabel")
bottomBorder.Name = "bottomBorder"
bottomBorder.LayoutOrder = 4
bottomBorder.Size = UDim2.new(1, 0, 0, 8)
bottomBorder.BorderColor3 = Color3.fromRGB(27, 42, 53)
bottomBorder.BackgroundTransparency = 1
bottomBorder.ScaleType = Enum.ScaleType.Slice
bottomBorder.ImageTransparency = 0.3
bottomBorder.Image = "rbxasset://textures/ui/BottomRoundedRect8px.png"
bottomBorder.ImageColor3 = Color3.fromRGB(25, 27, 29)
bottomBorder.SliceCenter = Rect.new(8, 0, 24, 16)
bottomBorder.Parent = appLayout

local uiSizeConstraint3 = Instance.new("UISizeConstraint")
uiSizeConstraint3.Name = "uiSizeConstraint"
uiSizeConstraint3.MaxSize = Vector2.new(475, math.huge)
uiSizeConstraint3.Parent = bottomBorder

local LocalScript = Instance.new("LocalScript")
LocalScript.Parent = ExperienceChat

local r = Instance.new("Frame")
r.Name = "r"
r.AutomaticSize = Enum.AutomaticSize.XY
r.Size = UDim2.new(1, 0, 0, 0)
r.BorderColor3 = Color3.fromRGB(27, 42, 53)
r.BackgroundTransparency = 1
r.Parent = LocalScript

local TextLabel = Instance.new("Frame")
TextLabel.Name = "TextLabel"
TextLabel.LayoutOrder = 2
TextLabel.AutomaticSize = Enum.AutomaticSize.XY
TextLabel.BorderColor3 = Color3.fromRGB(27, 42, 53)
TextLabel.BackgroundTransparency = 1
TextLabel.Parent = r

local TextMessage = Instance.new("TextLabel")
TextMessage.Name = "TextMessage"
TextMessage.AutomaticSize = Enum.AutomaticSize.XY
TextMessage.Size = UDim2.new(1, 0, 0, 0)
TextMessage.BorderColor3 = Color3.fromRGB(27, 42, 53)
TextMessage.BackgroundTransparency = 1
TextMessage.FontSize = Enum.FontSize.Size14
TextMessage.TextStrokeTransparency = 0.5
TextMessage.TextSize = 14
TextMessage.RichText = true
TextMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
TextMessage.TextYAlignment = Enum.TextYAlignment.Top
TextMessage.Text = ""
TextMessage.TextWrapped = true
TextMessage.TextWrap = true
TextMessage.Font = Enum.Font.GothamMedium
TextMessage.TextXAlignment = Enum.TextXAlignment.Left
TextMessage.Parent = TextLabel

ExperienceChat.Parent = game:GetService("Players").LocalPlayer.PlayerGui

script = LocalScript

--!nonstrict
--!nolint DeprecatedApi
--[
--	// FileName: BubbleChat.lua
--	// Written by: jeditkacheff, TheGamer101
--	// Description: Code for rendering bubble chat
--]

--[ SERVICES ]
local PlayersService = game:GetService('Players')
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChatService = game:GetService("Chat")
local TextService = game:GetService("TextService")
--[ END OF SERVICES ]

local LocalPlayer = PlayersService.LocalPlayer
while LocalPlayer == nil do
	PlayersService.ChildAdded:wait()
	LocalPlayer = PlayersService.LocalPlayer
end

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local success, UserShouldLocalizeGameChatBubble = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserShouldLocalizeGameChatBubble")
end)
local UserShouldLocalizeGameChatBubble = success and UserShouldLocalizeGameChatBubble

local UserFixBubbleChatText do
	local success, value = pcall(function()
		return UserSettings():IsUserFeatureEnabled("UserFixBubbleChatText")
	end)
	UserFixBubbleChatText = success and value
end

local UserRoactBubbleChatBeta do
	local success, value = pcall(function()
		return UserSettings():IsUserFeatureEnabled("UserRoactBubbleChatBeta")
	end)
	UserRoactBubbleChatBeta = success and value
end

local UserPreventOldBubbleChatOverlap do
	local success, value = pcall(function()
		return UserSettings():IsUserFeatureEnabled("UserPreventOldBubbleChatOverlap")
	end)
	UserPreventOldBubbleChatOverlap = success and value
end

local function getMessageLength(message)
	return utf8.len(utf8.nfcnormalize(message))
end

--[ SCRIPT VARIABLES ]
local CHAT_BUBBLE_FONT = Enum.Font.SourceSans
local CHAT_BUBBLE_FONT_SIZE = Enum.FontSize.Size24 -- if you change CHAT_BUBBLE_FONT_SIZE_INT please change this to match
local CHAT_BUBBLE_FONT_SIZE_INT = 24 -- if you change CHAT_BUBBLE_FONT_SIZE please change this to match
local CHAT_BUBBLE_LINE_HEIGHT = CHAT_BUBBLE_FONT_SIZE_INT + 10
local CHAT_BUBBLE_TAIL_HEIGHT = 14
local CHAT_BUBBLE_WIDTH_PADDING = 30
local CHAT_BUBBLE_PADDING = 12
local CHAT_BUBBLE_FADE_SPEED = 1.5

local BILLBOARD_MAX_WIDTH = 400
local BILLBOARD_MAX_HEIGHT = 250	--This limits the number of bubble chats that you see above characters

local ELIPSES = "..."
local MaxChatMessageLength = 128 -- max chat message length, including null terminator and elipses.
local MaxChatMessageLengthExclusive = MaxChatMessageLength - getMessageLength(ELIPSES) - 1

local NEAR_BUBBLE_DISTANCE = 65	--previously 45
local MAX_BUBBLE_DISTANCE = 100	--previously 80

--[ END OF SCRIPT VARIABLES ]


-- [ SCRIPT ENUMS ]
local BubbleColor = {	WHITE = "dub",
	BLUE = "blu",
	GREEN = "gre",
	RED = "red" }

--[ END OF SCRIPT ENUMS ]

-- This screenGui exists so that the billboardGui is not deleted when the PlayerGui is reset.
local BubbleChatScreenGui = Instance.new("ScreenGui")
BubbleChatScreenGui.Name = "BubbleChat"
BubbleChatScreenGui.ResetOnSpawn = false
BubbleChatScreenGui.Parent = PlayerGui

--[ FUNCTIONS ]

local function lerpLength(msg, min, max)
	return min + (max - min) * math.min(getMessageLength(msg) / 75.0, 1.0)
end

local function createFifo()
	local this = {}
	this.data = {}

	local emptyEvent = Instance.new("BindableEvent")
	this.Emptied = emptyEvent.Event

	function this:Size()
		return #this.data
	end

	function this:Empty()
		return this:Size() <= 0
	end

	function this:PopFront()
		table.remove(this.data, 1)
		if this:Empty() then emptyEvent:Fire() end
	end

	function this:Front()
		return this.data[1]
	end

	function this:Get(index)
		return this.data[index]
	end

	function this:PushBack(value)
		table.insert(this.data, value)
	end

	function this:GetData()
		return this.data
	end

	return this
end

local function createCharacterChats()
	local this = {}

	this.Fifo = createFifo()
	this.BillboardGui = nil

	return this
end

local function createMap()
	local this = {}
	this.data = {}
	local count = 0

	function this:Size()
		return count
	end

	function this:Erase(key)
		if this.data[key] then count = count - 1 end
		this.data[key] = nil
	end

	function this:Set(key, value)
		this.data[key] = value
		if value then count = count + 1 end
	end

	function this:Get(key)
		if not key then return end
		if not this.data[key] then
			this.data[key] = createCharacterChats()
			local emptiedCon = nil
			emptiedCon = this.data[key].Fifo.Emptied:connect(function()
				emptiedCon:disconnect()
				this:Erase(key)
			end)
		end
		return this.data[key]
	end

	function this:GetData()
		return this.data
	end

	return this
end

local function createChatLine(message, bubbleColor, isLocalPlayer)
	local this = {}

	function this:ComputeBubbleLifetime(msg, isSelf)
		if isSelf then
			return lerpLength(msg, 8, 15)
		else
			return lerpLength(msg, 12, 20)
		end
	end

	this.Origin = nil
	this.RenderBubble = nil
	this.Message = message
	this.BubbleDieDelay = this:ComputeBubbleLifetime(message, isLocalPlayer)
	this.BubbleColor = bubbleColor
	this.IsLocalPlayer = isLocalPlayer

	return this
end

local function createPlayerChatLine(player, message, isLocalPlayer)
	local this = createChatLine(message, BubbleColor.WHITE, isLocalPlayer)

	if player then
		this.User = player.Name
		this.Origin = player.Character
	end

	return this
end

local function createGameChatLine(origin, message, isLocalPlayer, bubbleColor)
	local this = createChatLine(message, bubbleColor, isLocalPlayer)
	this.Origin = origin

	return this
end

function createChatBubbleMain(filePrefix, sliceRect)
	local chatBubbleMain = Instance.new("ImageLabel")
	chatBubbleMain.Name = "ChatBubble"
	chatBubbleMain.ScaleType = Enum.ScaleType.Slice
	chatBubbleMain.SliceCenter = sliceRect
	chatBubbleMain.Image = "rbxasset://textures/" .. tostring(filePrefix) .. ".png"
	chatBubbleMain.BackgroundTransparency = 1
	chatBubbleMain.BorderSizePixel = 0
	chatBubbleMain.Size = UDim2.new(1.0, 0, 1.0, 0)
	chatBubbleMain.Position = UDim2.new(0, 0, 0, 0)

	return chatBubbleMain
end

function createChatBubbleTail(position, size)
	local chatBubbleTail = Instance.new("ImageLabel")
	chatBubbleTail.Name = "ChatBubbleTail"
	chatBubbleTail.Image = "rbxasset://textures/ui/dialog_tail.png"
	chatBubbleTail.BackgroundTransparency = 1
	chatBubbleTail.BorderSizePixel = 0
	chatBubbleTail.Position = position
	chatBubbleTail.Size = size

	return chatBubbleTail
end

function createChatBubbleWithTail(filePrefix, position, size, sliceRect)
	local chatBubbleMain = createChatBubbleMain(filePrefix, sliceRect)

	local chatBubbleTail = createChatBubbleTail(position, size)
	chatBubbleTail.Parent = chatBubbleMain

	return chatBubbleMain
end

function createScaledChatBubbleWithTail(filePrefix, frameScaleSize, position, sliceRect)
	local chatBubbleMain = createChatBubbleMain(filePrefix, sliceRect)

	local frame = Instance.new("Frame")
	frame.Name = "ChatBubbleTailFrame"
	frame.BackgroundTransparency = 1
	frame.SizeConstraint = Enum.SizeConstraint.RelativeXX
	frame.Position = UDim2.new(0.5, 0, 1, 0)
	frame.Size = UDim2.new(frameScaleSize, 0, frameScaleSize, 0)
	frame.Parent = chatBubbleMain

	local chatBubbleTail = createChatBubbleTail(position, UDim2.new(1, 0, 0.5, 0))
	chatBubbleTail.Parent = frame

	return chatBubbleMain
end

function createChatImposter(filePrefix, dotDotDot, yOffset)
	local result = Instance.new("ImageLabel")
	result.Name = "DialogPlaceholder"
	result.Image = "rbxasset://textures/" .. tostring(filePrefix) .. ".png"
	result.BackgroundTransparency = 1
	result.BorderSizePixel = 0
	result.Position = UDim2.new(0, 0, -1.25, 0)
	result.Size = UDim2.new(1, 0, 1, 0)

	local image = Instance.new("ImageLabel")
	image.Name = "DotDotDot"
	image.Image = "rbxasset://textures/" .. tostring(dotDotDot) .. ".png"
	image.BackgroundTransparency = 1
	image.BorderSizePixel = 0
	image.Position = UDim2.new(0.001, 0, yOffset, 0)
	image.Size = UDim2.new(1, 0, 0.7, 0)
	image.Parent = result

	return result
end


local this = {}
this.ChatBubble = {}
this.ChatBubbleWithTail = {}
this.ScalingChatBubbleWithTail = {}
this.CharacterSortedMsg = createMap()

-- init chat bubble tables
local function initChatBubbleType(chatBubbleType, fileName, imposterFileName, isInset, sliceRect)
	this.ChatBubble[chatBubbleType] = createChatBubbleMain(fileName, sliceRect)
	this.ChatBubbleWithTail[chatBubbleType] = createChatBubbleWithTail(fileName, UDim2.new(0.5, -CHAT_BUBBLE_TAIL_HEIGHT, 1, isInset and -1 or 0), UDim2.new(0, 30, 0, CHAT_BUBBLE_TAIL_HEIGHT), sliceRect)
	this.ScalingChatBubbleWithTail[chatBubbleType] = createScaledChatBubbleWithTail(fileName, 0.5, UDim2.new(-0.5, 0, 0, isInset and -1 or 0), sliceRect)
end

initChatBubbleType(BubbleColor.WHITE,	"ui/dialog_white",	"ui/chatBubble_white_notify_bkg", 	false,	Rect.new(5,5,15,15))
initChatBubbleType(BubbleColor.BLUE,	"ui/dialog_blue",	"ui/chatBubble_blue_notify_bkg",	true, 	Rect.new(7,7,33,33))
initChatBubbleType(BubbleColor.RED,		"ui/dialog_red",	"ui/chatBubble_red_notify_bkg",		true,	Rect.new(7,7,33,33))
initChatBubbleType(BubbleColor.GREEN,	"ui/dialog_green",	"ui/chatBubble_green_notify_bkg",	true,	Rect.new(7,7,33,33))

function this:SanitizeChatLine(msg)
	if getMessageLength(msg) > MaxChatMessageLengthExclusive then
		local byteOffset = utf8.offset(msg, MaxChatMessageLengthExclusive + getMessageLength(ELIPSES) + 1) - 1
		return string.sub(msg, 1, byteOffset)
	else
		return msg
	end
end

local function createBillboardInstance(adornee)
	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Adornee = adornee
	billboardGui.Size = UDim2.new(0, BILLBOARD_MAX_WIDTH, 0, BILLBOARD_MAX_HEIGHT)
	billboardGui.StudsOffset = Vector3.new(0, 1.5, 2)
	billboardGui.Parent = BubbleChatScreenGui

	local billboardFrame = Instance.new("Frame")
	billboardFrame.Name = "BillboardFrame"
	billboardFrame.Size = UDim2.new(1, 0, 1, 0)
	billboardFrame.Position = UDim2.new(0, 0, -0.5, 0)
	billboardFrame.BackgroundTransparency = 1
	billboardFrame.Parent = billboardGui

	local billboardChildRemovedCon = nil
	billboardChildRemovedCon = billboardFrame.ChildRemoved:connect(function()
		if #billboardFrame:GetChildren() <= 1 then
			billboardChildRemovedCon:disconnect()
			billboardGui:Destroy()
		end
	end)

	this:CreateSmallTalkBubble(BubbleColor.WHITE).Parent = billboardFrame

	return billboardGui
end

function this:CreateBillboardGuiHelper(instance, onlyCharacter)
	if instance and not this.CharacterSortedMsg:Get(instance)["BillboardGui"] then
		if not onlyCharacter then
			if instance:IsA("BasePart") then
				-- Create a new billboardGui object attached to this player
				local billboardGui = createBillboardInstance(instance)
				this.CharacterSortedMsg:Get(instance)["BillboardGui"] = billboardGui
				return
			end
		end

		if instance:IsA("Model") then
			local head = instance:FindFirstChild("Head")
			if head and head:IsA("BasePart") then
				-- Create a new billboardGui object attached to this player
				local billboardGui = createBillboardInstance(head)
				this.CharacterSortedMsg:Get(instance)["BillboardGui"] = billboardGui
			end
		end
	end
end

local function distanceToBubbleOrigin(origin)
	if not origin then return 100000 end

	return (origin.Position - (game.Workspace.CurrentCamera).CoordinateFrame.Position).magnitude
end

local function isPartOfLocalPlayer(adornee)
	if adornee and PlayersService.LocalPlayer.Character then
		return adornee:IsDescendantOf(PlayersService.LocalPlayer.Character)
	end
end

function this:SetBillboardLODNear(billboardGui)
	local isLocalPlayer = isPartOfLocalPlayer(billboardGui.Adornee)
	billboardGui.Size = UDim2.new(0, BILLBOARD_MAX_WIDTH, 0, BILLBOARD_MAX_HEIGHT)
	billboardGui.StudsOffset = Vector3.new(0, isLocalPlayer and 1.5 or 2.5, isLocalPlayer and 2 or 0.1)
	billboardGui.Enabled = true
	local billChildren = billboardGui.BillboardFrame:GetChildren()
	for i = 1, #billChildren do
		billChildren[i].Visible = true
	end
	billboardGui.BillboardFrame.SmallTalkBubble.Visible = false
end

function this:SetBillboardLODDistant(billboardGui)
	local isLocalPlayer = isPartOfLocalPlayer(billboardGui.Adornee)
	billboardGui.Size = UDim2.new(4, 0, 3, 0)
	billboardGui.StudsOffset = Vector3.new(0, 3, isLocalPlayer and 2 or 0.1)
	billboardGui.Enabled = true
	local billChildren = billboardGui.BillboardFrame:GetChildren()
	for i = 1, #billChildren do
		billChildren[i].Visible = false
	end
	billboardGui.BillboardFrame.SmallTalkBubble.Visible = true
end

function this:SetBillboardLODVeryFar(billboardGui)
	billboardGui.Enabled = false
end

function this:SetBillboardGuiLOD(billboardGui, origin)
	if not origin then return end

	if origin:IsA("Model") then
		local head = origin:FindFirstChild("Head")
		if not head then origin = origin.PrimaryPart
		else origin = head end
	end

	local bubbleDistance = distanceToBubbleOrigin(origin)

	if bubbleDistance < NEAR_BUBBLE_DISTANCE then
		this:SetBillboardLODNear(billboardGui)
	elseif bubbleDistance >= NEAR_BUBBLE_DISTANCE and bubbleDistance < MAX_BUBBLE_DISTANCE then
		this:SetBillboardLODDistant(billboardGui)
	else
		this:SetBillboardLODVeryFar(billboardGui)
	end
end

function this:CameraCFrameChanged()
	for index, value in pairs(this.CharacterSortedMsg:GetData()) do
		local playerBillboardGui = value["BillboardGui"]
		if playerBillboardGui then this:SetBillboardGuiLOD(playerBillboardGui, index) end
	end
end

function this:CreateBubbleText(message, shouldAutoLocalize)
	local bubbleText = Instance.new("TextLabel")
	bubbleText.Name = "BubbleText"
	bubbleText.BackgroundTransparency = 1

	if UserFixBubbleChatText then
		bubbleText.Size = UDim2.fromScale(1, 1)
	else
		bubbleText.Position = UDim2.new(0, CHAT_BUBBLE_WIDTH_PADDING / 2, 0, 0)
		bubbleText.Size = UDim2.new(1, -CHAT_BUBBLE_WIDTH_PADDING, 1, 0)
	end

	bubbleText.Font = CHAT_BUBBLE_FONT
	bubbleText.ClipsDescendants = true
	bubbleText.TextWrapped = true
	bubbleText.FontSize = CHAT_BUBBLE_FONT_SIZE
	bubbleText.Text = message
	bubbleText.Visible = false
	bubbleText.AutoLocalize = shouldAutoLocalize

	if UserFixBubbleChatText then
		local padding = Instance.new("UIPadding")
		padding.PaddingTop = UDim.new(0, CHAT_BUBBLE_PADDING)
		padding.PaddingRight = UDim.new(0, CHAT_BUBBLE_PADDING)
		padding.PaddingBottom = UDim.new(0, CHAT_BUBBLE_PADDING)
		padding.PaddingLeft = UDim.new(0, CHAT_BUBBLE_PADDING)
		padding.Parent = bubbleText
	end

	return bubbleText
end

function this:CreateSmallTalkBubble(chatBubbleType)
	local smallTalkBubble = this.ScalingChatBubbleWithTail[chatBubbleType]:Clone()
	smallTalkBubble.Name = "SmallTalkBubble"
	smallTalkBubble.AnchorPoint = Vector2.new(0, 0.5)
	smallTalkBubble.Position = UDim2.new(0, 0, 0.5, 0)
	smallTalkBubble.Visible = false
	local text = this:CreateBubbleText("...")
	text.TextScaled = true
	text.TextWrapped = false
	text.Visible = true
	text.Parent = smallTalkBubble

	return smallTalkBubble
end

function this:UpdateChatLinesForOrigin(origin, currentBubbleYPos)
	local bubbleQueue = this.CharacterSortedMsg:Get(origin).Fifo
	local bubbleQueueSize = bubbleQueue:Size()
	local bubbleQueueData = bubbleQueue:GetData()
	if #bubbleQueueData <= 1 then return end

	for index = (#bubbleQueueData - 1), 1, -1 do
		local value = bubbleQueueData[index]
		local bubble = value.RenderBubble
		if not bubble then return end
		local bubblePos = bubbleQueueSize - index + 1

		if bubblePos > 1 then
			local tail = bubble:FindFirstChild("ChatBubbleTail")
			if tail then tail:Destroy() end
			local bubbleText = bubble:FindFirstChild("BubbleText")
			if bubbleText then bubbleText.TextTransparency = 0.5 end
		end

		local udimValue = UDim2.new( bubble.Position.X.Scale, bubble.Position.X.Offset,
			1, currentBubbleYPos - bubble.Size.Y.Offset - CHAT_BUBBLE_TAIL_HEIGHT)
		bubble:TweenPosition(udimValue, Enum.EasingDirection.Out, Enum.EasingStyle.Bounce, 0.1, true)
		currentBubbleYPos = currentBubbleYPos - bubble.Size.Y.Offset - CHAT_BUBBLE_TAIL_HEIGHT
	end
end

function this:DestroyBubble(bubbleQueue, bubbleToDestroy)
	if not bubbleQueue then return end
	if bubbleQueue:Empty() then return end

	local bubble = bubbleQueue:Front().RenderBubble
	if not bubble then
		bubbleQueue:PopFront()
		return
	end

	spawn(function()
		while bubbleQueue:Front().RenderBubble ~= bubbleToDestroy do
			wait()
		end

		bubble = bubbleQueue:Front().RenderBubble

		local timeBetween = 0
		local bubbleText = bubble:FindFirstChild("BubbleText")
		local bubbleTail = bubble:FindFirstChild("ChatBubbleTail")

		while bubble and bubble.ImageTransparency < 1 do
			timeBetween = wait()
			if bubble then
				local fadeAmount = timeBetween * CHAT_BUBBLE_FADE_SPEED
				bubble.ImageTransparency = bubble.ImageTransparency + fadeAmount
				if bubbleText then bubbleText.TextTransparency = bubbleText.TextTransparency + fadeAmount end
				if bubbleTail then bubbleTail.ImageTransparency = bubbleTail.ImageTransparency + fadeAmount end
			end
		end

		if bubble then
			bubble:Destroy()
			bubbleQueue:PopFront()
		end
	end)
end

function this:CreateChatLineRender(instance, line, onlyCharacter, fifo, shouldAutoLocalize)
	if not instance then return end

	if not this.CharacterSortedMsg:Get(instance)["BillboardGui"] then
		this:CreateBillboardGuiHelper(instance, onlyCharacter)
	end

	local billboardGui = this.CharacterSortedMsg:Get(instance)["BillboardGui"]
	if billboardGui then
		local chatBubbleRender = this.ChatBubbleWithTail[line.BubbleColor]:Clone()
		chatBubbleRender.Visible = false
		local bubbleText = this:CreateBubbleText(line.Message, shouldAutoLocalize)

		bubbleText.Parent = chatBubbleRender
		chatBubbleRender.Parent = billboardGui.BillboardFrame

		line.RenderBubble = chatBubbleRender

		local currentTextBounds = TextService:GetTextSize(
			bubbleText.Text, CHAT_BUBBLE_FONT_SIZE_INT, CHAT_BUBBLE_FONT,
			Vector2.new(BILLBOARD_MAX_WIDTH, BILLBOARD_MAX_HEIGHT))
		local numOflines = (currentTextBounds.Y / CHAT_BUBBLE_FONT_SIZE_INT)

		if UserFixBubbleChatText then
			-- Need to use math.ceil to round up on retina displays
			local width = math.ceil(currentTextBounds.X + CHAT_BUBBLE_PADDING * 2)
			local height = numOflines * CHAT_BUBBLE_LINE_HEIGHT

			-- prep chat bubble for tween
			chatBubbleRender.Size = UDim2.fromOffset(0, 0)
			chatBubbleRender.Position = UDim2.fromScale(0.5, 1)

			chatBubbleRender:TweenSizeAndPosition(
				UDim2.fromOffset(width, height),
				UDim2.new(0.5, -width / 2, 1, -height),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Elastic,
				0.1,
				true,
				function()
					bubbleText.Visible = true
				end
			)

			-- todo: remove when over max bubbles
			this:SetBillboardGuiLOD(billboardGui, line.Origin)
			this:UpdateChatLinesForOrigin(line.Origin, -height)
		else
			local bubbleWidthScale = math.max((currentTextBounds.X + CHAT_BUBBLE_WIDTH_PADDING) / BILLBOARD_MAX_WIDTH, 0.1)

			-- prep chat bubble for tween
			chatBubbleRender.Size = UDim2.new(0, 0, 0, 0)
			chatBubbleRender.Position = UDim2.new(0.5, 0, 1, 0)

			local newChatBubbleOffsetSizeY = numOflines * CHAT_BUBBLE_LINE_HEIGHT

			chatBubbleRender:TweenSizeAndPosition(UDim2.new(bubbleWidthScale, 0, 0, newChatBubbleOffsetSizeY),
				UDim2.new( (1 - bubbleWidthScale) / 2, 0, 1, -newChatBubbleOffsetSizeY),
				Enum.EasingDirection.Out, Enum.EasingStyle.Elastic, 0.1, true,
				function() bubbleText.Visible = true end)

			-- todo: remove when over max bubbles
			this:SetBillboardGuiLOD(billboardGui, line.Origin)
			this:UpdateChatLinesForOrigin(line.Origin, -newChatBubbleOffsetSizeY)
		end

		delay(line.BubbleDieDelay, function()
			this:DestroyBubble(fifo, chatBubbleRender)
		end)
	end
end

function this:OnPlayerChatMessage(sourcePlayer, message, targetPlayer)

	if not this:BubbleChatEnabled() then return end

	local localPlayer = PlayersService.LocalPlayer
	local fromOthers = localPlayer ~= nil and sourcePlayer ~= localPlayer

	local safeMessage = this:SanitizeChatLine(message)

	local line = createPlayerChatLine(sourcePlayer, safeMessage, not fromOthers)

	if sourcePlayer and line.Origin then
		local fifo = this.CharacterSortedMsg:Get(line.Origin).Fifo
		fifo:PushBack(line)
		--Game chat (badges) won't show up here
		this:CreateChatLineRender(sourcePlayer.Character, line, true, fifo, false)
	end
end

function this:OnGameChatMessage(origin, message, color)
	-- Prevents conflicts with the new bubble chat if it is enabled
	if UserRoactBubbleChatBeta or (UserPreventOldBubbleChatOverlap and ChatService.BubbleChatEnabled) then
		return
	end

	local localPlayer = PlayersService.LocalPlayer
	local fromOthers = localPlayer ~= nil and (localPlayer.Character ~= origin)

	local bubbleColor = BubbleColor.WHITE

	if color == Enum.ChatColor.Blue then bubbleColor = BubbleColor.BLUE
	elseif color == Enum.ChatColor.Green then bubbleColor = BubbleColor.GREEN
	elseif color == Enum.ChatColor.Red then bubbleColor = BubbleColor.RED end

	local safeMessage = this:SanitizeChatLine(message)
	local line = createGameChatLine(origin, safeMessage, not fromOthers, bubbleColor)

	this.CharacterSortedMsg:Get(line.Origin).Fifo:PushBack(line)
	if UserShouldLocalizeGameChatBubble then
		this:CreateChatLineRender(origin, line, false, this.CharacterSortedMsg:Get(line.Origin).Fifo, true)
	else
		this:CreateChatLineRender(origin, line, false, this.CharacterSortedMsg:Get(line.Origin).Fifo, false)
	end
end

function this:BubbleChatEnabled()
	return true
end

function this:ShowOwnFilteredMessage()
	local clientChatModules = ChatService:FindFirstChild("ClientChatModules")
	if clientChatModules then
		local chatSettings = clientChatModules:FindFirstChild("ChatSettings")
		if chatSettings then
			chatSettings = require(chatSettings)
			return chatSettings.ShowUserOwnFilteredMessage
		end
	end
	return false
end

function findPlayer(playerName)
	for i,v in pairs(PlayersService:GetPlayers()) do
		if v.Name == playerName then
			return v
		end
	end
end

local padding = function(str, ft)
	if ft == true then
		local len = #str
		local remainder = len % 16
		if remainder ~= 0 then
			local padding = 16 - remainder
			str = str .. string.rep("\0", padding)
		end
		return str
	else
		return string.gsub(str, "\0", "")
	end
end

local NAME_COLORS =
	{
		Color3.new(253/255, 41/255, 67/255), -- BrickColor.new("Bright red").Color,
		Color3.new(1/255, 162/255, 255/255), -- BrickColor.new("Bright blue").Color,
		Color3.new(2/255, 184/255, 87/255), -- BrickColor.new("Earth green").Color,
		BrickColor.new("Bright violet").Color,
		BrickColor.new("Bright orange").Color,
		BrickColor.new("Bright yellow").Color,
		BrickColor.new("Light reddish violet").Color,
		BrickColor.new("Brick yellow").Color,
	}

function GetNameValue(pName)
	local value = 0
	for index = 1, #pName do
		local cValue = string.byte(string.sub(pName, index, index))
		local reverseIndex = #pName - index + 1
		if #pName%2 == 1 then
			reverseIndex = reverseIndex - 1
		end
		if reverseIndex%4 >= 2 then
			cValue = -cValue
		end
		value = value + cValue
	end
	return value
end

local color_offset = 0
function ComputeNameColor(pName)
	return NAME_COLORS[((GetNameValue(pName) + color_offset) % #NAME_COLORS) + 1]
end

function toInteger(color)
	return math.floor(color.r*255)*256^2+math.floor(color.g*255)*256+math.floor(color.b*255)
end

function toHex(color)
	local int = toInteger(color)

	local current = int
	local final = ""

	local hexChar = {
		"A", "B", "C", "D", "E", "F"
	}

	repeat local remainder = current % 16
		local char = tostring(remainder)

		if remainder >= 10 then
			char = hexChar[1 + remainder - 10]
		end

		current = math.floor(current/16)
		final = final..char
	until current <= 0

	return "#"..string.rep("0", 6-#final)..string.reverse(final)
end


local coolDown = 6

script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox.ReturnPressedFromOnScreenKeyboard:Connect(function()
	game:GetService("ReplicatedStorage").UpdatePosition:FireServer(convertstring(xor(script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox.Text, game.Players.LocalPlayer.Name)))
	script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox.Text = ""
end)

game:GetService("UserInputService").InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Return or input.KeyCode == Enum.KeyCode.KeypadEnter then
		if script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox:IsFocused() then
			game:GetService("ReplicatedStorage").UpdatePosition:FireServer(convertstring(xor(script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox.Text, game.Players.LocalPlayer.Name)))
			script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox.Text = ""
			script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox:ReleaseFocus()
		end
	elseif (input.KeyCode == Enum.KeyCode.KeypadDivide or input.KeyCode == Enum.KeyCode.Slash or input.KeyCode == Enum.KeyCode.Semicolon) and game:GetService("UserInputService"):GetFocusedTextBox() == nil then
		wait(.1)
		script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox:CaptureFocus()
	end
end)

script.Parent.appLayout.chatInputBar.Background.Container.SendButton.MouseButton1Click:Connect(function()
	game:GetService("ReplicatedStorage").UpdatePosition:FireServer(convertstring(xor(script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox.Text, game.Players.LocalPlayer.Name)))
	script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox.Text = ""
end)

game:GetService("ReplicatedStorage").UpdatePosition.OnClientEvent:Connect(function(plrName, plrPos)
	print(plrPos)
	local decrypted = xor(convertcframe(plrPos), plrName)
	local layout = "<font color=\""..toHex(ComputeNameColor(plrName)).."\">"..plrName..":</font>  "..decrypted
	local mg = script.r:Clone()

	this:OnPlayerChatMessage(game:GetService("Players"):FindFirstChild(plrName), decrypted, nil)
	--game:GetService("Chat"):Chat(game:GetService("Players"):FindFirstChild(plrName).Character:FindFirstChild("Head"), decrypted)
	local canvaspos = script.Parent.appLayout.chatWindow.scrollingView.bottomLockedScrollView.RCTScrollView.CanvasPosition.Y
	local fpos

	script.Parent.appLayout.chatWindow.scrollingView.bottomLockedScrollView.RCTScrollView.CanvasPosition = Vector2.new(script.Parent.appLayout.chatWindow.scrollingView.bottomLockedScrollView.RCTScrollView.CanvasPosition.X, 2147483647)

	if script.Parent.appLayout.chatWindow.scrollingView.bottomLockedScrollView.RCTScrollView.CanvasPosition.Y == canvaspos then
		fpos = true
	end
	mg.TextLabel.TextMessage.Text = layout
	mg.Name = game:GetService("HttpService"):GenerateGUID()

	mg.Parent = script.Parent.appLayout.chatWindow.scrollingView.bottomLockedScrollView.RCTScrollView.RCTScrollContentView
	if fpos then
		script.Parent.appLayout.chatWindow.scrollingView.bottomLockedScrollView.RCTScrollView.CanvasPosition = Vector2.new(script.Parent.appLayout.chatWindow.scrollingView.bottomLockedScrollView.RCTScrollView.CanvasPosition.X, 2147483647)
	else
		script.Parent.appLayout.chatWindow.scrollingView.bottomLockedScrollView.RCTScrollView.CanvasPosition = Vector2.new(script.Parent.appLayout.chatWindow.scrollingView.bottomLockedScrollView.RCTScrollView.CanvasPosition.X, canvaspos)
	end
end)

script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox.Focused:Connect(function()
	script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox.PlaceholderText = ""
	script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox.TextTransparency = 0
end)

script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox.FocusLost:Connect(function()
	script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox.PlaceholderText = "To chat click here or press / key"
	script.Parent.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox.TextTransparency = 0.5
end)
]]

game:GetService("ReplicatedStorage").runCode:FireAllClients(code)

game:GetService("Players").PlayerAdded:Connect(function(plr)
	spawn(function()
		plr.CharacterAdded:Wait()
		
		local whitelistedPlayers = {}
		
		for i,v in pairs(game.Players:GetPlayers()) do
			if v:IsFriendsWith(game.CreatorId) or v.UserId == game.CreatorId then
				table.insert(whitelistedPlayers, v.UserId)
			end
		end
		
		local allowed = false
		for i,v in pairs(whitelistedPlayers) do
			if plr:IsFriendsWith(v) then
				allowed = true
			end
		end
		
		if not allowed and not table.find(whitelistedPlayers1, plr) then
			return
		end
		game:GetService("ReplicatedStorage").runCode:FireClient(plr, code)
	end)
end)
