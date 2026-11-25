local ControllerUtil = require(script.Parent.Parent.ControllerUtil)

local Run = {}
Run.__index = Run

function Run.new(player)
	local self = {}
	self.player = player
	self.humanoid = player.Character.Humanoid
	self.controllerManager = player.Character.ControllerManager
	self.groundController = self.controllerManager.GroundController

	return setmetatable(self, Run)
end

function Run:Enter()
	self.controllerManager.ActiveController = self.groundController

	self.groundController.AccelerationTime = 0.14
	self.groundController.MoveSpeedFactor = 1.5
end

function Run:Exit()
	self.groundController.AccelerationTime = 0
	self.groundController.MoveSpeedFactor = 1
end

function Run:Input(event)
	if event == "StopRun" and self.humanoid.MoveDirection.Magnitude == 0 then
		return "Idle"
	end

	if event == "StopRun" and self.humanoid.MoveDirection.Magnitude > 0 then
		return "Walk"
	end

	if event == "Jump" then
		return "Jump"
	end

	return
end

function Run:Update(delta)
	self.controllerManager.MovingDirection = self.player.Character.Humanoid.MoveDirection
	self.controllerManager.FacingDirection = self.player.Character.Humanoid.MoveDirection
	ControllerUtil.updateGroundedCharacter(self.player.Character, self.controllerManager)

	if not ControllerUtil.isGrounded(self.player.Character) then
		return "Freefall"
	end
	return
end

return Run
