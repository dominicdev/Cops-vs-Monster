local storyboard = require "storyboard"
local external   = require "luafile.external"
local scene      = storyboard.newScene()
local w_         = display.contentWidth / 2
local h_         = display.contentHeight / 2 
local group      = nil
local object_    = nil
local button     = nil
local sql
local count = 0
local params = nil
local bg 
local numvolume 
local def_ 
local over_
local id_  
local textlabel
local level
local textalign 
local textsize
local scenestats = false
local goto = ""
local db
local trueDestroy;
-------------------------------
-- private functions
-------------------------------
function trueDestroy(toast)
    toast:removeSelf();
    toast = nil;
end

-------------------------------
-- public functions
-------------------------------
local function new(pText, pTime)

    local text = pText or "nil";
    local pTime = pTime;
    local toast = display.newGroup();

    toast.text                      = display.newText(toast, pText, 14, 12, native.systemFont, 20);
    toast.background                = display.newRoundedRect( toast, 0, 0, toast.text.width + 24, toast.text.height + 24, 16 );
    toast.background.strokeWidth    = 4
    toast.background:setFillColor(72, 64, 72)
    toast.background:setStrokeColor(96, 88, 96)

    toast.text:toFront();

    toast:setReferencePoint(toast.width*.5, toast.height*.5)
    --utils.maintainRatio(toast);
    toast.alpha = 0;
    toast.transition = transition.to(toast, {time=250, alpha = 1});

    if pTime ~= nil then
        timer.performWithDelay(pTime, function() destroy(toast) end);
    end

    toast.x = display.contentWidth * .5
    toast.y = display.contentHeight * .8

    return toast;
end

function destroy(toast)
    toast.transition = transition.to(toast, {time=250, alpha = 0, onComplete = function() trueDestroy(toast) end});
end

local function none_1 (event)
    if event.phase == "down" and event.keyName == "back" and scenestats == true then
        audio.play(external.sfx.clicksound)
        local scenefrom = {
                            effect  = "fade",
                            time    = 500,
                            params  = 
                            {   scenename   = "gametype",
                                soundv      = numvolume.soundv,
                            }
       }
        storyboard.gotoScene( "luafile.menu",scenefrom)
    return true
    end
end

local function onSceneTouch(event)
    
        local switch = event.target
        audio.play(external.sfx.clicksound)
        
        --adstatus.hideads ()
    if switch.id == "survival" and switch.stats == "unlocked" and event.phase == "ended" then
        
        level = 1
        count = 0
        local id = 1
        sql = "SELECT * FROM button WHERE level="..level.." AND id ="..id;

        for row in external.adshow.db:nrows(sql) do

        count = count + 1
        print(row.id)
        params.stage           = row.id
        params.rowid           = row.rowid
        params.monsternum      = row.monsternum
        params.damage          = row.damage
        params.speed           = row.speed
        params.masstatus       = row.masstatus
        params.mastermon       = row.mastermon
        params.masdamage       = row.masdamage
        params.masspeed        = row.masspeed
        params.highscore       = row.score
        params.level           = row.level
        params.rowid           = row.rowid
        params.bigmas          = row.bigmas
        params.bignum          = row.bignum
        params.bigdamage       = row.bigdamage
        params.bigspeed        = row.bigspeed
        params.star            = row.star
        params.monmovstats     = row.monmovstats
        params.movnum          = row.movnum
        --params.tutorial        = row.tutorial
        params.bossing         = row.bossing
        params.bossbol         = row.bossbol
        
        end

        local option = {
                            effect  = "fade",
                            time    = 500,
                            params  = 
                            {
                                stage           = params.stage,
                                monsternum      = params.monsternum,
                                damage          = params.damage,
                                speed           = params.speed,
                                masstatus       = params.masstatus,
                                mastermon       = params.mastermon,
                                masdamage       = params.masdamage,
                                masspeed        = params.masspeed,
                                highscore       = params.highscore,
                                level           = params.level,
                                rowid           = params.rowid,
                                bigmas          = params.bigmas,
                                bignum          = params.bignum,
                                bigdamage       = params.bigdamage,
                                bigspeed        = params.bigspeed,
                                star            = params.star,
                                monmovstats     = params.monmovstats,
                                movnum          = params.movnum,
                                tutorial        = "true",
                                bossing         = params.bossing,
                                bossbol         = params.bossbol,
                                soundv          = numvolume.soundv,
                                scenename       = "gametype",
                                screenfrom      = "survival",
                                rowid           = params.stage,
                            }
       }
       storyboard.gotoScene( "luafile.store",option)
        --adshow.callflurry("Start Game")
    elseif switch.id == "levels" and switch.stats == "unlocked" and event.phase == "ended" then
           local scenefrom = {
                            effect  = "fade",
                            time    = 500,
                            params  = 
                            {   scenename = "gametype",
                                soundv    = numvolume.soundv,
                                level     = switch.level,
                            }
       }
        storyboard.gotoScene( "luafile.levels",scenefrom)
    elseif switch.id == "bonus" and switch.stats == "unlocked" and event.phase == "ended" then
           local scenefrom = {
                            effect  = "fade",
                            time    = 500,
                            params  = 
                            {   scenename = "gametype",
                                soundv    = numvolume.soundv,
                                level     = switch.level,
                            }
       }
        storyboard.gotoScene( "luafile.bonus",scenefrom)
        goto = "bonus"
        external.adshow.loading("show") 
    elseif switch.id == "back" or event.phase == "down" and event.keyName == "back" then
           local scenefrom = {
                            effect  = "fade",
                            time    = 500,
                            params  = 
                            {
                                scenename = "gametype",
                                soundv    = numvolume.soundv,
                            }
       }
        storyboard.gotoScene( "luafile.menu",scenefrom)
    elseif switch.id == "survival" and switch.stats == "locked" and event.phase == "ended" then
        print("locked")
        new("Finish the Mission 1 to Unlocked Survival", 2000)
    elseif switch.id == "levels" and switch.stats == "locked" and event.phase == "ended" then 
        new("Finish the Mission 1 to Unlocked Mission 2", 2000)
    elseif switch.id == "bonus" and switch.stats == "locked" and event.phase == "ended" then
        new("Finish the Mission 2 to Unlocked Coin Rush", 2000)
    end
     
end

function scene:createScene( event )
group = self.view
bg = display.newImageRect("background/levelsScreen.png",display.contentWidth,display.contentHeight)
bg.x = w_
bg.y = h_
group:insert(bg)
Runtime:addEventListener( "key", none_1 )
end

function scene:willEnterScene(event)
button = {
         survival = nil,
         mission_1  = nil,
         mission_2  = nil,
         back     = nil,
         }    
object_ = display.newGroup()    
params = {}
end

function scene:enterScene( event )
group = self.view  
storyboard.purgeAll()
storyboard.removeAll() 
numvolume = event.params
local y_ = 0
scenestats = true
count = 0
sql = "SELECT * FROM gamestats ";

for row in external.adshow.db:nrows(sql) do

count = count + 1

if row.stats == "unlocked" then
    
    if row.gametype == "mission_1" then
        id_  = "levels"
        level = 1
        def_ = "button/woodbutton/m1btn.png"
        over_= "button/woodbutton/m1btnover.png"
    elseif row.gametype == "mission_2" then
        id_  = "levels"
        level = 2
        def_ = "button/woodbutton/m2btn.png"
        over_= "button/woodbutton/m2btnover.png"
    elseif row.gametype == "survival" then
        id_  = "survival"
        level = 0
        def_ = "button/woodbutton/survivalbtn.png"
        over_= "button/woodbutton/survivalbtnover.png"
    elseif row.gametype == "bonus" then
        id_  = "bonus"
        level = 0
        def_ = "button/woodbutton/minigame.png"
        over_= "button/woodbutton/minigameover.png"
    end
    textalign = "center"
    textsize = 50
elseif row.stats == "locked" then
    if row.gametype == "mission_1" then
       textlabel = " Mission 1"
       
    elseif row.gametype == "mission_2" then
       textlabel = "  Mission 2" 
       id_  = "levels"
    elseif row.gametype == "survival" then
       textlabel = "   Survival" 
       id_  = "survival"
    elseif row.gametype == "bonus" then
       textlabel = "   Bonus" 
       id_  = "bonus"
    end
    
    def_ = "button/woodbutton/locked.png"
    over_= "button/woodbutton/lockedover.png"
    
    textalign = "left"
    textsize = 35
    level = 0
end

button[count] = external.widget.newButton
    {
    defaultFile = def_,
    overFile    = over_,
    id          = id_,
    width       = 250, 
    height      = 80,
    onRelease   = onSceneTouch,
    }
button[count]:setReferencePoint(display.CenterReferencePoint)
button[count].x = w_
button[count].y = h_ + y_ - 160
button[count].stats = row.stats
button[count].level = level

object_:insert(button[count])
y_ = y_ + 100
end

button.back = external.widget.newButton
    {
        defaultFile = "button/orange/home.png",
        overFile    = "button/orange/hometap.png",
        id          = "back",
        width       = 80, 
        height      = 80,
        emboss      = true,
        onRelease   = onSceneTouch,
    }
button.back.x = w_ - 240
button.back.y = 80
button.back.stats = "back"
object_:insert(button.back)
external.adshow.calltapfortap("show")

timer.performWithDelay( 1000, function() 
if numvolume.scenename == "mainrestart" or numvolume.scenename == "buymenu"  then
external.adshow.loading("hide")  
end
end,1)

group:insert(object_)
end

function scene:exitScene( event )
external.adshow.calltapfortap("hide")
Runtime:removeEventListener( "key", none_1 )
object_:removeSelf()
object_ = nil 
end

function scene:destroyScene( event )
if goto == "bonus" then
    audio.stop()
end
goto = ""
group:removeSelf()
group = nil 
scenestats = false

end

scene:addEventListener( "createScene", scene )
scene:addEventListener("willEnterScene",scene)
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
