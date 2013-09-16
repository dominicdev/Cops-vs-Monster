local external      = require "luafile.external"
local storyboard    = require "storyboard"
local w             = display.contentWidth / 2
local h             = display.contentHeight / 2
local scene         = storyboard.newScene()
local numvolume     = 1
local showpopevent
local buttons 
local timerstop
local constatus
local scenefrom
local timertrans
local scroller
local devname
local texting
local twitter
local switch
local group
local popup
local color
local bg

local function followTwitterListener (event)
    
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
local toast = display.newGroup();
local function new(pText, pTime)

    local text = pText or "nil";
    local pTime = pTime;
    

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
    

twitter:follow("justTrying01")
twitter:authorise()

toast.new("Followed", 1500)
end

local function audiovolume (event)
    
    if event.phase == "ended" then
        if event.target.id == "mute" then
            audio.setVolume( 0 )
            buttons.playpause:removeSelf()
            buttons.playpause = nil
            buttons.playpause = external.widget.newButton
                {
                defaultFile = "button/audiobutton/mute.png",
                overFile    = "button/audiobutton/play.png",
                id          = "soundon",
                width       = 80, 
                height      = 80,
                emboss      = true,
                onRelease   = audiovolume,
                }
            buttons.playpause.x = 60
            buttons.playpause.y = 50
            group[2]:insert(buttons.playpause) 
            external.adshow.audiostats = false
        elseif event.target.id == "soundon" then
            audio.setVolume(numvolume)
            
            buttons.playpause:removeSelf()
            buttons.playpause = nil
            buttons.playpause = external.widget.newButton
                {
                defaultFile = "button/audiobutton/play.png",
                overFile    = "button/audiobutton/mute.png",
                id          = "mute",
                width       = 80, 
                height      = 80,
                emboss      = true,
                onRelease   = audiovolume,
                }
            buttons.playpause.x = 60
            buttons.playpause.y = 50
            group[2]:insert(buttons.playpause)
            external.adshow.audiostats = true
        end
    end 
end

local function onSceneTouch(event)
    
        switch = event.target
        audio.play(external.sfx.clicksound)
        
        --adstatus.hideads ()
        
    if switch.id == "game" then
        local option = {
                            effect  = "fade",
                            time    = 500,
                            params  = 
                            {
                                soundv = numvolume,
                                scenename = "menu",
                            }
       }
       storyboard.gotoScene( "luafile.gametype",option)
        --adshow.callflurry("Start Game")
       elseif switch.id == "highscore" then
           local scenefrom = {
                            effect  = "fade",
                            time    = 500,
                            params  = 
                            {
                                scenename = "menu"
                            }
       }
        storyboard.gotoScene( "luafile.highscore",scenefrom)
        --adshow.callflurry("View HighScore")
       elseif switch.id == "instruction" then
           local scenefrom = {
                            effect  = "fade",
                            time    = 500,
                            params  = 
                            {
                                scenename = "menu"
                            }
       }
        storyboard.gotoScene( "luafile.howto", scenefrom )
        --adshow.callflurry("Instruction")
    end
     
      --adshow.callrevmob("hide")  
end

local function ExitAppss (event)
    ----print("press")
    local keyName = event.keyName   
    
if keyName == "back" and event.phase == "down" then
    audio.play(external.sfx.clicksound)
    local function onComplete( event )
        if "clicked" == event.action then
            local i = event.index
            if 1 == i then
                if devname == "Android" then
                    native.requestExit()
                else
                  os.exit()  
                end
            elseif 2 == i then
            end
        end
    end 
  local alert = native.showAlert( "Exit Game", "Are You Sure?", { "YES", "NO" }, onComplete )
  return true
elseif keyName == "volumeUp" and event.phase == "down" then
      numvolume = numvolume + 0.1
      if numvolume > 1 then
          numvolume = 1
      end
      if numvolume > 0 then
          
            buttons.playpause:removeSelf()
            buttons.playpause = nil
            buttons.playpause = external.widget.newButton
                {
                        defaultFile = "button/audiobutton/play.png",
                        overFile    = "button/audiobutton/play.png",
                        id          = "soundon",
                        width       = 80, 
                        height      = 80,
                        emboss      = true,
                        onRelease   = audiovolume,
                }
            buttons.playpause.x = 60
            buttons.playpause.y = 50
            group[2]:insert(buttons.playpause) 
            
      end
      audio.setVolume(numvolume)
    return false  
