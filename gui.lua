--The main menu screen type options
local menuOptions = {X = 0, Y = 0, W = love.graphics.getWidth(), H = love.graphics:getHeight()/1.02,
Border = 0, NoOutline = true, ConstrainPosition = true, AutoSizeWindow = false, AllowResize = false}

local DialogboxOptions = {X = (love.graphics.getWidth()/4), Y = (love.graphics:getHeight()/11), W = (love.graphics.getWidth()/2), 
H = (love.graphics:getHeight()/3), Border = 12, ConstrainPosition = true, AutoSizeWindow = false, AllowResize = false
}

local hudOptions = {X = 0 + (love.graphics.getWidth() * 0.02), Y = 0, W = love.graphics.getWidth(),
H = (love.graphics:getHeight()/1.02), Border = 0, NoOutline = true, ConstrainPosition = true, 
AutoSizeWindow = false, AllowResize = false}

local PartySelectOptions = {X = (love.graphics.getWidth()/30), Y = (love.graphics:getHeight()/20), W = (love.graphics.getWidth() * 0.60), 
H = (love.graphics:getHeight() * 0.7), Border = 8, ConstrainPosition = true, AutoSizeWindow = false, AllowResize = false
}

local currentPartyselectedOptions = {X = (love.graphics.getWidth()/30), Y = (love.graphics:getHeight()* 0.78), W = (love.graphics.getWidth() * 0.60), 
H = (love.graphics.getHeight() * 0.16), Border = 8, ConstrainPosition = true, AutoSizeWindow = false, AllowResize = false}

--text options
local TitleLayoutOptions = {AlignX = 'center', AlignY = 'bottom'}
local TitleLettersLayoutOptions = {AlignX = 'left', AnchorX = true, AlignY = 'bottom'}
local TitleMainMenuOptions = {AlignX = 'center', AlignY = 'center', AlignRowY = 'top'}

local HudGUILayout = {AlignX = 'left', AnchorX = true, AlignY = 'bottom'}

local DialogboxLayout = {AnchorX = true}

local PartyselectLayout = {AnchorX = true}

local Style = slab.GetStyle()
LcdSolid = {}
LcdSolid["013"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/LcdSolid.ttf', 
love.graphics.getWidth() * 0.013)
LcdSolid["014"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/LcdSolid.ttf', 
love.graphics.getWidth() * 0.014)
LcdSolid["017"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/LcdSolid.ttf', 
love.graphics.getWidth() * 0.017)
LcdSolid["02"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/LcdSolid.ttf', 
love.graphics.getWidth() * 0.02)
LcdSolid["025"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/LcdSolid.ttf', 
love.graphics.getWidth() * 0.025)
LcdSolid["05"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/LcdSolid.ttf', 
love.graphics.getWidth() * 0.05)
LcdSolid["07"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/LcdSolid.ttf', 
love.graphics.getWidth() * 0.07)

SegoeUI = {}

SegoeUI["017"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/Segoe UI Bold.ttf', 
love.graphics.getWidth() * 0.017)
SegoeUI["03"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/Segoe UI Bold.ttf', 
love.graphics.getWidth() * 0.03)


Verdana = {}

Verdana["017"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/verdana.ttf', 
love.graphics.getWidth() * 0.017)
Verdana["02"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/verdana.ttf', 
love.graphics.getWidth() * 0.02)
Verdana["03"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/verdana.ttf', 
love.graphics.getWidth() * 0.03)

TimesNewRoman = {}

TimesNewRoman["017"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/times new roman.ttf', 
love.graphics.getWidth() * 0.017)
TimesNewRoman["02"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/times new roman.ttf', 
love.graphics.getWidth() * 0.02)
TimesNewRoman["03"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/times new roman.ttf', 
love.graphics.getWidth() * 0.03)

ArialBold = {}

