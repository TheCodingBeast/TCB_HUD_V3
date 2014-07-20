/*---------------------------------------------------------------------------
	
	Made By: TheCodingBeast
	This work is licensed under the Creative Commons Attribution 4.0 International License. 
	To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.
	
---------------------------------------------------------------------------*/

-- HUD Settings
local HUDSettings 	= {}
local HUDElements	= {}

HUDSettings.X		= "left"		-- Left 	/ Center / Right
HUDSettings.Y		= "bottom"		-- Bottom 	/ Center / Top

HUDSettings.Color1	= Color(65, 160, 255, 255)
HUDSettings.Color2	= Color(0, 125, 220, 255)

HUDSettings.Color3	= Color(115, 115, 115, 255)
HUDSettings.Color4	= Color(90, 90, 90, 255)

HUDSettings.BGColor1	= Color(0, 0, 0, 255)
HUDSettings.BGColor2	= Color(60, 60, 60, 255)
HUDSettings.BGColor3	= Color(40, 40, 40, 255)

HUDSettings.ColorHealth1 = Color(255, 25, 25, 255)
HUDSettings.ColorHealth2 = Color(0, 0, 0, 125)
	
HUDSettings.ColorArmor1	= Color(0, 175, 255, 255)
HUDSettings.ColorArmor2	= Color(0, 0, 0, 125)

HUDSettings.ColorHunger1 = Color(255, 190, 0, 255)
HUDSettings.ColorHunger2 = Color(0, 0, 0, 125)

HUDSettings.ColorStamina1 = Color(75, 255, 50, 255)
HUDSettings.ColorStamina2 = Color(0, 0, 0, 125)

HUDSettings.Border	= 15

HUDElements.Armor	= true
HUDElements.Hunger 	= true		-- Require: HungerMod
HUDElements.Stamina	= true 		-- Require: TCB Stamina

-- HUD Size
HUDSettings.Width 	= 500
HUDSettings.Height	= 235

if HUDElements.Armor then
	HUDSettings.Height = HUDSettings.Height + 36 		---
end

if HUDElements.Hunger then
	HUDSettings.Height = HUDSettings.Height + 36 		---
end

if HUDElements.Stamina then
	HUDSettings.Height = HUDSettings.Height + 36 		---
end

-- HUD Position
HUDSettings.PosX	= 0
HUDSettings.PoxY	= 0

if HUDSettings.X == "left" then
	HUDSettings.PosX = HUDSettings.Border
elseif HUDSettings.X == "center" then
	HUDSettings.PosX = ScrW() / 2 - HUDSettings.Width / 2
elseif HUDSettings.X == "right" then
	HUDSettings.PosX = ScrW() - HUDSettings.Width - HUDSettings.Border
else
	HUDSettings.PosX = HUDSettings.Border
end

if HUDSettings.Y == "top" then
	HUDSettings.PosY = HUDSettings.Border
elseif HUDSettings.Y == "center" then
	HUDSettings.PosY = ScrH() / 2 - HUDSettings.Height / 2
elseif HUDSettings.Y == "bottom" then
	HUDSettings.PosY = ScrH() - HUDSettings.Height - HUDSettings.Border
else
	HUDSettings.PosY = HUDSettings.Border
end

-- Hide Elements Table
local HideElementsTable = 
{
	["CHudHealth"] 				= true,
	["CHudBattery"]				= true,

	["DarkRP_HUD"]				= true,
	["DarkRP_EntityDisplay"]	= true,
	["DarkRP_ZombieInfo"]		= true,
	["DarkRP_Hungermod"]		= true,
	["DarkRP_Agenda"]			= true,
}

-- Hide Elements
local function HideElements(Name)

	if HideElementsTable[Name] then
		return false
	end

end
hook.Add("HUDShouldDraw", "TCB_HideElements", HideElements )


-- FormatNumber Function
local function formatNumber(n)
	if not n then return "" end
	if n >= 1e14 then return tostring(n) end
	n = tostring(n)
	local sep = sep or ","
	local dp = string.find(n, "%.") or #n+1
	for i=dp-4, 1, -3 do
		n = n:sub(1, i) .. sep .. n:sub(i+1)
	end
	return n
end

