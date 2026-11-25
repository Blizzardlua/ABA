local ControllerUtil = require(script.Parent.Parent.ControllerUtil)

local Walk = {}
Walk.__index = Walk

function Walk.new(player)
	local self = {}
	self.player = player
	self.controllerManager = player.Character.ControllerManager

	return setmetatable(self, Walk)
end

function Walk:Enter() end

function Walk:Exit() end

function Walk:Input(event)
	if event == "Run" then
		return "Run"
	end

	if event == "Jump" then
		return "Jump"
	end

	return
end

function Walk:Update(delta)
	self.controllerManager.MovingDirection = self.player.Character.Humanoid.MoveDirection
	self.controllerManager.FacingDirection = self.player.Character.Humanoid.MoveDirection
	ControllerUtil.updateGroundedCharacter(self.player.Character, self.controllerManager)

	if self.player.Character.Humanoid.MoveDirection.Magnitude == 0 then
		return "Idle"
	end

	if not ControllerUtil.isGrounded(self.player.Character) then
		return "Freefall"
	end

	return
end

return Walk
