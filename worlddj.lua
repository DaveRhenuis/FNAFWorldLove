--Here is where we control what is played and when is played
canChangeMusic = 1

function worlddjUpdate(dt)
	
	if gameMode < 1 and canChangeMusic == 1 then
		--Stop all audio
		love.audio.stop()
		sounds["Titlescreen Theme"]:play()
		canChangeMusic = 0
	elseif gameMode == 1 and canChangeMusic == 1 then
		--Stop all audio
		love.audio.stop()
		sounds.currentBGM = sounds[player.currentzone]["Overworld"]
		sounds.currentBGM:play()
		canChangeMusic = 0
	elseif gameMode == 1.1 and canChangeMusic == 1 then
		love.audio.stop()
		sounds.currentBGM = sounds[player.currentzone]["Cutscene"]
		sounds.currentBGM:play()
		canChangeMusic = 0
	elseif gameMode == 2 and canChangeMusic == 1 then
		love.audio.stop()
		sounds.currentBGM = sounds[player.currentzone]["Battle"]
		sounds.currentBGM:play()
		canChangeMusic = 0
	elseif gameMode == 3 and canChangeMusic == 1 then
		love.audio.stop()
		sounds.currentBGM = sounds["Underneath3"]
		sounds.currentBGM:play()		
		canChangeMusic = 0
	end
end