-- Base Draw
local function Base()

	-- Background
	draw.RoundedBox(0, HUDSettings.PosX-4, HUDSettings.PosY-4, HUDSettings.Width+8, HUDSettings.Height+8, HUDSettings.BGColor1)
	draw.RoundedBox(0, HUDSettings.PosX-2, HUDSettings.PosY-2, HUDSettings.Width+4, HUDSettings.Height+4, HUDSettings.BGColor2)
	draw.RoundedBox(0, HUDSettings.PosX, HUDSettings.PosY, HUDSettings.Width, HUDSettings.Height, HUDSettings.BGColor3)

	-- Top Bar
	draw.RoundedBox(0, HUDSettings.PosX, HUDSettings.PosY, HUDSettings.Width, 35, HUDSettings.Color1)
	draw.RoundedBox(0, HUDSettings.PosX+2, HUDSettings.PosY+2, HUDSettings.Width-4, 35-4, HUDSettings.Color2)

	-- Values
	local Name_Value	= LocalPlayer():Nick() or ""

	-- Name
	draw.DrawText(Name_Value, "TCB_BebasNeue_Default", HUDSettings.PosX + HUDSettings.Width / 2 + 1, HUDSettings.PosY + 6 + 1, Color(0,0,0,255), 1)
	draw.DrawText(Name_Value, "TCB_BebasNeue_Default", HUDSettings.PosX + HUDSettings.Width / 2, HUDSettings.PosY + 6, Color(255,255,255,255), 1)

end

