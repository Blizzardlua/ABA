local ControllerUtil = {}

local function blockcastFromCharacter(character)
	local origin = character.HumanoidRootPart.CFrame
	local size = Vector3.new(2, 1, 1)
	local direction = Vector3.new(0, -1, 0)
	local distance = 5

	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = { character }
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude

	return workspace:Blockcast(origin, size, direction * distance, raycastParams)
end

local function raycastCharacterLookVector(character)
	local rootPart = character.HumanoidRootPart
	local origin = rootPart.Position + Vector3.new(0, -3.25, 0)
	local direction = rootPart.CFrame.LookVector
	local distance = 0.75

	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = { character }
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude

	return workspace:Raycast(origin, direction * distance, raycastParams)
end

--[[ function ControllerUtil.isGrounded(character, controllerManager)
	local blockcastResult = blockcastFromCharacter(character)
	local GroundSensor = controllerManager.GroundSensor

	if blockcastResult then
		GroundSensor.SensedPart = blockcastResult.Instance
		GroundSensor.HitNormal = blockcastResult.Normal
		GroundSensor.HitFrame = CFrame.new(blockcastResult.Position)
		return true
	else
		GroundSensor.SensedPart = nil
		GroundSensor.HitNormal = Vector3.new(0, 1, 0)
		GroundSensor.HitFrame = CFrame.new(character.HumanoidRootPart.Position)
		return false
	end
end

function ControllerUtil.isClimbing(character, controllerManager)
	local raycastResult = raycastCharacterLookVector(character)
	local ClimbSensor = controllerManager.ClimbSensor

	if raycastResult then
		ClimbSensor.SensedPart = raycastResult.Instance
		ClimbSensor.HitNormal = raycastResult.Normal
		ClimbSensor.HitFrame = CFrame.new(raycastResult.Position)
		return true
	else
		ClimbSensor.SensedPart = nil
		ClimbSensor.HitNormal = Vector3.new(0, 0, 0)
		ClimbSensor.HitFrame = CFrame.new(character.HumanoidRootPart.Position)
		return false
	end
end ]]

function ControllerUtil.isGrounded(character)
	local blockcastResult = blockcastFromCharacter(character)

	if blockcastResult then
		return true
	else
		return false
	end
end

function ControllerUtil.canClimb(character)
	local raycastResult = raycastCharacterLookVector(character)

	if raycastResult then
		return true
	else
		return false
	end
end

function ControllerUtil.updateGroundedCharacter(character, controllerManager)
	local blockcastResult = blockcastFromCharacter(character)
	local GroundSensor = controllerManager.GroundSensor

	if blockcastResult then
		GroundSensor.SensedPart = blockcastResult.Instance
		GroundSensor.HitNormal = blockcastResult.Normal
		GroundSensor.HitFrame = CFrame.new(blockcastResult.Position)
	else
		GroundSensor.SensedPart = nil
		GroundSensor.HitNormal = Vector3.new(0, 1, 0)
		GroundSensor.HitFrame = CFrame.new(character.HumanoidRootPart.Position)
	end
end

function ControllerUtil.updateClimbingCharacter(character, controllerManager)
	local raycastResult = raycastCharacterLookVector(character)
	local ClimbSensor = controllerManager.ClimbSensor

	if raycastResult then
		ClimbSensor.SensedPart = raycastResult.Instance
		ClimbSensor.HitNormal = raycastResult.Normal
		ClimbSensor.HitFrame = CFrame.new(raycastResult.Position)
	else
		ClimbSensor.SensedPart = nil
		ClimbSensor.HitNormal = Vector3.new(0, 0, 0)
		ClimbSensor.HitFrame = CFrame.new(character.HumanoidRootPart.Position)
	end
end

return ControllerUtil
