--all sprites
sprites = {}
sprites["Titlescreen"] = {}
sprites["Background"] = {}

--Background sprites
--Titlescreen
sprites["Titlescreen"]["Background"] = love.graphics.newImage("sprites/Titlescreen_images/background_titlescreen.png")
sprites["Titlescreen"]["Animatronics"] = love.graphics.newImage("sprites/Titlescreen_images/animatronics_titlescreen.png")
sprites["Titlescreen"]["Fnaftitle"] = love.graphics.newImage("sprites/Titlescreen_images/fnafworldtitlesheet.png")
sprites["Titlescreen"]["Secondmenutitlebg"] = love.graphics.newImage("sprites/Titlescreen_images/secondmenutitlebg.png")
--Battleground background zones
sprites["Background"]["Lake"] = love.graphics.newImage("sprites/Backgrounds/lake.png")
sprites["Background"]["Fazbear Hills"] = sprites["Titlescreen"]["Secondmenutitlebg"]
sprites["Background"]["Dusting Fields"] = love.graphics.newImage("sprites/Backgrounds/dustingfields.png")
sprites["Background"]["Lilygear Lake"] = love.graphics.newImage("sprites/Backgrounds/lilygearlake.png")

--Scaling for sprites based on window dimensions
scale = {}
scale["Battle"] = {}
scale["Background"] = {}
scale["Icons"] = {}
scale["Actors"] = {}
scale["Actors"]["Battle"] = {}
scale["Attacks"] = {}
scale["Attacks"]["Pizza Wheel"] = {}
scale["Attacks"]["Bite"] = {}
scale["Attacks"]["enemyBite"] = {}

--remember to scale according to screen!
scale["Battle"]["X"] = 1
scale["Battle"]["Y"] = 1	
scale["Background"]["X"] = love.graphics.getWidth()/sprites["Titlescreen"]["Background"]:getWidth()
scale["Background"]["Y"] = love.graphics.getHeight()/sprites["Titlescreen"]["Background"]:getHeight()
scale["Actors"]["X"] = love.graphics.getWidth()/960
scale["Actors"]["Y"] = love.graphics.getHeight()/540
scale["Actors"]["Battle"]["X"] = love.graphics.getWidth()/1280
scale["Actors"]["Battle"]["Y"] = love.graphics.getHeight()/720
scale["Icons"]["X"] = love.graphics.getWidth()/1280
scale["Icons"]["Y"] = love.graphics.getHeight()/720
scale["Attacks"]["Pizza Wheel"]["X"] = love.graphics.getWidth()/1600
scale["Attacks"]["Pizza Wheel"]["Y"] = love.graphics.getHeight()/900
scale["Attacks"]["Bite"]["X"] = love.graphics.getWidth()/1600
scale["Attacks"]["Bite"]["Y"] = love.graphics.getHeight()/900
scale["Attacks"]["enemyBite"]["X"] = love.graphics.getWidth()/1600
scale["Attacks"]["enemyBite"]["Y"] = love.graphics.getHeight()/900

--Player overworld sprites
sprites["Player"] = love.graphics.newImage('sprites/Player_overworld/player_overworld_freddySheet.png')

--Characters actors sprites
sprites["Actor"] = {}
sprites["Actor"]["Void"] = love.graphics.newImage('sprites/Characters_used/void.png')
sprites["Actor"]["RIP"] = love.graphics.newImage('sprites/Characters_used/rip.png')
sprites["Actor"]["OldMan"] = love.graphics.newImage('sprites/Characters_used/oldman.png')
sprites["Actor"]["Fredbear"] = love.graphics.newImage('sprites/Characters_used/fredbearSheet.png')
sprites["Actor"]["Freddy"] = love.graphics.newImage('sprites/Characters_used/freddySheet.png')
sprites["Actor"]["Bonnie"] = love.graphics.newImage('sprites/Characters_used/bonnieSheet.png')
sprites["Actor"]["Chica"] = love.graphics.newImage('sprites/Characters_used/chicaSheet.png')
sprites["Actor"]["Foxy"] = love.graphics.newImage('sprites/Characters_used/foxySheet.png')

--IMAGES (ICONS) CHAR SELECT
sprites["Images"] = {}