-- PlayerInfo Draw
local function PlayerInfo()

	-- Values
	local Salary_Value	= "$"..formatNumber(LocalPlayer():getDarkRPVar("salary")	or 0)
	local Money_Value	= "$"..formatNumber(LocalPlayer():getDarkRPVar("money") 	or 0)
	local Job_Value		= LocalPlayer():getDarkRPVar("job") or ""

	local Box_Center	= HUDSettings.Width / 10
	local Box_TopSize	= (HUDSettings.Width / 2 - 40) / 1.5
	local Hud_Half		= HUDSettings.Width / 2

	-- Wallet
	draw.RoundedBox(0, HUDSettings.PosX + Box_Center, HUDSettings.PosY + 45 + 5, Box_TopSize + 8, 30, HUDSettings.BGColor1)
	draw.RoundedBox(0, HUDSettings.PosX + Box_Center + 2, HUDSettings.PosY + 45 + 5 + 2, Box_TopSize + 4, 26, HUDSettings.Color1)
	draw.RoundedBox(0, HUDSettings.PosX + Box_Center + 4, HUDSettings.PosY + 45 + 5 + 4, Box_TopSize, 22, HUDSettings.Color2)

	draw.RoundedBox(0, HUDSettings.PosX + 10, HUDSettings.PosY + 40 + 36, HUDSettings.Width / 2 - 20, 38, HUDSettings.BGColor1)
	draw.RoundedBox(0, HUDSettings.PosX + 10 + 2, HUDSettings.PosY + 40 + 36 + 2, HUDSettings.Width / 2 - 20 - 4, 34, HUDSettings.Color3)
	draw.RoundedBox(0, HUDSettings.PosX + 10 + 4, HUDSettings.PosY + 40 + 36 + 4, HUDSettings.Width / 2 - 20 - 8, 30, HUDSettings.Color4)

	draw.DrawText("Wallet", "TCB_BebasNeue_Small", HUDSettings.PosX + Box_Center + Box_TopSize / 2 + 1, HUDSettings.PosY + 45 + 10 + 1, Color(0,0,0,255), 1)
	draw.DrawText("Wallet", "TCB_BebasNeue_Small", HUDSettings.PosX + Box_Center + Box_TopSize / 2, HUDSettings.PosY + 45 + 10, Color(255,255,255,255), 1)

	draw.DrawText(Money_Value, "TCB_BebasNeue_Default", HUDSettings.PosX + Box_Center + Box_TopSize / 2 + 1, HUDSettings.PosY + 40 + 43 + 1, Color(0,0,0,255), 1)
	draw.DrawText(Money_Value, "TCB_BebasNeue_Default", HUDSettings.PosX + Box_Center + Box_TopSize / 2, HUDSettings.PosY + 40 + 43, Color(255,255,255,255), 1)

	-- Salary
	draw.RoundedBox(0, HUDSettings.PosX + Hud_Half + Box_Center, HUDSettings.PosY + 45 + 5, (HUDSettings.Width / 2 - 40) / 1.5 + 8, 44, HUDSettings.BGColor1)
	draw.RoundedBox(0, HUDSettings.PosX + Hud_Half + Box_Center + 2, HUDSettings.PosY + 45 + 5 + 2, (HUDSettings.Width / 2 - 40) / 1.5 + 4, 40, HUDSettings.Color1)
	draw.RoundedBox(0, HUDSettings.PosX + Hud_Half + Box_Center + 4, HUDSettings.PosY + 45 + 5 + 4, (HUDSettings.Width / 2 - 40) / 1.5, 36, HUDSettings.Color2)

	draw.RoundedBox(0, HUDSettings.PosX + Hud_Half + 10, HUDSettings.PosY + 40 + 36, HUDSettings.Width / 2 - 20, 38, HUDSettings.BGColor1)
	draw.RoundedBox(0, HUDSettings.PosX + Hud_Half + 10 + 2, HUDSettings.PosY + 40 + 36 + 2, HUDSettings.Width / 2 - 20 - 4, 34, HUDSettings.Color3)
	draw.RoundedBox(0, HUDSettings.PosX + Hud_Half + 10 + 4, HUDSettings.PosY + 40 + 36 + 4, HUDSettings.Width / 2 - 20 - 8, 30, HUDSettings.Color4)

	draw.DrawText("Salary", "TCB_BebasNeue_Small", HUDSettings.PosX + Hud_Half + Box_Center + Box_TopSize / 2 + 1, HUDSettings.PosY + 45 + 10 + 1, Color(0,0,0,255), 1)
	draw.DrawText("Salary", "TCB_BebasNeue_Small", HUDSettings.PosX + Hud_Half + Box_Center + Box_TopSize / 2, HUDSettings.PosY + 45 + 10, Color(255,255,255,255), 1)

	draw.DrawText(Salary_Value, "TCB_BebasNeue_Default", HUDSettings.PosX + Hud_Half + Box_Center + Box_TopSize / 2 + 1, HUDSettings.PosY + 40 + 43 + 1, Color(0,0,0,255), 1)
	draw.DrawText(Salary_Value, "TCB_BebasNeue_Default", HUDSettings.PosX + Hud_Half + Box_Center + Box_TopSize / 2, HUDSettings.PosY + 40 + 43, Color(255,255,255,255), 1)


	-- Job
	draw.RoundedBox(0, HUDSettings.PosX + Box_Center + HUDSettings.Width / 4, HUDSettings.PosY + 45 + 74 + 5, Box_TopSize + 8, 30, HUDSettings.BGColor1)
	draw.RoundedBox(0, HUDSettings.PosX + Box_Center + HUDSettings.Width / 4 + 2, HUDSettings.PosY + 45 + 74 + 5 + 2, Box_TopSize + 4, 26, HUDSettings.Color1)
	draw.RoundedBox(0, HUDSettings.PosX + Box_Center + HUDSettings.Width / 4 + 4, HUDSettings.PosY + 45 + 74 + 5 + 4, Box_TopSize, 22, HUDSettings.Color2)

	draw.RoundedBox(0, HUDSettings.PosX + 10, HUDSettings.PosY + 40 + 74 + 36, HUDSettings.Width - 20, 38, HUDSettings.BGColor1)
	draw.RoundedBox(0, HUDSettings.PosX + 10 + 2, HUDSettings.PosY + 40 + 74 + 36 + 2, HUDSettings.Width - 20 - 4, 34, HUDSettings.Color3)
	draw.RoundedBox(0, HUDSettings.PosX + 10 + 4, HUDSettings.PosY + 40 + 74 + 36 + 4, HUDSettings.Width - 20 - 8, 30, HUDSettings.Color4)

	draw.DrawText("Job", "TCB_BebasNeue_Small", HUDSettings.PosX + HUDSettings.Width / 4 + Box_Center + Box_TopSize / 2 + 1, HUDSettings.PosY + 45 + 74 + 10 + 1, Color(0,0,0,255), 1)
	draw.DrawText("Job", "TCB_BebasNeue_Small", HUDSettings.PosX + HUDSettings.Width / 4 + Box_Center + Box_TopSize / 2, HUDSettings.PosY + 45 + 74 + 10, Color(255,255,255,255), 1)

	draw.DrawText(Job_Value, "TCB_BebasNeue_Default", HUDSettings.PosX + HUDSettings.Width / 4 + Box_Center + Box_TopSize / 2 + 1, HUDSettings.PosY + 40 + 74 + 43 + 1, Color(0,0,0,255), 1)
	draw.DrawText(Job_Value, "TCB_BebasNeue_Default", HUDSettings.PosX + HUDSettings.Width / 4 + Box_Center + Box_TopSize / 2, HUDSettings.PosY + 40 + 74 + 43, Color(255,255,255,255), 1)