ArialBold["017"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/ArialBold.ttf', 
love.graphics.getWidth() * 0.017)
ArialBold["02"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/ArialBold.ttf', 
love.graphics.getWidth() * 0.02)
ArialBold["035"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/ArialBold.ttf', 
love.graphics.getWidth() * 0.035)
ArialBold["05"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/ArialBold.ttf', 
love.graphics.getWidth() * 0.05)
ArialBold["07"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/ArialBold.ttf', 
love.graphics.getWidth() * 0.07)

SansationBold = {}
SansationBold["035"] = love.graphics.newFont('libraries/Slab-master/Internal/Resources/Fonts/Sansation_Bold.ttf', 
love.graphics.getWidth() * 0.035)

local buttons = {}
buttons.starttitle = false
buttons.newgame = false
buttons.loadgame = false
buttons.achievements = false
buttons.options = false
buttons.exit = false
buttons.party = false
buttons.chips = false
buttons.bytes = false
buttons.save = false

currentSelectedChar = "Freddy"

function mainMenuGUI(dt)
	if gameMode == 0 then
		animations["Fnaftitle"]:update(dt)
		--title layout and options
		slab.BeginWindow('MainMenu', menuOptions)
		--setting the style of the menu
		Style.API.SetStyle("mainmenu")
		--we don't want any scrolling!======
		slab.SetScrollSpeed(0)
		
		--style of the font used for the title
		Style.API.PushFont(ArialBold["05"])
		slab.BeginLayout('TitleLayout', TitleLayoutOptions)
		
		--actual title content
		if slab.Button("START!") then
			gameMode = 0.1
		end
		slab.EndLayout()
		
		slab.SameLine({Pad = ((love.graphics.getWidth() * 0.58) * -1)})
		
		--change the font
		Style.API.PopFont()
		Style.API.PushFont(Verdana["02"])
		
		--other fonts used
		slab.BeginLayout('TitleLettersLayout', TitleLettersLayoutOptions)
		--slab.Text("")
		slab.Text("V1.65")
		slab.SameLine({Pad = ((love.graphics.getWidth() * 0.65))})
		Style.API.PopFont()
		Style.API.PushFont(Verdana["017"])
		slab.Text("FNAFLove by Dave Rhenuis")
		--slab.SameLine({Pad = ((love.graphics.getWidth()/1.60) * -1)})
		Style.API.PopFont()
		Style.API.PushFont(Verdana["02"])
		slab.Text("Update 1")
		slab.SameLine({Pad = ((love.graphics.getWidth() * 0.60))})
		Style.API.PopFont()
		Style.API.PushFont(Verdana["017"])
		slab.Text("FNAF World © Scott Cawthon")
		
		slab.EndLayout()
		Style.API.PopFont()
		
		slab.EndWindow()
	elseif gameMode == 0.1 then
		--title layout and options
		slab.BeginWindow('MainMenuOptions', menuOptions)
		--setting the style of the menu
		Style.API.SetStyle("mainmenu")
		--we don't want any scrolling!======
		slab.SetScrollSpeed(0)
		
		--style and font used in the layout
		Style.API.PushFont(ArialBold["035"])
		slab.BeginLayout('MainMenuOptionsLayout', TitleMainMenuOptions)
		if slab.Button("NEW GAME") then
			gameMode = 1
			canChangeMusic = 1
		end
		if slab.Button("LOAD GAME") then
			buttons.newgame = true
		end
		if slab.Button("ACHIEVEMENTS") then
			buttons.achievements = true
		end
		if slab.Button("OPTIONS") then
			buttons.options = true
		end
		if slab.Button("EXIT") then
			buttons.exit = true
		end
		--remember to pop everything out of the stack!
		slab.EndLayout()
		Style.API.PopFont()
		
		slab.EndWindow()
	end
end

