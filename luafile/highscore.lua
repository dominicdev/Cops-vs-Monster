local external   = require "luafile.external"
local storyboard    = require "storyboard" 
local scene      = storyboard.newScene()
local fullnamet = {};
local scoret = {};
local color = {};
local wave = {};
local cover = {}
local fullnamet_1 = {};
local scoret_1  = {};
local color_1  = {};
local wave_1  = {};
local cover_1  = {}
local w = display.contentWidth / 2
local h = display.contentHeight / 2
local deletebutton
local deleterecord
local screenGroup
local scroller_1
local backbutton
local background
local surbutton
local scroller
local rowplace
local easing_1
local numbers_
local height_
local numbers
local surcon
local group
local sql_1
local mask_
local count
local db
local sql

local function onSceneTouch(event)
    if event.phase == "ended" or event.keyName == "back" and event.phase == "down" then
         audio.play(external.sfx.clicksound)
        local scenefrom = 
                    {
                        effect = "fade",
                        time = 500,
                        params = 
                        {
                            scenename = "highscore"
                        }
                    }
        storyboard.gotoScene( "luafile.menu", scenefrom ) 
        return true
    end
end

function scene:createScene( event )
screenGroup = self.view
background = display.newImageRect("background/recordsceen.png",display.contentWidth,display.contentHeight)
background.x = w
background.y = h
screenGroup:insert(background)
end

function scene:enterScene( event )
screenGroup = self.view
storyboard.purgeAll()
storyboard.removeAll() 
surcon = true 
count = 0
group = {
        surgroup = display.newGroup(),
        rushgroup= display.newGroup(),
        }
        
if display.contentHeight > 960 then
    numbers = display.contentHeight -1200
    numbers_ =  display.contentHeight - 580 
    mask_ = "background/mask560x460_.png"
    height_ = 480
else
   numbers = display.contentHeight -1050
   numbers_ =  display.contentHeight - 480 
   mask_ = "background/mask560x460.png"
   height_ = 460
end

scroller = external.widget.newScrollView
            {
                width = 560,
                height = display.contentHeight*.4791666666666667,
                maskFile= mask_,
                hideBackground = true,
                hideScrollBar = true,
            }
scroller:setReferencePoint(display.TopCenterReferencePoint);            
scroller.x = display.contentWidth / 2
scroller.y = display.contentHeight / 2 + 50
group.surgroup:insert(scroller)

scroller_1 = external.widget.newScrollView
            {
                width = 560,
                height = display.contentHeight*.4791666666666667,
                maskFile= mask_,
                hideBackground = true,
                hideScrollBar = true,
            }
scroller_1:setReferencePoint(display.TopCenterReferencePoint);            
scroller_1.x = display.contentWidth + display.contentWidth / 2
scroller_1.y = display.contentHeight / 2 + 50
group.rushgroup:insert(scroller_1)

function deleterecord (event) 

local function onComplete(event)
        if "clicked" == event.action then
            audio.play(external.sfx.clicksound)
            local t = event.index
            if t == 1 then
                
                for i = 1,#fullnamet ,1 do
                    fullnamet[i].text = " "
                    scoret[i].text = " "
                    wave[i].text = " "
                end
                for i = 1,#fullnamet_1 ,1 do
                    fullnamet_1[i].text = " "
                    scoret_1[i].text = " "
                    wave_1[i].text = " "
                end
                rowplace = -40
                count = 0
                sql = "DELETE FROM records"
                sql_1 = "DELETE FROM records2"
                for row in external.adshow.db:nrows(sql) do
                    count = count + 1

                end
                count = 0
                for row in external.adshow.db:nrows(sql_1) do
                    count = count + 1

                end
            end
        end
    end
