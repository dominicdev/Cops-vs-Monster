
display.setStatusBar(display.HiddenStatusBar)
local widget = require "widget"
local sprite = require("sprite")
local physics = require("physics")
local storyboard = require "storyboard"
local adshow = require "luafile.adshow"
local spritefactory = require "luafile.spritefactory";
local sfx   =   require "luafile.sfx"
local scene = storyboard.newScene()
local h = display.contentHeight / 2
local w = display.contentWidth / 2
local controller = {}
local spritesset = {}
local flamers = {}
local mobrun = {}
local howto = {}
local group = {}
local human = {}
local numhuman = 0
local dis = {}
local cal = {}
local mobcount = 0
local buttonnext
local backbutton
local spriteListener
local finger 
local flash
local dead = {}
local deadnumber = 0
local bg
local scenefrom
local scroller

local function onSceneTouch(event)
    local switch = event.target
    audio.play(sfx.clicksound)
    if switch.id == "back" then
         audio.play(sfx.clicksound)
        local scenefrom = {
                            effect  = "fade",
                            time    = 500,
                            params  = 
                            {
                                scenename = "howto"
                            }
       }
        storyboard.gotoScene( "luafile.menu",scenefrom)
        --adshow.calladmob("hide")
       -- adshow.loading("show") 
    elseif switch.id == "next" then
       storyboard.gotoScene( "luafile.howto_1","slideLeft",1000) 
    end

end

function scene:createScene( event )
group[1] = self.view

bg = display.newImageRect("background/Lvl_1.png",display.contentWidth,display.contentHeight)
--bg:scale( 2, 2.5 )
bg.x = w
bg.y = h
group[1]:insert(bg)

function none (event)
    
    
end

Runtime:addEventListener( "key", none );
end

function scene:enterScene( event )
physics.start()
--adshow.calladmob("show")

scenefrom = event.params

storyboard.purgeAll()
storyboard.removeAll()

physics.setGravity(0,1.5)
h = display.contentHeight / 2
w = display.contentWidth / 2
deadnumber = 0
group[1] = self.view
group[2] = display.newGroup();
group[3] = display.newGroup();
group[4] = display.newGroup();
group[5] = display.newGroup();

controller [1]= false
controller [2]= false
controller [3]= false

finger = display.newImageRect("items/finger.png", 62, 83)
finger:setReferencePoint(display.CenterReferencePoint)
finger.x = w - w*.5
finger.y = h + 280
physics.addBody(finger,"static" ,{density = 0.1, bounce = 0,firction = 0})
finger.alpha = 0
finger:scale( 2, 2)
group[3]:insert(finger)

--dis[1] = display.newImageRect ("button/woodbutton/woodbtn.png",340,280)
--dis[1]:setReferencePoint(display.CenterReferencePoint)
--dis[1].x = w + 130
--dis[1].y = h + 270
--group[5]:insert(dis[1])

--dis[1] = display.newRect(0,0, 160, 130)
--dis[1]:setReferencePoint(display.CenterReferencePoint)
--dis[1]:setillColor(255, 102, 102, 100)
--dis[1]:scale( 2, 2)
--dis[1].x = w + 140
--dis[1].y = h + 270
--group[5]:insert(dis[1])

dis[2] = display.newImageRect("background/instruction1.png",display.contentWidth*.6,display.contentHeight*0.5)
dis[2]:setReferencePoint(display.CenterRightReferencePoint)
dis[2].x =  display.contentWidth - 10
dis[2].y = display.contentHeight*0.5
group[5]:insert(dis[2])

local rect_ = display.newRect(0,0, display.contentWidth, 10)
rect_:setReferencePoint(display.CenterReferencePoint)
rect_.x = display.contentWidth / 2
rect_.y = display.contentHeight - 50
physics.addBody(rect_,"static" ,{density = 0.1, bounce = 0,firction = 0})
rect_.myName = "flames"
group[3]:insert(rect_)
rect_.alpha = 0

function spriteListener (event)
    
    if event.phase == "end" then   
    event.sprite:removeSelf()
    howto[3] = timer.performWithDelay(500, mobmoving, 1)
    controller[2] = true  
    end
    
end

 local function deadmobs (hit)
    
    local x1 = hit.x
    local y1 = hit.y
    deadnumber = deadnumber + 1
    dead[deadnumber] = sprite.newSprite(spritefactory.spritedeadmob_)
    
    dead[deadnumber].x = x1
    dead[deadnumber].y = y1
    
    if hit.id == "runner 1" then
      dead[deadnumber]:prepare("dead_2")  
    elseif hit.id == "runner 2" then
      dead[deadnumber]:prepare("dead_2")
    elseif hit.id == "runner 3" then
      dead[deadnumber]:prepare("dead_3")
    elseif hit.id == "runner 4" then
      dead[deadnumber]:prepare("dead_4") 
    end

    dead[deadnumber]:play()
    group[2]:insert(dead[deadnumber])
    dead[deadnumber]:addEventListener( "sprite", spriteListener )
    hit:removeSelf() 
    hit.id = nil
