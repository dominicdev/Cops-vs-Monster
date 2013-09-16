
display.setStatusBar(display.HiddenStatusBar)
local w = display.contentWidth / 2
local h = display.contentHeight / 2
local widget = (require "widget")
local sprite = require("sprite")
local physics = require("physics")
local storyboard = require "storyboard"
local adshow = require "luafile.adshow"
local spritefactory = require "luafile.spritefactory";
local sfx = require "luafile.sfx";
local scene = storyboard.newScene()
local controller = {}
local spritesset = {}
local playexplode = {}
local carrun = {}
local bump = {}
local carpow = {}
local barelreper = {}
local flamers = {}
local cardeader = {}
local mobruner = {}
local barreler = {}
local ticker = {}
local howto = {}
local group = {}
local dis = {}
local cal = {}
local carrunnum = 0
local mobcount = 0
local barelnum = 0
local cardeadnum = 0
local barrelbacknum = 0
local lasernumber = 1
local laserbutton = {}
local carpowbutton
local backbutton
local menubutton
local scroller
local out = true
local bg
local colortimer
local mobmoving
local striker
local none
local addbarrel
local onTouch
local onKeyEvent
local function onSceneTouch(event)
    out  = false
    audio.play(sfx.clicksound)
    transition.cancel(colortimer)
    print(event.phase)
    if event.phase == "ended" then
        if event.target.id == "back" then
            local scenefrom = {
                            effect = "slideRight",
                            time = 1000,
                            params = {
                                scenename = "howto_1"
                            }
                       }
            storyboard.gotoScene( "luafile.howto",scenefrom)
        elseif event.target.id == "menu" then
            local scenefrom = {
                            effect = "slideRight",
                            time = 1000,
                            params = {
                                scenename = "howto_1"
                            }
                       }
            storyboard.gotoScene( "luafile.menu",scenefrom)
            adshow.loading("show") 
        end
        
    end
    
return true
end

local function stopnow (event)
if out  == true then
--scroller.alpha = 1
ticker[9] = false
--laserbutton:setEnabled(true)
dis[6]:pause()
dis[6]:removeSelf()
dis[6] = nil
laserbutton[lasernumber]:addEventListener( "touch", onTouch )
end
end

function striker (locy)
ticker[9] = true
dis[6] = sprite.newSprite(spritefactory.spritelaser)
dis[6].x = w 
dis[6].y = locy
dis[6]:prepare("strike")  
dis[6]:play()

group[3]:insert(dis[6])
physics.addBody(dis[6],"static",{density = 1, bounce = 0,isSensor = true});
dis[6].alpha = 0.8
dis[6].myName = "laserobj" --laser"
timer.performWithDelay(3000, stopnow, 1)    
end


function scene:createScene( event )
group[1] = self.view

bg = display.newImageRect("background/Lvl_1.png",display.contentWidth,display.contentHeight)
--bg:scale(2,2.5)
bg.x = w
bg.y = h
group[1]:insert(bg)

function none (event)
    
    
end
Runtime:addEventListener( "key", none );

end

function scene:enterScene( event )
    
physics.start()
physics.setGravity(0,1.5)
storyboard.purgeAll()
storyboard.removeAll()
group[1] = self.view

group[2] = display.newGroup();
group[3] = display.newGroup();
group[4] = display.newGroup();
group[5] = display.newGroup();
ticker[1] = 0
barrelbacknum = 0

--scroller = widget.newScrollView{
--width = 320,
--height = 240,
--maskFile= "background/mask-160x120.png",
--hideBackground = true,
--hideScrollBar = true,
--}
--scroller.x = scroller.x + 230
--scroller.y = scroller.y + h + 120
--group[5]:insert(scroller)

controller [1]= false
controller [2]= false
controller [3]= false
carpow[5] = false
ticker[14] = false

dis[2] = display.newImageRect ("background/instruction2.png",display.contentWidth*0.5 + 130,display.contentHeight*.4 - 100)
dis[2]:setReferencePoint(display.BottomCenterReferencePoint)
dis[2].x = display.contentWidth / 2 - 40
dis[2].y = display.contentHeight - 30
group[3]:insert(dis[2])

