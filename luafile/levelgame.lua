local external      = require "luafile.external"
local storyboard    = require "storyboard"
local scene         = storyboard.newScene()
local w_            = display.contentWidth / 2
local h_            = display.contentHeight / 2 
local group         = {}
local functions     = {}
local explodemon    = nil
local barrelback    = nil
local monsters      = nil
local objects_      = nil
local number_       = nil
local timer_        = nil
local carrun        = nil
local bumper        = nil
local params        = nil
local barrel        = nil
local laser         = nil
local flash         = nil
local text_         = nil
local game_         = nil
local trans         = nil
local life          = nil
local dead          = nil
local bol           = nil
local boss          = nil
local bullet        = nil
local backprob
local bg 

local function nonkey (event)

return true
end

local function none ()
    
    
end

function functions.spriteListener (event)
if event.phase == "end" then   
event.sprite:removeSelf()
end
end

local function shakingeffect ()
    
local stage = display.getCurrentStage()
local originalX = stage.x
local originalY = stage.y
local moveRightFunction
local moveLeftFunction
local rightTrans
local leftTrans
local originalTrans
local shakeTime = 80
local shakeRange = {min = 1, max = 3}
local endShake   	

moveRightFunction = function(event) rightTrans = transition.to(stage, {x = math.random(shakeRange.min,shakeRange.max), y = math.random(shakeRange.min, shakeRange.max), time = shakeTime, onComplete=moveLeftFunction}); end 
 
moveLeftFunction = function(event) leftTrans = transition.to(stage, {x = math.random(shakeRange.min,shakeRange.max) * -1, y = math.random(shakeRange.min,shakeRange.max) * -1, time = shakeTime, onComplete=endShake});  end 

moveRightFunction();

endShake = function(event) originalTrans = transition.to(stage, {x = originalX, y = originalY, time = 100}); end

    
end

local function onSceneTouch (event)
    print(event.phase)
    audio.play(external.sfx.clicksound)
    if event.phase == "ended" and event.target.id == "restart" then
        local option = 
            {
            effect = "fade",
            time = 500,
            params = 
                {
                    name        = event.target.id,
                    stage       = params.stage,
                    soundv      = params.soundv,
                    mastermon   = params.mastermon,
                    monsternum  = params.monsternum,
                    bignum      = params.bignum,
                    masstatus   = params.masstatus,
                    bigmas      = params.bigmas,
                    masdamage   = params.masdamage,
                    bigdamage   = params.bigdamage,
                    damage      = params.damage,
                    level       = params.level,
                    highscore   = params.highscore,
                    rowid       = params.rowid,
                    speed       = params.speed,
                    masspeed    = params.masspeed,
                    bigspeed    = params.bigspeed,
                    star        = params.star,
                    bigmas      = params.bigmas,
                    monmovstats = params.monmovstats,
                    movnum      = params.movnum,
                    tutorial    = game_.tutorial,
                    coin        = number_.coin,
                    car         = params.car,
                    laser       = params.laser,
                    barrel      = params.barrel,
                    bossbol     = params.bossbol,
                    bossing     = params.bossing,
                    
                }
            }
            storyboard.gotoScene( "luafile.mainrestart",option)
            
    elseif event.phase == "ended" and event.target.id == "next" then
        local option = 
            {
            effect = "fade",
            time = 500,
            params = 
                {   
                    name        = event.target.id,
                    stage       = params.stage,
                    level       = params.level,
                    score       = number_.score,
                    star        = number_.star,
                    rowid       = params.rowid,
                    coin        = number_.coin,
                    car         = number_.carP,
                    laser       = number_.laserP,
                    barrel      = number_.barrelP,
                }
            }
            storyboard.gotoScene( "luafile.mainrestart",option)
      elseif event.phase == "ended" and event.target.id == "menu" then
        local option = 
            {
            effect = "fade",
            time = 500,
            params = 
                {   
                    name        = event.target.id,
                    stage       = params.stage,
                    level       = params.level,
                    score       = number_.score,
                    star        = number_.star,
                    rowid       = params.rowid,
                    coin        = number_.coin,
                    car         = number_.carP,
                    laser       = number_.laserP,
                    barrel      = number_.barrelP,
                }
            }
            storyboard.gotoScene( "luafile.mainrestart",option)      
    elseif event.phase == "ended" and event.target.id == "quit" then
            local option = 
            {
            effect = "fade",
            time = 500,
            params = 
                { 
                    soundv = params.soundv,
                }
            }
         storyboard.gotoScene( "luafile.menu",option)
    end
end

function functions.top_5 ()
bol.top_5 = false  
end

function functions.top_4 (object_top4)
game_.movingobject = object_top4
bol.top_4 = false
trans.top_5 = transition.to (game_.movingobject,{y = display.contentHeight,time = 1000,onComplete = functions.top_5})   
trans.timer_5 = timer.performWithDelay(1000, none, 1)
bol.top_5 = true
end

function functions.top_3 (object_top3)
game_.movingobject = object_top3
bol.top_3 = false
    if bol.top == 1 then
        trans.top_4 = transition.to (game_.movingobject,{x = display.contentWidth*0.25,time = 500,onComplete = functions.top_4})  
    elseif bol.top == 2 then
        trans.top_4 = transition.to (game_.movingobject,{x = display.contentWidth/2,time = 500,onComplete = functions.top_4})  
    elseif bol.top == 3 then
        trans.top_4 = transition.to (game_.movingobject,{x = display.contentWidth - (display.contentWidth*0.25),time = 500,onComplete = functions.top_4})  
    end
trans.timer_4 = timer.performWithDelay(500, none, 1)
bol.top_4 = true
end

function functions.top_2 (object_top2)
game_.movingobject = object_top2
bol.top_2 = false
    if bol.top == 1 then
        trans.top_3 = transition.to (game_.movingobject,{y = display.contentHeight / 2 + 100,time = 1000,onComplete = functions.top_3}) 
    elseif bol.top == 2 then
        trans.top_3 = transition.to (game_.movingobject,{x = (display.contentWidth / 2) + 150,y = display.contentHeight / 2 + 100,time = 1000,onComplete = functions.top_3}) 
    elseif bol.top == 3 then
        trans.top_3 = transition.to (game_.movingobject,{y = display.contentHeight / 2 + 100,time = 1000,onComplete = functions.top_3}) 
    end
    trans.timer_3 = timer.performWithDelay(1000, none, 1)
    bol.top_3 = true
end

function functions.top_1 (object_top1)
game_.movingobject = object_top1
    bol.top_1 = false 
    if bol.top == 1 then
        trans.top_2 = transition.to (game_.movingobject,{x = display.contentWidth / 2,time = 500,onComplete = functions.top_2})  
    elseif bol.top == 2 then   
        trans.top_2 = transition.to (game_.movingobject,{x = (display.contentWidth / 2) - 150,time = 500,onComplete = functions.top_2})  
    elseif bol.top == 3 then
        trans.top_2 = transition.to (game_.movingobject,{x = (display.contentWidth / 2),time = 500,onComplete = functions.top_2})  
    end
    trans.timer_2 = timer.performWithDelay(500, none, 1)
    bol.top_2 = true
end

local function winnerscreen (event)
external.physics.stop()   
objects_.pausescreen = display.newImageRect("background/winner.png",400,150) -- winner
objects_.pausescreen.x = w_
objects_.pausescreen.y = h_ - 300
objects_.pausescreen.alpha = 0
objects_.pausescreen:scale (2,2)
group[5]:insert(objects_.pausescreen)

objects_.resbutton = external.widget.newButton
  {
    defaultFile     = "button/woodbutton/playagainbtn.png",
    overFile        = "button/woodbutton/playagainbtnover.png",
    id              = "restart",
    width           = 180, 
    height          = 63,
    onRelease       = onSceneTouch,
  }
objects_.resbutton.x = w_ - 100
objects_.resbutton.y = h_ + 30
objects_.resbutton.alpha = 0
objects_.resbutton:scale (0.5,0.5)
group[5]:insert(objects_.resbutton)

objects_.nextbutton = external.widget.newButton
  {
      defaultFile     = "button/woodbutton/nextbtn.png",
      overFile        = "button/woodbutton/nextbtnover.png",
      id              = "next",
      width           = 180, 
      height          = 63,
      onRelease       = onSceneTouch,
  }
objects_.nextbutton.x = w_ + 100
objects_.nextbutton.y = h_ + 30
objects_.nextbutton.alpha = 0
objects_.nextbutton:scale (0.5,0.5)
group[5]:insert(objects_.nextbutton)

objects_.menubutton = external.widget.newButton
    {
        defaultFile     = "button/woodbutton/menubtn.png",
        overFile        = "button/woodbutton/menubtnover.png",
        id              = "menu",
        width           = 180, 
        height          = 63,
        onRelease       = onSceneTouch,
    }
objects_.menubutton.x = w_ 
objects_.menubutton.y = objects_.nextbutton.y + 80
objects_.menubutton.alpha = 0
objects_.menubutton:scale (0.5,0.5)
group[5]:insert(objects_.menubutton)

if bol.carstart == true then
  timer.cancel(timer_.cartime)
  for u = 1, #carrun do
      if carrun[u].myname ~= nil then
          carrun[u]:pause()
      end
  end  
end

if bol.laser == true then
  timer.cancel(timer_.laser)
  objects_.beam:pause()
end

if bol.human == true then
    timer.cancel(timer_.human)
end

if bol.human_2 == true then
    timer.cancel(timer_.human_2)
end

if bol.top_1 == true then
    transition.cancel(trans.top_1)
    trans.can_1 = timer.cancel(trans.timer_1)
elseif bol.top_2 == true then
    transition.cancel(trans.top_2)
    trans.can_2 = timer.cancel(trans.timer_2)
elseif bol.top_3 == true then
    transition.cancel(trans.top_3)
    trans.can_3 = timer.cancel(trans.timer_3)
elseif bol.top_4 == true then
    transition.cancel(trans.top_4)
    trans.can_4 = timer.cancel(trans.timer_4)
elseif bol.top_5 == true then
    transition.cancel(trans.top_5)
    trans.can_5 = timer.cancel(trans.timer_5)
end

game_.winner = true

timer.performWithDelay(500, function()
--audio.stop()
audio.fade({channel=0, time=2000, volume=0})
end, 1)      
        if params.star == number_.life then
            number_.star = params.star
        else 
            number_.star = number_.life    
        end
        local function bunoscoin ()
            objects_.bunoscoin = display.newEmbossedText("+"..number_.coin.." Coins", 10, 10, "BadaBoom BB", 60,{ 255, 255, 255, 255 });
            objects_.bunoscoin:setReferencePoint(display.CenterReferencePoint);
            objects_.bunoscoin.x = w_
            objects_.bunoscoin.y = h_ - 50
            objects_.bunoscoin:setTextColor( 51, 51, 255 )
            group[5]:insert(objects_.bunoscoin)
            local color = 
            {
                highlight = 
                {
                    r =235, g = 0, b = 80, a = 255
                },
                shadow =
                {
                    r = 0, g = 0, b = 0, a = 255
                }
            }
             objects_.bunoscoin:setEmbossColor( color )
            bol.star = false
            if number_.starnum == number_.life then
                transition.to(objects_.nextbutton,{time = 1000,alpha = 1,xScale=1, yScale=1})
                transition.to(objects_.resbutton,{time = 1000,alpha = 1,xScale=1, yScale=1})
                transition.to(objects_.menubutton,{time = 1000,alpha = 1,xScale=1, yScale=1})
            end
        end
        timer_.star = timer.performWithDelay(600, function() 
        number_.starnum = number_.starnum + 1
        objects_[number_.starnum] = display.newImageRect("items/star.png", 50,50)  
        objects_[number_.starnum]:setReferencePoint(display.CenterReferencePoint)
        if number_.starnum == 1 then
            objects_[number_.starnum].x = w_
            if number_.starnum == number_.life then
                text_.score:setReferencePoint(display.CenterReferencePoint)
                transition.to(text_.score, {x = display.contentWidth / 2,y = display.contentHeight / 2 + 200 ,time = 1000,xScale=2, yScale=2,onComplete = bunoscoin})
                number_.coin = number_.coin + 3
            end
        elseif number_.starnum == 2 then
            objects_[number_.starnum].x = w_ + 100
            if number_.starnum == number_.life then
                text_.score:setReferencePoint(display.CenterReferencePoint)
                transition.to(text_.score, {x = display.contentWidth / 2,y = display.contentHeight / 2 + 200 ,time = 1000,xScale=2, yScale=2,onComplete = bunoscoin})
                number_.coin = number_.coin + 5
            end
        elseif number_.starnum == 3 then
            objects_[number_.starnum].x = w_ - 100
            if number_.starnum == number_.life then
                text_.score:setReferencePoint(display.CenterReferencePoint)
                transition.to(text_.score, {x = display.contentWidth / 2,y = display.contentHeight / 2 + 200 ,time = 1000,xScale=2, yScale=2,onComplete = bunoscoin})
                number_.coin = number_.coin + 10
            end
        end
        objects_[number_.starnum].y = h_ - 150
        group[5]:insert(objects_[number_.starnum])
        objects_[number_.starnum].alpha = 0
        objects_[number_.starnum]:scale (2,2)
        transition.to(objects_[number_.starnum],{time = 500,alpha = 1})
        transition.to(objects_[number_.starnum], {time = 800,xScale=1, yScale=1})
        audio.play(external.sfx.star)
        bol.star = true
        end, number_.life)
        transition.to(objects_.pausescreen, {time = 1000,alpha = 1,xScale=1, yScale=1})
        for i = 1, #monsters do
            if monsters[i].myname ~= nil then
                monsters[i]:pause()
                monsters[i]:removeEventListener("touch",functions.removerunner)
            end
        end
