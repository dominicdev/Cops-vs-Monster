local spritefactory = {}
local sprite = require "sprite";

local car = sprite.newSpriteSheet("spritesheets/car.png",180,81)
spritefactory.spritecar = sprite.newSpriteSet(car, 1, 12)
sprite.add(spritefactory.spritecar, "car1", 1, 3, 600, -0)
sprite.add(spritefactory.spritecar, "car2", 4, 3, 600, -0)
sprite.add(spritefactory.spritecar, "car3", 7, 3, 600, -0)
sprite.add(spritefactory.spritecar, "car4", 10, 3, 600, -0)

local deadmob = sprite.newSpriteSheet("spritesheets/deadalien.png", 100, 80)
spritefactory.spritedeadmob = sprite.newSpriteSet(deadmob, 1, 18)
sprite.add(spritefactory.spritedeadmob, "dead_1", 1, 6, 400, 1)
sprite.add(spritefactory.spritedeadmob, "dead_2", 7, 6, 400, 1)
sprite.add(spritefactory.spritedeadmob, "dead_3", 13, 6, 400, 1)

spritefactory.spritedeadmob_ = sprite.newSpriteSet(deadmob, 1, 18)
sprite.add(spritefactory.spritedeadmob_, "dead_1", 1, 6, 100, 1)
sprite.add(spritefactory.spritedeadmob_, "dead_2", 7, 6, 100, 1)
sprite.add(spritefactory.spritedeadmob_, "dead_3", 13, 6, 100, 1)

local explode = sprite.newSpriteSheet("spritesheets/explosion.png",130,130)
spritefactory.spritexplode  = sprite.newSpriteSet(explode, 1, 8)
sprite.add(spritefactory.spritexplode, "explode", 1, 8, 500, 1)

local fence = sprite.newSpriteSheet("items/fences.png",640,56)
spritefactory.spritefence = sprite.newSpriteSet(fence, 1, 3)
sprite.add(spritefactory.spritefence, "fence1", 1, 1, 1000, 1)
sprite.add(spritefactory.spritefence, "fence2", 2, 1, 1000, 1)
sprite.add(spritefactory.spritefence, "fence3", 3, 1, 1000, 1)

local powcar = sprite.newSpriteSheet("spritesheets/carpower.png",136,68)   
spritefactory.spritepowcar = sprite.newSpriteSet(powcar, 1, 16)
sprite.add(spritefactory.spritepowcar,"powercar_1", 1, 8, 300, 0)
sprite.add(spritefactory.spritepowcar,"powercar_2", 9, 8, 300, 0)

local flash = sprite.newSpriteSheet("spritesheets/flash.png", 160, 160)
spritefactory.spriteflash = sprite.newSpriteSet(flash , 1, 6)
sprite.add(spritefactory.spriteflash,"flash", 1, 6, 300, 1)

local laser = sprite.newSpriteSheet("spritesheets/beam.png", 300, 300)
spritefactory.spritelaser = sprite.newSpriteSet(laser, 1, 8)
sprite.add(spritefactory.spritelaser, "strike", 1, 8, 300,1)

local human = sprite.newSpriteSheet("spritesheets/human.png",64,98)
spritefactory.spritehuman = sprite.newSpriteSet(human, 1, 9)
sprite.add(spritefactory.spritehuman, "human", 1, 9, 500, -0)

local deadhuman = sprite.newSpriteSheet("spritesheets/humandead.png", 128, 96)
spritefactory.spritedeadhuman= sprite.newSpriteSet(deadhuman, 1, 6)
sprite.add(spritefactory.spritedeadhuman, "humandead", 1, 6, 1000, 1)

local alien_1 = sprite.newSpriteSheet("spritesheets/gus.png", 80, 114)
spritefactory.alien_1 = sprite.newSpriteSet(alien_1, 1, 6)
sprite.add(spritefactory.alien_1, "alien_1", 1, 6, 1000, 0)

local alien_2 = sprite.newSpriteSheet("spritesheets/goor.png", 80, 120)
spritefactory.alien_2 = sprite.newSpriteSet(alien_2, 1, 5)
sprite.add(spritefactory.alien_2, "alien_2", 1, 5, 800, 0)

local alien_3 = sprite.newSpriteSheet("spritesheets/giz.png", 80, 128)
spritefactory.alien_3 = sprite.newSpriteSet(alien_3, 1, 5)
sprite.add(spritefactory.alien_3, "alien_3", 1, 5, 800, 0)

local deadalien = sprite.newSpriteSheet("spritesheets/deadalien.png", 100, 80)
spritefactory.spritedeadalien= sprite.newSpriteSet(deadalien, 1, 18)
sprite.add(spritefactory.spritedeadalien, "deada_1", 1, 6, 400, 1)
sprite.add(spritefactory.spritedeadalien, "deada_2", 7, 6, 400, 1)
sprite.add(spritefactory.spritedeadalien, "deada_3", 13, 6, 400, 1)

local alienship_1 = sprite.newSpriteSheet("spritesheets/shipfront.png", 120, 129)
spritefactory.spritealienship = sprite.newSpriteSet(alienship_1, 1, 12)
sprite.add(spritefactory.spritealienship, "shipfront", 1, 4, 400, -0) 
sprite.add(spritefactory.spritealienship, "shipleft", 5, 4, 400, 0)
sprite.add(spritefactory.spritealienship, "shipright", 9, 4, 400, 0)

return spritefactory;