characterSelectNames = {"Freddy", "Bonnie", "Chica", "Foxy", "Golden Freddy", "Toy Freddy", "Toy Bonnie", 
"Toy Chica", "Mangle", "Puppet", "Fredbear", "Spring Bonnie", "Springtrap"}
characterSelectNamesLowcase = {"freddy", "bonnie", "chica", "foxy", "goldenfreddy", "toyfreddy", "toybonnie", 
"toychica", "mangle", "puppet", "fredbear", "springbonnie", "springtrap"}

local qntNames = #characterSelectNames

for i = 1, qntNames do
	sprites["Images"][i] = {}
	sprites["Images"][i].id = characterSelectNames[i]
	sprites["Images"][i]["Icon"] = love.graphics.newImage('sprites/Partyselect/' .. characterSelectNamesLowcase[i] .. '.png')
end

sprites["Team Slot"] = love.graphics.newImage('sprites/Partyselect/selectSheet.png')
sprites["Selected"] = love.graphics.newImage('sprites/Partyselect/selected.png')

sprites["Attacks"] = {}
sprites["Buttons"] = {}
sprites["SFX"] = {}

sprites["Attacks"]["Pizza Wheel"] = love.graphics.newImage("sprites/Attacks/pizzatime.png")
sprites["Attacks"]["Bite"] = love.graphics.newImage("sprites/Attacks/bite.png")
sprites["Attacks"]["enemyBite"] = love.graphics.newImage("sprites/Attacks/bite.png")

sprites["Buttons"]["Transparent Body"] = love.graphics.newImage("sprites/Buttons/buttontransparentbody.png")
sprites["Buttons"]["Type Mask"] = love.graphics.newImage("sprites/Buttons/colorbutton.png")
sprites["Buttons"]["Unused Button"] = love.graphics.newImage("sprites/Buttons/unusedbuttondisappear.png")
sprites["Buttons"]["Used Button"] = love.graphics.newImage("sprites/Buttons/usedbuttondisappear.png")

sprites["SFX"]["Cursor"] = love.graphics.newImage("sprites/Special_effects/cursor.png")
sprites["SFX"]["Victory"] = love.graphics.newImage("sprites/Special_effects/victory.png")
sprites["SFX"]["Level Up"] = love.graphics.newImage("sprites/Special_effects/levelup.png")
sprites["SFX"]["Star Trail"] = love.graphics.newImage("sprites/Special_effects/trailstareffect.png")
sprites["SFX"]["Damaged Entity"] = love.graphics.newImage("sprites/Special_effects/damageeffect.png")
sprites["SFX"]["Death"] = love.graphics.newImage("sprites/Special_effects/deatheffect.png")
sprites["SFX"]["Hit Orange Overlay"] = love.graphics.newImage("sprites/Special_effects/hitorangeoverlay.png")

--Grids for the animations
grids = {}
grids["Actor"] = {}
grids["Attacks"] = {}
grids["Buttons"] = {}
grids["SFX"] = {}

--Titlescreen fnaf title
grids["Fnaftitle"] = anim8.newGrid(650, 127, sprites["Titlescreen"]["Fnaftitle"]:getWidth(), 
sprites["Titlescreen"]["Fnaftitle"]:getHeight())

--Partyselect
grids["Team Slot"] = anim8.newGrid(70, 70, sprites["Team Slot"]:getWidth(), sprites["Team Slot"]:getHeight())

--battle Buttons
grids["Buttons"]["Transparent Body"] = anim8.newGrid(214, 50, sprites["Buttons"]["Transparent Body"]:getWidth(),
sprites["Buttons"]["Transparent Body"]:getHeight())
grids["Buttons"]["Type Mask"] = anim8.newGrid(214, 50, sprites["Buttons"]["Type Mask"]:getWidth(),
sprites["Buttons"]["Type Mask"]:getHeight())
grids["Buttons"]["Unused Button"] = anim8.newGrid(214, 50, sprites["Buttons"]["Unused Button"]:getWidth(),
sprites["Buttons"]["Unused Button"]:getHeight())
grids["Buttons"]["Used Button"] = anim8.newGrid(343, 80, sprites["Buttons"]["Used Button"]:getWidth(),
sprites["Buttons"]["Used Button"]:getHeight())

--Player overworld grids
grids["Player"] = anim8.newGrid(60, 60, sprites["Player"]:getWidth(), 
sprites["Player"]:getHeight())