end

local function gameoverscreen ()    
    external.physics.stop()
            objects_.pausescreen = display.newImageRect("background/gameover.png",display.contentWidth - 200,300)
            objects_.pausescreen:setReferencePoint(display.TopCenterReferencePoint)
            objects_.pausescreen.x = w_
            objects_.pausescreen.y = h_ - 300
            group[5]:insert(objects_.pausescreen)
            
            objects_.resbutton = external.widget.newButton
                {
                    defaultFile     = "button/woodbutton/playagainbtn.png",
                    overFile        = "button/woodbutton/playagainbtnover.png",
                    id              = "restart",
                    width           = 200, 
                    height          = 70,
                    onRelease       = onSceneTouch,
                }
            objects_.resbutton:setReferencePoint(display.TopCenterReferencePoint)
            objects_.resbutton.x = w_ - 120
            objects_.resbutton.y = objects_.pausescreen.y + objects_.pausescreen.height + 50
            group[5]:insert(objects_.resbutton)

            objects_.quitbutton = external.widget.newButton
                {
                    defaultFile     = "button/woodbutton/quitbtn.png",
                    overFile        = "button/woodbutton/quitbtnover.png",
                    id              = "quit",
                    width           = 200, 
                    height          = 70,
                    onRelease       = onSceneTouch,
                }
            objects_.quitbutton:setReferencePoint(display.TopCenterReferencePoint)
            objects_.quitbutton.x = w_ + 120
            objects_.quitbutton.y = objects_.pausescreen.y + objects_.pausescreen.height + 50
            group[5]:insert(objects_.quitbutton)
            
            if game_.killed ~= number_.monsterleft then
                if bol.mobrun == true then
                    timer.cancel(timer_.mob)
                end
                if bol.masrun == true then
                    timer.cancel(timer_.master)
                end
                if bol.bigrun == true then
                    timer.cancel(timer_.bigmas)
                end
                if bol.movrun == true then
                    timer.cancel(timer_.movmob)
                end
                if bol.human == true then
                    timer.cancel(timer_.human)
                end
                if bol.human_2 == true then
                    timer.cancel(timer_.human_2)
                end
                for i = 1, #monsters do
                    if monsters[i].myname ~= nil then
                        monsters[i]:pause()
                        monsters[i]:removeEventListener("touch",functions.removerunner)
                    end
                end
            end
            if bol.carstart == true then
                timer.cancel(timer_.cartime)
                for u = 1, #carrun do
                    if carrun[u].myname ~= nil then
                        carrun[u]:pause()
                    end
                end  
            end
            if bol.laser == true then
                timer.cancel(timer_.laser)
                objects_.beam:pause()
            end
            if bol.top_1 == true then
                transition.cancel(trans.top_1)
                trans.can_1 = timer.cancel(trans.timer_1)
            elseif bol.top_2 == true then
                transition.cancel(trans.top_2)
                trans.can_2 = timer.cancel(trans.timer_2)
            elseif bol.top_3 == true then
                transition.cancel(trans.top_3)
                trans.can_3 = timer.cancel(trans.timer_3)
            elseif bol.top_4 == true then
                transition.cancel(trans.top_4)
                trans.can_4 = timer.cancel(trans.timer_4)
            elseif bol.top_5 == true then
                transition.cancel(trans.top_5)
                trans.can_5 = timer.cancel(trans.timer_5)
            end
            if boss.bol_ == true then
                transition.cancel(boss.move_)
                timer.cancel(boss.timer_)
            end
            if boss.bol_1 == true then
                transition.cancel(boss.move_1)
                timer.cancel(boss.timer_1)
            end
            if boss.bol_2 == true then
                transition.cancel(boss.move_2)
               timer.cancel(boss.timer_2)
            end
            game_.over = true
timer.performWithDelay(300, function()

audio.stop()
end, 1)
end

local function pauseall (event)
    
    if event.phase == "ended" or (event.keyName == "back" and event.phase == "down") then
        audio.play(external.sfx.clicksound)
        if game_.pause == true and game_.over == false and game_.winner == false then
            external.physics.pause()
            audio.pause()
            objects_.pause:removeSelf()
            
            Runtime:removeEventListener("enterFrame", functions.updatestatus)
            
            objects_.pause = external.widget.newButton   
                {
                    defaultFile     = "button/orange/pausetap.png",
                    overFile        = "button/orange/pause.png",
                    id              = "Pause",
                    width           = 80, 
                    height          = 80,
                    onRelease       = pauseall,
                }
            objects_.pause:setReferencePoint(display.CenterReferencePoint)
            objects_.pause.x = display.contentWidth - 50
            objects_.pause.y = display.contentHeight - 50
            group[5]:insert(objects_.pause)
            
            objects_.pausescreen = display.newImageRect("background/gamepause.png",300,300)
            objects_.pausescreen:setReferencePoint(display.TopCenterReferencePoint)
            objects_.pausescreen.x = w_
            objects_.pausescreen.y = h_ - 220
            group[5]:insert(objects_.pausescreen)
            
            objects_.resbutton = external.widget.newButton
                {
                    defaultFile     = "button/woodbutton/playagainbtn.png",
                    overFile        = "button/woodbutton/playagainbtnover.png",
                    id              = "restart",
                    width           = 200, 
                    height          = 70,
                    onRelease       = onSceneTouch,
                }
            objects_.resbutton:setReferencePoint(display.TopCenterReferencePoint)
            objects_.resbutton.x = w_ - 120
            objects_.resbutton.y = objects_.pausescreen.y + objects_.pausescreen.height + 50
            group[5]:insert(objects_.resbutton)

            objects_.quitbutton = external.widget.newButton
                {
                    defaultFile     = "button/woodbutton/quitbtn.png",
                    overFile        = "button/woodbutton/quitbtnover.png",
                    id              = "quit",
                    width           = 200, 
                    height          = 70,
                    onRelease       = onSceneTouch,
                }
            objects_.quitbutton:setReferencePoint(display.TopCenterReferencePoint)
            objects_.quitbutton.x = w_ + 100
            objects_.quitbutton.y = objects_.pausescreen.y + objects_.pausescreen.height + 50
            group[5]:insert(objects_.quitbutton)
            
            if bol.carstart == true then
                timer.pause(timer_.cartime)
                for u = 1, #carrun do
                    if carrun[u].myname ~= nil then
                        carrun[u]:pause()
                    end
                end  
            end
            if game_.killed ~= number_.monsterleft then
                
                if bol.mobrun == true then
                    timer.pause(timer_.mob)
                end
                if bol.masrun == true then
                    timer.pause(timer_.master)
                end
                if bol.bigrun == true then
                    timer.pause(timer_.bigmas)
                end
                if bol.movrun == true then
                    timer.pause(timer_.movmob)
                end
                if bol.human == true then
                    timer.pause(timer_.human)
                end
                if bol.human_2 == true then
                    timer.pause(timer_.human_2)
                end
                for i = 1, #monsters do
                    if monsters[i].myname ~= nil then
                        monsters[i]:pause()
                        monsters[i]:removeEventListener("touch",functions.removerunner)
                    end
                end
            end
            
            if bol.laser == true then
                timer.pause(timer_.laser)
                objects_.beam:pause()
            end
            
            if bol.top_1 == true then
                    transition.cancel(trans.top_1)
                    trans.can_1 = timer.pause(trans.timer_1)
            elseif bol.top_2 == true then
                    transition.cancel(trans.top_2)
                    trans.can_2 = timer.pause(trans.timer_2)
            elseif bol.top_3 == true then
                    transition.cancel(trans.top_3)
                    trans.can_3 = timer.pause(trans.timer_3)
            elseif bol.top_4 == true then
                    transition.cancel(trans.top_4)
                    trans.can_4 = timer.pause(trans.timer_4)
            elseif bol.top_5 == true then
                    transition.cancel(trans.top_5)
                    trans.can_5 = timer.pause(trans.timer_5)
            end
            
            if boss.bol_ == true then
                transition.cancel(boss.move_)
                boss.timepause_ = timer.pause(boss.timer_)
            end
            if boss.bol_1 == true then
                transition.cancel(boss.move_1)
                boss.timepause_1 = timer.pause(boss.timer_1)
            end
            if boss.bol_2 == true then
                transition.cancel(boss.move_2)
                boss.timepause_2 = timer.pause(boss.timer_2)
            end
            if boss.stats_ == true then
                for k = 1, #boss do
                    if boss[k].myname ~= nil then
                        boss[k]:pause()
                        boss[k]:removeEventListener("touch",functions.removerunner)
                    end
                end
            end
            game_.pause = false
            
        elseif game_.pause == false and game_.over == false then
            external.physics.start()
            audio.resume()
            
            Runtime:addEventListener("enterFrame", functions.updatestatus)
            objects_.pause:removeSelf()
            objects_.pause = nil
            objects_.resbutton:removeSelf()
            objects_.resbutton = nil
            objects_.quitbutton:removeSelf()
            objects_.quitbutton = nil
            objects_.pausescreen:removeSelf()
            objects_.pausescreen = nil
            objects_.pause = external.widget.newButton   
                {
                    defaultFile     = "button/orange/pause.png",
                    overFile        = "button/orange/pausetap.png",
                    id              = "Pause",
                    width           = 80, 
                    height          = 80,
                    onRelease       = pauseall,
                }
            objects_.pause:setReferencePoint(display.CenterReferencePoint)
            objects_.pause.x = display.contentWidth - 50
            objects_.pause.y = display.contentHeight - 50
            group[3]:insert(objects_.pause)
            
            
            if bol.carstart == true then
                timer.resume(timer_.cartime)
                for u = 1, #carrun do
                    if carrun[u].myname ~= nil then
                        carrun[u]:play()
                    end
                end
            else 
            end
            if game_.killed ~= number_.monsterleft then
                if bol.mobrun == true then
                    timer.resume(timer_.mob)
                end
                if bol.masrun == true then
                    timer.resume(timer_.master)
                end

                if bol.bigrun == true then
                    timer.resume(timer_.bigmas)
                end

                if bol.movrun  == true then
                    timer.resume(timer_.movmob)
                end
                if bol.human == true then
                    timer.resume(timer_.human)
                end
                if bol.human_2 == true then
                    timer.resume(timer_.human_2)
                end
                for i = 1, #monsters do
                    if monsters[i].myname ~= nil then
                        monsters[i]:play()
                        monsters[i]:addEventListener("touch",functions.removerunner)
                    end
                end
            end
            if bol.laser == true then
                timer.resume(timer_.laser)
                objects_.beam:play()
            end
                if bol.top_1 == true then
                        if bol.top == 1 then
                            trans.top_1 = transition.to (game_.movingobject,{y = display.contentHeight / 2 - 300,time = trans.can_1,onComplete = functions.top_1})
                        elseif bol.top == 2 then
                            trans.top_1 = transition.to (game_.movingobject,{y = display.contentHeight / 2 - 400,time = trans.can_1,onComplete = functions.top_1})
                        elseif bol.top == 3 then
                            trans.top_1 = transition.to (game_.movingobject,{y = display.contentHeight / 2 - 300,time = trans.can_1,onComplete = functions.top_1})
                        end
                    timer.resume(trans.timer_1)
                elseif bol.top_2 == true then
                        if bol.top == 1 then
                            trans.top_2 = transition.to (game_.movingobject,{x = display.contentWidth / 2,time = trans.can_2,onComplete = functions.top_2})
                        elseif bol.top == 2 then
                            trans.top_2 = transition.to (game_.movingobject,{x = (display.contentWidth / 2) - 150,time = trans.can_2,onComplete = functions.top_2})  
                        elseif bol.top == 3 then
                            trans.top_2 = transition.to (game_.movingobject,{x = (display.contentWidth / 2),time = trans.can_2,onComplete = functions.top_2})  
                        end
                    timer.resume(trans.timer_2)
                elseif bol.top_3 == true then
                        if bol.top == 1 then
                            trans.top_3 = transition.to (game_.movingobject,{y = display.contentHeight / 2 + 100,time = trans.can_3,onComplete = functions.top_3})
                        elseif bol.top == 2 then
                            trans.top_3 = transition.to (game_.movingobject,{x = (display.contentWidth / 2) + 150,y = display.contentHeight / 2 + 100,time = trans.can_3,onComplete = functions.top_3}) 
                        elseif bol.top == 3 then
                            trans.top_3 = transition.to (game_.movingobject,{y = display.contentHeight / 2 + 100,time = trans.can_3,onComplete = functions.top_3}) 
                        end
                    timer.resume(trans.timer_3)
                elseif bol.top_4 == true then
                        if bol.top == 1 then
                            trans.top_4 = transition.to (game_.movingobject,{x = display.contentWidth*0.25,time = trans.can_4,onComplete = functions.top_4})
                        elseif bol.top == 2 then
                            trans.top_4 = transition.to (game_.movingobject,{x = display.contentWidth/2,time = trans.can_4,onComplete = functions.top_4})  
                        elseif bol.top == 3 then
                            trans.top_4 = transition.to (game_.movingobject,{x = display.contentWidth - (display.contentWidth*0.25),time = trans.can_4,onComplete = functions.top_4})
                        end
                    timer.resume(trans.timer_4)
                elseif bol.top_5 == true then
                        trans.top_5 = transition.to (game_.movingobject,{y = display.contentHeight,time = trans.can_5,onComplete = functions.top_5})  
                        timer.resume(trans.timer_5)
                end
                                    
            if boss.bol_ == true then
                boss.move_ = transition.to(boss[boss.num],{time = boss.timepause_,y = display.contentHeight*.25,onComplete = functions.move1})
                timer.resume(boss.timer_)
                
            end
            if boss.bol_1 == true then
                if boss.locx == 1 then
                    boss.move_1 = transition.to(boss[boss.num],{time = boss.timepause_1,x = display.contentWidth / 2,onComplete = functions.move2}) 
                elseif boss.locx == 2 then
                    boss.move_1 = transition.to(boss[boss.num],{time = boss.timepause_1,x = (display.contentWidth / 2)  + (display.contentWidth*.25),onComplete = functions.move2}) 
                elseif boss.locx == 3 then    
                    boss.move_1 = transition.to(boss[boss.num],{time = boss.timepause_1,x = (display.contentWidth / 2)  - (display.contentWidth*.25),onComplete = functions.move2}) 
                elseif boss.locx == 4 then
                    boss.move_1 = transition.to(boss[boss.num],{time = boss.timepause_1,x = (display.contentWidth / 2)  + (display.contentWidth*.25) + (display.contentWidth*.125),onComplete = functions.move2}) 
                elseif boss.locx == 5 then    
                    boss.move_1 = transition.to(boss[boss.num],{time = boss.timepause_1,x = (display.contentWidth / 2)  - (display.contentWidth*.25) - (display.contentWidth*.125),onComplete = functions.move2}) 
                end
                timer.resume(boss.timer_1)
            end
            if boss.bol_2 == true then
                if boss.locy == 1 then
                    boss.move_2 = transition.to(boss[boss.num],{time = boss.timepause_2,x = display.contentWidth / 2,onComplete = functions.move1}) 
                elseif boss.locy == 2 then
                    boss.move_2 = transition.to(boss[boss.num],{time = boss.timepause_2,x = (display.contentWidth / 2)  + (display.contentWidth*.25),onComplete = functions.move1}) 
                elseif boss.locy == 3 then    
                    boss.move_2 = transition.to(boss[boss.num],{time = boss.timepause_2,x = (display.contentWidth / 2)  - (display.contentWidth*.25),onComplete = functions.move1}) 
                elseif boss.locy == 4 then
                    boss.move_2 = transition.to(boss[boss.num],{time = boss.timepause_2,x = (display.contentWidth / 2)  + (display.contentWidth*.25) + (display.contentWidth*.125),onComplete = functions.move1}) 
                elseif boss.locy == 5 then    
                    boss.move_2 = transition.to(boss[boss.num],{time = boss.timepause_2,x = (display.contentWidth / 2)  - (display.contentWidth*.25) - (display.contentWidth*.125),onComplete = functions.move1}) 
                end
                timer.resume(boss.timer_2)
            end
            if boss.stats_ == true then
                for k = 1, #boss do
                    if boss[k].myname ~= nil then
                        boss[k]:play()
                        boss[k]:addEventListener("touch",functions.removerunner)
                    end
                end
            end            
            game_.pause = true    
        end
        return true
    end
    
end

local function stopnow (event)
--audio.stop({channel = 29})

objects_.beam:pause()
objects_.beam:removeSelf()
objects_.beam = nil

end

function functions.striker (locx,locy)
    
if number_.laserP ~= 0 then
shakingeffect ()
bol.laser = true
--audio.play(external.sfx.sound_7,{channel = 29})
audio.setVolume(0.1,{channel = 29})
objects_.beam = external.sprite.newSprite(external.spritefactory.spritelaser)
objects_.beam.x = locx 
objects_.beam.y = locy
objects_.beam:prepare("strike")  
objects_.beam:play()
group[6]:insert(objects_.beam)
external.physics.addBody(objects_.beam,"static",{density = 1, bounce = 0,isSensor = true});
objects_.beam.myname = "beam"
objects_.beam.alpha = 0.8
objects_.beam:addEventListener( "sprite", functions.spriteListener )
number_.laserP = number_.laserP - 1
bol.laser = false
audio.play(external.sfx.sound_1)
if number_.laserP == -1 then
    number_.laserP = 0
end

--timer_.laser = timer.performWithDelay(8000, stopnow, 1) 
end

end

local function carrunning (event)

number_.carnum  = number_.carnum + 1
local carnum_ =  math.random(1,4)
carrun[number_.carnum] = external.sprite.newSprite(external.spritefactory.spritecar)
carrun[number_.carnum].rotation = 0

if carnum_ == 1 then
    carrun[number_.carnum]:setReferencePoint(display.CenterReferencePoint);
    carrun[number_.carnum].x = display.contentWidth + 50
    carrun[number_.carnum].y = h_ - 50
    carrun[number_.carnum]:prepare("car1")
    carrun[number_.carnum]:play()
    carrun[number_.carnum].id = "right"
    game_.cardir = -60
elseif carnum_ == 2 then
    carrun[number_.carnum]:setReferencePoint(display.CenterReferencePoint);
    carrun[number_.carnum].x = 50
    carrun[number_.carnum].y = h_ - 50
    carrun[number_.carnum]:prepare("car2")
    carrun[number_.carnum]:play()
    carrun[number_.carnum].id = "left"
    game_.cardir = 60
elseif carnum_ == 3 then
    carrun[number_.carnum]:setReferencePoint(display.CenterReferencePoint);
    carrun[number_.carnum].x = display.contentWidth + 50
    carrun[number_.carnum].y = h_ - 250
    carrun[number_.carnum]:prepare("car3")
    carrun[number_.carnum]:play()
    carrun[number_.carnum].id = "right"
    game_.cardir = -60
elseif carnum_ == 4 then
    carrun[number_.carnum]:setReferencePoint(display.CenterReferencePoint);
    carrun[number_.carnum].x = 50
    carrun[number_.carnum].y = h_ - 250
    carrun[number_.carnum]:prepare("car4")
    carrun[number_.carnum]:play()  
    carrun[number_.carnum].id = "left"
    game_.cardir = 60
end
carrun[number_.carnum].dir = game_.cardir
external.physics.addBody(carrun[number_.carnum],{density = 0, bounce = 0,isSensor = true})
carrun[number_.carnum]:applyForce(game_.cardir, 0, carrun[number_.carnum].x , carrun[number_.carnum].y)
carrun[number_.carnum].myname = "car";
group[3]:insert(carrun[number_.carnum]);

number_.carpow  = number_.carpow + 1
if number_.carpow == 7 then
    bol.carstart = false
    objects_.carpow:setEnabled(true) 
    number_.carpow = 0
end
audio.play(external.sfx.sound_3,{channel = 7})
audio.setVolume(0.7,{channel = 7})
end

function functions.bombhit(object,locx,locy)
local x1 = locx
local y1 = locy
print(object)
    if  object == "runnerers" then
        number_.score = number_.score + 50
        number_.deadmon = number_.deadmon + 1
        dead[number_.deadmon] = external.sprite.newSprite(external.spritefactory.spritedeadmob)
        dead[number_.deadmon].x = x1
        dead[number_.deadmon].y = y1
        dead[number_.deadmon]:prepare("dead_2")
        dead[number_.deadmon]:play()
        group[2]:insert(dead[number_.deadmon])
        dead[number_.deadmon]:addEventListener( "sprite", functions.spriteListener )
        number_.mobster = number_.mobster - 1
        game_.killed = game_.killed + 1
        audio.play(external.sfx.splat)
    elseif object == "masters" then
        number_.score = number_.score + 100
        number_.deadmon = number_.deadmon + 1
        dead[number_.deadmon] = external.sprite.newSprite(external.spritefactory.spritedeadmob)
        dead[number_.deadmon].x = x1
        dead[number_.deadmon].y = y1
        dead[number_.deadmon]:prepare("dead_3")  
        dead[number_.deadmon]:play()
        group[2]:insert(dead[number_.deadmon])
        dead[number_.deadmon]:addEventListener( "sprite", functions.spriteListener )
        number_.mastermon = number_.mastermon - 1
        game_.killed = game_.killed + 1 
        audio.play(external.sfx.splat)
    end
end

function functions.removerunner(event)
local hit = event.target
local holder = hit.id  

if event.phase == "began" then
    event.target.damage = event.target.damage - 1
    local x1 = hit.x
    local y1 = hit.y
    audio.play(external.sfx.sound_2)
    number_.flasher = number_.flasher + 1;
    flash[number_.flasher] = external.sprite.newSprite(external.spritefactory.spriteflash)
    flash[number_.flasher].x = x1
    flash[number_.flasher].y = y1
    flash[number_.flasher]:prepare("flash")
    flash[number_.flasher]:play()
    flash[number_.flasher].alpha = 0.5
    group[5]:insert(flash[number_.flasher])
    flash[number_.flasher]:addEventListener( "sprite", functions.spriteListener )
    
    if hit.damage == 0 and hit.myname == "runnerers" then
        number_.score = number_.score + 50
        number_.deadmon = number_.deadmon + 1
        dead[number_.deadmon] = external.sprite.newSprite(external.spritefactory.spritedeadmob)
        dead[number_.deadmon].x = x1
        dead[number_.deadmon].y = y1
        dead[number_.deadmon]:prepare("dead_2")

        dead[number_.deadmon]:play()
        group[2]:insert(dead[number_.deadmon])
        dead[number_.deadmon]:addEventListener( "sprite", functions.spriteListener )
        
        number_.mobster = number_.mobster - 1
        event.target:removeSelf() 
        event.target.myname = nil
        game_.killed = game_.killed + 1
        audio.play(external.sfx.splat)
    elseif hit.damage == 0 and hit.myname == "masters" then
        
        number_.score = number_.score + 100
        number_.deadmon = number_.deadmon + 1
        dead[number_.deadmon] = external.sprite.newSprite(external.spritefactory.spritedeadmob)
        dead[number_.deadmon].x = x1
        dead[number_.deadmon].y = y1
        dead[number_.deadmon]:prepare("dead_3")  
        dead[number_.deadmon]:play()
        group[2]:insert(dead[number_.deadmon])
        dead[number_.deadmon]:addEventListener( "sprite", functions.spriteListener )
        event.target:removeSelf() 
        event.target.myname = nil
        number_.mastermon = number_.mastermon - 1
        game_.killed = game_.killed + 1 
        audio.play(external.sfx.splat)
    elseif hit.damage == 0 and hit.myname == "bossing" then
        
        if boss.bol_ == true then
            transition.cancel(boss.move_)
            timer.cancel(boss.timer_)
            boss.bol_ = false 
        end
        if boss.bol_1 == true then
            transition.cancel(boss.move_1)
            timer.cancel(boss.timer_1)
            boss.bol_1 = false 
        end
        if boss.bol_2 == true then
            transition.cancel(boss.move_2)
           timer.cancel(boss.timer_2)
           boss.bol_2 = false
        end
    
        number_.score = number_.score + 500
        number_.deadmon = number_.deadmon + 1
        dead[number_.deadmon] = external.sprite.newSprite(external.spritefactory.spritexplode)
        dead[number_.deadmon].x = x1
        dead[number_.deadmon].y = y1
        dead[number_.deadmon]:prepare("explode")  
        dead[number_.deadmon]:play()
        group[2]:insert(dead[number_.deadmon])
        dead[number_.deadmon]:addEventListener( "sprite", functions.spriteListener )
        event.target:removeSelf() 
        event.target.myname = nil
        audio.play(external.sfx.sound_1)
        boss.stats_ = false
        number_.bossing = number_.bossing - 1
        game_.killed = game_.killed + 1 
        
        if number_.bossing ~= 0 then
            timer.resume(timer_.bolsstats)
        elseif number_.bossing == 0 then
            bol.bolsstats = false
        end
        
    elseif hit.damage == 0 and hit.myname == "bigmaster" then
        
        number_.score = number_.score + 500
        number_.deadmon = number_.deadmon + 1
        dead[number_.deadmon] = external.sprite.newSprite(external.spritefactory.spritedeadmob)
        dead[number_.deadmon].x = x1
        dead[number_.deadmon].y = y1
        dead[number_.deadmon]:prepare("dead_1")  
        dead[number_.deadmon]:play()
        group[2]:insert(dead[number_.deadmon])
        dead[number_.deadmon]:addEventListener( "sprite", functions.spriteListener )
        event.target:removeSelf() 
        event.target.myname = nil
        number_.bignum = number_.bignum - 1
        game_.killed = game_.killed + 1 
        audio.play(external.sfx.splat)
        --audio.play( external.sfx.sound_1)
    elseif hit.damage == 0 and hit.myname == "human" then
        
        number_.score = number_.score + 500
        number_.deadmon = number_.deadmon + 1
        dead[number_.deadmon] = external.sprite.newSprite(external.spritefactory.spritedeadhuman)
        dead[number_.deadmon].x = x1
        dead[number_.deadmon].y = y1
        dead[number_.deadmon]:prepare("humandead")  
        dead[number_.deadmon]:play()
        group[2]:insert(dead[number_.deadmon])
        dead[number_.deadmon]:addEventListener( "sprite", functions.spriteListener )
        event.target:removeSelf() 
        event.target.myname = nil
        audio.play( external.sfx.humanfail) 
        life[number_.life]:removeSelf()
        number_.life = number_.life - 1
    end    
end


end

function functions.mobstart (event)
    local mobnum_       = 2--math.random(1,4)
    number_.monster = number_.monster + 1 
    
    if mobnum_ == 1 then
        monsters[number_.monster] =  external.sprite.newSprite(external.spritefactory.alien_3)
        monsters[number_.monster]:prepare("alien_3") 
        monsters[number_.monster]:play()
        monsters[number_.monster].id = "runner 1" 
        
    elseif mobnum_ == 2 then

        monsters[number_.monster] =  external.sprite.newSprite(external.spritefactory.alien_2)
        monsters[number_.monster]:prepare("alien_2") 
        monsters[number_.monster]:play()
        monsters[number_.monster].id = "runner 2"  

    elseif mobnum_ == 3 then
        monsters[number_.monster] =  external.sprite.newSprite(external.spritefactory.alien_3)
        monsters[number_.monster]:prepare("alien_3") 
        monsters[number_.monster]:play()
        monsters[number_.monster].id = "runner 3"
    elseif mobnum_ == 4 then

        monsters[number_.monster] =  external.sprite.newSprite(external.spritefactory.alien_2)
        monsters[number_.monster]:prepare("alien_2") 
        monsters[number_.monster]:play()
        monsters[number_.monster].id = "runner 4"   

    end