end

-- Health Start
ElementStartHealth = HUDSettings.PosY + 45 + 74 + 74 + 5

local function ElementHealth()

	local DrawHealth = LocalPlayer():Health() or 0
	local EchoHealth = LocalPlayer():Health() or 0
	local DrawWidth	 = HUDSettings.Width - 38 - 75 + 4

	if DrawHealth < 0 then 
		DrawHealth = 0
	elseif DrawHealth > 100 then
		DrawHealth = 100
	end

	draw.RoundedBox(0, HUDSettings.PosX + 10 + 0, ElementStartHealth + 0, 75 + 8, 30, HUDSettings.BGColor1)
	draw.RoundedBox(0, HUDSettings.PosX + 10 + 2, ElementStartHealth + 2, 75 + 4, 26, HUDSettings.Color1)
	draw.RoundedBox(0, HUDSettings.PosX + 10 + 4, ElementStartHealth + 4, 75 + 0, 22, HUDSettings.Color2)

	draw.RoundedBox(0, HUDSettings.PosX + 95 + 0, ElementStartHealth + 0, HUDSettings.Width - 38 - 75 + 8, 30, HUDSettings.BGColor1)
	draw.RoundedBox(0, HUDSettings.PosX + 95 + 2, ElementStartHealth + 2, HUDSettings.Width - 38 - 75 + 4, 26, HUDSettings.Color3)
	draw.RoundedBox(0, HUDSettings.PosX + 95 + 4, ElementStartHealth + 4, HUDSettings.Width - 38 - 75 + 0, 22, HUDSettings.Color4)

	draw.DrawText("Health:", "TCB_BebasNeue_Small", HUDSettings.PosX + 10 + 75 / 2 + 0, ElementStartHealth + 5 + 1, Color(0,0,0,255), 1)
	draw.DrawText("Health:", "TCB_BebasNeue_Small", HUDSettings.PosX + 10 + 75 / 2 + 1, ElementStartHealth + 5 + 0, Color(255,255,255,255), 1)

	if DrawArmor != 0 then
		draw.RoundedBox(0, HUDSettings.PosX + 95 + 2, ElementStartHealth + 2, DrawWidth * DrawHealth / 100 - 0, 26 - 0, HUDSettings.ColorHealth1)
		draw.RoundedBox(0, HUDSettings.PosX + 95 + 4, ElementStartHealth + 4, DrawWidth * DrawHealth / 100 - 4, 26 - 4, HUDSettings.ColorHealth2)
	end
	
	draw.DrawText(EchoHealth.."%", "TCB_BebasNeue_Small", HUDSettings.PosX + 95 + 2 + DrawWidth / 2 + 1, ElementStartHealth + 5 + 1, Color(0,0,0,255), 1)
	draw.DrawText(EchoHealth.."%", "TCB_BebasNeue_Small", HUDSettings.PosX + 95 + 2 + DrawWidth / 2 + 0, ElementStartHealth + 5 + 0, Color(255,255,255,255), 1)

end

-- Elements Start
ElementStartHeight = HUDSettings.PosY + 45 + 74 + 74 + 5 + 36