end

local function fingerback (fingers)
audio.play(sfx.sound_2)
transition.to(fingers,{x = w - w*.5,y = h + 280, time = 500})
end

function mobmoving (event)
    
controller[4] = false
local mobnum       = 1--math.random(1,4)
mobcount           = mobcount + 1
mobrun[mobcount]   = sprite.newSprite(spritefactory.alien_2)
mobrun[mobcount].y = -10
mobrun[mobcount].x = w - w*.5

if mobnum == 1 then
    
    mobrun[mobcount]:prepare("alien_2")  
    mobrun[mobcount]:play()
    mobrun[mobcount].id = "runner 1" 
    
elseif mobnum == 2 then
    
    mobrun[mobcount]:prepare("running2")  
    mobrun[mobcount]:play()
    mobrun[mobcount].id = "runner 2"  
    
elseif mobnum == 3 then
        
    mobrun[mobcount]:prepare("running3")  
    mobrun[mobcount]:play()
    mobrun[mobcount].id = "runner 3"
elseif mobnum == 4 then
        
    mobrun[mobcount]:prepare("running4")  
    mobrun[mobcount]:play()
    mobrun[mobcount].id = "runner 4"   

end

physics.addBody(mobrun[mobcount],"static" ,{density = 0.1, bounce = 0,firction = 0})
howto[1] = transition.to(mobrun[mobcount],{y = h - 100, time = 1500, onComplete = deadmobs})
group[2]:insert(mobrun[mobcount])
finger.alpha = 1

howto[2] = transition.to(finger,{x = mobrun[mobcount].x + 10, y = h - 30, time = 1500, onComplete = fingerback})
controller[1] = true  
end

backbutton = widget.newButton
    {
        defaultFile     = "button/orange/home.png",
        overFile        = "button/orange/hometap.png",
        width           = 80, 
        height          = 80,
        emboss          = true,
        id              = "back",
        onRelease       = onSceneTouch,
    }
backbutton.x = w - 240
backbutton.y = 80
backbutton.alpha = 0
transition.to(backbutton,{alpha = 1,time = 600})
group[3]:insert(backbutton)

buttonnext = widget.newButton
    {
        defaultFile     = "button/orange/right.png",
        overFile        = "button/orange/righttap.png",
        width           = 80, 
        height          = 80,
        emboss          = true,
        id              = "next",
        onRelease       = onSceneTouch,
    }
buttonnext.x = w + 240
buttonnext.y = 80
buttonnext.alpha = 0
transition.to(buttonnext,{alpha = 1,time = 600})
group[3]:insert(buttonnext)

group[1]:insert(group[2])
group[1]:insert(group[3])
group[1]:insert(group[5])
group[1]:insert(group[4])

howto[4] = timer.performWithDelay(3000, mobmoving, 1)
controller[4] = true

function onKeyEvent( event )
        if event.keyName == "back" and event.phase == "down" then 
            local scenefrom = {
                                    effect  = "slideUp",
                                    time    = 500,
                                    params  = 
                                    {
                                        scenename = "howto"
                                    }
               }
                storyboard.gotoScene( "luafile.menu",scenefrom)
                --adshow.calladmob("hide")
                adshow.loading()
                return true
        end 
end

Runtime:addEventListener( "key", onKeyEvent );
timer.performWithDelay(1000, function ()
--adshow.loading("hide") 
end, 1)
end

function scene:exitScene( event )

if controller[1] == true then
    transition.cancel(howto[1])
    transition.cancel(howto[2])
    print("stop")
end

if controller[2] == true then
    timer.cancel(howto[3]) 
end

if controller[4] == true then
    timer.cancel(howto[4]) 
end

Runtime:removeEventListener( "key", onKeyEvent );
Runtime:removeEventListener( "key", none );
group[3]:removeSelf()
group[3] = nil
group[4]:removeSelf()
group[4] = nil
group[5]:removeSelf()
group[5] = nil
group[2]:removeSelf()
group[2] = nil
end

function scene:destroyScene( event )
print( "((destroying scene howt0_1's view))" )


group[1]:removeSelf()
group[1] = nil
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "destroyScene", scene )
scene:addEventListener( "exitScene", scene )

return scene