monsters[number_.monster].y = -50
monsters[number_.monster].x = (math.random(50,display.contentWidth - 50))
monsters[number_.monster].damage = number_.damage  
external.physics.addBody(monsters[number_.monster] ,{density = 0, bounce = 0,firction = 0})
monsters[number_.monster].isFixedRotation = true
monsters[number_.monster]:applyForce(0, game_.mobspeed, monsters[number_.monster].x , monsters[number_.monster].y)
monsters[number_.monster].myname = "runnerers";
monsters[number_.monster]:addEventListener("touch",functions.removerunner)
group[2]:insert(monsters[number_.monster])

end

function functions.masterstart (event)
    
    local mobnum_       = 1--math.random(1,2)
    number_.monster = number_.monster + 1 
    monsters[number_.monster] =  external.sprite.newSprite(external.spritefactory.alien_1)
    monsters[number_.monster].y = -80
    monsters[number_.monster].x = (math.random(50,display.contentWidth - 50))
    
    if mobnum_ == 1 then

        monsters[number_.monster]:prepare("alien_1")  
        monsters[number_.monster]:play()
        
    elseif mobnum_ == 2 then

        monsters[number_.monster]:prepare("master_2")  
        monsters[number_.monster]:play() 
  
    end
monsters[number_.monster].id = "master" 
monsters[number_.monster].damage = number_.masdamage 
external.physics.addBody(monsters[number_.monster] ,{density = 0, bounce = 0,firction = 0})
monsters[number_.monster].isFixedRotation = true
monsters[number_.monster]:applyForce(0, game_.masspeed, monsters[number_.monster].x , monsters[number_.monster].y)
monsters[number_.monster].myname = "masters";
monsters[number_.monster]:addEventListener("touch",functions.removerunner)
group[2]:insert(monsters[number_.monster])

end

function functions.bigmastercall (event)
    
    number_.monster = number_.monster + 1 
    monsters[number_.monster] =  external.sprite.newSprite(external.spritefactory.alien_3)
    monsters[number_.monster].y = -100
    monsters[number_.monster].x = (math.random(50,display.contentWidth - 50))
    monsters[number_.monster]:prepare("alien_3")  
    monsters[number_.monster]:play()
    monsters[number_.monster].id = "bigmaster" 
    monsters[number_.monster].damage = number_.bigdamage
    external.physics.addBody(monsters[number_.monster] ,{density = 0, bounce = 0,firction = 0})
    monsters[number_.monster].isFixedRotation = true
    monsters[number_.monster]:applyForce(0, number_.bigspeed, monsters[number_.monster].x , monsters[number_.monster].y)
    monsters[number_.monster].myname = "bigmaster";
    monsters[number_.monster]:addEventListener("touch",functions.removerunner)
    group[2]:insert(monsters[number_.monster])  
    
end

function functions.helphuman (event)
    
    number_.monster = number_.monster + 1 
    monsters[number_.monster] =  external.sprite.newSprite(external.spritefactory.spritehuman)
    monsters[number_.monster].y = -100
    monsters[number_.monster].x = (math.random(50,display.contentWidth - 50))
    monsters[number_.monster]:prepare("human")  
    monsters[number_.monster]:play()
    monsters[number_.monster].id = "human" 
    monsters[number_.monster].damage = 1
    external.physics.addBody(monsters[number_.monster] ,{density = 0, bounce = 0,firction = 0,isSensor = true})
    monsters[number_.monster].isFixedRotation = true
    monsters[number_.monster]:applyForce(0, 20, monsters[number_.monster].x , monsters[number_.monster].y)
    monsters[number_.monster].myname = "human";
    monsters[number_.monster]:addEventListener("touch",functions.removerunner)
    group[6]:insert(monsters[number_.monster]) 
    audio.play( external.sfx.human) 
    number_.human = number_.human + 1
    if number_.human == 3 then
        bol.human = false
    end
end

function functions.helphuman_2 (event)
    
    number_.monster = number_.monster + 1 
    monsters[number_.monster] =  external.sprite.newSprite(external.spritefactory.spritehuman)
    monsters[number_.monster].y = -100
    monsters[number_.monster].x = (math.random(50,display.contentWidth - 50))
    monsters[number_.monster]:prepare("human")  
    monsters[number_.monster]:play()
    monsters[number_.monster].id = "human" 
    monsters[number_.monster].damage = 1
    external.physics.addBody(monsters[number_.monster] ,{density = 0, bounce = 0,firction = 0,isSensor = true})
    monsters[number_.monster].isFixedRotation = true
    monsters[number_.monster]:applyForce(0, 20, monsters[number_.monster].x , monsters[number_.monster].y)
    monsters[number_.monster].myname = "human";
    monsters[number_.monster]:addEventListener("touch",functions.removerunner)
    group[6]:insert(monsters[number_.monster]) 
    audio.play( external.sfx.human) 
    number_.human_2 = number_.human_2 + 1
    if number_.human_2 == 3 then
        bol.human_2 = false
    end
end

function functions.movingmonster (event)
    
    local mobnum_   = 1--math.random(1,4)
    number_.monster = number_.monster + 1 

    if mobnum_ == 1 then
        monsters[number_.monster] =  external.sprite.newSprite(external.spritefactory.spritealienship)
        monsters[number_.monster]:prepare("shipfront")  
        monsters[number_.monster]:play()
        monsters[number_.monster].id = "runner 1" 
        
    elseif mobnum_ == 2 then
        monsters[number_.monster] =  external.sprite.newSprite(external.spritefactory.alien_1)
        monsters[number_.monster]:prepare("alien_1")  
        monsters[number_.monster]:play()
        monsters[number_.monster].id = "runner 2"  

    elseif mobnum_ == 3 then
        monsters[number_.monster] =  external.sprite.newSprite(external.spritefactory.alien_2)
        monsters[number_.monster]:prepare("alien_2")  
        monsters[number_.monster]:play()
        monsters[number_.monster].id = "runner 3"
    elseif mobnum_ == 4 then
        monsters[number_.monster] =  external.sprite.newSprite(external.spritefactory.alien_1)
        monsters[number_.monster]:prepare("alien_1")  
        monsters[number_.monster]:play()
        monsters[number_.monster].id = "runner 4"   

    end
    monsters[number_.monster].y = -100
    monsters[number_.monster].name = "mover"
    monsters[number_.monster].damage = 2 
    external.physics.addBody(monsters[number_.monster],{density = 0, bounce = 0,firction = 0,isSensor = true})
    monsters[number_.monster].isFixedRotation = true
    monsters[number_.monster].myname = "runnerers";
    monsters[number_.monster]:addEventListener("touch",functions.removerunner)
    group[3]:insert(monsters[number_.monster])
    bol.top = math.random (1,3)

game_.movingobject = monsters[number_.monster]
    if bol.top == 1 then
        monsters[number_.monster].x =  50
        trans.top_1 = transition.to (game_.movingobject,{y = display.contentHeight / 2 - 300,time = 1500,onComplete = functions.top_1})
        trans.timer_1 = timer.performWithDelay(1500, none, 1)
        bol.top_1 = true
    elseif bol.top == 2 then
        monsters[number_.monster].x =  display.contentWidth / 2
        trans.top_1 = transition.to (game_.movingobject,{y = display.contentHeight / 2 - 400,time = 1000,onComplete = functions.top_1})
        trans.timer_1 = timer.performWithDelay(1000, none, 1)
        bol.top_1 = true   
    elseif bol.top == 3 then    
        monsters[number_.monster].x =  display.contentWidth - 50
        trans.top_1 = transition.to (game_.movingobject,{y = display.contentHeight / 2 - 300,time = 1500,onComplete = functions.top_1})
        trans.timer_1 = timer.performWithDelay(1500, none, 1)
        bol.top_1 = true    
    end

end

function functions.firingboss (xloc,yloc)
    bullet.num = bullet.num + 1
    bullet[bullet.num] = display.newImageRect("items/ammu.png",18,18)
    bullet[bullet.num].x = xloc
    bullet[bullet.num].y = yloc + (bullet[bullet.num].height + 50)
    bullet[bullet.num].myname = "bullet"
    group[6]:insert(bullet[bullet.num])
    external.physics.addBody(bullet[bullet.num],{isSensor = true})
    bullet[bullet.num]:applyForce(0,10, bullet[bullet.num].x, bullet[bullet.num].y)
end

function functions.move2 (object_2)
boss.locy = math.random(1,5)
boss.bol_1 = false
if boss.locy == 1 then
    boss.move_2 = transition.to(object_2,{time = boss.time_1,x = display.contentWidth / 2,onComplete = functions.move1}) 
elseif boss.locy == 2 then
    boss.move_2 = transition.to(object_2,{time = boss.time_1,x = (display.contentWidth / 2)  + (display.contentWidth*.25),onComplete = functions.move1}) 
elseif boss.locy == 3 then    
    boss.move_2 = transition.to(object_2,{time = boss.time_1,x = (display.contentWidth / 2)  - (display.contentWidth*.25),onComplete = functions.move1}) 
elseif boss.locy == 4 then
    boss.move_2 = transition.to(object_2,{time = boss.time_1,x = (display.contentWidth / 2)  + (display.contentWidth*.25) + (display.contentWidth*.125),onComplete = functions.move1}) 
elseif boss.locy == 5 then    
    boss.move_2 = transition.to(object_2,{time = boss.time_1,x = (display.contentWidth / 2)  - (display.contentWidth*.25) - (display.contentWidth*.125),onComplete = functions.move1}) 
end
boss.timer_2 = timer.performWithDelay (boss.time_1,none,1)
boss.bol_2 = true
boss.locv  = math.random(1,3)
    if boss.locv == 1 then
    elseif boss.locv == 2 then 
        functions.firingboss (object_2.x,object_2.y)
    elseif boss.locv == 3 then 
    end
end

function functions.move1 (object_1)
boss.locx = math.random(1,5)
boss.bol_2 = false
boss.bol_ = false
if boss.locx == 1 then
    boss.move_1 = transition.to(object_1,{time = boss.time_1,x = display.contentWidth / 2,onComplete = functions.move2}) 
elseif boss.locx == 2 then
    boss.move_1 = transition.to(object_1,{time = boss.time_1,x = (display.contentWidth / 2)  + (display.contentWidth*.25),onComplete = functions.move2}) 
elseif boss.locx == 3 then    
    boss.move_1 = transition.to(object_1,{time = boss.time_1,x = (display.contentWidth / 2)  - (display.contentWidth*.25),onComplete = functions.move2}) 
elseif boss.locx == 4 then
    boss.move_1 = transition.to(object_1,{time = boss.time_1,x = (display.contentWidth / 2)  + (display.contentWidth*.25) + (display.contentWidth*.125),onComplete = functions.move2}) 
elseif boss.locx == 5 then    
    boss.move_1 = transition.to(object_1,{time = boss.time_1,x = (display.contentWidth / 2)  - (display.contentWidth*.25) - (display.contentWidth*.125),onComplete = functions.move2}) 
end
boss.timer_1 = timer.performWithDelay (boss.time_1,none,1)
boss.bol_1 = true
boss.locv  = math.random(1,5)
    if boss.locv == 1 then

    elseif boss.locv == 2 then 
        functions.firingboss (object_1.x,object_1.y)
    elseif boss.locv == 3 then 
        functions.firingboss (object_1.x,object_1.y)
    elseif boss.locv == 4 then 
    elseif boss.locv == 5 then 
    end
end

function functions.start()
boss.num = boss.num + 1
boss[boss.num] = sprite.newSprite(external.spritefactory.spritealienship);
boss[boss.num]:setReferencePoint(display.CenterReferencePoint)
boss.locz = math.random(1,3)
if boss.locz == 1 then
boss[boss.num].x = display.contentWidth / 2
elseif boss.locz == 2 then
boss[boss.num].x = (display.contentWidth / 2)  + (display.contentWidth*.25)
elseif boss.locz == 3 then    
boss[boss.num].x = (display.contentWidth / 2)  - (display.contentWidth*.25)
end
boss[boss.num].y = -10
boss[boss.num]:prepare("shipfront"); 
boss[boss.num]:play()  
boss[boss.num].myname = "bossing"
boss[boss.num].damage = 5
boss[boss.num]:addEventListener("touch",functions.removerunner)
group[6]:insert(boss[boss.num])
boss.move_ = transition.to(boss[boss.num],{time = boss.time_1,y = display.contentHeight*.25,onComplete = functions.move1})
boss.timer_ = timer.performWithDelay (boss.time_1,none,1)
boss.bol_ = true
boss.stats_ = true
    if number_.bossing ~= 0 then
        timer.pause(timer_.bosstats)
    end
end

