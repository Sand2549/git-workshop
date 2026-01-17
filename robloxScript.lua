local ServerStorage = game:GetService("ServerStorage") -- แก้คำผิดจาก Sever เป็น Server
local taw = script.Parent

local rawName = "meet1" 
local cookedName = "black1" 

local prompt = Instance.new("ProximityPrompt")
prompt.Parent = taw
prompt.ActionText = "วาง" 
prompt.ObjectText = "หม้อ"
prompt.HoldDuration = 1

local foodOnStove = nil 

prompt.Triggered:Connect(function(player)
	
	if foodOnStove ~= nil then
		
		local cookedTool = ServerStorage:FindFirstChild(cookedName)
		
		if cookedTool then
			local toolClone = cookedTool:Clone()
			toolClone.Parent = player.Backpack
			
			local human = player.Character:FindFirstChild("Humanoid")
			if human then human:EquipTool(toolClone) end
			
			foodOnStove:Destroy()
			foodOnStove = nil
			prompt.ActionText = "วาง"
		end
		return -- จบการทำงานรอบนี้ ไม่ไปทำส่วนข้างล่าง
	end
	
	-- [[ ส่วนที่ 2: ถ้าเตาว่าง (ให้วางเนื้อดิบ) ]]
	local myMeat = player.Character:FindFirstChild(rawName) -- เช็คของในมือ
	
	if myMeat then
		local handle = myMeat:FindFirstChild("Handle")
		
		if handle then
			-- 1. สร้างภาพเนื้อดิบบนเตา
			local meatPart = handle:Clone()
			meatPart.Parent = workspace
			-- ขยับขึ้นมา 1 หน่วย (0.5 อาจจะจมเตา)
			meatPart.CFrame = taw.CFrame * CFrame.new(0, 1, 0) 
			meatPart.Anchored = true
			meatPart.CanCollide = false
			
			myMeat:Destroy()
			foodOnStove = meatPart 
			
			prompt.Enabled = false
			
			task.wait(5)
			
			if foodOnStove then foodOnStove:Destroy() end 
			
			local cookedSource = ServerStorage:FindFirstChild(cookedName)
			if cookedSource and cookedSource:FindFirstChild("Handle") then
				
				local cookedPart = cookedSource.Handle:Clone()
				cookedPart.Parent = workspace
				cookedPart.CFrame = taw.CFrame * CFrame.new(0, 1, 0)
				cookedPart.Anchored = true
				cookedPart.CanCollide = false
				
				foodOnStove = cookedPart 
			end
			
		prompt.Enabled = true
			prompt.ActionText = "หยิบ"
		end
	end
	
end)