elseif keyName == "volumeDown" and event.phase == "down" then
      numvolume = numvolume - 0.1
      if numvolume < 0 then
          numvolume = 0
            buttons.playpause:removeSelf()
            buttons.playpause = nil
            buttons.playpause = external.widget.newButton
                {
                    defaultFile = "button/audiobutton/mute.png",
                    overFile    = "button/audiobutton/play.png",
                    id          = "soundon",
                    width       = 80, 
                    height      = 80,
                    emboss      = true,
                    onRelease   = audiovolume,
                }
            buttons.playpause.x = 60
            buttons.playpause.y = 50
            group[2]:insert(buttons.playpause) 
      end
      audio.setVolume(numvolume)
    return false
    end
end

function scene:createScene( event )
--adshow.callflurry("MENU")
print("wtf")
group = {}
group[1] = self.view
group[2] = display.newGroup()
bg = display.newImageRect("background/cover.png",display.contentWidth,display.contentHeight)
bg.x = w
bg.y = h
group[1]:insert(bg)
buttons = {
        aboutbutton     = nil,
        storebutton     = nil,
        facebutton      = nil,
        twitbutton      = nil,
        insbutton       = nil,
        newbutton       = nil,
        highbutton      = nil,
        appbutton       = nil,
        playpause       = nil,
        wall            = nil,
            }
timertrans = false
constatus = false
popup = false

end

function scene:enterScene( event )
storyboard.purgeAll()
storyboard.removeAll() 
group[1] = self.view
scenefrom = event.params
Runtime:addEventListener( "key", ExitAppss )
timertrans = false
audio.play(external.sfx.backmusic,{loops = 99,channel = 1})
audio.setVolume(0.5,{channel = 1})
buttons.wall = display.newImageRect("items/iapback.png",display.contentWidth - 80,460)
buttons.wall.x = w
buttons.wall.y = h
buttons.wall.alpha = 0

scroller = external.widget.newScrollView
            {
                width = display.contentWidth - 80,
                height = 460 ,
                maskFile= "background/mask560x460.png",
                hideBackground = true,
                hideScrollBar = true,
            }
scroller:setReferencePoint(display.CenterReferencePoint)
scroller.x = w
scroller.y = h
scroller.alpha = 0
texting = display.newEmbossedText("TEAM\n8 Apps Studio\n\nWebSite:\nwww.8appstudio.com\n\nProgrammer:\nME!!\n\nGraphic Artist:\nBEA!! :D\n\n", 10, 10, "BadaBoom BB", 35,{ 0, 0, 0, 255 });
texting:setReferencePoint(display.CenterReferencePoint);
texting.x =  texting.width  - 100
texting.y = texting.height + 50
texting:setTextColor( 255, 102, 102 )

color = 
{
    highlight = 
    {
        r =0, g = 0, b = 0, a = 255
    },
    shadow =
    {
        r = 0, g = 0, b = 0, a = 255
    }
}
texting:setEmbossColor( color )
scroller:insert(texting)

local function aboutustop (object)
    if event.phase == "ended" then
        
    end
end
 
buttons.aboutbutton = external.widget.newButton
    {
        defaultFile = "button/woodbutton/aboutbtn.png",
        overFile    = "button/woodbutton/aboutbtnover.png",
        width       = 200, 
        height      = 80,
        onRelease   = function (event)
            audio.play(external.sfx.clicksound)  
            if event.phase == "ended" and timertrans == false then
            scroller.alpha = 1
            buttons.wall.alpha = 1
            timertrans = true
            else
            scroller.alpha = 0
            buttons.wall.alpha = 0
            timertrans = false
            end
        end,
    }
buttons.aboutbutton:setReferencePoint(display.CenterReferencePoint)
buttons.aboutbutton.x = w/2 - 10
buttons.aboutbutton.y = display.contentHeight - 50
buttons.aboutbutton.alpha = 0
group[2]:insert(buttons.aboutbutton)

