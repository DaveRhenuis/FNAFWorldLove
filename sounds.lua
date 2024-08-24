--Here is all the sounds used ingame
sounds = {}
sounds["Titlescreen Theme"] = {}
sounds["Fazbear Hills"] = {}
sounds["Dusting Fields"] = {}
sounds["Circus"] = {}
sounds["Digital Circus"] = {}

sounds["SFX"] = {}

--dustingfieldsbattle, fazbearhillsbattle, titlescreentheme

--Main menu sounds
sounds["Titlescreen Theme"] = love.audio.newSource("sounds/titlescreentheme.mp3", "stream")
sounds["Titlescreen Theme"]:setLooping(true)

--Game Over
sounds["Underneath3"] = love.audio.newSource("sounds/underneath3.mp3", "stream")
sounds["Underneath3"]:setLooping(true)

--Fazbear hills sounds
sounds["Fazbear Hills"]["Overworld"] = love.audio.newSource("sounds/overworld1.mp3", "stream")
sounds["Fazbear Hills"]["Overworld"]:setLooping(true)
sounds["Fazbear Hills"]["Cutscene"] = love.audio.newSource("sounds/overworld1cutscene.mp3", "stream")
sounds["Fazbear Hills"]["Cutscene"]:setLooping(true)
sounds["Fazbear Hills"]["Battle"] = love.audio.newSource("sounds/fazbearhillsbattle.mp3", "stream")
sounds["Fazbear Hills"]["Battle"]:setLooping(true)

--Dusting Fields
sounds["Dusting Fields"]["Overworld"] = love.audio.newSource("sounds/icedungeon.mp3", "stream")
sounds["Dusting Fields"]["Overworld"]:setLooping(true)
sounds["Dusting Fields"]["Cutscene"] = love.audio.newSource("sounds/Himalayan Atmosphere.mp3", "stream")
sounds["Dusting Fields"]["Cutscene"]:setLooping(true)
sounds["Dusting Fields"]["Battle"] = love.audio.newSource("sounds/dustingfieldsbattle.mp3", "stream")
sounds["Dusting Fields"]["Battle"]:setLooping(true)

--Circus
sounds["Circus"] = love.audio.newSource("sounds/overworld2.mp3", "stream")
sounds["Circus"]:setLooping(true)

--SFX
sounds["SFX"]["Victory"] = love.audio.newSource("sounds/victory.mp3", "stream")
sounds["SFX"]["Victory"]:setLooping(true)
sounds["SFX"]["Yugiohp1"] = love.audio.newSource("sounds/yugiohp1.mp3", "static")
sounds["SFX"]["Yugiohp1"]:setLooping(true)
sounds["SFX"]["Yugiohp2"] = love.audio.newSource("sounds/yugiohp2.mp3", "static")
sounds["SFX"]["Yugiohp2"]:setLooping(false)
sounds["SFX"]["Yay"] = love.audio.newSource("sounds/yay.mp3", "static")
sounds["SFX"]["Yay"]:setLooping(false)
sounds["SFX"]["Abilities Menu Pop"] = love.audio.newSource("sounds/abilitiesmenupop.mp3", "static")
sounds["SFX"]["Abilities Menu Pop"]:setLooping(false)
sounds["SFX"]["New Challenger"] = love.audio.newSource("sounds/newchallenger.mp3", "static")
sounds["SFX"]["New Challenger"]:setLooping(false)
sounds["SFX"]["Death"] = love.audio.newSource("sounds/death.mp3", "static")
sounds["SFX"]["Death"]:setLooping(false)
sounds["SFX"]["Pizza Wheel"] = love.audio.newSource("sounds/pizzatime.mp3", "static")
sounds["SFX"]["Pizza Wheel"]:setLooping(false)
sounds["SFX"]["Bite"] = love.audio.newSource("sounds/bite1.mp3", "static")
sounds["SFX"]["Bite"]:setLooping(false)
sounds["SFX"]["enemyBite"] = love.audio.newSource("sounds/bite1.mp3", "static")
sounds["SFX"]["enemyBite"]:setLooping(false)

--Easter eggs
sounds["Digital Circus"]["Opening"] = love.audio.newSource("sounds/digitalcircusopen.mp3", "stream")
sounds["Digital Circus"]["Opening"]:setLooping(false)
sounds["Digital Circus"]["Loop"] = love.audio.newSource("sounds/digitalcircusloop.mp3", "stream")
sounds["Digital Circus"]["Loop"]:setLooping(true)

--Current background music initialization (will always loop)
sounds.currentBGM = sounds["Fazbear Hills"]["Overworld"]
sounds.currentBGM:setLooping(true)