--Characters actors grids
grids["Actor"]["Fredbear"] = anim8.newGrid(250, 300, sprites["Actor"]["Fredbear"]:getWidth(),
sprites["Actor"]["Fredbear"]:getHeight())
grids["Actor"]["Freddy"] =  anim8.newGrid(250, 250, sprites["Actor"]["Freddy"]:getWidth(),
sprites["Actor"]["Freddy"]:getHeight())
grids["Actor"]["Bonnie"] =  anim8.newGrid(250, 250, sprites["Actor"]["Bonnie"]:getWidth(),
sprites["Actor"]["Bonnie"]:getHeight())
grids["Actor"]["Chica"] = anim8.newGrid(250, 250, sprites["Actor"]["Chica"]:getWidth(),
sprites["Actor"]["Chica"]:getHeight())
grids["Actor"]["Foxy"] = anim8.newGrid(250, 250, sprites["Actor"]["Foxy"]:getWidth(),
sprites["Actor"]["Foxy"]:getHeight())

grids["Actor"]["Void"] = anim8.newGrid(250, 250, sprites["Actor"]["Void"]:getWidth(),
sprites["Actor"]["Void"]:getHeight())
grids["Actor"]["RIP"] = anim8.newGrid(112, 140, sprites["Actor"]["RIP"]:getWidth(),
sprites["Actor"]["RIP"]:getHeight())


grids["Attacks"]["Pizza Wheel"] = anim8.newGrid(150, 150, sprites["Attacks"]["Pizza Wheel"]:getWidth(),
sprites["Attacks"]["Pizza Wheel"]:getHeight())
grids["Attacks"]["Bite"] = anim8.newGrid(169, 169, sprites["Attacks"]["Bite"]:getWidth(),
sprites["Attacks"]["Bite"]:getHeight())
grids["Attacks"]["enemyBite"] = anim8.newGrid(169, 169, sprites["Attacks"]["enemyBite"]:getWidth(),
sprites["Attacks"]["enemyBite"]:getHeight())

grids["SFX"]["Victory"] = anim8.newGrid(250, 250, sprites["SFX"]["Victory"]:getWidth(),
sprites["SFX"]["Victory"]:getHeight())
grids["SFX"]["Level Up"] = anim8.newGrid(250, 75, sprites["SFX"]["Level Up"]:getWidth(),
sprites["SFX"]["Level Up"]:getHeight())

grids["SFX"]["Star Trail"] = anim8.newGrid(150, 75, sprites["SFX"]["Star Trail"]:getWidth(),
sprites["SFX"]["Star Trail"]:getHeight())
grids["SFX"]["Damaged Entity"] = anim8.newGrid(150, 150, sprites["SFX"]["Damaged Entity"]:getWidth(),
sprites["SFX"]["Damaged Entity"]:getHeight())
grids["SFX"]["Death"] = anim8.newGrid(300, 300, sprites["SFX"]["Death"]:getWidth(), sprites["SFX"]["Death"]:getHeight())

--All animations
animations = {}
animations["Player"] = {}
animations["Player"]["Idle"] = {}
animations["Player"]["Running"] = {}
--player overworld animations
animations["Player"]["Idle"]["Up"] = anim8.newAnimation(grids["Player"]('3-3', 1), 0.05)
animations["Player"]["Idle"]["Right"] = anim8.newAnimation(grids["Player"]('3-3', 3), 0.05)
animations["Player"]["Idle"]["Down"] = anim8.newAnimation(grids["Player"]('3-3', 4), 0.05)
animations["Player"]["Idle"]["Left"] = anim8.newAnimation(grids["Player"]('3-3', 2), 0.05)
animations["Player"]["Running"]["Up"] = anim8.newAnimation(grids["Player"]('1-15', 1), 0.05)
animations["Player"]["Running"]["Right"] = anim8.newAnimation(grids["Player"]('1-15', 3), 0.05)
animations["Player"]["Running"]["Down"] = anim8.newAnimation(grids["Player"]('1-15', 4), 0.05)
animations["Player"]["Running"]["Left"] = anim8.newAnimation(grids["Player"]('1-15', 2), 0.05)

--titlescreen animations
--title
animations["Fnaftitle"] = anim8.newAnimation(grids["Fnaftitle"]('1-3', 1), 0.15)

--Partyselect
animations["Team Slot"] = anim8.newAnimation(grids["Team Slot"]('1-11', 1), 0.05)

--buttons Battle
animations["Buttons"] = {}

