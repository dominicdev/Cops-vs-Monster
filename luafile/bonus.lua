local external      = require "luafile.external"
local storyboard    = require "storyboard"
local scene     = storyboard.newScene()
local w_        = display.contentWidth / 2
local h_        = display.contentHeight / 2
local alientap  = nil
local display_  = nil
local isPaused  = nil
local alien_1   = nil
local alien_2   = nil
local alien_3   = nil
local alien_4   = nil
local linenum   = nil
local trans_1   = nil
local object    = nil
local group     = nil
local time_     = nil
local map       = nil
local num       = nil
local bol       = nil
local minuteHandler = 1
local secondHandler = 0
local milliHandler = 0
local killthemall
local onTouched_
local params
local pop_1
local pop_2
local pop_3
local pop_4
local color
local sql
local row
local function none (event)

return true
end

local function none_1 ()
    
end

local function addclockers (locx,locy)
    if (secondHandler+2) >= 6 then
        print("more then 6")
        minuteHandler = minuteHandler + 1
        secondHandler = secondHandler - 2
    else
     secondHandler = secondHandler + 2 
    end
local function deletetext (textobject) 
    textobject:removeSelf()
    textobject = nil
end
display_.timers = display.newText ("+20sec Time",0,0,nil,25)
display_.timers:setReferencePoint(display.CenterReferencePoint)
display_.timers.x = locx
display_.timers.y = locy
transition.to (display_.timers,{y = locy - 200,time = 2000,onComplete = deletetext})
end

local function screengo (event)
    if event.phase == "ended" then
        if event.target.id == "menu" then
            local option = 
            {
            effect = "fade",
            time = 500,
            params = 
                { 
                    soundv = params.soundv,
                    name   = "menu",
                }
            }
         storyboard.gotoScene( "luafile.menu",option)
         elseif event.target.id == "restart" then
            local option = 
            {
            effect = "fade",
            time = 500,
            params = 
                { 
                    soundv = params.soundv,
                    name   = "restartbonus",
                }
            }
         storyboard.gotoScene( "luafile.mainrestart",option)
        elseif event.target.id == "menu_over" then
            
            local option = 
                {
                effect = "fade",
                time = 500,
                params = 
                    { 
                        soundv = params.soundv,
                        name   = "menu",
                    }
                }
            storyboard.gotoScene( "luafile.menu",option)
        elseif event.target.id == "restart_over" then
            
            local option = 
            {
            effect = "fade",
            time = 500,
            params = 
                { 
                    soundv = params.soundv,
                    name   = "restartbonus",
                }
            }
         storyboard.gotoScene( "luafile.mainrestart",option)
        end
    end
end

local function updatestats (event)
display_.score:setText("Score: "..num.score)
display_.score:setReferencePoint(display.CenterLeftReferencePoint);
display_.score.x = w_ - 300

display_.monstertext:setText(" x "..num.monkill)
display_.monstertext:setReferencePoint(display.CenterLeftReferencePoint);
display_.monstertext.x = display_.monsterimage.x + display_.monsterimage.width
end

local function gameoverscreen ()
isPaused = nil

num.coin = math.modf(num.monkill/3)
num.coin = num.coin * num.addcoin

local coin
sql = "SELECT * FROM item";
for row in external.adshow.db:nrows(sql) do
coin = row.coin
end
coin = coin + num.coin

local addcoin = [[UPDATE item SET coin=']]..coin..[[' WHERE id = 1]]
external.adshow.db:exec( addcoin )
print(addcoin)


display_.overscreen = display.newImageRect("background/gameover.png",display.contentWidth - 200,300)
display_.overscreen:setReferencePoint(display.TopCenterReferencePoint)
display_.overscreen.x = w_
display_.overscreen.y = h_ - 250
display_.overscreen.alpha = 0
group.group_6:insert(display_.overscreen)

display_.restartbutton = external.widget.newButton
    {
        defaultFile     = "button/woodbutton/playagainbtn.png",
        overFile        = "button/woodbutton/playagainbtnover.png",
        id              = "restart_over",
        width           = 200, 
        height          = 70,
        onRelease       = screengo,
    }
display_.restartbutton:setReferencePoint(display.TopCenterReferencePoint)
display_.restartbutton.x = w_ - 120
display_.restartbutton.y = display_.overscreen.y + display_.overscreen.height + 50
display_.restartbutton.alpha = 0
group.group_6:insert(display_.restartbutton)

display_.quitbutton = external.widget.newButton
    {
        defaultFile     = "button/woodbutton/menubtn.png",
        overFile        = "button/woodbutton/menubtnover.png",
        id              = "menu_over",
        width           = 200, 
        height          = 70,
        onRelease       = screengo,
    }
display_.quitbutton:setReferencePoint(display.TopCenterReferencePoint)
display_.quitbutton.x = w_ + 120
display_.quitbutton.y = display_.overscreen.y + display_.overscreen.height + 50
display_.quitbutton.alpha = 0
group.group_6:insert(display_.quitbutton)

timer.cancel(time_.play_1)
timer.cancel(time_.play_2)
timer.cancel(time_.play_3)
timer.cancel(time_.play_4)

if bol.stats1 == true then
    transition.cancel(trans_1.trans1)
    time_.holder_1 = timer.pause(time_.time_1)
    for i = 1, #alien_1,1 do
        if alien_1[i].id ~= nil then
            alien_1[i]:removeEventListener("touch",killthemall)
        end
    end
end

if bol.stats2 == true then
    transition.cancel(trans_1.trans2)
    time_.holder_2 = timer.cancel(time_.time_2)
    for p = 1, #alien_2,1 do

        if alien_2[p].id ~= nil then
            alien_2[p]:removeEventListener("touch",killthemall)
        end
    end
end

if bol.stats3 == true then
    transition.cancel(trans_1.trans3)
    time_.holder_3 = timer.cancel(time_.time_3)
    for k = 1, #alien_3,1 do
        if alien_3[k].id ~= nil then
            alien_3[k]:removeEventListener("touch",killthemall)
        end
    end
end

 if bol.stats4 == true then
    transition.cancel(trans_1.trans4)
    time_.holder_4 = timer.cancel(time_.time_4)
    for l = 1, #alien_4,1 do

        if alien_4[l].id ~= nil then
            alien_4[l]:removeEventListener("touch",killthemall)
        end
    end