-- Element: Armor
local function ElementArmor()

	local DrawArmor = LocalPlayer():Armor() or 0
	local EchoArmor	= LocalPlayer():Armor() or 0
	local DrawWidth	= HUDSettings.Width - 38 - 75 + 4

	if DrawArmor < 0 then 
		DrawArmor = 0
	elseif DrawArmor > 100 then
		DrawArmor = 100
	end

	draw.RoundedBox(0, HUDSettings.PosX + 10 + 0, ElementStartHeight + 0, 75 + 8, 30, HUDSettings.BGColor1)
	draw.RoundedBox(0, HUDSettings.PosX + 10 + 2, ElementStartHeight + 2, 75 + 4, 26, HUDSettings.Color1)
	draw.RoundedBox(0, HUDSettings.PosX + 10 + 4, ElementStartHeight + 4, 75 + 0, 22, HUDSettings.Color2)

	draw.RoundedBox(0, HUDSettings.PosX + 95 + 0, ElementStartHeight + 0, HUDSettings.Width - 38 - 75 + 8, 30, HUDSettings.BGColor1)
	draw.RoundedBox(0, HUDSettings.PosX + 95 + 2, ElementStartHeight + 2, HUDSettings.Width - 38 - 75 + 4, 26, HUDSettings.Color3)
	draw.RoundedBox(0, HUDSettings.PosX + 95 + 4, ElementStartHeight + 4, HUDSettings.Width - 38 - 75 + 0, 22, HUDSettings.Color4)

	draw.DrawText("Armor:", "TCB_BebasNeue_Small", HUDSettings.PosX + 10 + 75 / 2 + 0, ElementStartHeight + 5 + 1, Color(0,0,0,255), 1)
	draw.DrawText("Armor:", "TCB_BebasNeue_Small", HUDSettings.PosX + 10 + 75 / 2 + 1, ElementStartHeight + 5 + 0, Color(255,255,255,255), 1)

	if DrawArmor != 0 then
		draw.RoundedBox(0, HUDSettings.PosX + 95 + 2, ElementStartHeight + 2, DrawWidth * DrawArmor / 100 - 0, 26 - 0, HUDSettings.ColorArmor1)
		draw.RoundedBox(0, HUDSettings.PosX + 95 + 4, ElementStartHeight + 4, DrawWidth * DrawArmor / 100 - 4, 26 - 4, HUDSettings.ColorArmor2)
	end
	
	draw.DrawText(EchoArmor.."%", "TCB_BebasNeue_Small", HUDSettings.PosX + 95 + 2 + DrawWidth / 2 + 1, ElementStartHeight + 5 + 1, Color(0,0,0,255), 1)
	draw.DrawText(EchoArmor.."%", "TCB_BebasNeue_Small", HUDSettings.PosX + 95 + 2 + DrawWidth / 2 + 0, ElementStartHeight + 5 + 0, Color(255,255,255,255), 1)

end

-- Element: Hunger
local function ElementHunger()

	local StartHeight = ElementStartHeight

	if HUDElements.Armor then StartHeight = StartHeight + 36 end

	local DrawHunger 	= math.ceil(LocalPlayer():getDarkRPVar("Energy") or 0)
	local EchoHunger	= math.ceil(LocalPlayer():getDarkRPVar("Energy") or 0)
	local DrawWidth		= HUDSettings.Width - 38 - 75 + 4

	if DrawHunger < 0 then 
		DrawHunger = 0
	elseif DrawHunger > 100 then
		DrawHunger = 100
	end

	draw.RoundedBox(0, HUDSettings.PosX + 10 + 0, StartHeight + 0, 75 + 8, 30, HUDSettings.BGColor1)
	draw.RoundedBox(0, HUDSettings.PosX + 10 + 2, StartHeight + 2, 75 + 4, 26, HUDSettings.Color1)
	draw.RoundedBox(0, HUDSettings.PosX + 10 + 4, StartHeight + 4, 75 + 0, 22, HUDSettings.Color2)

	draw.RoundedBox(0, HUDSettings.PosX + 95 + 0, StartHeight + 0, HUDSettings.Width - 38 - 75 + 8, 30, HUDSettings.BGColor1)
	draw.RoundedBox(0, HUDSettings.PosX + 95 + 2, StartHeight + 2, HUDSettings.Width - 38 - 75 + 4, 26, HUDSettings.Color3)
	draw.RoundedBox(0, HUDSettings.PosX + 95 + 4, StartHeight + 4, HUDSettings.Width - 38 - 75 + 0, 22, HUDSettings.Color4)

	draw.DrawText("Hunger:", "TCB_BebasNeue_Small", HUDSettings.PosX + 10 + 75 / 2 + 0, StartHeight + 5 + 1, Color(0,0,0,255), 1)
	draw.DrawText("Hunger:", "TCB_BebasNeue_Small", HUDSettings.PosX + 10 + 75 / 2 + 1, StartHeight + 5 + 0, Color(255,255,255,255), 1)

	if DrawHunger != 0 then
		draw.RoundedBox(0, HUDSettings.PosX + 95 + 2, StartHeight + 2, DrawWidth * DrawHunger / 100 - 0, 26 - 0, HUDSettings.ColorHunger1)
		draw.RoundedBox(0, HUDSettings.PosX + 95 + 4, StartHeight + 4, DrawWidth * DrawHunger / 100 - 4, 26 - 4, HUDSettings.ColorHunger2)
	end
	
	draw.DrawText(EchoHunger.."%", "TCB_BebasNeue_Small", HUDSettings.PosX + 95 + 2 + DrawWidth / 2 + 1, StartHeight + 5 + 1, Color(0,0,0,255), 1)
	draw.DrawText(EchoHunger.."%", "TCB_BebasNeue_Small", HUDSettings.PosX + 95 + 2 + DrawWidth / 2 + 0, StartHeight + 5 + 0, Color(255,255,255,255), 1)