function cutscenesGUI(dt)
	if gameMode == 1.1 then
		currentCutsceneNPC["Animation"]:update(dt)
		if not(player.currentParty[1] == currentCutsceneNPC["Name"]) then 
			animations["Actor"][player.currentParty[1]]["Idle"]:update(dt)
		elseif not(currentCutsceneNPC["Animation"] == animations["Actor"][player.currentParty[1]]["Idle"]) then
			animations["Actor"][player.currentParty[1]]["Idle"]:update(dt)
		end
		slab.BeginWindow('DialogBox', DialogboxOptions)
		Style.API.SetStyle("Dark")
		Style.API.PushFont(Verdana["017"])
		slab.BeginLayout('DialogBox', DialogboxLayout)
		if currentDialogIndex <= currentMaxDialogIndex then
			slab.Textf((currentCutsceneNPC["Story"][currentDialogIndex]),
			{Align = "left"})
		end
		slab.EndLayout()
		Style.API.PopFont()
		slab.EndWindow()
	elseif gameMode == 3 then
		slab.BeginWindow('DialogBox', DialogboxOptions)
		Style.API.SetStyle("Dark")
		Style.API.PushFont(Verdana["017"])
		slab.BeginLayout('DialogBox', DialogboxLayout)
		if currentDialogIndex <= currentMaxDialogIndex then
			slab.Textf((npcs["OldMan"]["Story"][oldManStory][currentDialogIndex]),
			{Align = "left"})
		end
		slab.EndLayout()
		Style.API.PopFont()
		slab.EndWindow()
	end
end

function hudOverworld(dt)
	--hud overworld
	if gameMode == 1 then
		slab.BeginWindow('hudOverworld', hudOptions)
		Style.API.SetStyle("hudGUI")
		slab.SetScrollSpeed(0)
		Style.API.PushFont(LcdSolid["02"])
		slab.BeginLayout('hudGUILayout', HudGUILayout)
		
		if slab.Button("PARTY") then
			gameMode = 1.01
		end
		
		slab.SameLine()
		if slab.Button("CHIPS") then
			buttons.chips = true
		end
		
		slab.SameLine()
		if slab.Button("BYTES") then
			buttons.bytes = true
		end
		
		slab.SameLine()
		if slab.Button("SAVE") then
			buttons.save = true
		end
		
		slab.EndLayout()
		Style.API.PopFont()
		slab.EndWindow()
	end
	
	--partyselect hud
	if gameMode == 1.01 then
		slab.BeginWindow('partySelect', PartySelectOptions)
		slab.BeginLayout('partySelectLayout', PartyselectLayout)
		Style.API.SetStyle("partyselect")
		
		local count = 0
		
		for i, obj in ipairs(sprites["Images"]) do 
			local halfAlpha = {1.0, 1.0, 1.0, 0.5}
			local normalAlpha = {1.0, 1.0, 1.0, 1.0}
			
			--if the current character is not in the roster avalible, then
			if not isInRoster(obj.id) then
				slab.Image(obj.id, {Image = obj["Icon"], Color = halfAlpha})
				slab.SameLine()
				count = count + 1
			else
				--if it is in the roster avalible
				slab.Image(obj.id, {Image = obj["Icon"], Color = normalAlpha})
				--don't use IsMouseClicked!!!!
				if slab.IsControlClicked() then
					if isInParty(obj.id) then
						kickFromParty(obj.id)
					else
						addToParty(obj.id)
					end
				end
				slab.SameLine()
				count = count + 1
			end
			if (count/((love.graphics.getWidth()/100) - 3)) >= 1 then
				slab.NewLine(1)
				count = 0
			end

		end
		
		slab.EndLayout()
		slab.EndWindow()
		
		--little window that do nothing
		slab.BeginWindow('currentPartyselected', currentPartyselectedOptions)
		Style.API.SetStyle("partyselect")
		slab.EndWindow()
		animations["Team Slot"]:update(dt)
	end
end

function partyselectGUIdrawable()

	local index = 1
	love.graphics.setFont(LcdSolid["017"])
	love.graphics.print("Current party", (love.graphics.getWidth() * 0.013) + (40 * scale["Icons"]["X"]), (love.graphics:getHeight() * 0.79))
	--put animations for the last selected character here
	for i, obj in ipairs(sprites["Images"]) do
		
		if isInParty(obj.id) then
			index = getPartyIndex(obj.id)
			love.graphics.draw(sprites["Images"][i]["Icon"], (love.graphics.getWidth() * 0.013) + ((75 * scale["Icons"]["X"]) * index), 
			(love.graphics:getHeight() * 0.88), 0, scale["Icons"]["X"], scale["Icons"]["Y"], 35, 40)
		end
		
	end
	for j = 1, 4 do
		animations["Team Slot"]:draw(sprites["Team Slot"], (love.graphics.getWidth() * 0.013) + ((75 * scale["Icons"]["X"]) * j), 
		(love.graphics:getHeight() * 0.88), 0, scale["Icons"]["X"], scale["Icons"]["Y"], 35, 40)
		love.graphics.setFont(LcdSolid["02"])
		love.graphics.print(j, (love.graphics.getWidth() * 0.013) + ((75 * scale["Icons"]["X"]) * j), 
		(love.graphics:getHeight() * 0.88), 0, scale["Icons"]["X"], scale["Icons"]["Y"], 27, 37)
	end

	--for debugging
	love.graphics.print(player.currentParty[1], 500, 500)
	love.graphics.print(player.currentParty[2], 600, 500)
	love.graphics.print(player.currentParty[3], 700, 500)
	love.graphics.print(player.currentParty[4], 800, 500)

end

function cutscenesGUIdrawables()
	if gameMode == 1.1 then
		love.graphics.draw(sprites["Background"][player.currentzone], 0, 0, 0, 
		scale["Background"]["X"], scale["Background"]["Y"])

		currentCutsceneNPC["Animation"]:draw(currentCutsceneNPC["Sprite"], (love.graphics.getWidth() * 0.18), 
		(love.graphics:getHeight() * 0.71), 0, (scale["Actors"]["X"] * -1), scale["Actors"]["Y"], actors[currentCutsceneNPC["Name"]].offsetX, actors[currentCutsceneNPC["Name"]].offsetY)
		
		--remember to be the slot1 of the party member for cutscenes
		animations["Actor"][player.currentParty[1]]["Idle"]:draw(sprites["Actor"][player.currentParty[1]], (love.graphics.getWidth() * 0.83), 
		(love.graphics:getHeight() * 0.71), 0, scale["Actors"]["X"], scale["Actors"]["Y"], actors[player.currentParty[1]].offsetX, actors[player.currentParty[1]].offsetY)
	elseif gameMode == 3 then
		love.graphics.draw(sprites["Background"]["Lake"], (love.graphics.getWidth() * 0.2), (love.graphics:getHeight() * 0.73), 0,
		scale["Actors"]["X"], scale["Actors"]["Y"], (love.graphics.getWidth() * 0.06) * -1, (love.graphics.getHeight() * 0.03))
		love.graphics.draw(sprites["Actor"]["OldMan"], (love.graphics.getWidth() * 0.18), (love.graphics:getHeight() * 0.71), 0,
		scale["Actors"]["X"], scale["Actors"]["Y"], 0, (love.graphics.getHeight() * 0.1))
	end
end

function isInRoster(name)
	local isInRoster = false
	for i = 1, #player.currentRoster do
		if player.currentRoster[i] == name then
			isInRoster = true
		end
	end
	return isInRoster
end

function isInParty(name)
	for i = 1, 4 do
		if player.currentParty[i] == name then
			return true
		end
	end
	return false
end

function kickFromParty(name)
	for i = 1, 4 do
		if player.currentParty[i] == name then
			player.currentParty[i] = "Void"
			return
		end
	end
end

function addToParty(name)
	for i = 1, 4 do
		if player.currentParty[i] == "Void" then
			player.currentParty[i] = name
			return
		end
	end
end

function getPartyIndex(name)
	for i = 1, 4 do
		if player.currentParty[i] == name then
			return i
		end
	end
	return
end