for k = 1,7,1 do

    barreler[k]   =display.newImageRect("button/barrelbut/barrel.png", 64, 64);
    barreler[k].y = h + 80;
        if k == 1 then
            barreler[k].x = w;
        elseif k == 2 then
            barreler[k].x = w - 100;
        elseif k == 3 then
            barreler[k].x = w + 100;
        elseif k == 4 then
            barreler[k].x = w - 190;
        elseif k == 5 then
            barreler[k].x = w + 190;
        elseif k == 6 then
            barreler[k].x = w + 290;
        elseif k == 7 then
            barreler[k].x = w - 290;
        end

physics.addBody(barreler[k],"static",{density  = 0,bounce = 0,friction = 0});
barreler[k].myName = "barrelers";
barreler[k].id = "barrel #"..k;
group[2]:insert(barreler[k]);           
end

local rect_ = display.newRect(0,0, display.contentWidth, 10)
rect_:setReferencePoint(display.CenterReferencePoint)
rect_.x = display.contentWidth / 2
rect_.y = display.contentHeight - 50
physics.addBody(rect_,"static" ,{density = 0.1, bounce = 0,firction = 0})
rect_.myName = "flamerss"
group[3]:insert(rect_)
rect_.alpha = 0


local function spriteListenerdead (event)
    
    if event.phase == "end" then   
    event.sprite:removeSelf()
    end
    
end

function mobmoving (event)
 controller[4] = false
local mobnum       = 1--math.random(1,4)
mobcount           = mobcount + 1
mobruner[mobcount]   = sprite.newSprite(spritefactory.alien_2)
mobruner[mobcount].y = -10
mobruner[mobcount].x = (math.random(50,250))

if mobnum == 1 then
    
    mobruner[mobcount]:prepare("alien_2")  
    mobruner[mobcount]:play()
    mobruner[mobcount].id = "runner 1" 
    
elseif mobnum == 2 then
    
    mobruner[mobcount]:prepare("running2")  
    mobruner[mobcount]:play()
    mobruner[mobcount].id = "runner 2"  
    
elseif mobnum == 3 then
        
    mobruner[mobcount]:prepare("running3")  
    mobruner[mobcount]:play()
    mobruner[mobcount].id = "runner 3"
elseif mobnum == 4 then
        
    mobruner[mobcount]:prepare("running4")  
    mobruner[mobcount]:play()
    mobruner[mobcount].id = "runner 4"   

end
--mobruner[mobcount]:scale(2,2)
physics.addBody(mobruner[mobcount] ,{density = 0.1, bounce = 0,firction = 0})
mobruner[mobcount].myName = "runnerers";
group[2]:insert(mobruner[mobcount])
--controller[1] = true  
end

local function spriteend (event)
    if event.phase == "end" then   
    event.sprite:removeSelf()
    end
end

local function explodeevent(locx,locy) -- EXPLODE
    
    ticker[1] = ticker[1] + 1
    playexplode[ticker[1]]= sprite.newSprite(spritefactory.spritexplode)
   -- playexplode[ticker[1]]:scale(2,2)
    playexplode[ticker[1]].x = locx
    playexplode[ticker[1]].y = locy
    playexplode[ticker[1]]:prepare("explode")
    playexplode[ticker[1]]:play()
    group[2]:insert(playexplode[ticker[1]])
    playexplode[ticker[1]]:addEventListener( "sprite", spriteend )
    
    
end

function addbarrel (event)
    
local locbarrel = event.target
if barrelbacknum == 7 then
    barrelbacknum = 0
end
barrelbacknum = barrelbacknum + 1 
if barelnum == 0 or barelnum == -1 then
    barelnum = 0
end

--audio.play(sound[6])
barreler[barrelbacknum] = display.newImageRect("button/barrelbut/barrel.png", 64, 64);
barreler[barrelbacknum].x = locbarrel.x
barreler[barrelbacknum].y = locbarrel.y
physics.addBody(barreler[barrelbacknum],"static",{density  = 0,bounce = 0,friction = 0})
barreler[barrelbacknum].myName = "barrelers"
barreler[barrelbacknum].id = event.target.id
group[2]:insert(barreler[barrelbacknum])