end

-- Element: Stamina
local function ElementStamina()

	local StartHeight = ElementStartHeight

	if HUDElements.Armor then StartHeight = StartHeight + 36 end
	if HUDElements.Hunger then StartHeight = StartHeight + 36 end

	local DrawStamina 	= LocalPlayer():GetNWInt("tcb_stamina") or 0
	local EchoStamina	= LocalPlayer():GetNWInt("tcb_stamina") or 0
	local DrawWidth		= HUDSettings.Width - 38 - 75 + 4

	if DrawStamina < 0 then 
		DrawStamina = 0
	elseif DrawStamina > 100 then
		DrawStamina = 100
	end

	draw.RoundedBox(0, HUDSettings.PosX + 10 + 0, StartHeight + 0, 75 + 8, 30, HUDSettings.BGColor1)
	draw.RoundedBox(0, HUDSettings.PosX + 10 + 2, StartHeight + 2, 75 + 4, 26, HUDSettings.Color1)
	draw.RoundedBox(0, HUDSettings.PosX + 10 + 4, StartHeight + 4, 75 + 0, 22, HUDSettings.Color2)

	draw.RoundedBox(0, HUDSettings.PosX + 95 + 0, StartHeight + 0, HUDSettings.Width - 38 - 75 + 8, 30, HUDSettings.BGColor1)
	draw.RoundedBox(0, HUDSettings.PosX + 95 + 2, StartHeight + 2, HUDSettings.Width - 38 - 75 + 4, 26, HUDSettings.Color3)
	draw.RoundedBox(0, HUDSettings.PosX + 95 + 4, StartHeight + 4, HUDSettings.Width - 38 - 75 + 0, 22, HUDSettings.Color4)

	draw.DrawText("Stamina:", "TCB_BebasNeue_Small", HUDSettings.PosX + 10 + 75 / 2 + 0, StartHeight + 5 + 1, Color(0,0,0,255), 1)
	draw.DrawText("Stamina:", "TCB_BebasNeue_Small", HUDSettings.PosX + 10 + 75 / 2 + 1, StartHeight + 5 + 0, Color(255,255,255,255), 1)

	if DrawStamina != 0 then
		draw.RoundedBox(0, HUDSettings.PosX + 95 + 2, StartHeight + 2, DrawWidth * DrawStamina / 100 - 0, 26 - 0, HUDSettings.ColorStamina1)
		draw.RoundedBox(0, HUDSettings.PosX + 95 + 4, StartHeight + 4, DrawWidth * DrawStamina / 100 - 4, 26 - 4, HUDSettings.ColorStamina2)
	end
	
	draw.DrawText(EchoStamina.."%", "TCB_BebasNeue_Small", HUDSettings.PosX + 95 + 2 + DrawWidth / 2 + 1, StartHeight + 5 + 1, Color(0,0,0,255), 1)
	draw.DrawText(EchoStamina.."%", "TCB_BebasNeue_Small", HUDSettings.PosX + 95 + 2 + DrawWidth / 2 + 0, StartHeight + 5 + 0, Color(255,255,255,255), 1)

end