local alert = native.showAlert( "Delete All Records", "Are You Sure?", { "YES", "NO" }, onComplete )
audio.play(external.sfx.clicksound)
end
local highscoresur   = display.newEmbossedText("SURVIVAL", 10, 10, "Dimitri", 70,{ 0, 0, 0, 255 });
highscoresur:setReferencePoint(display.CenterReferencePoint);
highscoresur.x =  display.contentWidth / 2;  
highscoresur.y = h + 30;    
highscoresur:setTextColor( 51, 51, 51 )
group.surgroup:insert(highscoresur);

local highscorerush   = display.newEmbossedText("MINI GAME", 10, 10, "Dimitri", 70,{ 0, 0, 0, 255 });
highscorerush:setReferencePoint(display.CenterReferencePoint);
highscorerush.x =  display.contentWidth / 2 + display.contentWidth 
highscorerush.y = h + 30;    
highscorerush:setTextColor( 51, 51, 51 )
group.rushgroup:insert(highscorerush);

local color = 
{
    highlight = 
    {
        r =255, g = 255, b = 255, a = 255
    },
    shadow =
    {
        r = 255, g = 255, b = 255, a = 255
    }
}
highscoresur:setEmbossColor( color )
highscorerush:setEmbossColor( color )
rowplace = numbers
count = 0
sql = "SELECT * FROM records WHERE event = 'survival' ORDER BY total DESC ";

for row in external.adshow.db:nrows(sql) do
    count = count + 1
    fullnamet[count] = display.newText(count..".Score: "..row.total, 0,0,"BadaBoom BB",40)
    fullnamet[count]:setReferencePoint(display.CenterLeftReferencePoint)
    fullnamet[count].x = 70
    fullnamet[count].y = rowplace + 150
    scoret[count] = display.newText("Name: "..row.name, 0,0,"BadaBoom BB",40)
    scoret[count]:setReferencePoint(display.CenterLeftReferencePoint)
    scoret[count].x = 70
    scoret[count].y = rowplace + 185
    wave[count] = display.newText("Wave: "..row.level, 0,0,"BadaBoom BB",36)
    wave[count]:setReferencePoint(display.CenterLeftReferencePoint)
    wave[count].x = 70
    wave[count].y = rowplace + 220
    scroller:insert(fullnamet[count])
    scroller:insert(scoret[count])
    scroller:insert(wave[count])
    rowplace = rowplace + 170
    fullnamet[count]:setTextColor( 51, 255, 51)
    scoret[count]:setTextColor(102, 0, 102)
    wave[count]:setTextColor( 0, 153, 153)
end

rowplace = numbers
count = 0
sql = "SELECT * FROM records2 ORDER BY score DESC ";

for row in external.adshow.db:nrows(sql) do
count = count + 1
fullnamet_1[count] = display.newText(count..".Score: "..row.score, 0,0,"BadaBoom BB",40)
fullnamet_1[count]:setReferencePoint(display.CenterLeftReferencePoint)
fullnamet_1[count].x = 70
fullnamet_1[count].y = rowplace + 150
fullnamet_1[count]:setTextColor( 51, 255, 51)
scroller_1:insert(fullnamet_1[count])

scoret_1[count] = display.newText("Name: "..row.name, 0,0,"BadaBoom BB",40)
scoret_1[count]:setReferencePoint(display.CenterLeftReferencePoint)
scoret_1[count].x = 70
scoret_1[count].y = rowplace + 185
scoret_1[count]:setTextColor(102, 0, 102)
scroller_1:insert(scoret_1[count])

wave_1[count] = display.newText(row.level, 0,0,"BadaBoom BB",36)
wave_1[count]:setReferencePoint(display.CenterLeftReferencePoint)
wave_1[count].x = 70
wave_1[count].y = rowplace + 220
wave_1[count]:setTextColor( 0, 153, 153)
scroller_1:insert(wave_1[count])

rowplace = rowplace + 170

end

backbutton = external.widget.newButton
        {
        defaultFile = "button/orange/home.png",
        overFile    = "button/orange/hometap.png",
        width       = 80, 
        height      = 80,
        emboss      = true,
        onRelease   = onSceneTouch,
        }
 backbutton.x = w - 240
 backbutton.y = 80
 backbutton.alpha = 0
