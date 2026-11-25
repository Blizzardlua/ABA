local Players = game:GetService("Players")

local ControllerManager = game.ServerStorage.ControllerManager

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        character.Humanoid.EvaluateStateMachine = false

        local characterController = ControllerManager:Clone()
        characterController.ActiveController = characterController.GroundController
        characterController.RootPart = character.HumanoidRootPart
        characterController.Parent = character
    end)
end)

return {}