end
bol.game = false
local function showsrewards ()
    local cointexter = nil
    if num.coin == 1 or num.coin == 0 then
        cointexter = "coin"
    else
        cointexter = "coins"
    end
display_.cointext = display.newEmbossedText("+ "..num.coin.." "..cointexter, 10, 10, "BadaBoom BB", 50,{ 255, 255, 255, 255 });
display_.cointext:setReferencePoint(display.CenterReferencePoint);
display_.cointext.x = w_ ;  
display_.cointext.y = display_.quitbutton.y  + 130;    
display_.cointext:setTextColor( 204, 0, 0 )
group.group_6:insert(display_.cointext);
display_.cointext:setEmbossColor( color )

local function savename (event)
    if event.phase == "ended" then
        local tablefill =[[INSERT INTO records2 VALUES (NULL,']] ..display_.textname.text.. [[',']] .. num.score .. [[',']].. map.dif ..[[');]]
        external.adshow.db:exec(tablefill)
        print(tablefill)
        display_.textname:removeSelf()
        display_.textname = nil
        display_.savebutton:removeSelf()
        display_.savebutton = nil
        native.setKeyboardFocus(nil)
        bol.key_ = false
    end
end

display_.textname = native.newTextField(0, 0, 260, 60)
display_.textname:setReferencePoint(display.CenterReferencePoint)
display_.textname.x = w_ 
display_.textname.y = 130
display_.textname.align = "center"
display_.textname.text  = "NAME"
display_.textname.font = native.newFont( "Dimitr", display_.textname.height/2 )
display_.textname.inputType = "default"
display_.textname:setTextColor( 0, 0, 0, 255 )
group.group_6:insert(display_.textname)

display_.savebutton = external.widget.newButton
    {
        defaultFile     = "button/woodbutton/save.png",
        overFile        = "button/woodbutton/saveover.png",
        width           = 200, 
        height          = 70,
        onRelease       = savename,
    }
display_.savebutton:setReferencePoint(display.TopCenterReferencePoint)
display_.savebutton.x = w_
display_.savebutton.y = display_.textname.y + 50
group.group_6:insert(display_.savebutton)

bol.key_ = true
function onTouched_(event)
native.setKeyboardFocus(nil)
bol.key_ = false
end
Runtime:addEventListener( "touch", onTouched_ )

end

transition.to (display_.overscreen,{alpha =1 , time = 1000})
transition.to (display_.restartbutton,{alpha =1 , time = 1000})
transition.to (display_.quitbutton,{alpha =1 , time = 1000,onComplete = showsrewards})
end

local function pauseallgame (event) 
        
    if event.phase == "ended" and bol.game == true or (event.keyName == "back" and event.phase == "down" and bol.game == true) then
        if isPaused == false then
            isPaused = true
            display_.pausebutton:removeSelf()
            display_.pausebutton = nil
            timer.pause(time_.game)
            
            display_.pausescreen = display.newImageRect("background/gamepause.png",300,300)
            display_.pausescreen:setReferencePoint(display.TopCenterReferencePoint)
            display_.pausescreen.x = w_
            display_.pausescreen.y = h_ - 220
            group.group_6:insert(display_.pausescreen)

            display_.restartbutton = external.widget.newButton
                {
                    defaultFile     = "button/woodbutton/playagainbtn.png",
                    overFile        = "button/woodbutton/playagainbtnover.png",
                    id              = "restart",
                    width           = 200, 
                    height          = 70,
                    onRelease       = screengo,
                }
            display_.restartbutton:setReferencePoint(display.TopCenterReferencePoint)
            display_.restartbutton.x = w_ - 120
            display_.restartbutton.y = display_.pausescreen.y + display_.pausescreen.height + 50
            group.group_6:insert(display_.restartbutton)

            display_.quitbutton = external.widget.newButton
                {
                    defaultFile     = "button/woodbutton/menubtn.png",
                    overFile        = "button/woodbutton/menubtnover.png",
                    id              = "menu",
                    width           = 200, 
                    height          = 70,
                    onRelease       = screengo,
                }
            display_.quitbutton:setReferencePoint(display.TopCenterReferencePoint)
            display_.quitbutton.x = w_ + 120
            display_.quitbutton.y = display_.pausescreen.y + display_.pausescreen.height + 50
            group.group_6:insert(display_.quitbutton)

             display_.pausebutton = external.widget.newButton
                {
                    defaultFile     = "button/orange/playtap.png",
                    overFile        = "button/orange/pause.png",
                    width           = 80, 
                    height          = 80,
                    onRelease   = pauseallgame,
                }
            display_.pausebutton.x = display.contentWidth - 50
            display_.pausebutton.y = 50
            group.group_6:insert(display_.pausebutton) 
            
            timer.pause(time_.play_1)
            timer.pause(time_.play_2)
            timer.pause(time_.play_3)
            timer.pause(time_.play_4)

            if bol.stats1 == true then

                transition.cancel(trans_1.trans1)
                time_.holder_1 = timer.pause(time_.time_1)

                for i = 1, #alien_1,1 do
                    if alien_1[i].id ~= nil then
                        alien_1[i]:removeEventListener("touch",killthemall)
                    end
                end
            end
            if bol.stats2 == true then
                transition.cancel(trans_1.trans2)
                time_.holder_2 = timer.pause(time_.time_2)
                for p = 1, #alien_2,1 do

                    if alien_2[p].id ~= nil then
                        alien_2[p]:removeEventListener("touch",killthemall)
                    end
                end
            end
            if bol.stats3 == true then
                transition.cancel(trans_1.trans3)
                time_.holder_3 = timer.pause(time_.time_3)
                for k = 1, #alien_3,1 do
                    if alien_3[k].id ~= nil then
                        alien_3[k]:removeEventListener("touch",killthemall)
                    end
                end
            end
             if bol.stats4 == true then
                transition.cancel(trans_1.trans4)
                time_.holder_4 = timer.pause(time_.time_4)
                for l = 1, #alien_4,1 do

                    if alien_4[l].id ~= nil then
                        alien_4[l]:removeEventListener("touch",killthemall)
                    end
                end
            end 
        elseif isPaused == true then
            
            if bol.stats1 == true then
                if bol.trans_1 == true then
                   trans_1.trans1 = transition.to(alien_1[num.alien_1],{y = map.section_1.height - 100,time = time_.holder_1,onComplete = pop_1}) 
                   time_.time_1 = timer.performWithDelay(time_.holder_1,none_1,1)
                elseif bol.trans_1 == false then
                    trans_1.trans1 = transition.to (alien_1[num.alien_1],{y =map.section_1.height,time = time_.holder_1,onComplete = changeobject})  
                    time_.time_1 = timer.performWithDelay(time_.holder_1,none_1,1)
                end
            for i = 1, #alien_1,1 do
                if alien_1[i].id ~= nil then
                    alien_1[i]:addEventListener("touch",killthemall)
                end
            end
            end
        
            if bol.stats2 == true then
                if bol.trans_2 == true then
                   trans_1.trans2 = transition.to(alien_2[num.alien_2],{y = map.section_1.y + map.section_2.height + 150,time = time_.holder_2,onComplete = pop_2}) 
                   time_.time_2 = timer.performWithDelay(time_.holder_2,none_1,1)
                elseif bol.trans_2 == false then
                    trans_1.trans2 = transition.to (alien_2[num.alien_2],{y = map.section_2.y + map.section_2.height,time = time_.holder_2,onComplete = changeobject})  
                    time_.time_2 = timer.performWithDelay(time_.holder_2,none_1,1)
                end
            for p = 1, #alien_2,1 do
                if alien_2[p].id ~= nil then
                    alien_2[p]:addEventListener("touch",killthemall)
                end
            end
            end
            if bol.stats3 == true then
                if bol.trans_3 == true then
                   trans_1.trans3 = transition.to(alien_3[num.alien_3],{y = map.section_2.y + map.section_3.height + 30,time = time_.holder_3,onComplete = pop_3}) 
                   time_.time_3 = timer.performWithDelay(time_.holder_3,none_1,1)
                elseif bol.trans_3 == false then
                    trans_1.trans3 = transition.to (alien_3[num.alien_3],{y = map.section_2.y + map.section_3.height + 160,time = time_.holder_3,onComplete = changeobject})  
                    time_.time_3 = timer.performWithDelay(time_.holder_3,none_1,1)
                end
            for k = 1, #alien_3,1 do
                if alien_3[k].id ~= nil then
                    alien_3[k]:addEventListener("touch",killthemall)
                end
            end
            end
            if bol.stats4 == true then
                if bol.trans_4 == true then
                    trans_1.trans4 = transition.to (alien_4[num.alien_4],{y = map.section_2.y + map.section_3.height + map.section_4.height,time = time_.holder_4,onComplete = pop_4})
                    time_.time_4 = timer.performWithDelay(time_.holder_4,none_1,1)
                elseif bol.trans_4 == false then
                    trans_1.trans4 = transition.to (alien_4[num.alien_4],{y = map.section_2.y + map.section_3.height + map.section_4.height + 150,time = time_.holder_4,onComplete = changeobject})
                    time_.time_4 = timer.performWithDelay(time_.holder_4,none_1,1)
                end
           for l = 1, #alien_4,1 do
                if alien_4[l].id ~= nil then
                    alien_4[l]:addEventListener("touch",killthemall)
                end
            end
            end
            timer.resume(time_.play_1)
            timer.resume(time_.play_2)
            timer.resume(time_.play_3)
            timer.resume(time_.play_4)
            isPaused = false
            timer.resume(time_.game)
            display_.pausebutton:removeSelf()
            display_.pausebutton = nil
            display_.quitbutton:removeSelf()
            display_.quitbutton = nil
            display_.restartbutton:removeSelf()
            display_.restartbutton = nil
            display_.pausescreen:removeSelf()
            display_.pausescreen = nil
            display_.pausebutton = external.widget.newButton
            {
                defaultFile     = "button/orange/pause.png",
                overFile        = "button/orange/pausetap.png",
                width           = 80, 
                height          = 80,
                onRelease   = pauseallgame,
            }
            display_.pausebutton.x = display.contentWidth - 50
            display_.pausebutton.y = 50
            group.group_6:insert(display_.pausebutton) 
        end
    end