screenGroup:insert(backbutton);

deletebutton = external.widget.newButton
        {
         defaultFile    = "button/woodbutton/deleteallbtn.png",
         overFile       = "button/woodbutton/deleteallbtnover.png",
         id             = "delete",
         width          = 180, 
         height         = 63,
         onRelease      = deleterecord
        }
deletebutton:setReferencePoint(display.CenterRightReferencePoint)        
deletebutton.x = display.contentWidth - 30
deletebutton.y = 70
deletebutton.alpha = 0
screenGroup:insert(deletebutton);

function easing_1 (event)
    if event.phase == "ended" and event.target.id == "showrush" then
        if surcon == true then
            transition.to(group.rushgroup,{x = -display.contentWidth,time = 1000,transition=easing.outExpo})
            transition.to(group.surgroup,{x = -display.contentWidth,time = 1000,transition=easing.outExpo})  
            surcon = false
            local function changeoil (object)
            object:removeSelf()
            object = nil  
            surbutton = external.widget.newButton
                    {
                    defaultFile = "button/orange/left.png",
                    overFile    = "button/orange/lefttap.png",
                    id          = "showrush",
                    width       = 80, 
                    height      = 80,
                    emboss      = true,
                    onRelease   = easing_1,
                    }
            surbutton.x = 80
            surbutton.y = h + 30;
            surbutton.alpha = 0
            screenGroup:insert(surbutton);
            transition.to(surbutton,{time = 1500,alpha = 1}) 
            end
            transition.to(surbutton,{x = 80,time = 100,transition=easing.outExpo,alpha = 0,onComplete = changeoil}) 
        elseif surcon == false then
            transition.to(group.rushgroup,{x = display.contentWidth / 2 + 50,time = 1000,transition=easing.outExpo})
            transition.to(group.surgroup,{x = 0,time = 1000,transition=easing.outExpo})
            surcon = true
            local function changeoil (object)
            object:removeSelf()
            object = nil
            surbutton = external.widget.newButton
                    {
                    defaultFile = "button/orange/right.png",
                    overFile    = "button/orange/righttap.png",
                    id          = "showrush",
                    width       = 80, 
                    height      = 80,
                    emboss      = true,
                    onRelease   = easing_1,
                    }
            surbutton.x = display.contentWidth - 80
            surbutton.y = h + 30;
            surbutton.alpha = 0
            screenGroup:insert(surbutton);
            transition.to(surbutton,{time = 1500,alpha = 1}) 
            end
            transition.to(surbutton,{x = display.contentWidth - 80,time = 100,transition=easing.outExpo,alpha = 0,onComplete = changeoil}) 
        end  
    end
end
surbutton = external.widget.newButton
        {
        defaultFile = "button/orange/right.png",
        overFile    = "button/orange/righttap.png",
        id          = "showrush",
        width       = 80, 
        height      = 80,
        emboss      = true,
        onRelease   = easing_1,
        }
surbutton.x = display.contentWidth - 80
surbutton.y = h + 30;
surbutton.alpha = 1
screenGroup:insert(surbutton);

timer.performWithDelay( 500, function() 
transition.to(deletebutton,{alpha = 1,time = 500})
transition.to(backbutton,{alpha = 1,time = 500})
end, 1 )

screenGroup:insert(group.surgroup)
screenGroup:insert(group.rushgroup)
Runtime:addEventListener( "key", onSceneTouch );
end

function scene:exitScene( event )        

Runtime:removeEventListener( "key", onSceneTouch );
for i = 1,#fullnamet ,1 do
    fullnamet[i].text = " "
    scoret[i].text    = " "
end

group.surgroup:removeSelf()
group.surgroup = nil
group.rushgroup:removeSelf()
group.rushgroup = nil
end

function scene:destroyScene( event )
screenGroup:removeSelf()
screenGroup = nil

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene