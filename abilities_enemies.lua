enemyabilities = {}

enemyabilities["enemyBite"] = {}
enemyabilities["enemyBite"].id = "enemyBite"
enemyabilities["enemyBite"].atype = "Attack"
enemyabilities["enemyBite"].isAOE = false
enemyabilities["enemyBite"].requireTarget = true
enemyabilities["enemyBite"].hasSFX = false
enemyabilities["enemyBite"].range = {1, 2, 3, 4}
function enemyBitesYou(enemy, ally)
	bite = worldBattle:newRectangleCollider(ally.body:getX() - 20, ally.body:getY() - 20, (love.graphics.getHeight() * 0.1), (love.graphics.getHeight() * 0.1), {collision_class = 'Enemy_attack'})
	bite.atktype = "target"
	bite.atkname = "enemyBite"
	bite.animation = animations["Attacks"]["enemyBite"]
	bite.depthY = bite.body:getY()
	--this is the actual offset:
	bite.width = 130 * scale["Attacks"]["enemyBite"]["X"]
	bite.height = 130 * scale["Attacks"]["enemyBite"]["Y"]
	--xD
	bite.damage = enemy.adamage + math.random(-3, 5)
	bite.timer = 0.25
	bite.target = ally.index
	bite.sound = sounds["SFX"]["enemyBite"]
	bite.animation:gotoFrame(1)
	table.insert(attacks["Enemy"][enemy.index], bite)
end
function enemyBitesYouDamageScript(ally, bite)
	bite.sound:stop()
	bite.sound:play()
	ally.currentHealth = ally.currentHealth - bite.damage
	createDamageIndicator(bite.damage, ally)
	createHitIndicator(ally)
	checkIfIsDead(ally)
	shakeScreenFunction(0.1)
	hitOrangeOverlayFunction(0.2)
end
enemyabilities["enemyBite"].script = enemyBitesYou
enemyabilities["enemyBite"].damageScript = enemyBitesYouDamageScript
enemyabilities["enemyBite"].abilityCost = 100

enemyabilities["enemySwipe"] = {}
enemyabilities["enemySwipe"].id = "enemySwipe"
enemyabilities["enemySwipe"].atype = "Attack"
enemyabilities["enemySwipe"].isAOE = false
enemyabilities["enemySwipe"].requireTarget = true
enemyabilities["enemySwipe"].hasSFX = false