return true
end

local function timerstart (event)

local updateClock
local textHolder
local text

textHolder = minuteHandler..":"..secondHandler..milliHandler;

text = display.newEmbossedText( textHolder, 0, 0, "BadaBoom BB", 90,{ 255, 255, 255, 255 });
text:setReferencePoint(display.CenterLeftReferencePoint)
text.x = display.contentWidth / 2 + 20
text.y = display.contentHeight - text.height
text:setTextColor( 153, 153, 153 )
group.group_6:insert(text)

updateClock = function( event )
if(minuteHandler ~= 0 or secondHandler ~= 0 or milliHandler ~= 0)then
    if(secondHandler == 0 and milliHandler == 0 and minuteHandler ~= 0)then
        minuteHandler = minuteHandler - 1
    end
    if(secondHandler == 0 and milliHandler == 0)then
        secondHandler = 6
    elseif(secondHandler == 0 and milliHandler > 0) then
        secondHandler = 0
    end
    if(milliHandler == 0) then
        milliHandler = 10
    end
    if(milliHandler > 0)then
        milliHandler = milliHandler - 1
        if(milliHandler == 9)then
            secondHandler = secondHandler - 1
        end
    end
elseif(minuteHandler == 0 or secondHandler == 0 or milliHandler == 0)then
    timer.cancel(time_.game)
    gameoverscreen()
end

text:setText(minuteHandler..":"..secondHandler..milliHandler);
text:setReferencePoint(display.CenterLeftReferencePoint)
text.x = display.contentWidth / 2 + 20
end
time_.game = timer.performWithDelay(1000, updateClock, 0)
end

local function spriteListener (event)
    if event.phase == "end" then   
        event.sprite:removeSelf()
        event.sprite = nil
    end
end

function killthemall (event)
        local target = event.target
        local phase = event.phase
        
        if phase == "began" and (target.id == "goor_line_1" or target.id == "guz_line_1" or target.id == "giz_line_1") then
            audio.play(external.sfx.splat)
            if bol.stats1 == true then
            transition.cancel(trans_1.trans1)
            timer.cancel(time_.time_1)
            end
            bol.trans_1 = false  
            bol.stats1 = false
            num.score = num.score + 100
            num.monkill = num.monkill + 1
            num.tapped = num.tapped + 1
            alientap[num.tapped] = external.sprite.newSprite(external.spritefactory.spritedeadmob)
            alientap[num.tapped].x = target.x
            alientap[num.tapped].y = target.y
            if target.id == "goor_line_1" then
                alientap[num.tapped]:prepare("dead_2")
            elseif target.id == "guz_line_1" then
                alientap[num.tapped]:prepare("dead_3")  
            elseif target.id == "giz_line_1" then
                alientap[num.tapped]:prepare("dead_1")    
            end
            alientap[num.tapped]:play()
            alientap[num.tapped]:addEventListener( "sprite", spriteListener )
            target:removeSelf()
            target.id = nil
        elseif phase == "began" and (target.id == "goor_line_2"  or target.id == "guz_line_2" or target.id == "giz_line_2") then
            audio.play(external.sfx.splat)
            if bol.stats2 == true then
                transition.cancel(trans_1.trans2)
                timer.cancel(time_.time_2)
            end
                bol.trans_2 = false  
                bol.stats2 = false
                num.score = num.score + 100
                num.monkill = num.monkill + 1
                num.tapped = num.tapped + 1
                alientap[num.tapped] = external.sprite.newSprite(external.spritefactory.spritedeadmob)
                alientap[num.tapped].x = target.x
                alientap[num.tapped].y = target.y
            if target.id == "goor_line_2" then
                alientap[num.tapped]:prepare("dead_2")
            elseif target.id == "guz_line_2" then
                alientap[num.tapped]:prepare("dead_3")  
            elseif target.id == "giz_line_2" then
                alientap[num.tapped]:prepare("dead_1")    
            end
            alientap[num.tapped]:play()
            alientap[num.tapped]:addEventListener( "sprite", spriteListener )
            target:removeSelf()
            target.id = nil
        elseif phase == "began" and (target.id == "goor_line_3" or target.id == "guz_line_3" or target.id == "giz_line_3") then
            audio.play(external.sfx.splat)
            if bol.stats3 == true then
                transition.cancel(trans_1.trans3)
                timer.cancel(time_.time_3)
            end
                bol.trans_3 = false 
                bol.stats3 = false
                num.score = num.score + 100
                num.monkill = num.monkill + 1
                num.tapped = num.tapped + 1
                alientap[num.tapped] = external.sprite.newSprite(external.spritefactory.spritedeadmob)
                alientap[num.tapped].x = target.x
                alientap[num.tapped].y = target.y
            if target.id == "goor_line_3" then
                alientap[num.tapped]:prepare("dead_2")
            elseif target.id == "guz_line_3" then
                alientap[num.tapped]:prepare("dead_3")  
            elseif target.id == "giz_line_3" then
                alientap[num.tapped]:prepare("dead_1")    
            end
            alientap[num.tapped]:play()
            alientap[num.tapped]:addEventListener( "sprite", spriteListener )
            target:removeSelf()
            target.id = nil
        elseif phase == "began" and (target.id == "goor_line_4"  or target.id == "guz_line_4" or target.id == "giz_line_4") then
            audio.play(external.sfx.splat)
            if bol.stats4 == true then
            transition.cancel(trans_1.trans4)
            timer.cancel(time_.time_4)
            end
            bol.trans_4 = false 
            bol.stats4 = false
            num.score = num.score + 100
            num.monkill = num.monkill + 1
            num.tapped = num.tapped + 1
            alientap[num.tapped] = external.sprite.newSprite(external.spritefactory.spritedeadmob)
            alientap[num.tapped].x = target.x
            alientap[num.tapped].y = target.y
        if target.id == "goor_line_4" then
            alientap[num.tapped]:prepare("dead_2")
        elseif target.id == "guz_line_4" then
            alientap[num.tapped]:prepare("dead_3")  
        elseif target.id == "giz_line_4" then
            alientap[num.tapped]:prepare("dead_1")    
        end
        alientap[num.tapped]:play()
        alientap[num.tapped]:addEventListener( "sprite", spriteListener )
        target:removeSelf()
        target.id = nil
        elseif phase == "began" and target.id == "human_line_1" then
        audio.play(external.sfx.humanfail)
            if bol.stats1 == true then
                transition.cancel(trans_1.trans1)
                timer.cancel(time_.time_1)
            end
            gameoverscreen ()
            timer.cancel(time_.game)
            bol.trans_1 = false  
            bol.stats1 = false
        elseif phase == "began" and target.id == "human_line_2" then        
            audio.play(external.sfx.humanfail)
            if bol.stats2 == true then
                transition.cancel(trans_1.trans2)
                timer.cancel(time_.time_2)
            end
            gameoverscreen ()
            timer.cancel(time_.game)
            bol.trans_2 = false  
            bol.stats2 = false
        elseif phase == "began" and target.id == "human_line_3" then 
            audio.play(external.sfx.humanfail)
            if bol.stats3 == true then
                transition.cancel(trans_1.trans3)
                timer.cancel(time_.time_3)
            end
            gameoverscreen ()
            timer.cancel(time_.game)
            bol.trans_3 = false 
            bol.stats3 = false
        elseif phase == "began" and target.id == "human_line_4" then 
            audio.play(external.sfx.humanfail)
            if bol.stats4 == true then
                transition.cancel(trans_1.trans4)
                timer.cancel(time_.time_4)
            end
            gameoverscreen ()
            timer.cancel(time_.game)
            bol.trans_4 = false 
            bol.stats4 = false
        elseif phase == "began" and target.id == "clock_line_1" then
            audio.play(external.sfx.sound_10)
            if bol.stats1 == true then
                transition.cancel(trans_1.trans1)
                timer.cancel(time_.time_1)
            end
            bol.trans_1 = false 
            bol.stats1 = false
            addclockers (target.x,target.y)
            target:removeSelf()
            target.id = nil
        elseif phase == "began" and target.id == "clock_line_2" then
            audio.play(external.sfx.sound_10)
            if bol.stats2 == true then
                transition.cancel(trans_1.trans2)
                timer.cancel(time_.time_2)
            end
            bol.trans_2 = false  
            bol.stats2 = false
            addclockers (target.x,target.y)
            target:removeSelf()
            target.id = nil
        elseif phase == "began" and target.id == "clock_line_3" then
            audio.play(external.sfx.sound_10)
            if bol.stats3 == true then
                transition.cancel(trans_1.trans3)
                timer.cancel(time_.time_3)
            end
            bol.trans_3 = false 
            bol.stats3 = false
            addclockers (target.x,target.y)
            target:removeSelf()
            target.id = nil
        elseif phase == "began" and target.id == "clock_line_4" then
            audio.play(external.sfx.sound_10)
            if bol.stats4 == true then
                transition.cancel(trans_1.trans4)
                timer.cancel(time_.time_4)
            end
            bol.trans_4 = false 
            bol.stats4 = false
            addclockers (target.x,target.y)
            target:removeSelf()
            target.id = nil
        end
    
        
end

local function changeobject (object)
    if object.id == "goor_line_1" and bol.trans_1 == false  or object.id == "guz_line_1" and bol.trans_1 == false or object.id == "giz_line_1" and bol.trans_1 == false or object.id == "human_line_1" and bol.trans_1 == false or object.id == "clock_line_1" and bol.trans_1 == false then
        bol.stats1 = false
    elseif object.id == "goor_line_2" and bol.trans_2 == false or object.id == "guz_line_2" and bol.trans_2 == false or object.id == "giz_line_2" and bol.trans_2 == false or object.id == "human_line_2" and bol.trans_2 == false or object.id == "clock_line_2" and bol.trans_2 == false then
        bol.stats2 = false
    elseif object.id == "goor_line_3" and bol.trans_3 == false or object.id == "guz_line_3" and bol.trans_3 == false or object.id == "giz_line_3" and bol.trans_3 == false or object.id == "human_line_3" and bol.trans_3 == false or object.id == "clock_line_3" and bol.trans_3 == false then
        bol.stats3 = false
    elseif object.id == "goor_line_4" and bol.trans_4 == false or object.id == "guz_line_4" and bol.trans_4 == false or object.id == "giz_line_4" and bol.trans_4 == false or object.id == "human_line_4" and bol.trans_4 == false or object.id == "clock_line_4" and bol.trans_4 == false then
        bol.stats4 = false
    end
if object.id ~= nil then
object:removeSelf()
object.id = nil 
end
end

function pop_1 ()
    if bol.trans_1 == false then
        bol.stats1 = true
        alien_1[num.alien_1]:addEventListener("touch",killthemall)
        trans_1.trans1 = transition.to(alien_1[num.alien_1],{y = map.section_1.height - 120,time = num.speed_1,onComplete = pop_1}) 
        time_.time_1 = timer.performWithDelay(num.speed_1,none_1,1)
        bol.trans_1 = true
    elseif bol.trans_1 == true then
        bol.trans_1 = false 
        trans_1.trans1 = transition.to (alien_1[num.alien_1],{y = map.section_1.height,time = num.speed_1,onComplete = changeobject})  
        time_.time_1 = timer.performWithDelay(num.speed_1,none_1,1)
         
    end
end

function pop_2 ()
    if bol.trans_2 == false then
        bol.stats2 = true
        alien_2[num.alien_2]:addEventListener("touch",killthemall)
        trans_1.trans2 = transition.to (alien_2[num.alien_2],{y =  map.section_1.y + map.section_2.height + 150,time = num.speed_2,onComplete = pop_2})
        time_.time_2 = timer.performWithDelay(num.speed_2,none_1,1)
        bol.trans_2 = true
        
    elseif bol.trans_2 == true then
        trans_1.trans2 = transition.to (alien_2[num.alien_2],{y = map.section_2.y + map.section_2.height,time = num.speed_2,onComplete = changeobject})
        time_.time_2 = timer.performWithDelay(num.speed_2,none_1,1)
        bol.trans_2 = false
    end
    
end

function pop_3 ()
    if bol.trans_3 == false then
        bol.stats3 = true
        alien_3[num.alien_3]:addEventListener("touch",killthemall)
        trans_1.trans3 = transition.to (alien_3[num.alien_3],{y = map.section_2.y + map.section_3.height + 30,time = num.speed_3,onComplete = pop_3})
        time_.time_3 = timer.performWithDelay(num.speed_3,none_1,1)
        bol.trans_3 = true
        
    elseif bol.trans_3 == true then
        trans_1.trans3 = transition.to (alien_3[num.alien_3],{y = map.section_2.y + map.section_3.height + 160,time = num.speed_3,onComplete = changeobject})
        time_.time_3 = timer.performWithDelay(num.speed_3,none_1,1)
        bol.trans_3 = false
    end
    
end

function pop_4 ()
    if bol.trans_4 == false then
        bol.stats4 = true
        alien_4[num.alien_4]:addEventListener("touch",killthemall)
        trans_1.trans4 = transition.to (alien_4[num.alien_4],{y = map.section_2.y + map.section_3.height + map.section_4.height,time = num.speed_4,onComplete = pop_4})
        time_.time_4 = timer.performWithDelay(num.speed_4,none_1,1)
        bol.trans_4 = true
        
    elseif bol.trans_4 == true then
        trans_1.trans4 = transition.to (alien_4[num.alien_4],{y = map.section_2.y + map.section_3.height + map.section_4.height + 150,time = num.speed_4,onComplete = changeobject})
        time_.time_4 = timer.performWithDelay(num.speed_4,none_1,1)
        bol.trans_4 = false
    end
    
end

function scene:createScene(event)
params = event.params
group = 
    {
    group_1 = display.newGroup(),
    group_2 = display.newGroup(),
    group_3 = display.newGroup(),
    group_4 = display.newGroup(),
    group_5 = display.newGroup(),
    group_6 = display.newGroup(),
    }
display_ = 
        {
        pausebutton     = nil,
        quitbutton      = nil,
        restartbutton   = nil,
        score           = nil,
        overscreen      = nil,
        pausescreen     = nil,
        count           = nil,
        monstertext     = nil,
        monsterimage    = nil,
        cointext        = nil,
        easybutton      = nil,
        mediumbutton    = nil,
        hardbutton      = nil,
        easyimage       = nil,
        mediumimage     = nil,
        hardimage       = nil,
        textname        = nil,
        timers          = nil,
        savebutton      = nil,
        levels          = nil,
        minibg          = nil,
        }
map = 
    {
    section_1 = nil,
    section_2 = nil,
    section_3 = nil,
    section_4 = nil,
    section_5 = nil,
    dif       = nil,
    }

num   = 
    {
    time_1 = nil,
    time_2 = nil,
    time_3 = nil,
    time_4 = nil,
    time_5 = nil,
    alien_1 = 0,
    alien_2 = 0,
    alien_3 = 0,
    alien_4 = 0,
    speed_1 = 600,
    speed_2 = 550,
    speed_3 = 700,
    speed_4 = 900,
    score   = 0,
    tapped  = 0,
    monkill = 0,
    coin    = 0,
    addcoin = 0,
    }