function functions.updatestatus (event)
    
    text_.score:setText("Score: "..number_.score)
    text_.score:setReferencePoint(display.CenterLeftReferencePoint);
    text_.score.x = w_ - 300

    text_.laser.text = "x"..number_.laserP
    text_.laser:setReferencePoint(display.TopRightReferencePoint);
    text_.laser.x = display.contentWidth - 10;

    text_.car.text = "x"..number_.carP
    text_.car:setReferencePoint(display.TopRightReferencePoint);
    text_.car.x = display.contentWidth - 10;

    text_.barrel.text   = "x"..number_.barrelP -- barrel
    text_.barrel:setReferencePoint(display.TopRightReferencePoint);
    text_.barrel.x = display.contentWidth - 10;

    text_.monster.text = "x"..number_.mobster
    text_.monster:setReferencePoint(display.CenterLeftReferencePoint);
    text_.monster.x = display.contentWidth - 140

    text_.master.text = "x"..number_.mastermon
    text_.master:setReferencePoint(display.CenterLeftReferencePoint);
    text_.master.x = display.contentWidth - 240  
    
    text_.bigmaster.text = "x"..number_.bignum
    text_.bigmaster:setReferencePoint(display.CenterLeftReferencePoint);
    text_.bigmaster.x = display.contentWidth - 340   
    
if bol.masstatus == "true" then
    
end

if bol.bigmas == "true" then

end

if params.highscore < number_.score then
    number_.highscore = number_.score
    text_.highscore:setText("Highscore: "..number_.highscore)
    text_.highscore:setReferencePoint(display.CenterLeftReferencePoint);
    text_.highscore.x = w_ - 300
end

if number_.mobster == 0 and bol.mobrun == true then
    bol.mobrun = false
end

if number_.mastermon == 0 and bol.masrun == true then
    bol.masrun = false   
    timer_.human_2 = timer.performWithDelay(5000, functions.helphuman_2, 3)
    bol.human_2 = true
end

if number_.movnum == 0 then
    bol.movrun = false   
end

if number_.mastermon <= (params.mastermon/2) and bol.bigrun == false then
    
    if number_.bignum ~= 0 then
        
    timer_.bigmas = timer.performWithDelay(3000, functions.bigmastercall, number_.bignum)
    if bol.bols == "true" then
    timer_.bosstats = timer.performWithDelay(5000, functions.start, number_.bossing)    
    bol.bosstats = true
    bol.bols = "false"
    end
    
    audio.stop({channel = 18})
    audio.fade({channel=18, time=2000, volume=0})
    audio.play( external.sfx.bigmonster,{loops= -1,channel = 19,volume = 0} )
    audio.fade({channel=19, time=3000, volume=0.5})
    end
    bol.bigrun = true
    timer_.human = timer.performWithDelay(5000, functions.helphuman, 3)
    bol.human = true
end

if number_.life == 0 and game_.over == false then
    gameoverscreen ()  
    game_.stats = true
    Runtime:removeEventListener("enterFrame", functions.updatestatus)
end

if game_.killed == number_.monsterleft and number_.mobster == 0 and number_.mastermon == 0 and number_.bignum == 0 and number_.bossing == 0 then
    winnerscreen ()
    game_.stats = true
    Runtime:removeEventListener("enterFrame", functions.updatestatus)
    if number_.highscore > number_.score then
        number_.highscore = number_.score
        text_.highscore:setText("Highscore: "..number_.highscore)
        text_.highscore:setReferencePoint(display.CenterLeftReferencePoint);
        text_.highscore.x = w_ - 300
    end
end

if number_.mobster == 0 and number_.mastermon == 0 and  number_.movnum == 0 and number_.bignum == 0 and number_.bossing == 0 then
    print("Wtf")
end

end

local function fencehit ()
    if number_.fencelife == 4 then
        objects_.fence:removeSelf()
        objects_.fence.myname = nil
        timer.performWithDelay(1, function() 
        objects_.fence = external.sprite.newSprite(external.spritefactory.spritefence);
        objects_.fence:prepare("fence2");
        objects_.fence.x = w_;
        objects_.fence.y = h_ + 130;
        objects_.fence:play();
        external.physics.addBody(objects_.fence,"static",{density = 0, bounce = 0,isSensor = true});
        objects_.fence.myname = "fence";
        group[3]:insert(objects_.fence);
        end, 1)
    elseif number_.fencelife == 2 then
        objects_.fence:removeSelf()
        objects_.fence.myname = nil
        timer.performWithDelay(1, function()
        objects_.fence = external.sprite.newSprite(external.spritefactory.spritefence);
        objects_.fence:prepare("fence3");
        objects_.fence.x = w_;
        objects_.fence.y = h_ + 130;
        objects_.fence:play();
        external.physics.addBody(objects_.fence,"static",{density = 0, bounce = 0,isSensor = true});
        objects_.fence.myname = "fence";
        group[3]:insert(objects_.fence);
        end, 1)
    elseif number_.fencelife == 0 and bol.fence == true then
        objects_.fence:removeSelf()
        objects_.fence.myname = nil
        bol.fence = false
    end
end

function scene:createScene (event)
group[1] = self.view
bg = display.newImageRect("background/Lvl_1.png",display.contentWidth,display.contentHeight)   
bg.x = w_
bg.y = h_
group[1]:insert(bg)
Runtime:addEventListener( "key", nonkey )
end

function scene:willEnterScene (event)
group[2]    = display.newGroup()
group[3]    = display.newGroup()
group[4]    = display.newGroup()
group[5]    = display.newGroup()
group[6]    = display.newGroup()

bol         = {
                laser       = false,
                mobrun      = false,
                carstart    = false,
                masstatus   = nil,
                masrun      = false,
                bigmas      = nil,
                bigrun      = nil,
                fence       = false,
                top         = nil,
                top_1       = false,
                top_2       = false,
                top_3       = false,
                top_4       = false,
                top_5       = false,
                monmovstats = nil,
                movrun      = false,
                human       = false,
                human_2     = false,
                fog         = false,
                star        = false,
                bols        = false,
                bosstats    = false,
                }
text_       = {
                barrel      = nil,
                laser       = nil,
                car         = nil,
                monster     = nil,
                style       = nil,
                master      = nil,
                highscore   = nil,
                count       = nil,
                bigmaster   = nil,
                level       = nil,
                }
objects_    = {
                remover_    = nil,
                remover     = nil,
                pause       = nil,
                carpow      = nil,
                barrel      = nil,
                beam        = nil,
                left_       = nil,
                right_      = nil,
                top_        = nil,
                monster     = nil,
                pausescreen = nil,
                quitbutton  = nil,
                resbutton   = nil,
                nextbutton  = nil,
                menubutton  = nil,
                master      = nil,
                bigmaster   = nil,
                fence       = nil,
                fog_1       = nil,
                fog_2       = nil,
                fogmov      = nil,
                dark        = nil,
                bunoscoin   = nil,
                level       = nil,
                }                   
timer_      = {
                mob     = nil,
                laser   = nil,
                cartime = nil,
                master  = nil,
                bigmas  = nil,
                star    = nil,
                movmob  = nil,
                human   = nil,
                human_2  = nil,
                bosstats = nil,
                }           
number_     = {
                monster     = 0,
                monsterleft = nil,
                flasher     = 0,
                deadmon     = 0,
                lasernumber = 0,
                damage      = nil,
                carP        = 0,
                laserP      = 0,
                barrelP     = 0,
                exnum       = 0,
                barrel      = 0,
                mobnum      = 0,
                score       = 0,
                life        = 3,
                carnum      = 0,
                carpow      = 0,
                masdamage   = nil,
                mastermon   = 0,
                mobster     = nil,
                highscore   = nil,
                bignum      = 0,
                bigdamage   = nil,
                totalmon    = nil,
                bigspeed    = nil,
                fencelife   = 6,
                star        = 0,
                starnum     = 0,
                movnum      = 0,
                human       = 0,
                human_2     = 0,
                coin        = 0,
                alien1spd   = 0,
                alien2spd   = 0,
                alien3spd   = 0,
                bossing     = 0,
                }
game_       = {
                pause   = true,
                cardir  = nil,
                start   = nil,
                killed  = 0,
                over    = false,
                winner  = false,
                mobspeed   = nil,
                masspeed   = nil,
                level      = nil,
                stats      = false,
                movingobject = nil,
                tutorial     = nil,   
            }
trans       = {
            top_1 = nil,
            top_2 = nil,
            top_3 = nil,
            top_4 = nil,
            top_5 = nil,
            can_1 = nil,
            can_2 = nil,
            can_3 = nil,
            can_4 = nil,
            can_5 = nil,
            timer_1 = nil,
            timer_2 = nil,
            timer_3 = nil,
            timer_4 = nil,
            timer_5 = nil,
            }            
boss = {
            num         = 0,
            time_1      = 1000,
            move_       = nil,
            move_1      = nil,
            move_2      = nil,
            bol_        = false,
            bol_1       = false,
            bol_2       = false,
            pause       = false,
            timer_      = nil,
            timer_1     = nil,
            timer_2     = nil,
            timepause   = nil,
            timepause_1 = nil,
            timepause_2 = nil,
            locx        = nil,
            locy        = nil,
            locz        = nil,
            locv        = nil,
            stats_      = false,
            }
bullet =  {
            num = 0,
            }            
monsters    = {}
bumper      = {}
carrun      = {}
dead        = {}
flash       = {}
laser       = {}
barrel      = {}
explodemon  = {}
barrelback  = {}
life        = {}

params              = event.params

number_.monsterleft = tonumber(params.monsternum) + tonumber(params.mastermon) + tonumber(params.bignum) + tonumber(params.movnum) + tonumber(params.bossing)

number_.mobster     = tonumber(params.monsternum) + tonumber(params.movnum)
number_.monsternum  = tonumber(params.monsternum)
number_.mastermon   = tonumber(params.mastermon)
number_.bignum      = tonumber(params.bignum)
number_.movnum      = tonumber(params.movnum)
number_.bossing     = tonumber(params.bossing)

bol.bols            = params.bossbol
bol.masstatus       = params.masstatus
bol.bigmas          = params.bigmas
bol.monmovstats     = params.monmovstats

number_.masdamage   = params.masdamage
number_.bigdamage   = params.bigdamage
number_.damage      = params.damage

number_.highscore   = params.highscore
game_.level         = params.level

game_.mobspeed      = params.speed
game_.masspeed      = params.masspeed
number_.bigspeed    = params.bigspeed

game_.tutorial      = params.tutorial

number_.carP        = params.car
number_.laserP      = params.laser
number_.barrelP     = params.barrel

end

function scene:enterScene (event)

external.physics.start()
external.physics.setGravity(0,0)
group[1] = self.view  
local environment = system.getInfo("environment")
if environment == "simulator" then
print("You're in the simulator.")
else 
system.activate("multitouch")
end

storyboard.purgeAll()
storyboard.removeAll() 
backprob = event.params



if backprob.rowid >= 1  and backprob.rowid <= 5 or backprob.rowid >= 21  and backprob.rowid <= 25 then
objects_.dark = display.newImageRect("background/lateafternoon.png",display.contentWidth,display.contentHeight+50)

elseif backprob.rowid >= 6  and backprob.rowid <= 10 or backprob.rowid >= 26  and backprob.rowid <= 30 then  
objects_.dark = display.newImageRect("background/earlynight.png",display.contentWidth,display.contentHeight+50)
   
elseif backprob.rowid >= 11  and backprob.rowid <= 15 or backprob.rowid >= 31  and backprob.rowid <= 35 then
objects_.dark = display.newImageRect("background/dark.png",display.contentWidth,display.contentHeight+50)

elseif backprob.rowid >= 16  and backprob.rowid <= 20 or backprob.rowid >= 26  and backprob.rowid <= 40 then
objects_.dark = display.newImageRect("background/dark.png",display.contentWidth,display.contentHeight+50)

objects_.fog_1 = display.newImageRect("background/fn-leftfog.png",display.contentWidth,display.contentHeight)
objects_.fog_1:setReferencePoint(display.CenterReferencePoint)  
objects_.fog_1.x = w_ - (w_*.5)
objects_.fog_1.y = h_
objects_.fog_1.alpha = 0
group[5]:insert(objects_.fog_1)

objects_.fog_2 = display.newImageRect("background/fn-rightfog.png",display.contentWidth,display.contentHeight)
objects_.fog_2:setReferencePoint(display.CenterReferencePoint)  
objects_.fog_2.x = w_ + (w_*.5)
objects_.fog_2.y = h_
objects_.fog_2.alpha = 0
group[5]:insert(objects_.fog_2)

end

objects_.dark:setReferencePoint(display.CenterReferencePoint) 
objects_.dark.x = w_
objects_.dark.y = h_
objects_.dark.alpha = 0
group[5]:insert(objects_.dark)

objects_._remover= display.newRect(0, 0, display.contentWidth*0.35, 10)
objects_._remover:setReferencePoint(display.CenterReferencePoint)
objects_._remover.x = w_ - 20
objects_._remover.y = display.contentHeight - 130;
external.physics.addBody(objects_._remover,"static",{density = 1, bounce = 0});
objects_._remover.myname = "end"
objects_._remover.alpha = 0
group[3]:insert(objects_._remover)

objects_.remover_= display.newRect(0, 0, display.contentWidth*0.25, 10)
objects_.remover_:setReferencePoint(display.CenterReferencePoint)
objects_.remover_.x = w_ - 240;
objects_.remover_.y = display.contentHeight - 160;
external.physics.addBody(objects_.remover_,"static",{density = 1, bounce = 0});
objects_.remover_.myname = "end"
objects_.remover_.alpha = 0
group[3]:insert(objects_.remover_)

objects_.remover = display.newRect(0, 0, display.contentWidth*0.35, 10)
objects_.remover:setReferencePoint(display.CenterReferencePoint)
objects_.remover.x = w_ + 200;
objects_.remover.y = display.contentHeight - 160;
external.physics.addBody(objects_.remover,"static",{density = 1, bounce = 0});
objects_.remover.myname = "end"
objects_.remover.alpha = 0
group[3]:insert(objects_.remover)

objects_.top_ = display.newRect(0, 0, display.contentHeight + 200, 10)
objects_.top_:setReferencePoint(display.CenterReferencePoint)
objects_.top_.x = w_
objects_.top_.y = -200
external.physics.addBody(objects_.top_,"static",{density = 1, bounce = 0,isSensor = true});
objects_.top_.myname = "sides"
objects_.top_.alpha = 1
group[3]:insert(objects_.top_)

objects_.left_ = display.newRect(0, 0, 10, display.contentHeight + 200)
objects_.left_:setReferencePoint(display.CenterReferencePoint)
objects_.left_.x = - 150
objects_.left_.y = h_
external.physics.addBody(objects_.left_,"static",{density = 1, bounce = 0,isSensor = true});
objects_.left_.myname = "sides"
objects_.left_.alpha = 1
group[3]:insert(objects_.left_)

objects_.right_ = display.newRect(0, 0, 10, display.contentHeight + 200)
objects_.right_:setReferencePoint(display.CenterReferencePoint)
objects_.right_.x = display.contentWidth + 150
objects_.right_.y = h_
external.physics.addBody(objects_.right_,"static",{density = 1, bounce = 0,isSensor = true});
objects_.right_.myname = "sides"
objects_.right_.alpha = 1
group[3]:insert(objects_.right_)

objects_.monster = display.newImageRect("button/icon/smallgoor.png",60,60)
objects_.monster:setReferencePoint(display.CenterReferencePoint)
objects_.monster.x = display.contentWidth - 170
objects_.monster.y = display.contentHeight - 30
objects_.monster.alpha = 0
group[3]:insert(objects_.monster)

objects_.master = display.newImageRect("button/icon/smallgus.png",60,60)
objects_.master:setReferencePoint(display.CenterReferencePoint)
objects_.master.x = display.contentWidth - 270
objects_.master.y = display.contentHeight - 30
objects_.master.alpha = 0
group[3]:insert(objects_.master)

objects_.bigmaster = display.newImageRect("button/icon/smallgiz.png",60,60)
objects_.bigmaster:setReferencePoint(display.CenterReferencePoint)
objects_.bigmaster.x = display.contentWidth - 370
objects_.bigmaster.y = display.contentHeight - 30
objects_.bigmaster.alpha = 0
group[3]:insert(objects_.bigmaster)

local function showobjects (event)
    
text_.level   = display.newEmbossedText("Stage "..params.stage.." ".."M-"..params.level, 10, 10, "BadaBoom BB", 32,{ 255, 255, 255, 255 });
text_.level:setReferencePoint(display.CenterLeftReferencePoint);
text_.level.x = w_ - 300;  
text_.level.y = 40;    
text_.level:setTextColor( 51, 51, 255 )
group[5]:insert(text_.level); 

text_.score   = display.newEmbossedText("Score: "..number_.score, 10, 10, "BadaBoom BB", 32,{ 255, 255, 255, 255 });
text_.score:setReferencePoint(display.CenterLeftReferencePoint);
text_.score.x = w_ - 300;  
text_.score.y = text_.level.y + 30;    
text_.score:setTextColor( 51, 51, 255 )
group[5]:insert(text_.score);

text_.highscore   = display.newEmbossedText("Highscore: "..number_.highscore, 10, 10, "BadaBoom BB", 32,{ 255, 255, 255, 255 });
text_.highscore:setReferencePoint(display.CenterLeftReferencePoint);
text_.highscore.x = w_ - 300;  
text_.highscore.y = display.contentHeight - 40;    
text_.highscore:setTextColor( 51, 51, 255 )
group[3]:insert(text_.highscore);

local color = 
{
    highlight = 
    {
        r =235, g = 0, b = 80, a = 255
    },
    shadow =
    {
        r = 0, g = 0, b = 0, a = 255
    }
}
text_.score:setEmbossColor( color )
text_.level:setEmbossColor( color )
text_.highscore:setEmbossColor( color )

text_.monster   = display.newText("x"..number_.mobster, 0, 0, "BadaBoom BB", 30);
text_.monster:setReferencePoint(display.CenterLeftReferencePoint);
text_.monster.x = display.contentWidth - 140  
text_.monster.y = display.contentHeight - 20    
group[3]:insert(text_.monster);

text_.master   = display.newText("x"..number_.mastermon, 0, 0, "BadaBoom BB", 30);
text_.master:setReferencePoint(display.CenterLeftReferencePoint);
text_.master.x = display.contentWidth - 240  
text_.master.y = display.contentHeight - 20    
text_.master.alpha = 0
group[3]:insert(text_.master);

text_.bigmaster   = display.newText("x"..number_.bignum, 0, 0, "BadaBoom BB", 30);
text_.bigmaster:setReferencePoint(display.CenterLeftReferencePoint);
text_.bigmaster.x = display.contentWidth - 340  
text_.bigmaster.y = display.contentHeight - 20
text_.bigmaster.alpha = 0
group[3]:insert(text_.bigmaster);

local x_ = 0
local y_ = 0

for q = 1 , number_.life ,1 do
    
    life[q] = display.newImageRect("items/heart.png", 30, 30)
    life[q]:setReferencePoint(display.CenterReferencePoint);
    if q >= 7 then
    y_ = y_ + 40
    life[q].x = 30 + y_   
    life[q].y = display.contentHeight - 50; 
    else
    x_ = x_ + 40
    life[q].x = 30 + x_
    life[q].y = display.contentHeight - 80;
    end
group[3]:insert(life[q])
end

text_.laser= display.newText("x"..number_.laserP, 0, 0, "BadaBoom BB", 25); --laser
text_.laser:setReferencePoint(display.TopRightReferencePoint);
text_.laser.x = display.contentWidth - 10;
text_.laser.y = h_ + (h_/2) - 33;
group[3]:insert(text_.laser);

text_.car = display.newText("x"..number_.carP,  0, 0, "BadaBoom BB", 25); -- car
text_.car:setReferencePoint(display.TopRightReferencePoint);
text_.car.x = display.contentWidth - 10;
text_.car.y = h_ + (h_/2) + 35; 
group[3]:insert(text_.car);

text_.barrel   = display.newText("x"..number_.barrelP,  0, 0, "BadaBoom BB", 25); -- barrel
text_.barrel:setReferencePoint(display.TopRightReferencePoint);
text_.barrel.x = display.contentWidth - 10;
text_.barrel.y = h_ + (h_/2) + 100;
group[3]:insert(text_.barrel);

for k = 1,7,1 do
barrel[k]   = display.newImageRect("button/barrelbut/barrel.png", 68, 36);
barrel[k].y = h_ + 60;

if k == 1 then
    barrel[k].x = w_;
elseif k == 2 then
    barrel[k].x = w_ - 100;
elseif k == 3 then
    barrel[k].x = w_ + 100;
elseif k == 4 then
    barrel[k].x = w_ - 190;
elseif k == 5 then
    barrel[k].x = w_ + 190;
elseif k == 6 then
    barrel[k].x = w_ + 290;
elseif k == 7 then
    barrel[k].x = w_ - 290;
end

external.physics.addBody(barrel[k],"static",{density  = 0,bounce = 0,friction = 0,isSensor = true});
barrel[k].myname = "barrel";
barrel[k].id = "barrel "..k;
group[3]:insert(barrel[k]);
end    

objects_.fence = external.sprite.newSprite(external.spritefactory.spritefence);
objects_.fence:prepare("fence1");
objects_.fence.x = w_;
objects_.fence.y = h_ + 110;
objects_.fence:play();
external.physics.addBody(objects_.fence,"static",{density = 0, bounce = 0,isSensor = true});
objects_.fence.myname = "fence";
bol.fence = true
group[3]:insert(objects_.fence);

Runtime:addEventListener("enterFrame", functions.updatestatus)
if game_.level == 1 then
    number_.alien1spd = 1500
    number_.alien2spd = 2500
    number_.alien3spd = 3500
elseif game_.level == 2 then
    number_.alien1spd = 1000
    number_.alien2spd = 2000
    number_.alien3spd = 3000
end

timer_.mob = timer.performWithDelay(number_.alien1spd, functions.mobstart, number_.monsternum)
bol.mobrun = true

if bol.masstatus == "true" then
    timer_.master = timer.performWithDelay(number_.alien2spd, functions.masterstart, number_.mastermon)
    bol.masrun = true   
    transition.to(objects_.master,{alpha = 1, time = 1500})
    text_.master.alpha = 1
end

if bol.monmovstats == "true" then
   timer_.movmob = timer.performWithDelay(number_.alien3spd, functions.movingmonster, number_.movnum)  
   bol.movrun = true
end

if bol.bigmas == "true" then
    bol.bigrun = false
    transition.to(objects_.bigmaster,{alpha = 1, time = 1500})
    text_.bigmaster.alpha = 1
end

transition.to(objects_.barrel,{alpha = 1, time = 1500})
transition.to(objects_.carpow,{alpha = 1, time = 1500})
transition.to(objects_.pause,{alpha = 1, time = 1500})
transition.to(objects_.monster,{alpha = 1, time = 1500})
transition.to(laser[number_.lasernumber],{alpha = 1, time = 1500})

if backprob.stage >= 1  and backprob.stage <= 5 or backprob.stage >= 21  and backprob.stage <= 25 then
transition.to(objects_.dark,{alpha = 1, time = 2000})
elseif backprob.stage >= 6  and backprob.stage <= 10 or backprob.stage >= 26  and backprob.stage <= 30 then  
transition.to(objects_.dark,{alpha = .5, time = 2000})
elseif backprob.stage >= 11  and backprob.stage <= 15 or backprob.stage >= 31  and backprob.stage <= 35 then
transition.to(objects_.dark,{alpha = 1, time = 2000})
elseif backprob.stage >= 16  and backprob.stage <= 20 or backprob.stage >= 36  and backprob.stage <= 40 then
transition.to(objects_.dark,{alpha = 1, time = 2000})
transition.to(objects_.fog_1,{alpha = .4, time = 2000})
transition.to(objects_.fog_2,{alpha = .4, time = 2000})
end


end

objects_.barrel   = display.newImageRect("button/barrelbut/barrel.png", 68, 36)
objects_.barrel:setReferencePoint(display.CenterReferencePoint)
objects_.barrel.x = display.contentWidth - 60;
objects_.barrel.y = h_ + (h_/2) + 100;
objects_.barrel.alpha = 0
group[3]:insert(objects_.barrel)

objects_.carpow = external.widget.newButton
    {
    defaultFile = "button/carbut/car.png",
    overFile    = "button/carbut/cartap.png",
    id          = "carpower",
    width       = 80, 
    height      = 50,
    onRelease   = function ()
        if number_.carP ~= 0 and game_.pause == true and bol.carstart == false and game_.stats == false then
            timer_.cartime = timer.performWithDelay(2500, carrunning, 7)
            bol.carstart = true
            number_.carP = number_.carP - 1
        end
        if number_.carP == -1 then
            number_.carP = 0
        end
    end,
    }
objects_.carpow:setReferencePoint(display.CenterReferencePoint)
objects_.carpow.x = display.contentWidth - 60;
objects_.carpow.y = h_ + (h_/2) + 20;
objects_.carpow.alpha = 0
group[3]:insert(objects_.carpow)

objects_.pause = external.widget.newButton   
    {
    defaultFile     = "button/orange/pause.png",
    overFile        = "button/orange/pausetap.png",
    id              = "Pause",
    width           = 80, 
    height          = 80,
    onRelease       = pauseall,
    }
objects_.pause:setReferencePoint(display.CenterReferencePoint)
objects_.pause.x = display.contentWidth - 50
objects_.pause.y = display.contentHeight - 50
objects_.pause.alpha = 0
group[3]:insert(objects_.pause)

function functions.lasertouch( event )

local t = event.target

local phase = event.phase

    if "began" == phase and number_.laserP ~= 0 and game_.pause == true and bol.laser == false and game_.stats == false then

        local parent = t.parent
        parent:insert( t )
        display.getCurrentStage():setFocus( t )
        t.isFocus = true
        t.x0 = event.x - t.x
        t.y0 = event.y - t.y

    elseif t.isFocus then
        if "moved" == phase then
            t.x = event.x - t.x0
            t.y = event.y - t.y0
        elseif "ended" == phase or "cancelled" == phase then
            display.getCurrentStage():setFocus( nil )
            t.isFocus = false
            functions.striker (laser[number_.lasernumber].x,laser[number_.lasernumber].y)
            laser[number_.lasernumber]:removeSelf()
            laser[number_.lasernumber]= nil
            number_.lasernumber = number_.lasernumber + 1
            laser[number_.lasernumber] = display.newImageRect("button/laser/laser_1.png" ,60,60 )
            laser[number_.lasernumber]:setReferencePoint(display.CenterReferencePoint)
            laser[number_.lasernumber].x = display.contentWidth - 60;
            laser[number_.lasernumber].y = h_ + (h_/2) - 50;
            laser[number_.lasernumber]:addEventListener( "touch", functions.lasertouch )
            
            group[3]:insert(laser[number_.lasernumber])
            --end  
        end
    end
    return true
end

number_.lasernumber = number_.lasernumber + 1
laser[number_.lasernumber] = display.newImageRect("button/laser/laser_1.png" ,60, 60)
laser[number_.lasernumber]:setReferencePoint(display.CenterReferencePoint)
laser[number_.lasernumber].x = display.contentWidth - 60;
laser[number_.lasernumber].y = h_ + (h_/2) - 50;
laser[number_.lasernumber].alpha = 0
laser[number_.lasernumber]:addEventListener( "touch", functions.lasertouch )
group[3]:insert(laser[number_.lasernumber])

function functions.barrelbackevent (event)

