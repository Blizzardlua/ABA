local UserInputService = game:GetService("UserInputService")

local ControllerUtil = require(script.Parent.Parent.ControllerUtil)
local StateConfig = require(script.Parent.Parent.StateConfig)

local Jump = {}
Jump.__index = Jump

function Jump.new(player)
	local self = {}
	self.player = player
	self.humanoid = player.Character.Humanoid
	self.humanoidRootPart = player.Character.HumanoidRootPart
	self.controllerManager = player.Character.ControllerManager

	return setmetatable(self, Jump)
end

function Jump:Enter()
	self.humanoidRootPart:ApplyImpulse(Vector3.new(0, 650, 0))
	self.controllerManager.ActiveController = self.controllerManager.AirController
end

function Jump:Exit() end

function Jump:Input(event) end

function Jump:Update(delta)
	if self.humanoidRootPart.AssemblyLinearVelocity.Y <= 0 then
		return "Freefall"
	end
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

return Jump
