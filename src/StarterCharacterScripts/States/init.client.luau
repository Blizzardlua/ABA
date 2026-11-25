local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local Input = game:GetService("ReplicatedStorage"):WaitForChild("Input")

local playerState
local States = {
	Idle = require(script.Idle),
	Walk = require(script.Walk),
	Run = require(script.Run),
	Jump = require(script.Jump),
	Freefall = require(script.Freefall),
	Land = require(script.Land),
}

local function changeState(newState)
	playerState:Exit()
	playerState = newState
	playerState:Enter()
end

local function input(event: string)
	local nextState = playerState:Input(event)
	if not nextState or not States[nextState] then
		return
	end

	local newState = States[nextState].new(player)
	if newState then
		changeState(newState)
	end
end

local function update(delta)
	local nextState = playerState:Update(delta)
	if not nextState or not States[nextState] then
		return
	end

	local newState = States[nextState].new(player)
	if newState then
		changeState(newState)
	end
end

if not player.Character then
	player.CharacterAdded:Wait()
end
playerState = States.Idle.new(player)

Input.Event:Connect(input)
RunService.PreRender:Connect(update)