-- Default Stuff
local function Agenda()
	local agenda = LocalPlayer():getAgendaTable()
	if not agenda then return end

	draw.RoundedBox(10, 10, 10, 460, 110, Color(0, 0, 0, 155))
	draw.RoundedBox(10, 12, 12, 456, 106, Color(51, 58, 51,100))
	draw.RoundedBox(10, 12, 12, 456, 20, Color(0, 0, 70, 100))

	draw.DrawNonParsedText(agenda.Title, "DarkRPHUD1", 30, 12, Color(255, 0, 0, 255), 0)

	local text = LocalPlayer():getDarkRPVar("agenda") or ""

	text = text:gsub("//", "\n"):gsub("\\n", "\n")
	text = DarkRP.textWrap(text, "DarkRPHUD1", 440)
	draw.DrawNonParsedText(text, "DarkRPHUD1", 30, 35, Color(255, 255, 255, 255), 0)
end

local VoiceChatTexture = surface.GetTextureID("voice/icntlk_pl")
local function DrawVoiceChat()
	if LocalPlayer().DRPIsTalking then
		local chbxX, chboxY = chat.GetChatBoxPos()

		local Rotating = math.sin(CurTime()*3)
		local backwards = 0
		if Rotating < 0 then
			Rotating = 1-(1+Rotating)
			backwards = 180
		end
		surface.SetTexture(VoiceChatTexture)
		surface.SetDrawColor(Color(140,0,0,180))
		surface.DrawTexturedRectRotated(ScrW() - 100, chboxY, Rotating*96, 96, backwards)
	end
end

CreateConVar("DarkRP_LockDown", 0, {FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE})
local function LockDown()
	local chbxX, chboxY = chat.GetChatBoxPos()
	if util.tobool(GetConVarNumber("DarkRP_LockDown")) then
		local cin = (math.sin(CurTime()) + 1) / 2
		local chatBoxSize = math.floor(ScrH() / 4)
		draw.DrawNonParsedText(DarkRP.getPhrase("lockdown_started"), "ScoreboardSubtitle", chbxX, chboxY + chatBoxSize, Color(cin * 255, 0, 255 - (cin * 255), 255), TEXT_ALIGN_LEFT)
	end
end

local Arrested = function() end

usermessage.Hook("GotArrested", function(msg)
	local StartArrested = CurTime()
	local ArrestedUntil = msg:ReadFloat()

	Arrested = function()
		if CurTime() - StartArrested <= ArrestedUntil and LocalPlayer():getDarkRPVar("Arrested") then
		draw.DrawNonParsedText(DarkRP.getPhrase("youre_arrested", math.ceil(ArrestedUntil - (CurTime() - StartArrested))), "DarkRPHUD1", ScrW()/2, ScrH() - ScrH()/12, colors.white, 1)
		elseif not LocalPlayer():getDarkRPVar("Arrested") then
			Arrested = function() end
		end
	end
end)

local AdminTell = function() end

usermessage.Hook("AdminTell", function(msg)
	timer.Destroy("DarkRP_AdminTell")
	local Message = msg:ReadString()

	AdminTell = function()
		draw.RoundedBox(4, 10, 10, ScrW() - 20, 100, Color(0, 0, 0, 200))
		draw.DrawNonParsedText(DarkRP.getPhrase("listen_up"), "GModToolName", ScrW() / 2 + 10, 10, Color(255, 255, 255, 255), 1)
		draw.DrawNonParsedText(Message, "ChatFont", ScrW() / 2 + 10, 80, Color(200, 30, 30, 255), 1)
	end

	timer.Create("DarkRP_AdminTell", 10, 1, function()
		AdminTell = function() end
	end)
end)

local function DrawPlayerInfo(ply)
	local pos = ply:EyePos()

	pos.z = pos.z + 10 -- The position we want is a bit above the position of the eyes
	pos = pos:ToScreen()
	pos.y = pos.y - 50 -- Move the text up a few pixels to compensate for the height of the text

	if GAMEMODE.Config.showname and not ply:getDarkRPVar("wanted") then
		draw.DrawNonParsedText(ply:Nick(), "DarkRPHUD2", pos.x + 1, pos.y + 1, Color(0,0,0,255), 1)
		draw.DrawNonParsedText(ply:Nick(), "DarkRPHUD2", pos.x, pos.y, team.GetColor(ply:Team()), 1)
	end

	if GAMEMODE.Config.showhealth and not ply:getDarkRPVar("wanted") then
		draw.DrawNonParsedText(DarkRP.getPhrase("health", ply:Health()), "DarkRPHUD2", pos.x + 1, pos.y + 21, Color(0,0,0,255), 1)
		draw.DrawNonParsedText(DarkRP.getPhrase("health", ply:Health()), "DarkRPHUD2", pos.x, pos.y + 20, Color(255,255,255,255), 1)
	end

	if GAMEMODE.Config.showjob then
		local teamname = team.GetName(ply:Team())
		draw.DrawNonParsedText(ply:getDarkRPVar("job") or teamname, "DarkRPHUD2", pos.x + 1, pos.y + 41, Color(0,0,0,255), 1)
		draw.DrawNonParsedText(ply:getDarkRPVar("job") or teamname, "DarkRPHUD2", pos.x, pos.y + 40, Color(255,255,255,255), 1)
	end

	if ply:getDarkRPVar("HasGunlicense") then
		surface.SetMaterial(Page)
		surface.SetDrawColor(255,255,255,255)
		surface.DrawTexturedRect(pos.x-16, pos.y + 60, 32, 32)
	end