event.target.id = nil
event.target:removeSelf()
group[2]:remove(locbarrel)

end


local function hitcar (left,right,hitting,spriteid)
--print("hitcar ID "..spriteid)

if hitting == "runnerers" then
    cardeader[cardeadnum]= sprite.newSprite(spritefactory.spritedeadmob_)
    if spriteid == "runner 1" then
       cardeader[cardeadnum]:prepare("dead_1")
    elseif spriteid == "runner 2" then
        cardeader[cardeadnum]:prepare("dead_2")
    elseif spriteid == "runner 3" then
        cardeader[cardeadnum]:prepare("dead_3")
    elseif spriteid == "runner 4" then
        cardeader[cardeadnum]:prepare("dead_4")
    end 
end
--cardeader[cardeadnum]:scale(2,2)
cardeader[cardeadnum].x = left
cardeader[cardeadnum].y = right
cardeader[cardeadnum]:play()
group[2]:insert(cardeader[cardeadnum])
cardeader[cardeadnum]:addEventListener( "sprite", spriteListenerdead ) 
end

local function removebump (bumpobject)
    if carpow[5]  == false then
    bumpobject:removeSelf()
    bumpobject = nil 
    end
end

local function removecar (carobject)
        if carpow[5]  == false then
            if carobject.id ~= nil then
                carobject.id  = nil
                carobject:removeSelf()
                carobject  = nil
                
                --print("car remove")
            end
        end
        ticker[14] = false
end


local function carrunning (event)
ticker[14]= true
ticker[22] = true
carrunnum  = carrunnum + 1
local carnum_ = math.random(1,4)
carrun[carrunnum] = sprite.newSprite(spritefactory.spritecar)
carrun[carrunnum].rotation = 0

bump[carrunnum] = display.newRect( 0, 0, 8, 35)


if carnum_ == 1 then
    carrun[carrunnum].x = w + 500
    carrun[carrunnum].y = h - 100
    carrun[carrunnum]:prepare("car1")
    carrun[carrunnum]:play()
    bump[carrunnum].x = carrun[carrunnum].x - 100
    bump[carrunnum].y = carrun[carrunnum].y
    bump[carrunnum].id = "bumper "..carrunnum
    ticker[16] = -200
    ticker[17] = -300

elseif carnum_ == 2 then
    carrun[carrunnum] .x = w - 500
    carrun[carrunnum] .y = h - 100
    carrun[carrunnum] :prepare("car2")
    carrun[carrunnum] :play()
    bump[carrunnum].x = carrun[carrunnum].x + 100
    bump[carrunnum].y = carrun[carrunnum].y
    bump[carrunnum].id = "bumper "..carrunnum
    ticker[16] = 580*2
    ticker[17] = 630*2

elseif carnum_ == 3 then
    carrun[carrunnum] .x = w + 500
    carrun[carrunnum] .y = h - 200
    carrun[carrunnum] :prepare("car3")
    carrun[carrunnum] :play()
    bump[carrunnum].x = carrun[carrunnum].x - 100
    bump[carrunnum].y = carrun[carrunnum].y
    bump[carrunnum].id = "bumper "..carrunnum
    ticker[16] = -200
    ticker[17] = -300

elseif carnum_ == 4 then
    carrun[carrunnum] .x = w - 500
    carrun[carrunnum] .y = h - 290
    carrun[carrunnum] :prepare("car4")
    carrun[carrunnum] :play()  
    bump[carrunnum].x = carrun[carrunnum].x + 100
    bump[carrunnum].y = carrun[carrunnum].y
    bump[carrunnum].id = "bumper "..carrunnum
    ticker[16] = 580*2
    ticker[17] = 630*2

end


carrun[carrunnum].id = "carrer "..carrunnum
bump[carrunnum].alpha = 0
physics.addBody(carrun[carrunnum],"static",{density = 5, bounce = 0});--,isSensor = true})
physics.addBody(bump[carrunnum],"static",{density = 10, bounce = 15});--,isSensor = true})
carrun[carrunnum].myName = "carrer";
bump[carrunnum].myName = "bumper";
ticker[12] = transition.to(carrun[carrunnum], {x = ticker[16], y = carrun.y,time = 2000,onComplete = removecar});
ticker[13] = transition.to(bump[carrunnum]  , {x = ticker[17], y = carrun.y,time = 2000,onComplete = removebump});
group[3]:insert(carrun[carrunnum]);
group[3]:insert(bump[carrunnum]);
carpow[5] = true
end



