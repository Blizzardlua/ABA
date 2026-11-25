local UserInputService = game:GetService("UserInputService")

local ControllerUtil = require(script.Parent.Parent.ControllerUtil)
local StateConfig = require(script.Parent.Parent.StateConfig)

local Freefall = {}
Freefall.__index = Freefall

function Freefall.new(player)
	local self = {}
	self.player = player
	self.humanoid = player.Character.Humanoid
	self.controllerManager = player.Character.ControllerManager

	return setmetatable(self, Freefall)
end

function Freefall:Enter()
	if self.controllerManager.ActiveController ~= self.controllerManager.AirController then
		self.controllerManager.ActiveController = self.controllerManager.AirController
	end
end

function Freefall:Exit() end

function Freefall:Input(event)
	return
end

function Freefall:Update(delta)
	if ControllerUtil.isGrounded(self.player.Character) then
		return "Land"
	end

	if
		UserInputService:IsKeyDown(Enum.KeyCode.W)
		and ControllerUtil.canClimb(self.player.Character)
		and StateConfig.Climb.climbCount == 0
	then
		return "Climb"
	end

	return
end

return Freefall