end

local function DrawWantedInfo(ply)
	if not ply:Alive() then return end

	local pos = ply:EyePos()
	if not pos:isInSight({LocalPlayer(), ply}) then return end

	pos.z = pos.z + 14
	pos = pos:ToScreen()

	if GAMEMODE.Config.showname then
		draw.DrawNonParsedText(ply:Nick(), "DarkRPHUD2", pos.x + 1, pos.y + 1, Color(0,0,0,255), 1)
		draw.DrawNonParsedText(ply:Nick(), "DarkRPHUD2", pos.x, pos.y, team.GetColor(ply:Team()), 1)
	end

	local wantedText = DarkRP.getPhrase("wanted", tostring(ply:getDarkRPVar("wantedReason")))

	draw.DrawNonParsedText(wantedText, "DarkRPHUD2", pos.x, pos.y - 40, Color(0,0,0,255), 1)
	draw.DrawNonParsedText(wantedText, "DarkRPHUD2", pos.x + 1, pos.y - 41, Color(255,0,0,255), 1)
end


local function DrawEntityDisplay()
	local shootPos = LocalPlayer():GetShootPos()
	local aimVec = LocalPlayer():GetAimVector()

	for k, ply in pairs(players or player.GetAll()) do
		if not ply:Alive() or ply == LocalPlayer() then continue end
		local hisPos = ply:GetShootPos()
		if ply:getDarkRPVar("wanted") then DrawWantedInfo(ply) end

		if GAMEMODE.Config.globalshow then
			DrawPlayerInfo(ply)
		-- Draw when you're (almost) looking at him
		elseif not GAMEMODE.Config.globalshow and hisPos:DistToSqr(shootPos) < 160000 then
			local pos = hisPos - shootPos
			local unitPos = pos:GetNormalized()
			if unitPos:Dot(aimVec) > 0.95 then
				local trace = util.QuickTrace(shootPos, pos, LocalPlayer())
				if trace.Hit and trace.Entity ~= ply then return end
				DrawPlayerInfo(ply)
			end
		end
	end

	local tr = LocalPlayer():GetEyeTrace()

	if IsValid(tr.Entity) and tr.Entity:isKeysOwnable() and tr.Entity:GetPos():Distance(LocalPlayer():GetPos()) < 200 then
		tr.Entity:drawOwnableInfo()
	end
end

function GAMEMODE:DrawDeathNotice(x, y)
	if not GAMEMODE.Config.showdeaths then return end
	self.BaseClass:DrawDeathNotice(x, y)
end

local function DisplayNotify(msg)
	local txt = msg:ReadString()
	GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
	surface.PlaySound("buttons/lightswitch2.wav")

	-- Log to client console
	print(txt)
end
usermessage.Hook("_Notify", DisplayNotify)

function DisableDrawInfo()
	return false
end
hook.Add("HUDDrawTargetID", "DisableDrawInfo", DisableDrawInfo)










-- HUDPaint
local function DrawTCBHud()

	-- Custom
	Base()
	PlayerInfo()

	-- Elements
	ElementHealth()

	if HUDElements.Armor then
		ElementArmor()
	end

	if HUDElements.Hunger then
		ElementHunger()
	end

	if HUDElements.Stamina then
		ElementStamina()
	end

	-- Default
	Agenda()
	DrawVoiceChat()
	LockDown()
	
	Arrested()
	AdminTell()
	
	DrawEntityDisplay()

end
hook.Add("HUDPaint", "DrawTCBHud", DrawTCBHud)