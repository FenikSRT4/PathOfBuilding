-- Path of Building
--
-- Module: ConfigSetService
-- Config set service for managing config sets.
--

local t_insert = table.insert
local t_remove = table.remove

local ConfigSetServiceClass = newClass("ConfigSetService", function(self, configTab)
	self.configTab = configTab
end)

function ConfigSetServiceClass:NewConfigSet(name)
	local configSetId = #self.configTab.configSets + 1
	self.configTab:NewConfigSet(configSetId, name)
	t_insert(self.configTab.configSetOrderList, configSetId)
	self.configTab:SetActiveConfigSet(configSetId, false, true)
	self.configTab:AddUndoState()
	self.configTab.build:SyncLoadouts()
end

function ConfigSetServiceClass:CopyConfigSet(configSetId, name)
	local newConfigSet = self.configTab:CopyConfigSet(configSetId, name)
	t_insert(self.configTab.configSetOrderList, newConfigSet.id)
	self.configTab:SetActiveConfigSet(newConfigSet.id, false, true)
	self.configTab:AddUndoState()
	self.configTab.build:SyncLoadouts()
end

function ConfigSetServiceClass:RenameConfigSet(configSetId, newName)
	local configSet = self.configTab.configSets[configSetId]
	if configSet then
		configSet.title = newName
		self.configTab.modFlag = true
		self.configTab:AddUndoState()
		self.configTab.build:SyncLoadouts()
	end
end

function ConfigSetServiceClass:DeleteConfigSet(configSetId, orderListIndex)
	local configSet = self.configTab.configSets[configSetId]
	if #self.configTab.configSetOrderList > 1 then
		t_remove(self.configTab.configSetOrderList, orderListIndex)
		self.configTab.configSets[configSetId] = nil
		if configSetId == self.configTab.activeConfigSetId then
			self.configTab:SetActiveConfigSet(self.configTab.configSetOrderList[m_max(1, orderListIndex - 1)], false, true)
		end
		self.configTab:AddUndoState()
		self.configTab.build:SyncLoadouts()
	end
end

function ConfigSetServiceClass:GetConfigSetList()
	local newSetList = { }
	for index, configSetId in ipairs(self.configTab.configSetOrderList) do
		local configSet = self.configTab.configSets[configSetId]
		t_insert(newSetList, configSet.title or "Default")
	end
	return newSetList
end