bol = 
    {
    trans_1 = false,
    trans_2 = false,
    trans_3 = false,
    trans_4 = false,
    trans_5 = false,
    stats1  = false,
    stats2  = false,
    stats3  = false,
    stats4  = false,
    game    = false,
    key_    = false,
    }
object =
    {
    rect_1 = nil,
    rect_2 = nil,
    rect_3 = nil,
    recx1  = nil,
    recx2  = nil,
    recx3  = nil,
    }
linenum = 
    {
    line_1 = nil,
    line_2 = nil,
    }
trans_1 = 
    {
    trans1 = nil,
    trans2 = nil,
    trans3 = nil,
    trans4 = nil,
    hold_1 = nil,
    hold_2 = nil,
    hold_3 = nil,
    hold_4 = nil,
    }
time_ = 
    {
    time_1   = nil,
    time_2   = nil,
    time_3   = nil,
    time_4   = nil,
    time_5   = nil,
    holder_1 = nil,
    holder_2 = nil,
    holder_3 = nil,
    holder_4 = nil,
    play_1   = nil,
    play_2   = nil,
    play_3   = nil,
    play_4   = nil,
    game     = nil,
    }
alien_1     = {}
alien_2     = {}
alien_3     = {}
alien_4     = {}
alientap    = {}
isPaused    = false
minuteHandler = 1
secondHandler = 0
milliHandler = 0
end

function scene:enterScene(event)
group[1] = self.view
storyboard.purgeAll()
storyboard.removeAll() 

local environment   = system.getInfo("environment")
if environment == "simulator" then
print("You're in the simulator.")
else 
system.activate("multitouch")
end

map.section_1 = display.newImageRect("background/1.png",display.contentWidth,(display.contentHeight*0.3159420289855072))
map.section_1:setReferencePoint(display.TopCenterReferencePoint)
map.section_1.x = display.contentWidth / 2
map.section_1.y = 0
map.section_1.alpha = 0
group.group_1:insert(map.section_1)

map.section_2 = display.newImageRect("background/2.png",display.contentWidth,(display.contentHeight*0.175))
map.section_2:setReferencePoint(display.TopCenterReferencePoint)
map.section_2.x = display.contentWidth / 2
map.section_2.y =  map.section_1.height - (map.section_1.height*.17)
map.section_2.alpha = 0
group.group_2:insert(map.section_2)

map.section_3 = display.newImageRect("background/3.png",display.contentWidth,(display.contentHeight*0.1885416666666667))
map.section_3:setReferencePoint(display.TopCenterReferencePoint)
map.section_3.x = display.contentWidth / 2
map.section_3.y = map.section_2.y + map.section_2.height - (map.section_2.height*.21)
map.section_3.alpha = 0
group.group_3:insert(map.section_3)

map.section_4 = display.newImageRect("background/4.png",display.contentWidth,(display.contentHeight*0.1854166666666667))
map.section_4:setReferencePoint(display.TopCenterReferencePoint)
map.section_4.x = display.contentWidth / 2
map.section_4.y = map.section_3.y + map.section_3.height - (map.section_3.height*.18)
map.section_4.alpha = 0
group.group_4:insert(map.section_4)

map.section_5 = display.newImageRect("background/5.png",display.contentWidth,(display.contentHeight*0.3541666666666667))
map.section_5:setReferencePoint(display.TopCenterReferencePoint)
map.section_5.x = display.contentWidth / 2
map.section_5.y = map.section_4.y + map.section_4.height - (map.section_4.height*.20)
map.section_5.alpha = 0
group.group_5:insert(map.section_5)

local function holeline_1 () 
local randompos = math.random(1,4)
local timeadd = math.random(1,20)
num.alien_1 = num.alien_1 + 1
if timeadd == 7 then
    alien_1[num.alien_1] = display.newImageRect("items/clock.png", 80, 95)
    alien_1[num.alien_1].id = "clock_line_1"
else
    if randompos == 1 then
        alien_1[num.alien_1] = display.newImageRect("items/goor.png", 80, 95)
        alien_1[num.alien_1].id = "goor_line_1"
    elseif randompos == 2 then
        alien_1[num.alien_1] = display.newImageRect("items/guz.png", 80, 95)
        alien_1[num.alien_1].id = "guz_line_1"  
    elseif randompos == 3 then
        alien_1[num.alien_1] = display.newImageRect("items/giz.png", 80, 95)
        alien_1[num.alien_1].id = "giz_line_1"
    elseif randompos == 4 then
        alien_1[num.alien_1] = display.newImageRect("items/human.png", 80, 95)
        alien_1[num.alien_1].id = "human_line_1"
    end    
end
alien_1[num.alien_1]:setReferencePoint(display.TopCenterReferencePoint)
local poshuman = math.random(1,3)
if poshuman == 1 then
    alien_1[num.alien_1].x  = map.section_1.width - (map.section_1.width*.82)
elseif poshuman == 2 then
    alien_1[num.alien_1].x  = map.section_1.width / 2 + 5
elseif poshuman == 3 then
    alien_1[num.alien_1].x  = map.section_1.width - (map.section_1.width*.17)
end
alien_1[num.alien_1].y  = map.section_1.height
group.group_1:insert(alien_1[num.alien_1])
pop_1()
end

local function holeline_2 () 
local randompos = math.random(1,2)
local randomimg = math.random(1,4)
local timeadd   = math.random(1,20)
num.alien_2 = num.alien_2 + 1
if timeadd == 13 then
    alien_2[num.alien_2] = display.newImageRect("items/clock.png", 80, 95)
    alien_2[num.alien_2].id = "clock_line_2" 
else
    if randomimg == 1 then
        alien_2[num.alien_2] = display.newImageRect("items/goor.png", 80, 95)
        alien_2[num.alien_2].id = "goor_line_2"
    elseif randomimg == 2 then
        alien_2[num.alien_2] = display.newImageRect("items/guz.png", 80, 95)
        alien_2[num.alien_2].id = "guz_line_2"  
    elseif randomimg == 3 then
        alien_2[num.alien_2] = display.newImageRect("items/giz.png", 80, 95)
        alien_2[num.alien_2].id = "giz_line_2"
    elseif randomimg == 4 then
        alien_2[num.alien_2] = display.newImageRect("items/human.png", 80, 95)
        alien_2[num.alien_2].id = "human_line_2"
    end    