local locbarrel = event.target
    if event.phase == "ended" and number_.barrelP ~= 0 and game_.pause == true and game_.stats == false then
    audio.play(external.sfx.sound_6)
    number_.barrel = number_.barrel + 1
    barrel[number_.barrel] = display.newImageRect("button/barrelbut/barrel.png", 68, 36)
    barrel[number_.barrel].x = locbarrel.x
    barrel[number_.barrel].y = locbarrel.y
    external.physics.addBody(barrel[number_.barrel],"static",{density  = 0,bounce = 0,friction = 0,isSensor = true})
    barrel[number_.barrel].myname = "barrel"
    barrel[number_.barrel].id = event.target.id
    group[2]:insert(barrel[number_.barrel])  
    event.target:removeSelf()
    event.target.myname = nil
    event.target = nil
    number_.barrelP = number_.barrelP - 1

        if number_.barrelP == -1 then

            number_.barrelP = 0
        end
    end
end

local function explodeevent(locx,locy) -- EXPLODE
shakingeffect ()
number_.exnum = number_.exnum + 1
explodemon[number_.exnum] = external.sprite.newSprite(external.spritefactory.spritexplode)
explodemon[number_.exnum].x = locx
explodemon[number_.exnum].y = locy
explodemon[number_.exnum]:prepare("explode")
explodemon[number_.exnum]:play()
group[2]:insert(explodemon[number_.exnum])
explodemon[number_.exnum]:addEventListener( "sprite", functions.spriteListener )

end

local function barrelexplode(locx,locy) -- EXPLODE
shakingeffect () 

number_.exnum = number_.exnum + 1
explodemon[number_.exnum] = external.sprite.newSprite(external.spritefactory.spritexplode)
explodemon[number_.exnum].x = locx
explodemon[number_.exnum].y = locy
explodemon[number_.exnum]:prepare("explode")
explodemon[number_.exnum]:play()
group[2]:insert(explodemon[number_.exnum])
explodemon[number_.exnum]:addEventListener( "sprite", functions.spriteListener )

end

function functions.collisionevent (event)

if ((event.object1.myname == "end" and event.object2.myname == "bullet") or 
    (event.object1.myname == "bullet" and event.object2.myname == "end")) then
    
        if event.object1.myname == "bullet" then
                event.object1:removeSelf()
                event.object1.myname = nil
        elseif event.object2.myname == "bullet" then
                event.object2:removeSelf()
                event.object2.myname = nil
        end
end

if ((event.object1.myname == "fence" and event.object2.myname == "bullet") or 
    (event.object1.myname == "bullet" and event.object2.myname == "fence")) then
        if event.object1.myname == "bullet" then
                event.object1:removeSelf()
                event.object1.myname = nil
                number_.fencelife = number_.fencelife - 1
        elseif event.object2.myname == "bullet" then
                event.object2:removeSelf()
                event.object2.myname = nil
                number_.fencelife = number_.fencelife - 1
        end
            if number_.fencelife == - 1 then
                number_.fencelife = 0 
            end
        audio.play(external.sfx.sound_4, { channel=21 })
        fencehit()
end

if ((event.object1.myname == "barrel" and event.object2.myname == "bullet") or 
    (event.object1.myname == "bullet" and event.object2.myname == "barrel")) then
    audio.play(external.sfx.sound_1)
if event.object1.myname == "barrel" then
    explodeevent(event.object1.x,event.object1.y)
    number_.barrel = number_.barrel + 1
    barrelback[number_.barrel] = display.newImageRect("button/barrelbut/barreltap.png", 68, 36)
    barrelback[number_.barrel].x = event.object1.x
    barrelback[number_.barrel].y = event.object1.y
    barrelback[number_.barrel].myname = "repbarrel"
    barrelback[number_.barrel].alpha = 0.5
    barrelback[number_.barrel]:addEventListener( "touch", functions.barrelbackevent )
    group[4]:insert(barrelback[number_.barrel])
elseif event.object2.myname == "barrel" then
    explodeevent(event.object2.x,event.object2.y)
    number_.barrel = number_.barrel + 1
    barrelback[number_.barrel] = display.newImageRect("button/barrelbut/barreltap.png", 68, 36)
    barrelback[number_.barrel].x = event.object2.x
    barrelback[number_.barrel].y = event.object2.y
    barrelback[number_.barrel].myname = "repbarrel"
    barrelback[number_.barrel].alpha = 0.5
    barrelback[number_.barrel]:addEventListener( "touch", functions.barrelbackevent )
    group[4]:insert(barrelback[number_.barrel])
end
event.object1:removeSelf()
event.object1.myname = nil
event.object2:removeSelf()
event.object2.myname = nil
end

if ((event.object1.myname == "end" and event.object2.myname == "human") or 
    (event.object1.myname == "human" and event.object2.myname == "end")) then

        if event.object1.myname == "human" then
                event.object1:removeSelf()
                event.object1.myname = nil
        elseif event.object2.myname == "human" then
                event.object2:removeSelf()
                event.object2.myname = nil
        end
        number_.score = number_.score + 500
        number_.coin = number_.coin + 3
        
end

if  (event.object1.myname == "masters" and event.object2.myname == "runnerers") or 
    (event.object1.myname == "runnerers" and event.object2.myname == "masters") or 
    (event.object1.myname == "bigmaster" and event.object2.myname == "runnerers") or 
    (event.object1.myname == "runnerers" and event.object2.myname == "bigmaster")or
    (event.object1.myname == "bigmaster" and event.object2.myname == "masters") or 
    (event.object1.myname == "masters" and event.object2.myname == "bigmaster")then

    if event.phase == "began" then
        event.object1.isSensor = true
        event.object2.isSensor = true
    elseif event.phase == "ended" then
        event.object1.isSensor = false
        event.object2.isSensor = false
    end

end

if ((event.object1.myname == "fence" and event.object2.myname == "runnerers") or 
    (event.object1.myname == "runnerers" and event.object2.myname == "fence") or
    (event.object1.myname == "fence" and event.object2.myname == "masters") or 
    (event.object1.myname == "masters" and event.object2.myname == "fence") or 
    (event.object1.myname == "fence" and event.object2.myname == "bigmaster") or 
    (event.object1.myname == "bigmaster" and event.object2.myname == "fence"))then

    if event.object1.myname == "runnerers" and event.phase == "began" then
        number_.fencelife = number_.fencelife - 1
        event.object1:removeSelf()
        event.object1.myname = nil
        number_.mobster = number_.mobster - 1
        game_.killed = game_.killed + 1
    elseif event.object2.myname == "runnerers" and event.phase == "began" then
        number_.fencelife = number_.fencelife - 1
        event.object2:removeSelf()
        event.object2.myname = nil

        number_.mobster = number_.mobster - 1
        game_.killed = game_.killed + 1
    elseif event.object1.myname == "masters" and event.phase == "began" then
        number_.fencelife = number_.fencelife - 1
        event.object1:removeSelf()
        event.object1.myname = nil
        number_.mastermon = number_.mastermon - 1
        game_.killed = game_.killed + 1
    elseif event.object2.myname == "masters" and event.phase == "began" then
        number_.fencelife = number_.fencelife - 1
        event.object2:removeSelf()
        event.object2.myname = nil
        number_.mastermon = number_.mastermon - 1
        game_.killed = game_.killed + 1
    elseif event.object1.myname == "bigmaster" and event.phase == "began" then
        number_.fencelife = 0
    elseif event.object2.myname == "bigmaster" and event.phase == "began" then    
        number_.fencelife = 0
    end

    if number_.fencelife == - 1 then
        number_.fencelife = 0 
    end
    audio.play(external.sfx.sound_4, { channel=21 })
    fencehit()
end

if ((event.object1.myname == "end" and event.object2.myname == "runnerers") or 
    (event.object1.myname == "runnerers" and event.object2.myname == "end") or
    (event.object1.myname == "end" and event.object2.myname == "masters") or 
    (event.object1.myname == "masters" and event.object2.myname == "end") or 
    (event.object1.myname == "end" and event.object2.myname == "bigmaster") or 
    (event.object1.myname == "bigmaster" and event.object2.myname == "end"))then

    if event.object1.myname == "runnerers" or event.object1.myname == "masters" or event.object1.myname == "bigmaster" then

        if event.object1.myname == "runnerers" then
            number_.mobster = number_.mobster - 1
        elseif event.object1.myname == "masters" then
            number_.mastermon = number_.mastermon - 1
        elseif event.object1.myname == "bigmaster" then
            number_.bignum = number_.bignum - 1
        end

        event.object1:removeSelf()
        event.object1.myname = nil

    elseif event.object2.myname == "runnerers" or event.object2.myname == "masters" or event.object2.myname == "bigmaster" then

        if event.object2.myname == "runnerers" then
            number_.mobster = number_.mobster - 1
        elseif event.object2.myname == "masters" then
            number_.mastermon = number_.mastermon - 1
        elseif event.object2.myname == "bigmaster" then
            number_.bignum = number_.bignum - 1    
        end

        event.object2:removeSelf()
        event.object2.myname = nil    

    end
    game_.killed = game_.killed + 1
    life[number_.life]:removeSelf()
    number_.life = number_.life - 1
end

if ((event.object1.myname == "sides" and event.object2.myname == "runnerers") or 
    (event.object1.myname == "runnerers" and event.object2.myname == "sides")) or
    ((event.object1.myname == "sides" and event.object2.myname == "car") or 
    (event.object1.myname == "car" and event.object2.myname == "sides") or 
    (event.object1.myname == "sides" and event.object2.myname == "masters") or 
    (event.object1.myname == "masters" and event.object2.myname == "sides")or
    (event.object1.myname == "sides" and event.object2.myname == "bigmaster") or 
    (event.object1.myname == "bigmaster" and event.object2.myname == "sides"))then

    if event.object1.myname == "runnerers" or event.object1.myname == "car" or event.object1.myname == "masters" or event.object1.myname == "bigmaster" then

        if event.object1.myname == "runnerers" then
            number_.mobster = number_.mobster - 1
            game_.killed = game_.killed + 1
            number_.score = number_.score + 200
        elseif event.object1.myname == "masters" then
            number_.mastermon = number_.mastermon - 1
            game_.killed = game_.killed + 1
            number_.score = number_.score + 300
        elseif event.object1.myname == "bigmaster" then
            number_.bignum = number_.bignum - 1
            game_.killed = game_.killed + 1
        end

        event.object1:removeSelf()
        event.object1.myname = nil
    elseif event.object2.myname == "runnerers" or event.object2.myname == "car" or event.object2.myname == "masters" or event.object2.myname == "bigmaster" then

        if event.object2.myname == "runnerers" then
            number_.mobster = number_.mobster - 1
            game_.killed = game_.killed + 1
            number_.score = number_.score + 200
        elseif event.object2.myname == "masters" then
            number_.mastermon = number_.mastermon - 1
            game_.killed = game_.killed + 1
            number_.score = number_.score + 300
        elseif event.object2.myname == "bigmaster" then
            number_.bignum = number_.bignum - 1
            game_.killed = game_.killed + 1
        end

        event.object2:removeSelf()
        event.object2.myname = nil    
    end
end

if ((event.object1.myname == "car" and event.object2.myname == "runnerers") or 
    (event.object1.myname == "runnerers" and event.object2.myname == "car") or
    (event.object1.myname == "car" and event.object2.myname == "masters") or 
    (event.object1.myname == "masters" and event.object2.myname == "car")) then

    if event.object1.myname == "runnerers" or event.object1.myname == "masters" then
        event.object1.isFixedRotation = false
        event.object1:applyForce(event.object2.dir,0 , event.object1.x , event.object1.y + 10)
    elseif event.object2.myname == "runnerers" or event.object2.myname == "masters" then
        event.object2.isFixedRotation = false
        event.object2:applyForce(event.object1.dir,0 , event.object1.x + 10 , event.object1.y) 
    end
    audio.play(external.sfx.sound_5)
end

if ((event.object1.myname == "beam" and event.object2.myname == "runnerers") or 
    (event.object1.myname == "runnerers" and event.object2.myname == "beam") or
    (event.object1.myname == "beam" and event.object2.myname == "masters") or 
    (event.object1.myname == "masters" and event.object2.myname == "beam")) then
    
    if event.object1.myname == "masters" or event.object1.myname == "runnerers" then
            functions.bombhit(event.object1.myname,event.object1.x,event.object1.y)
            event.object1:removeSelf()
            event.object1.myname = nil
    elseif event.object2.myname == "runnerers" or event.object2.myname == "masters" then
            functions.bombhit(event.object2.myname,event.object2.x,event.object2.y)
            event.object2:removeSelf()
            event.object2.myname = nil
    end
    game_.killed = game_.killed + 1
 
end

if ((event.object1.myname == "barrel" and event.object2.myname == "runnerers") or 
    (event.object1.myname == "runnerers" and event.object2.myname == "barrel")or
    (event.object1.myname == "barrel" and event.object2.myname == "masters") or 
    (event.object1.myname == "masters" and event.object2.myname == "barrel")) then

    if event.object1.myname == "runnerers" or event.object1.myname == "masters" then
        
        explodeevent(event.object1.x,event.object1.y)
        if event.object1.myname == "runnerers" then
            number_.mobster = number_.mobster - 1
            number_.score = number_.score + 100
        elseif event.object1.myname == "masters" then
            number_.mastermon = number_.mastermon - 1
            number_.score = number_.score + 200
        end

        event.object1:removeSelf()
        event.object1.myname = nil
        if event.object2.myname == "barrel" then

            number_.barrel = number_.barrel + 1
            barrelback[number_.barrel] = display.newImageRect("button/barrelbut/barreltap.png", 68, 36)
            barrelback[number_.barrel].x = event.object2.x
            barrelback[number_.barrel].y = event.object2.y
            barrelback[number_.barrel].myname = "repbarrel"
            barrelback[number_.barrel].alpha = 0.5
            barrelback[number_.barrel]:addEventListener( "touch", functions.barrelbackevent )
            group[4]:insert(barrelback[number_.barrel])
            event.object2:removeSelf()
            event.object2.myname = nil
            number_.score = number_.score + 200
        end

    elseif event.object2.myname == "runnerers" or event.object2.myname == "masters" then
        explodeevent(event.object2.x,event.object2.y)
        if event.object2.myname == "runnerers" then

--            if event.object2.name == "mover" then
--            number_.movnum = number_.movnum - 1
--            end
            number_.mobster = number_.mobster - 1
            number_.score = number_.score + 100
        elseif event.object2.myname == "masters" then

            number_.mastermon = number_.mastermon - 1
            number_.score = number_.score + 200
        end

        event.object2:removeSelf()
        event.object2.myname = nil 
        if event.object1.myname == "barrel" then
     
            number_.barrel = number_.barrel + 1
            barrelback[number_.barrel] = display.newImageRect("button/barrelbut/barreltap.png", 68, 36)
            barrelback[number_.barrel].x = event.object1.x
            barrelback[number_.barrel].y = event.object1.y
            barrelback[number_.barrel].myname = "repbarrel"
            barrelback[number_.barrel].alpha = 0.5
            barrelback[number_.barrel]:addEventListener( "touch", functions.barrelbackevent )
            group[4]:insert(barrelback[number_.barrel])
            event.object1:removeSelf()
            event.object1.myname = nil
            number_.score = number_.score + 200
        end
    end

    game_.killed = game_.killed + 1
    audio.play(external.sfx.sound_1)
end

if ((event.object1.myname == "barrel" and event.object2.myname == "bigmaster") or 
    (event.object1.myname == "bigmaster" and event.object2.myname == "barrel")or
    (event.object1.myname == "car" and event.object2.myname == "bigmaster") or 
    (event.object1.myname == "bigmaster" and event.object2.myname == "car")) then

    if event.object1.myname == "barrel" then

            barrelexplode(event.object1.x,event.object1.y)
            number_.barrel = number_.barrel + 1
            barrelback[number_.barrel] = display.newImageRect("button/barrelbut/barreltap.png", 68, 36)
            barrelback[number_.barrel].x = event.object1.x
            barrelback[number_.barrel].y = event.object1.y
            barrelback[number_.barrel].myname = "repbarrel"
            barrelback[number_.barrel].alpha = 0.5
            barrelback[number_.barrel]:addEventListener( "touch", functions.barrelbackevent )
            group[4]:insert(barrelback[number_.barrel])
            event.object1:removeSelf()
            event.object1.myname = nil
    elseif event.object2.myname == "barrel" then 

            barrelexplode(event.object2.x,event.object2.y)
            number_.barrel = number_.barrel + 1
            barrelback[number_.barrel] = display.newImageRect("button/barrelbut/barreltap.png", 68, 36)
            barrelback[number_.barrel].x = event.object2.x
            barrelback[number_.barrel].y = event.object2.y
            barrelback[number_.barrel].myname = "repbarrel"
            barrelback[number_.barrel].alpha = 0.5
            barrelback[number_.barrel]:addEventListener( "touch", functions.barrelbackevent )
            group[4]:insert(barrelback[number_.barrel])
            event.object2:removeSelf()
            event.object2.myname = nil
    elseif event.object2.myname == "car" then
            explodeevent(event.object2.x,event.object2.y)
            event.object2:removeSelf()
            event.object2.myname = nil
    elseif event.object1.myname == "car" then
            explodeevent(event.object1.x,event.object1.y)
            event.object1:removeSelf()
            event.object1.myname = nil
    end
   audio.play( external.sfx.sound_1) 
end

end

local count_ = 0
text_.count   = display.newEmbossedText("", 10, 10, "BadaBoom BB", 120,{ 255, 255, 255, 255 });
text_.count:setReferencePoint(display.CenterReferencePoint);
text_.count.x = w_ ;  
text_.count.y = h_;    
text_.count:setTextColor( 255, 0, 0 )
group[3]:insert(text_.count); 

local colors = 
{
    highlight = 
    {
        r =235, g = 0, b = 80, a = 255
    },
    shadow =
    {
        r = 0, g = 0, b = 0, a = 255
    }
}
text_.count:setEmbossColor( colors )

timer.performWithDelay( 2000, function() 
external.adshow.loading("hide") 
--print(game_.tutorial)

if game_.tutorial == "false" then
local monster_s
local monsters_ = false
local fing = false
local fingermove
local powertur
local displaytutorial 
local texttap   = display.newEmbossedText(" ", 10, 10, "BadaBoom BB", 50,{ 255, 255, 255, 255 });
texttap:setReferencePoint(display.CenterReferencePoint);
texttap.x = w_ ;  
texttap.y = display.contentHeight /2 - 200    
texttap.alpha = 0 
texttap:setTextColor( 255, 0, 0 )
group[3]:insert(texttap); 

local colors = 
{
    highlight = 
    {
        r =235, g = 0, b = 80, a = 255
    },
    shadow =
    {
        r = 0, g = 0, b = 0, a = 255
    }
}
texttap:setEmbossColor( colors )
local finger = display.newImageRect("items/finger.png", 62, 83)
finger.x = w_+20
finger.y = display.contentHeight - 100
finger.alpha = 0
finger:scale( 2, 2)
group[3]:insert(finger)

function taptutorial(event)
    if fing == true then
        transition.cancel (fingermove)
    end
    if monsters_ == true then
        transition.cancel (monster_s)
    end
        local hit = event.target
        local holder = hit.id  
    if event.phase == "began" then
        local x1 = hit.x
        local y1 = hit.y
        audio.play(external.sfx.sound_2)
        number_.flasher = number_.flasher + 1;
        flash[number_.flasher] = external.sprite.newSprite(external.spritefactory.spriteflash)
        flash[number_.flasher].x = x1
        flash[number_.flasher].y = y1
        flash[number_.flasher]:prepare("flash")
        flash[number_.flasher]:play()
        group[3]:insert(flash[number_.flasher])
        flash[number_.flasher]:addEventListener( "sprite", functions.spriteListener )

        dead[number_.deadmon] = external.sprite.newSprite(external.spritefactory.spritedeadmob)
        dead[number_.deadmon].x = x1
        dead[number_.deadmon].y = y1
        dead[number_.deadmon]:prepare("dead_2")
        dead[number_.deadmon]:play()
        group[2]:insert(dead[number_.deadmon])
        dead[number_.deadmon]:addEventListener( "sprite", functions.spriteListener )
        event.target:removeSelf() 
        event.target.myname = nil 
        finger:removeSelf()
        finger = nil
        texttap:removeSelf()
        texttap = ni
        local function endtutoria (event)
                    game_.tutorial = "true"
                    timer.performWithDelay(500, function()
                        if count_ == 0 then
                            text_.count:setText("R E A D Y")
                            text_.count:setReferencePoint(display.CenterReferencePoint);
                            text_.count.x = w_ ; 
                            audio.play(external.sfx.star)
                        elseif count_ == 1 then
                            text_.count:setText("S E T")
                            text_.count:setReferencePoint(display.CenterReferencePoint);
                            text_.count.x = w_ ;
                            audio.play(external.sfx.star)
                        elseif count_ == 2 then
                            text_.count:setText("G O")
                            text_.count:setReferencePoint(display.CenterReferencePoint);
                            text_.count.x = w_ ;
                            audio.play(external.sfx.star)
                        elseif count_ == 3 then
                            timer.performWithDelay(300, showobjects, 1)
                            text_.count:setText("Game On!")
                            text_.count:setReferencePoint(display.CenterReferencePoint);
                            text_.count.x = w_ ;
                            transition.to(text_.count,{alpha = 0,time = 1000})
                            audio.play(external.sfx.sound_9)
                            audio.play( external.sfx.sound_13,{loops= -1,channel = 18} )
                            audio.setVolume( 0.4, { channel=18} )
                            Runtime:removeEventListener( "key", nonkey )
                            Runtime:addEventListener( "key", pauseall )

                        end

                     count_ = count_ + 1   
                    end,4)

                    local path = system.pathForFile("records.sqlite",system.ResourceDirectory  )
                    db = sqlite3.open( path )  
                    local tablesave_1 = [[UPDATE button SET tutorial =']]..game_.tutorial..[[' WHERE id =]]..1
                    db:exec( tablesave_1) 
                    db:close()
        end
        
        timer.performWithDelay(1000, function() 
        endtutoria()
        end, 1)
    return true
    end
end

function fingermoving_ (objecter_)
--group[2]:insert(texttap)lay.contentHeight - 100  
fing = false
fingermove = transition.to(finger,{x = w_+20 ,y = display.contentHeight - 100 ,delay = 500,time = 500,onComplete = fingermoving}) 
fing = true
end 

local tappings = false
function fingermoving (objecter_)
texttap:setText("TAP TO KILL THE ALIEN")
texttap:setReferencePoint(display.CenterReferencePoint);
texttap.x = w_+20 ;
texttap.alpha = 1
 if tappings == false then
    monsters[number_.monster]:addEventListener("touch",taptutorial) 
     tappings = true
 end
fing = false
fingermove = transition.to(finger,{x = monsters[number_.monster].x+20 ,y = monsters[number_.monster].y + 100,delay = 500,time = 500,onComplete = fingermoving_}) 
fing = true
end
local function starttutorial_ (event)
    
if event.phase == "began" then
    
number_.monster = number_.monster + 1 
monsters[number_.monster] =  external.sprite.newSprite(external.spritefactory.alien_2)
monsters[number_.monster]:prepare("alien_2") 
monsters[number_.monster]:play()
monsters[number_.monster].id = "tutorial"  
monsters[number_.monster].y = -50
monsters[number_.monster].x = display.contentWidth / 2 
monster_s = transition.to(monsters[number_.monster],{y = display.contentHeight /2 ,delay = 500,time = 2500,onComplete = fingermoving})
monsters_ = true
group[2]:insert(monsters[number_.monster])

local function removedisplay_ ()
displaytutorial:removeSelf()
displaytutorial = nil  
end
 
transition.to(displaytutorial,{x = display.contentWidth*2,time = 1000,transition=easing.linear,onComplete = removedisplay_})
finger.alpha = 1
    end
end

displaytutorial = display.newImageRect("background/instructions.png",display.contentWidth,display.contentHeight)
displaytutorial:setReferencePoint(display.CenterReferencePoint);
displaytutorial.x = display.contentWidth /2
displaytutorial.y = display.contentHeight / 2
displaytutorial:addEventListener("touch",starttutorial_) 
group[2]:insert(displaytutorial)
else
    
timer.performWithDelay(500, function()
    
    if count_ == 0 then
        text_.count:setText("R E A D Y")
        text_.count:setReferencePoint(display.CenterReferencePoint);
        text_.count.x = w_ ; 
        audio.play(external.sfx.star)
    elseif count_ == 1 then
        text_.count:setText("S E T")
        text_.count:setReferencePoint(display.CenterReferencePoint);
        text_.count.x = w_ ;
        audio.play(external.sfx.star)
    elseif count_ == 2 then
        text_.count:setText("G O")
        text_.count:setReferencePoint(display.CenterReferencePoint);
        text_.count.x = w_ ;
        audio.play(external.sfx.star)
    elseif count_ == 3 then
        timer.performWithDelay(300, showobjects, 1)
        text_.count:setText("Game On!")
        text_.count:setReferencePoint(display.CenterReferencePoint);
        text_.count.x = w_ ;
        transition.to(text_.count,{alpha = 0,time = 1000})
        audio.play(external.sfx.sound_9)
        audio.play( external.sfx.sound_13,{loops= -1,channel = 18} )
        audio.setVolume( 0.4, { channel=18} )
        Runtime:removeEventListener( "key", nonkey )
        Runtime:addEventListener( "key", pauseall )
    end

 count_ = count_ + 1   
end,4)
end

end,1)

group[1]:insert(group[4])
group[1]:insert(group[2])
group[1]:insert(group[3])
group[1]:insert(group[6])
group[1]:insert(group[5])
Runtime:addEventListener("collision", functions.collisionevent)
end

function scene:exitScene (event)
    
if bol.fog == true then
    transition.cancel(objects_.fogmov)
end
    
external.adshow.loading("show")

if bol.carstart == true and game_.pause == false then
    timer.cancel(timer_.cartime)  
    
end
if bol.mobrun == true and game_.pause == false then
    timer.cancel(timer_.mob)
    external.physics.stop()
    audio.stop()
    
end
if bol.laser == true and game_.pause == false then
    timer.cancel(timer_.laser)
end

if bol.masrun == true and game_.pause == false then
timer.cancel(timer_.master)
end

if bol.bigrun == true and game_.pause == false then
timer.cancel(timer_.bigmas)
end

Runtime:removeEventListener( "key", pauseall )

local environment = system.getInfo("environment")
if environment == "simulator" then
print("You're in the simulator.")
else 
system.deactivate("multitouch")
end

if bol.star == true then
    transition.cancel(timer_.star)
end

end

function scene:destroyScene(event)
    
group[2]:removeSelf()
group[2] = nil
group[3]:removeSelf()
group[3] = nil
group[4]:removeSelf()
group[4] = nil
group[5]:removeSelf()
group[5] = nil
group[6]:removeSelf()
group[6] = nil
group[1]:removeSelf()
group[1] = nil
print("destroy group")
end

scene:addEventListener("createScene", scene )
scene:addEventListener("willEnterScene",scene)
scene:addEventListener("enterScene", scene )
scene:addEventListener("exitScene", scene )
scene:addEventListener("destroyScene", scene )

return scene
