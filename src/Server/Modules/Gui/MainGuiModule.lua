-- Main Gui Module
-- Username
-- November 2, 2022



local MainGuiModule = {}

function MainGuiModule:CreateGui(parent)
    local wait1= game.ServerStorage.Aero:WaitForChild("Modules")
    if wait1 then
    local MainComponentModule = self.Modules.Gui.components.MainComponentModule
    MainComponentModule:Create(parent)
    end    
end
     



return MainGuiModule