end

alien_2[num.alien_2]:setReferencePoint(display.TopCenterReferencePoint)
if randompos == 1 then
    alien_2[num.alien_2].x  = map.section_2.width*.25 + 20
elseif randompos == 2 then
    alien_2[num.alien_2].x  =map.section_2.width - map.section_2.width*.28
end
alien_2[num.alien_2].y  = map.section_2.y + map.section_2.height 
group.group_2:insert(alien_2[num.alien_2])
pop_2()
end

local function holeline_3 () 
local randompos = math.random(1,4)
local timeadd   = math.random(1,20)
num.alien_3 = num.alien_3 + 1
if timeadd == 16 then
    alien_3[num.alien_3] = display.newImageRect("items/clock.png", 80, 95)
    alien_3[num.alien_3].id = "clock_line_3"
else
    if randompos == 1 then
        alien_3[num.alien_3] = display.newImageRect("items/goor.png", 80, 95)
        alien_3[num.alien_3].id = "goor_line_3"
    elseif randompos == 2 then
        alien_3[num.alien_3] = display.newImageRect("items/guz.png", 80, 95)
        alien_3[num.alien_3].id = "guz_line_3"  
    elseif randompos == 3 then
        alien_3[num.alien_3] = display.newImageRect("items/giz.png", 80, 95)
        alien_3[num.alien_3].id = "giz_line_3"
    elseif randompos == 4 then
        alien_3[num.alien_3] = display.newImageRect("items/human.png", 80, 95)
        alien_3[num.alien_3].id = "human_line_3"
    end   
end
alien_3[num.alien_3]:setReferencePoint(display.TopCenterReferencePoint)
local poshuman = math.random(1,3)
if poshuman == 1 then
    alien_3[num.alien_3].x  = map.section_1.width - (map.section_1.width*.82)
elseif poshuman == 2 then
    alien_3[num.alien_3].x  = map.section_1.width / 2 + 5
elseif poshuman == 3 then
    alien_3[num.alien_3].x  = map.section_1.width - (map.section_1.width*.17)
end
alien_3[num.alien_3].y  = map.section_2.y + map.section_3.height + 160
group.group_3:insert(alien_3[num.alien_3])
pop_3()
end

local function holeline_4 () 
local randompos = math.random(1,2)
local randomimg = math.random(1,4)
local timeadd   = math.random(1,20)

num.alien_4 = num.alien_4 + 1

if timeadd == 13 then
    alien_4[num.alien_4] = display.newImageRect("items/clock.png", 80, 95)
    alien_4[num.alien_4].id = "clock_line_4"
else
    if randomimg == 1 then
        alien_4[num.alien_4] = display.newImageRect("items/goor.png", 80, 95)
        alien_4[num.alien_4].id = "goor_line_4"
    elseif randomimg == 2 then
        alien_4[num.alien_4] = display.newImageRect("items/guz.png", 80, 95)
        alien_4[num.alien_4].id = "guz_line_4"  
    elseif randomimg == 3 then
        alien_4[num.alien_4] = display.newImageRect("items/giz.png", 80, 95)
        alien_4[num.alien_4].id = "giz_line_4"
    elseif randomimg == 4 then
        alien_4[num.alien_4] = display.newImageRect("items/human.png", 80, 95)
        alien_4[num.alien_4].id = "human_line_4"
    end
end

alien_4[num.alien_4]:setReferencePoint(display.TopCenterReferencePoint)
if randompos == 1 then
    alien_4[num.alien_4].x  = map.section_2.width*.25 + 20
elseif randompos == 2 then
    alien_4[num.alien_4].x  =map.section_2.width - map.section_2.width*.28
end
alien_4[num.alien_4].y  = map.section_2.y + map.section_3.height + map.section_4.height + 150
group.group_4:insert(alien_4[num.alien_4])
pop_4()
end 

local function start ()
time_.play_1 = timer.performWithDelay(2500,holeline_1,0)
time_.play_2 = timer.performWithDelay(3000,holeline_2,0)
time_.play_3 = timer.performWithDelay(3500,holeline_3,0)
time_.play_4 = timer.performWithDelay(4000,holeline_4,0)
bol.game = true

display_.score = display.newEmbossedText("Score: "..num.score, 10, 10, "BadaBoom BB", 40,{ 255, 255, 255, 255 });
display_.score:setReferencePoint(display.CenterLeftReferencePoint);
display_.score.x = w_ - 300;  
display_.score.y = display.contentHeight - 50;    
display_.score:setTextColor( 153, 153, 153 )
group.group_6:insert(display_.score);
display_.score:setEmbossColor( color )

display_.monsterimage = display.newImageRect("button/icon/smallsymbol.png",100,100)
display_.monsterimage:setReferencePoint(display.CenterLeftReferencePoint)
display_.monsterimage.x = w_ - 300;
display_.monsterimage.y = display.contentHeight - 130; 
group.group_6:insert(display_.monsterimage)

display_.monstertext = display.newEmbossedText(" x "..num.monkill, 10, 10, "BadaBoom BB", 50,{ 255, 255, 255, 255 });
display_.monstertext:setReferencePoint(display.CenterLeftReferencePoint);
display_.monstertext.x = display_.monsterimage.x + display_.monsterimage.width + 20
display_.monstertext.y = display.contentHeight - 130;    
display_.monstertext:setTextColor( 153, 153, 153 )
group.group_6:insert(display_.monstertext);
display_.monstertext:setEmbossColor( color )
Runtime:addEventListener("enterFrame", updatestats)
end

display_.count   = display.newEmbossedText("", 10, 10, "BadaBoom BB", 120,{ 255, 255, 255, 255 });
display_.count:setReferencePoint(display.CenterReferencePoint);
display_.count.x = w_ ;  
display_.count.y = h_;    
display_.count:setTextColor( 255, 0, 0 )
group.group_6:insert(display_.count); 

display_.levels   = display.newEmbossedText("", 10, 10, "BadaBoom BB", 70);
display_.levels:setReferencePoint(display.TopLeftReferencePoint);
display_.levels.x = 30 ;  
display_.levels.y = 30;    
display_.levels:setTextColor( 0, 0, 153 )
group.group_6:insert(display_.levels); 
color = 
{
    highlight = 
    {
        r =0, g = 0, b = 80, a = 255
    },
    shadow =
    {
        r = 0, g = 0, b = 0, a = 255
    }
}
display_.count:setEmbossColor( color )

local function removecounttext (text_)
display_.levels:setText(text_.id)
display_.levels:setReferencePoint(display.TopLeftReferencePoint);
display_.levels.x = 30 ;
text_:removeSelf()
text_.id = nil
text_ = nil
end
local count_ = 0
timer.performWithDelay( 2000, function() 
    if params.scenename == "mainrestart" or params.scenename == "gametype" then
        external.adshow.loading("hide")
    end
local function countstart (event)
    if event.phase == "ended" then
        timer.performWithDelay(500, function()
        if count_ == 0 then
            display_.count:setText("R E A D Y")
            display_.count:setReferencePoint(display.CenterReferencePoint);
            display_.count.x = w_ ; 
            audio.play(external.sfx.star)
        elseif count_ == 1 then
            display_.count:setText("S E T")
            display_.count:setReferencePoint(display.CenterReferencePoint);
            display_.count.x = w_ ;
            audio.play(external.sfx.star)
        elseif count_ == 2 then
            display_.count:setText("G O")
            display_.count:setReferencePoint(display.CenterReferencePoint);
            display_.count.x = w_ ;
            audio.play(external.sfx.star)
        elseif count_ == 3 then
            display_.count:setText("Game On!")
            display_.count:setReferencePoint(display.CenterReferencePoint);
            display_.count.x = w_ ;
            display_.count.id = event.target.id
            transition.to(display_.count,{alpha = 0,time = 500,onComplete = removecounttext})
            audio.play(external.sfx.sound_9)
            audio.play( external.sfx.sound_13,{loops= -1,channel = 18} )
            audio.setVolume( 0.4, { channel=18} )
            Runtime:removeEventListener( "key", none )
            Runtime:addEventListener( "key", pauseallgame )
            start()
            timerstart()
        end
         count_ = count_ + 1   
        end,4)
    if event.target.id == "easy" then
        num.speed_1 = 600
        num.speed_2 = 650
        num.speed_3 = 700
        num.speed_4 = 900
        num.addcoin = 1
    elseif event.target.id == "medium" then
        num.speed_1 = 550
        num.speed_2 = 500
        num.speed_3 = 650
        num.speed_4 = 600
        num.addcoin = 2
    elseif event.target.id == "hard" then
        num.speed_1 = 400
        num.speed_2 = 400
        num.speed_3 = 450
        num.speed_4 = 450
        num.addcoin = 3
    end
    map.dif = event.target.id
    display_.easybutton:removeSelf()
    display_.easybutton = nil
    display_.mediumbutton:removeSelf()
    display_.mediumbutton = nil
    display_.hardbutton:removeSelf()
    display_.hardbutton = nil
    display_.minibg:removeSelf()
    display_.minibg = nil
    map.section_1.alpha = 1
    map.section_2.alpha = 1
    map.section_3.alpha = 1
    map.section_4.alpha = 1
    map.section_5.alpha = 1
    display_.pausebutton.alpha = 1
    end
end
display_.minibg = display.newImageRect("background/minibg.png",display.contentWidth,display.contentHeight)
display_.minibg:setReferencePoint(display.CenterReferencePoint)
display_.minibg.x = display.contentWidth / 2
display_.minibg.y = display.contentHeight / 2
group.group_6:insert(display_.minibg)

display_.mediumbutton = external.widget.newButton
{
    defaultFile     = "items/medium.png",
    overFile        = "items/mediumover.png",
    id              = "medium",
    width           = 300, 
    height          = display.contentHeight*.2375,
    onRelease       = countstart,
}
display_.mediumbutton:setReferencePoint(display.CenterReferencePoint)
display_.mediumbutton.x = w_
display_.mediumbutton.y = h_
group.group_6:insert(display_.mediumbutton)

display_.easybutton = external.widget.newButton
{
    defaultFile     = "items/easy.png",
    overFile        = "items/easyover.png",
    id              = "easy",
    width           = 300, 
    height          = display.contentHeight*.2375,
    onRelease       = countstart,
}
display_.easybutton:setReferencePoint(display.BottomCenterReferencePoint)
display_.easybutton.x = w_ 
display_.easybutton.y = display_.mediumbutton.y - 30 - (display_.mediumbutton.height/2)
group.group_6:insert(display_.easybutton)


display_.hardbutton = external.widget.newButton
{
    defaultFile     = "items/hard.png",
    overFile        = "items/hardover.png",
    id              = "hard",
    width           = 300, 
    height          = display.contentHeight*.2375,
    onRelease       = countstart,
}
display_.hardbutton:setReferencePoint(display.TopCenterReferencePoint)
display_.hardbutton.x =  w_
display_.hardbutton.y = (display_.mediumbutton.height/2) + display_.mediumbutton.y + 30
group.group_6:insert(display_.hardbutton)
end,1)

display_.pausebutton = external.widget.newButton
{
    defaultFile     = "button/orange/pause.png",
    overFile        = "button/orange/pausetap.png",
    width           = 80, 
    height          = 80,
    onRelease   = pauseallgame,
}
display_.pausebutton.x = display.contentWidth - 50
display_.pausebutton.y = 50
display_.pausebutton.alpha = 0
group.group_6:insert(display_.pausebutton) 

group[1]:insert(group.group_1)    
group[1]:insert(group.group_2)
group[1]:insert(group.group_3)
group[1]:insert(group.group_4)
group[1]:insert(group.group_5)
group[1]:insert(group.group_6) 

Runtime:addEventListener( "key", none )
end

function scene:exitScene(event)
external.adshow.loading("show")     
Runtime:removeEventListener( "touch", onTouched_ )
Runtime:removeEventListener( "key", pauseallgame )
Runtime:removeEventListener("enterFrame", updatestats)
timer.performWithDelay(1000, function()
audio.stop()
end, 1)

local environment   = system.getInfo("environment")
if environment == "simulator" then
print("You're in the simulator.")
else 
system.deactivate("multitouch")
end

if bol.key_ == true then
    
end
group.group_1:removeSelf()
group.group_1 = nil
group.group_2:removeSelf()
group.group_2 = nil
group.group_3:removeSelf()
group.group_3 = nil
group.group_4:removeSelf()
group.group_4 = nil
group.group_5:removeSelf()
group.group_5 = nil
group.group_6:removeSelf()
group.group_6 = nil
end

function scene:destroyScene(event)

group[1]:removeSelf()
group[1] = nil
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene