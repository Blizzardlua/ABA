local ControllerUtil = require(script.Parent.Parent.ControllerUtil)

local Idle = {}
Idle.__index = Idle

function Idle.new(player)
	local self = {}
	self.player = player
	self.humanoid = player.Character.Humanoid
	self.controllerManager = player.Character.ControllerManager

	return setmetatable(self, Idle)
end

function Idle:Enter() end

function Idle:Exit() end

function Idle:Input(event)
	if event == "Run" then
		return "Run"
	end

	if event == "Jump" then
		return "Jump"
	end

	return
end

function Idle:Update(delta)
	self.controllerManager.MovingDirection = Vector3.new(0, 0, 0)
	self.controllerManager.FacingDirection = self.player.Character.HumanoidRootPart.CFrame.LookVector
	ControllerUtil.updateGroundedCharacter(self.player.Character, self.controllerManager)

	if self.humanoid.MoveDirection.Magnitude > 0 then
		return "Walk"
	end

	if not ControllerUtil.isGrounded(self.player.Character) then
		return "Freefall"
	end

	return
end

return Idle
