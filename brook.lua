local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/BigManV2/hawktuahdomain/refs/heads/main/src.lua"))()

local gui = Library:create{
    Theme = Library.Themes.Rusty
}

-- Vehicle Speed Section START (vsm)
local maxspeedsetplayer = game.Players.LocalPlayer.Name
local vehicles = workspace:FindFirstChild("Vehicles")
local playerVehicle, body, vehicleSeat, turbostat, maxspeedstat

if vehicles then
    print("Vehicles folder found.")
    playerVehicle = vehicles:FindFirstChild(maxspeedsetplayer .. "Car")
    if playerVehicle then
        print("Player's vehicle found:", playerVehicle)
        body = playerVehicle:FindFirstChild("Body")
        if body then
            print("Body found:", body)
            vehicleSeat = body:FindFirstChild("VehicleSeat")
            if vehicleSeat then
                print("VehicleSeat found:", vehicleSeat)
                turbostat = vehicleSeat:FindFirstChild("Turbo")
                maxspeedstat = vehicleSeat:FindFirstChild("TopSpeed")
                print("Turbo:", turbostat, "TopSpeed:", maxspeedstat)
            else
                warn("VehicleSeat not found in Body.")
            end
        else
            warn("Body not found in player's vehicle.")
        end
    else
        warn("Player's vehicle not found: " .. maxspeedsetplayer)
    end
else
    warn("Vehicles folder not found in workspace.")
end

-- Initialize the Vehicle Speed tab
local vsm = gui:Tab{
    Name = "Vehicle Speed",
    Icon = "rbxassetid://6022668901"
}

-- Max Speed Slider
vsm:Slider{
    Name = "Max Speed",
    Default = maxspeedstat and maxspeedstat.Value or 50,
    Min = 0,
    Max = 100,
    Callback = function(v)
        if vehicles and playerVehicle and body and vehicleSeat and maxspeedstat then
            maxspeedstat.Value = v
        else
            gui:Notification{
                Title = "Error",
                Text = "You need a car for this.",
                Duration = 3
            }
        end
    end
}

-- Turbo Slider
vsm:Slider{
    Name = "Turbo",
    Default = turbostat and turbostat.Value or 11,
    Min = 0,
    Max = 100,
    Callback = function(v)
        if vehicles and playerVehicle and body and vehicleSeat and turbostat then
            turbostat.Value = v
        else
            gui:Notification{
                Title = "Error",
                Text = "You need a car for this.",
                Duration = 3
            }
        end
    end
}

-- "What Does This Do?" Button
vsm:Button{
    Name = "What Does This Do?",
    Description = nil,
    Callback = function()
        VSMwdtd()
    end
}

function VSMwdtd()
    gui:Prompt{
        Followup = false,
        Title = "What Does This Do? (1 of 2)",
        Text = "This allows you to change the max speed and turbo of your car.",
        Buttons = {
            next = function()
                gui:Prompt{
                    Followup = true,
                    Title = "What Does This Do? (2 of 2)",
                    Text = "Turbo affects acceleration; max speed affects top speed.",
                    Buttons = { close = function() return true end }
                }
            end,
            close = function() return true end
        }
    }
end

-- Road Rage Section START (rrs)
local isRRSon = false
local RRSspeed = 100
local RRStarget = nil
local playercar = vehicles and vehicles:FindFirstChild(maxspeedsetplayer .. "Car")

-- Initialize Road Rage tab
local rrs = gui:Tab{
    Name = "Road Rage",
    Icon = "rbxassetid://6034767618"
}

rrs:Textbox{
    Name = "Target's Username (case sensitive)",
    Callback = function(text)
        local player = game.Players:FindFirstChild(text)
        if player and player.Character then
            RRStarget = player.Character:FindFirstChild("HumanoidRootPart")
            print("Target set to:", RRStarget)
        else
            RRStarget = nil
            warn("Invalid target username.")
        end
    end
}

rrs:Slider{
    Name = "Speed",
    Default = 100,
    Min = 100,
    Max = 500,
    Callback = function(v)
        RRSspeed = v
    end
}

rrs:Toggle{
    Name = "Toggle",
    StartingState = false,
    Callback = function(state)
        isRRSon = state
        RRSrun()
    end
}

rrs:Button{
    Name = "What Does This Do?",
    Description = nil,
    Callback = function()
        RRSwdtd()
    end
}

function RRSwdtd()
    gui:Prompt{
        Followup = false,
        Title = "What Does This Do? (1 of 2)",
        Text = "This script launches your car at the target.",
        Buttons = {
            next = function()
                gui:Prompt{
                    Followup = true,
                    Title = "What Does This Do? (2 of 2)",
                    Text = "If the target sits in your car, it will be launched.",
                    Buttons = { close = function() return true end }
                }
            end,
            close = function() return true end
        }
    }
end

function RRSrun()
    while isRRSon do
        if RRStarget and playercar then
            local targetPosition = RRStarget.Position
            local objectPosition = playercar:FindFirstChild("Chassis"):FindFirstChild("Mass").Position
            local massObject = playercar:FindFirstChild("Chassis"):FindFirstChild("Mass")
            if massObject then
                local direction = (targetPosition - objectPosition).Unit
                massObject.Velocity = massObject.Velocity + direction * RRSspeed
            else
                warn("Mass object not found in player's car.")
                break
            end
        else
            warn("Invalid target or player's car not set.")
            break
        end
        wait(0.1)
    end
end
-- Road Rage Section END


--Misc Start (misc)
local misc = gui:Tab{
	Name = "Misc",
	Icon = "rbxassetid://6022668907"
}

misc:button{
	Name = "Inject Infinite Yeild",
	Description = nil,
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
	end

}

misc:button{
	Name = "Reload",
	Description = nil,
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/BigManV2/hawktuahdomain/refs/heads/main/brook.lua"))()
	end

}
--Misc End (misc)
