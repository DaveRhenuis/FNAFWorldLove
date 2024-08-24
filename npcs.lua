npcs = {}

currentDialogIndex = 1
currentMaxDialogIndex = 3

oldManStory = 0
gameOversPlayer = 0

currentCutsceneNPC = {}
currentCutsceneNPC["Name"] = {} 
currentCutsceneNPC["Animation"] = {} 
currentCutsceneNPC["Sprite"] = {} 
currentCutsceneNPC["Background"] = {} 
currentCutsceneNPC["Story"] = {}

currentCutscenePartyMember = {}
currentCutscenePartyMember.id = "Freddy"
currentCutscenePartyMember.offsetX = 125
currentCutscenePartyMember.offsetY = 125

npcs["Fredbear"] = {}
npcs["Fredbear"]["PosX"] = 550
npcs["Fredbear"]["PosY"] = 300
npcs["Fredbear"] = world:newRectangleCollider(npcs["Fredbear"]["PosX"], npcs["Fredbear"]["PosY"], 
35, 60, {collision_class = 'NPC'})
npcs["Fredbear"]:setFixedRotation(true)
npcs["Fredbear"]:setType('static')
npcs["Fredbear"].id = "Fredbear"

npcs["Fredbear"]["Story"] = {}
--remember to put the name before the one that is talking!
npcs["Fredbear"]["Story"][1] = {"Fredbear: Hello, ANIMATRONIC! We are having trouble once again in Animatronica...",
"Fredbear: This time, it's Balloon Boy! I've suspected that he was acting weird lately... Doesn't even looks like the Balloon Boy I know!",
"Fredbear: He's been causing a lot of trouble lately, and some of us went missing... And I think he is potentially the one behind it.",
"Fredbear: I need your help to track him down, and to understand what is happening to Animatronica!", "Fredbear: Oh, and I almost forgot... To go to the next dialog, you can press either 'e' or 'return'.",
"Fredbear: And that's not all! You can get into some trouble instantly by pressing 'f', but first be sure to prepare yourself to a tough fight!",
"Fredbear: 'escape' can be use to go back some menus too! And to open the abilities menu during a fight, you can right click in any party member! But you need to have enough energy first, around 50% should be enough...", "Fredbear: And before I go, I must warn you something: don't try to use Bash Jam, Hot Cheese or Jumpscare! Those can completely destroy our world!",
"Fredbear: Have a nice look around, and don't forget to have fun! You can try to win using only Pizza Wheel to see how far you can go, haha!"}
npcs["Fredbear"]["Story"][1]["Animations"] = {"Idle", "Idle", "Idle", "Idle", "Idle", "Idle", "Idle", "Idle", "Idle"}
npcs["Fredbear"]["Story"][2] = {"Nothing to see here!", "..."}
npcs["Fredbear"]["Story"]["Progress"] = 1

npcs["Fredbear"]["Current Animation"] = animations["Actor"]["Fredbear"]["Idle"]

npcs["OldMan"] = {}
npcs["OldMan"].id = "OldMan"
npcs["OldMan"]["Story"] = {}
npcs["OldMan"]["Story"][1] = {"...", "Come and sit with me a while.", "Leave the demon to his demons.", "Rest your own soul.",
"There is nothing else."}
npcs["OldMan"]["Story"][2] = {"...", "Incompleteness is fascinating.", "It makes you wonder what It could have been.",
"Your world is broken."}
npcs["OldMan"]["Story"][3] = {"...", "Once, I've met someone like you.", "He tried to fix your world.",
"But he was alone.", "He fixed as much as he could.", "It wasn't enough, though."}
npcs["OldMan"]["Story"][4] = {"...", "So, you like Stories?", "Tell me one I've never heard before."}
npcs["OldMan"]["Story"][5] = {"..."}

function npcsUpdate(dt)
	for i, npc in pairs(npcs) do
		if not(npc.id == "OldMan") then
			npc["Current Animation"]:update(dt)
		end
	end
end	

function npcsDraw()
	for i, npc in pairs(npcs) do
		if not(npc.id == "OldMan") then
			npc["Current Animation"]:draw(sprites["Actor"][npc.id], npc.body:getX(), 
			npc.body:getY(), nil, 0.25, 0.25, 130, 170)
		end
	end
end

function playCutscene(npcname, animation, spritename, story, storyprogress)

	currentCutsceneNPC["Name"] = npcname
	--for test, delete later (change the npc overworld animation too)
	--npcs[npcname]["Current Animation"] = animation
	
	currentCutsceneNPC["Sprite"] = spritename
	currentCutsceneNPC["Animation"] = animation
	
	currentDialogIndex = 0
	currentMaxDialogIndex = #story[storyprogress]
	
	for i = 1, currentMaxDialogIndex do
		currentCutsceneNPC["Story"][i] = npcs[npcname]["Story"][storyprogress][i]:gsub("ANIMATRONIC", player.currentParty[1])
	end
	
	gameMode = 1.1
	canChangeMusic = 1
	
end

function cutsceneKeypressed(key)
	if gameMode == 1.1 then
		if key == "e" or key == "return" then
			if currentDialogIndex < currentMaxDialogIndex then
				currentDialogIndex = currentDialogIndex + 1
				currentCutsceneNPC["Animation"] = animations["Actor"][currentCutsceneNPC["Name"]][npcs[currentCutsceneNPC["Name"]]["Story"][npcs[currentCutsceneNPC["Name"]]["Story"]["Progress"]]["Animations"][currentDialogIndex]]
			else
				for i = 1, currentMaxDialogIndex do
					currentCutsceneNPC["Story"][i] = "Void"
				end
				gameMode = 1
				canChangeMusic = 1
			end
		end
	elseif gameMode == 3 then
		if key == "e" or key == "return" then
			if currentDialogIndex < currentMaxDialogIndex then
				currentDialogIndex = currentDialogIndex + 1
			else
				for i = 1, currentMaxDialogIndex do
					npcs["OldMan"]["Story"]["Current"] = "Void"
				end
				gameMode = 0
				canChangeMusic = 1
			end
		end
	end
end