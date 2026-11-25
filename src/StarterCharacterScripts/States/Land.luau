local StateConfig = require(script.Parent.Parent.StateConfig)

local Land = {}
Land.__index = Land

function Land.new(player)
	local self = {}
	self.player = player
	self.humanoid = player.Character.Humanoid
	self.controllerManager = player.Character.ControllerManager

	return setmetatable(self, Land)
end

function Land:Enter()
	self.controllerManager.ActiveController = self.controllerManager.GroundController
	StateConfig.Climb.climbCount = 0
end

function Land:Exit() end

function Land:Input(event) end

function Land:Update(delta)
	return "Idle"
end

return Land