buttons.facebutton = external.widget.newButton
{
    defaultFile = "button/facebook/tap.png",
    overFile    = "button/facebook/over.png",
    label       = "        Like US!",
    font        = "BadaBoom BB",
    id          = "facebook",
    width       = 40, 
    height      = 40,
    fontSize    = 30,
    labelAlign  = "left",
    labelColor  = { default={0, 0, 0,255}, over={153, 255, 255} },
    emboss      = true,
    onRelease   = function (event)
    audio.play(external.sfx.clicksound)
    if event.phase == "ended" then
        
        local trueDestroy;

            function trueDestroy(toast)
                toast:removeSelf();
                toast = nil;
            end

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
            local function listineralert (event)
             ----print(event.action)
             if event.action == "clicked" then
                 
                    local i = event.index
                    if i == 1 then
                        new("Check internet connection", 1500) 
                        local function networkListener_1( event )
                            if ( event.isError ) then
                                   -- --print( "Network error!")
                                    new("Network Error", 1500)
                            else
                                    system.openURL("https://www.facebook.com/8AppStudio?ref=stream")
                                    -- print ( "Connected share" )      
                            end
                        end
                        if constatus == false then
                            network.request( "https://encrypted.google.com", "GET", networkListener_1 )
                            constatus = true
                        elseif constatus == true then
                            constatus = false
                        end
                        
                    elseif i == 2 then
                        new("Check internet connection", 1500) 
                        local function networkListener_2( event )
                            if ( event.isError ) then
                                    ----print( "Network error!")
                                    new("Network Error", 1500)
                            else
                                    native.showWebPopup(20, 20, display.contentWidth - 40, display.contentHeight - 160, "https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fwww.facebook.com/pages/Home-Invation-Community/612653745441523")
                                    popup = true
                                    print ( "Connected LIKE" )      
                            end
                        end

                        if constatus == false then
                            network.request( "https://encrypted.google.com", "GET", networkListener_2 )
                            constatus = true
                        elseif constatus == true then
                            constatus = false
                        end
                    
                    elseif i == 3 then  

                    end
                end
            end
    native.showAlert( "Facebook", " Visit and Share", { "LIKE US!","Share","Cancel" },listineralert )           
      
    end
    end,}
buttons.facebutton:setReferencePoint(display.CenterLeftReferencePoint)
buttons.facebutton.x = 20
buttons.facebutton.y = 110
buttons.facebutton.alpha = 1
scroller:insert(buttons.facebutton)

buttons.twitbutton = external.widget.newButton
{
    defaultFile = "button/twitter/tap.png",
    overFile    = "button/twitter/over.png",
    label       = "        Follow US!",
    font        = "BadaBoom BB",
    id          = "twitter",
    width       = 40, 
    height      = 40,
    fontSize    = 30,
    labelAlign  = "left",
    labelColor  = { default={0, 0, 0,255}, over={153, 255, 255} },
    emboss      = true,
    onRelease   = function ()
    audio.play(external.sfx.clicksound)
    
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
local function networkListener( event )
        if ( event.isError ) then
                --print( "Network error!")
                new("Network Error", 1500)
        else
                print ( "Connected" )
                twitter = external.GGTwitter:new( "qrocz3l60SijeAe9pXTDw", "RkaWqnQ7TY93qVCxA3e9bL7K3AKyH63fQba9EoRuw",followTwitterListener)
                twitter:authorise()
                
        end
    end
 
 
    network.request( "https://encrypted.google.com", "GET", networkListener )
    
new("Check internet connection", 1500)
    
end,
}
buttons.twitbutton:setReferencePoint(display.CenterLeftReferencePoint)
buttons.twitbutton.x = 20
buttons.twitbutton.y = buttons.facebutton.y  + 50
buttons.twitbutton.alpha = 1
scroller:insert(buttons.twitbutton)

buttons.appbutton = external.widget.newButton
{
    defaultFile = "button/8app/tap.png",
    overFile    = "button/8app/over.png",
    id          = "game",
    width       = 150, 
    height      = 60,
    onRelease   = function (event)
        if event.phase == "ended" then
           
            
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



         local function networkListener_3( event )
            if ( event.isError ) then
                    --print( "Network error!")
                    new("Network Error", 1500)
            else
                    print ( "Connected" )
                    system.openURL("http://8appstudio.com")

            end
        end


        network.request( "https://encrypted.google.com", "GET", networkListener_3 )
        return toast;
    end

    function destroy(toast)
        toast.transition = transition.to(toast, {time=250, alpha = 0, onComplete = function() trueDestroy(toast) end});
    end
       new("Check internet connection", 1500)         
    end
            end,}
buttons.appbutton:setReferencePoint(display.CenterLeftReferencePoint)
buttons.appbutton.x = 20
buttons.appbutton.y = buttons.twitbutton.y  + 70
buttons.appbutton.alpha = 1
scroller:insert(buttons.appbutton)

buttons.insbutton = external.widget.newButton
{
    defaultFile = "button/woodbutton/howtoplaybtn.png",
    overFile    = "button/woodbutton/howtoplaybtnover.png",
    id          = "instruction",
    width       = 300, 
    height      = 74,
    onRelease   = onSceneTouch,
}
buttons.insbutton:setReferencePoint(display.CenterRightReferencePoint)
buttons.insbutton.x = display.contentWidth*2
buttons.insbutton.y = h  + 150

buttons.newbutton = external.widget.newButton
{
    defaultFile = "button/woodbutton/newgamebtn.png",
    overFile    = "button/woodbutton/newgamebtnover.png",
    id          = "game",
    width       = 300, 
    height      = 176,
    onRelease   = onSceneTouch,
}
buttons.newbutton:setReferencePoint(display.BottomRightReferencePoint)
buttons.newbutton.x = display.contentWidth*2
buttons.newbutton.y = buttons.insbutton.y - buttons.insbutton.height + 30

