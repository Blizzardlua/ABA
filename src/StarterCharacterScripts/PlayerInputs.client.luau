local UserInputService = game:GetService("UserInputService")
local Input = game:GetService("ReplicatedStorage"):WaitForChild("Input")

local wPressed = 0
local running = false
local taskDelay

UserInputService.InputBegan:Connect(function(input, _gp)
	if input.KeyCode == Enum.KeyCode.W then
		if wPressed == 1 then
			Input:Fire("Run")
			running = true
			task.cancel(taskDelay)
			return
		end

		wPressed += 1
		taskDelay = task.delay(0.5, function()
			wPressed = 0
		end)
	end
end)

UserInputService.InputEnded:Connect(function(input, _gp)
	if input.KeyCode == Enum.KeyCode.W and running then
		Input:Fire("StopRun")
		wPressed = 0
		running = false
	end
end)

UserInputService.InputBegan:Connect(function(input, _gp)
	if input.KeyCode == Enum.KeyCode.Space then
		Input:Fire("Jump")
	end
end)