animations["Buttons"]["Transparent Body"] = anim8.newAnimation(grids["Buttons"]["Transparent Body"]('1-12', 1), 0.05)
animations["Buttons"]["Type Mask"] = anim8.newAnimation(grids["Buttons"]["Type Mask"]('1-12', 1), 0.05)
animations["Buttons"]["Unused Button"] = anim8.newAnimation(grids["Buttons"]["Unused Button"]('1-10', 1), 0.03, 'pauseAtEnd')
animations["Buttons"]["Used Button"] = anim8.newAnimation(grids["Buttons"]["Used Button"]('1-12', 1), 0.028, 'pauseAtEnd')

--TESTING=====================================================================
--REMEMBER TO GET THE TIMER RIGHT! TIMER = TOTAL FRAME TIME - 2
animations["Actor"] = {}
animations["Actor"]["Void"] = {}
animations["Actor"]["RIP"] = {}
animations["Actor"]["Fredbear"] = {}
animations["Actor"]["Freddy"] = {}
animations["Actor"]["Bonnie"] = {}
animations["Actor"]["Chica"] = {}
animations["Actor"]["Foxy"] = {}

animations["Actor"]["Void"]["Idle"] = anim8.newAnimation(grids["Actor"]["Void"]('1-1', 1), 0.05)
animations["Actor"]["RIP"]["Idle"] = anim8.newAnimation(grids["Actor"]["RIP"]('1-1', 1), 0.05)

--Characters actors animations
--Fredbear
animations["Actor"]["Fredbear"]["Idle"] = anim8.newAnimation(grids["Actor"]["Fredbear"]('1-9', 3), 0.05)
animations["Actor"]["Fredbear"]["Attack"] = anim8.newAnimation(grids["Actor"]["Fredbear"]('1-17', 2), 0.04)
animations["Actor"]["Fredbear"]["Glitch"] = anim8.newAnimation(grids["Actor"]["Fredbear"]('1-4', 1), 0.04)

--Freddy
animations["Actor"]["Freddy"]["Idle"] = anim8.newAnimation(grids["Actor"]["Freddy"]('1-10', 1), 0.05)
animations["Actor"]["Freddy"]["Attack"] = anim8.newAnimation(grids["Actor"]["Freddy"]('1-11', 2, '10-1', 2), 0.04)

--Bonnie
animations["Actor"]["Bonnie"]["Idle"] = anim8.newAnimation(grids["Actor"]["Bonnie"]('1-10', 2), 0.05)
animations["Actor"]["Bonnie"]["Attack"] = anim8.newAnimation(grids["Actor"]["Bonnie"]('1-16', 1), 0.04)

--Chica
animations["Actor"]["Chica"]["Idle"] = anim8.newAnimation(grids["Actor"]["Chica"]('1-11', 1), 0.05)
animations["Actor"]["Chica"]["Attack"] = anim8.newAnimation(grids["Actor"]["Chica"]('1-19', 2), 0.04)

--Foxy
animations["Actor"]["Foxy"]["Idle"] = anim8.newAnimation(grids["Actor"]["Foxy"]('1-10', 1), 0.05)
animations["Actor"]["Foxy"]["Attack"] = anim8.newAnimation(grids["Actor"]["Foxy"]('1-19', 2), 0.04)

-- attacks animations
animations["Attacks"] = {}
animations["Attacks"]["Pizza Wheel"] = anim8.newAnimation(grids["Attacks"]["Pizza Wheel"]('1-6', 1), 0.02)
animations["Attacks"]["Bite"] = anim8.newAnimation(grids["Attacks"]["Bite"]('1-9', 1), 0.03)
animations["Attacks"]["enemyBite"] = anim8.newAnimation(grids["Attacks"]["enemyBite"]('1-9', 1), 0.03)

--sfx animations
animations["SFX"] = {}
animations["SFX"]["Victory"] = anim8.newAnimation(grids["SFX"]["Victory"]('1-12', 1), 0.03)
animations["SFX"]["Level Up"] = anim8.newAnimation(grids["SFX"]["Level Up"]('1-12', 1), 0.03)
animations["SFX"]["Star Trail"] = anim8.newAnimation(grids["SFX"]["Star Trail"]('1-5', 1), 0.05)
animations["SFX"]["Damaged Entity"] = anim8.newAnimation(grids["SFX"]["Damaged Entity"]('1-9', 1), 0.03, 'pauseAtEnd')
animations["SFX"]["Death"] = anim8.newAnimation(grids["SFX"]["Death"]('1-7', 1), 0.05, 'pauseAtEnd')