local loop = 0

local function carpower (event)

--carpowbutton.onRelease = none
carpowbutton:setEnabled(false)
local phase = event.phase
ticker[15] = true

if "ended" == phase then
    
        
    ticker[18] = timer.performWithDelay(2500,function(event)
    carrunning()
    loop = loop + 1
    if loop == 10 then
        ticker[15] = false
        ticker[22] = false
        carpowbutton:setEnabled(true)
        loop = 0
    end
    
    end,10) 
    
end
    
end

laserbutton[lasernumber] = display.newImageRect("button/laser/laser_1.png" ,display.contentWidth*0.125, display.contentHeight*0.0416666666666667)
laserbutton[lasernumber].x = w + 260
laserbutton[lasernumber].y = h + 140
group[3]:insert(laserbutton[lasernumber])

function onTouch( event )
	local t = event.target

    local phase = event.phase
    if "began" == phase then
            -- Make target the top-most object
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

                    if t.y > (h + 200) then
                        print("end")

                        t.x = w + 260
                        t.y = h + 140

                    else
                        
                        striker (laserbutton[lasernumber].y)
                        laserbutton[lasernumber]:removeSelf()
                        laserbutton[lasernumber]:removeEventListener( "touch", onTouch )
                        lasernumber = lasernumber + 1
                        laserbutton[lasernumber] = display.newImageRect("button/laser/laser_1.png" ,80, 40)
                        laserbutton[lasernumber].x = w + 260
                        laserbutton[lasernumber].y = h + 140
                        group[3]:insert(laserbutton[lasernumber])
                        
                    end
            end
    end
    return true
end
 
-- make 'myObject' listen for touch events
laserbutton[lasernumber]:addEventListener( "touch", onTouch )


carpowbutton = widget.newButton

    {
    defaultFile = "button/carbut/car.png",
    overFile    = "button/carbut/cartap.png",
    id          = "carpower",
    width       = 80, height = 50,
    onRelease   = carpower,
    }

carpowbutton.x = w + 260
carpowbutton.y = h + 200
group[3]:insert(carpowbutton)

menubutton = widget.newButton

    {
    defaultFile = "button/woodbutton/gotitbtn.png",
    overFile    = "button/woodbutton/gotitbtnover.png",
    id          = "menu",
    width       = 150, 
    height      = 54,
    onRelease   = onSceneTouch,
    }
menubutton:setReferencePoint(display.CenterRightReferencePoint)
menubutton.x = display.contentWidth - 10
menubutton.y = 50
menubutton.alpha = 0

group[3]:insert(menubutton)

local colornum = true
local function textcolor (event)
    if colornum == true then
        colortimer = transition.to(menubutton, {alpha = 1 , time = 500,onComplete = textcolor})
        colornum = false
    elseif colornum == false then
        colortimer = transition.to(menubutton, {alpha = 0 , time = 500,onComplete = textcolor})
        colornum = true
    end
    

end
textcolor ()
--colortimer = transition.to(menubutton, {alpha = 1 , time = 100,onComplete = textcolor})


backbutton = widget.newButton
    {
        defaultFile     = "button/orange/left.png",
        overFile        = "button/orange/lefttap.png",
        id              = "back",
        width           = 80, height = 80,
        emboss          = true,
        onRelease       = onSceneTouch,
    }
backbutton.x = w - 240
backbutton.y = 80
backbutton.alpha = 0
transition.to(backbutton,{alpha = 1,time = 600})
group[3]:insert(backbutton)

howto[4] = timer.performWithDelay(3000, mobmoving, 0)
controller[4] = true

Runtime:addEventListener("collision", function(event)
    
if((event.object1.myName == "runnerers" and event.object2.myName =="flamerss") or 
(event.object1.myName == "flamerss" and event.object2.myName =="runnerers")) then

if event.object1.myName == "runnerers" then
    event.object1:removeSelf()
    event.object1.myName = nil
elseif event.object2.myName == "runnerers" then
    event.object2:removeSelf()
    event.object2.myName = nil   
    
end

end

if((event.object1.myName == "runnerers" and event.object2.myName =="barrelers") or 
(event.object1.myName =="barrelers" and event.object2.myName =="runnerers")) then

audio.play(sfx.sound_1)

if barelnum == 7 then
    barelnum = 0
end

local function deletetext (hittext)
    hittext:removeSelf()
    hittext = nil
end

barelnum = barelnum + 1
if event.object1.myName == "runnerers" then
    
explodeevent(event.object1.x,event.object1.y)
barelreper[barelnum] = display.newImageRect("button/barrelbut/barreltap.png", 64, 64);
barelreper[barelnum].alpha = .5
barelreper[barelnum].x = event.object2.x
barelreper[barelnum].y = event.object2.y
barelreper[barelnum].id = event.object2.id
group[4]:insert(barelreper[barelnum])

event.object2.id = nil
event.object1.id = nil

elseif event.object2.myName == "runnerers" then
    
explodeevent(event.object2.x,event.object2.y)
barelreper[barelnum] = display.newImageRect("button/barrelbut/barreltap.png", 64, 64);
barelreper[barelnum].alpha = .5
barelreper[barelnum].x = event.object1.x
barelreper[barelnum].y = event.object1.y
barelreper[barelnum].id = event.object1.id
group[4]:insert(barelreper[barelnum])

event.object1.id = nil
event.object2.id = nil

end

barelreper[barelnum]:addEventListener("tap",addbarrel)

event.object1:removeSelf()
event.object1.myName = nil
event.object2:removeSelf()
event.object2.myName = nil
end


if((event.object1.myName == "runnerers" and event.object2.myName == "laserobj") or 
   (event.object1.myName == "laserobj" and event.object2.myName == "runnerers")) then

audio.play(sfx.sound_1)

if event.object2.myName == "runnerers" then
    explodeevent(event.object2.x,event.object2.y)
    event.object2:removeSelf()
    event.object2.myName=nil
    event.object2.id = nil
elseif event.object1.myName == "runnerers" then
    explodeevent(event.object1.x,event.object1.y)
    event.object1:removeSelf()
    event.object1.myName=nil
    event.object1.id = nil
end

end


if((event.object1.myName == "runnerers" and event.object2.myName =="carrer") or 
(event.object1.myName =="carrer" and event.object2.myName =="runnerers")) then

--audio.play(sound[2])

if event.object2.myName == "runnerers" then
    hitcar(event.object2.x,event.object2.y,event.object2.myName,event.object2.id)
    
    event.object2:removeSelf()
    event.object2.myName=nil
    event.object2.id = nil
elseif event.object1.myName == "runnerers" then
    hitcar(event.object1.x,event.object1.y,event.object1.myName,event.object1.id)
    
    event.object1:removeSelf()
    event.object1.myName=nil
    event.object1.id = nil
end

end

end)

group[1]:insert(group[4])
group[1]:insert(group[2])
group[1]:insert(group[3])
group[1]:insert(group[5])

function onKeyEvent ( event )
    transition.cancel(colortimer)
    if event.keyName == "back" and event.phase == "down" then
    out  = false
    local scenefrom = 
                {
                    effect = "slideRight",
                    time = 1000,
                    params = {
                        scenename = "howto_1"
                    }
                }
    storyboard.gotoScene( "luafile.howto",scenefrom)
    return true
    end
end

Runtime:addEventListener( "key", onKeyEvent );

end

function scene:exitScene( event )
    
timer.cancel(howto[4])  
Runtime:removeEventListener( "key", onKeyEvent );

if carpow[5] == true then
transition.cancel(ticker[12])
transition.cancel(ticker[13])

end
if ticker[15] == true then
    timer.cancel(ticker[18])
end
physics.stop()
group[2]:removeSelf()
group[2] = nil
group[3]:removeSelf()
group[3] = nil
group[4]:removeSelf()
group[4] = nil
group[5]:removeSelf()
group[5] = nil
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