buttons.highbutton = external.widget.newButton
{
    defaultFile = "button/woodbutton/highscoresbtn.png",
    overFile    = "button/woodbutton/highscoresbtnover.png",
    id          = "highscore",
    width       = 300, 
    height      = 176,
    onRelease   = onSceneTouch,
}
buttons.highbutton:setReferencePoint(display.TopRightReferencePoint)
buttons.highbutton.x = display.contentWidth*2
buttons.highbutton.y = buttons.insbutton.y + buttons.insbutton.height - 30

if external.adshow.audiostats == true then
    
buttons.playpause = external.widget.newButton
{
        defaultFile = "button/audiobutton/play.png",
        overFile    = "button/audiobutton/mute.png",
        id          = "mute",
        width       = 80, 
        height      = 80,
        emboss      = true,
        onRelease   = audiovolume,
    }
buttons.playpause.x = 60
buttons.playpause.y = 50
elseif external.adshow.audiostats == false then
buttons.playpause = external.widget.newButton
{
        defaultFile = "button/audiobutton/mute.png",
        overFile    = "button/audiobutton/play.png",
        id          = "soundon",
        width       = 80, 
        height      = 80,
        emboss      = true,
        onRelease   = audiovolume,
    }
buttons.playpause.x = 60
buttons.playpause.y = 50    
end

buttons.storebutton = external.widget.newButton
    {
    defaultFile = "button/woodbutton/moregamesbtn.png",
    overFile    = "button/woodbutton/moregamesbtnover.png",
    width       = 211, 
    height      = 80,
    onRelease = function(event)
        audio.play(external.sfx.clicksound)
        if event.phase == "ended" then
                    local trueDestroy;
                        function trueDestroy(toast)
                            toast:removeSelf();
                            toast = nil;
                    end

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
                    local function networkListener( event )
                            if ( event.isError ) then
                                    --print( "Network error!")
                                    new("Network Error", 1500)
                            else
                                    --print ( "Connected" )
                                    external.adshow.showmore()
                                    external.adshow.calltapfortap ("appwall")
                            end
                    end


                    network.request( "https://encrypted.google.com", "GET", networkListener )

                    new("Check internet connection", 1500)
            end
        end,}
buttons.storebutton:setReferencePoint(display.CenterRightReferencePoint)
buttons.storebutton.x = display.contentWidth - 10
buttons.storebutton.y = display.contentHeight - 50
buttons.storebutton.alpha = 0

timer.performWithDelay( 1000, function() 
if (scenefrom.scenename == "gametype") or (scenefrom.scenename == "highscore") or (scenefrom.scenename == "howto") or (scenefrom.scenename == "store") then
else
    external.adshow.loading("hide")
end
timer.performWithDelay( 2500, function() 
    if external.adshow.sqlload == false then
        external.adshow.loadsql  ()
        external.adshow.sqlload = true
    end
end,1)

transition.to(buttons.newbutton, { time=1000, x= display.contentWidth, transition=easing.inOutQuad})  
transition.to(buttons.insbutton, { delay = 500,time=1000, x= display.contentWidth, transition=easing.inOutQuad}) 
transition.to(buttons.highbutton, { delay = 300,time=1000, x= display.contentWidth, transition=easing.inOutQuad}) 
transition.to(buttons.aboutbutton, { delay = 1000,time=2000, alpha = 1}) 
--transition.to(alienship, { delay = 1000,time=5000,x = display.contentWidth - 100}) 
transition.to(buttons.storebutton, { delay = 1000,time=2000, alpha = 1}) 
end, 1 )

function showpopevent(event)
    if popup == true then
        native.cancelWebPopup()
        popup = false
    end
end

Runtime:addEventListener( "touch", showpopevent )
group[2]:insert(buttons.playpause) 

group[2]:insert(buttons.newbutton)
group[2]:insert(buttons.insbutton)
group[2]:insert(buttons.highbutton)  
group[2]:insert(buttons.storebutton)
group[2]:insert(buttons.wall)
group[2]:insert(scroller)
group[1]:insert(group[2])

end

function scene:exitScene( event )
    
Runtime:removeEventListener( "touch", showpopevent )
if popup == true then
    native.cancelWebPopup()
    popup = false
end
Runtime:removeEventListener( "key", ExitAppss )
popup = false
group[2]:removeSelf()
group[2] = nil

end

function scene:destroyScene( event )  
group[1]:removeSelf()
group[1] = nil

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene