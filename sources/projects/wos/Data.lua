local Configurations = require(game.ReplicatedStorage.WOS.Configurations)
local DSS = game:GetService("DataStoreService")
local DS = DSS:GetDataStore(tostring(Configurations.DataSaveString))


game.Players.PlayerAdded:Connect(function(plr)
	-- Setup Data (Display)
	local leaderstats = Instance.new("Folder", plr)
	leaderstats.Name = "leaderstats"
	
	local stage = Instance.new("IntValue", leaderstats)
	stage.Name = "Stage"
	
	local rp = Instance.new("IntValue", leaderstats)
	rp.Name = "RP"
	
	local dataFolder = Instance.new("Folder", plr)
	dataFolder.Name = "Data"
	
	local Tstage = Instance.new("IntValue", plr)
	Tstage.Name = "TStage" 
	
	local function produceInstance(name, typeOfInstance : string, location, defaultValue)
		local making = Instance.new(typeOfInstance, location)
		making.Name = name
		making.Value = defaultValue
		return making
	end

	


	local FreeSkipTimeMin = produceInstance("FreeSkipTimeMin", "IntValue", dataFolder, 39)
	local FreeSkips = produceInstance("FreeSkips", "IntValue", dataFolder, 0)
	
	local key = "ID_".. plr.UserId
	
	local data
	local success, error = pcall(function()
		data = DS:GetAsync(key)
	end)
	
	-- Load Data
	if success then
		stage.Value = data.stage
		rp.Value = data.rp
		
		FreeSkips.Value = data.free_skips.amount
		FreeSkipTimeMin.Value = data.free_skips.mins
		Tstage.Value = stage.Value -- (TStage stands for the Stage the player is at)
		print("Data loaded: ".. key.. " (".. plr.Name.. "'s data: ".. tostring(stage.Value).. ")")
	else
		warn("Data ".. key.. " Unsuccessful when loading with error \"".. error.. "\"")
	end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	-- Save Data
	local key = "ID_".. plr.UserId
	--local data = plr.leaderstats.Stage.Value
	local success, error = pcall(function()
		local data = {
			stage = plr.leaderstats.Stage.Value;
			rp = plr.leaderstats.RP.Value;
			free_skips = {
				amount = plr.Data.FreeSkips.Value;
				mins = plr.Data.FreeSkipTimeMin.Value;
			};
		}
		
		DS:SetAsync(key, data)
	end)
	
	if success then
		print("Data saved: ".. key)
	else
		warn("Data ".. key.. " Unsuccessful when saving with error \"".. error.. "\"")
	end
end)

game.ReplicatedStorage.WOS.SkipBought.OnServerEvent:Connect(function(plr)
	-- Save Data
	local key = "ID_".. plr.UserId
	--local data = plr.leaderstats.Stage.Value
	local success, error = pcall(function()
		local data = {
			stage = plr.leaderstats.Stage.Value;
			rp = plr.leaderstats.RP.Value;
			free_skips = {
				amount = plr.Data.FreeSkips.Value;
				mins = plr.Data.FreeSkipTimeMin.Value;
			};
		}
		
		DS:SetAsync(key, data)
	end)

	if success then
		print("Data saved: ".. key)
	else
		warn("Data ".. key.. " Unsuccessful when saving with error \"".. error.. "\"")
	end
end)
