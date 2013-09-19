local external      = require "luafile.external"
local storyboard    = require "storyboard"
local scene         = storyboard.newScene()
local w             = display.contentWidth / 2
local h             = display.contentHeight / 2
local group         = {}
local bg
local switch
local dis 
local cal
local number 
local name
local stats
local onTouched_
local function onSceneTouch(event)
switch = event.targe
-- open SQLite database, if it doesn't exist, create database
--print(path)

-- setup the table if it doesn't exist
local tablesetup = "CREATE TABLE IF NOT EXISTS records (id INTEGER PRIMARY KEY, name, score,time, car, barrel,total,level,lives);"
external.adshow.db:exec( tablesetup )
--print(tablesetup)

-- save student data to database
local tablefill =[[INSERT INTO records VALUES (NULL,']] .. name.text .. [[',']] .. number[1] .. [[',']].. number[2] .. [[',']] .. number[3] .. [[',']].. number[4] .. [[',']].. number[5] ..[[',']].. number[9] ..[[');]]
external.adshow.db:exec(tablefill)
--print(tablefill )

local tablesave = [[UPDATE item SET car=']].. number[3] ..[[',barrel=']]..number[4]..[[',laser=']]..number[8]..[[',coin=']]..number[7]..[[',event=']]..stats.gametype..[[' WHERE id = 1]]
external.adshow.db:exec( tablesave )
--print(tablesave)
--number[10]..
--close database
external.adshow.db:close()
--print("db closed")
audio.play(external.sfx.clicksound)          
local scenefrom = 
            {
            effect = "fade",
            time = 600,
            params = 
                {
                    scenename = "records"
                }

            } 
storyboard.gotoScene( "luafile.menu", scenefrom  )
--adshow.inneractive ("hide") 
end

local function cancelstats (event)
if event.keyName == "back" and event.phase == "down" then
    audio.play(external.sfx.clicksound)
    local function onComplete (event)
        if "clicked" == event.action then
            local t = event.index
            if t == 1 then
                local scenefrom = 
                                {
                                effect = "fade",
                                time = 600,
                                params = 
                                    {
                                        scenename = "records"
                                    }

                                } 
                storyboard.gotoScene( "luafile.menu", scenefrom  )
                --adshow.inneractive ("hide") 
            end
        end 
    end
local alert = native.showAlert( "Don't Save Record", "Are You Sure?", { "YES", "NO" }, onComplete )    
return true  
end

end

function scene:createScene( event )
group[1] = self.view

bg = display.newImageRect("background/scoreview.png",display.contentWidth,display.contentHeight)
bg.x = w
bg.y = h
group[1]:insert(bg)
end

function scene:enterScene( event )
--adshow.inneractive ("show")    
group[1] = self.view
group[2] = display.newGroup()
dis = {}
cal = {}
number = {}

storyboard.purgeAll()
storyboard.removeAll() 

stats = event.params

Runtime:addEventListener( "key", cancelstats );
local color = 
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

number[1] = stats.uscore;
number[2] = stats.utime;
number[3] = stats.ucar;
number[4] = stats.ubarrel;
number[8] = stats.ulaser;
number[9] = stats.ulevel
number[10] = stats.ulives
number[5] = stats.uscore + (stats.utime * 3) + (stats.ucar * 500) + (stats.ubarrel * 1000) + (stats.ulaser * 5000);
number[6] = stats.ulevel*5

number[7] = stats.ucoin + number[6]

dis[9] = display.newEmbossedText("+"..number[6].." Coins", 10, 10, "Dimitri", 40,{ 255, 255, 255, 255 });
dis[9]:setReferencePoint(display.CenterReferencePoint)
dis[9].x = w 
dis[9].y = h - 200
dis[9]:setTextColor( 0, 204, 0 )
dis[9]:setEmbossColor( color )
group[2]:insert(dis[9])


dis[11] = display.newEmbossedText("WAVE# "..stats.ulevel, 10, 10, "Dimitri", 40,{ 255, 255, 255, 255 });
dis[11]:setReferencePoint(display.CenterReferencePoint)
dis[11].x = w 
dis[11].y = dis[9].y + 50
dis[11]:setTextColor( 0, 204, 0 )
dis[11]:setEmbossColor( color )
group[2]:insert(dis[11])

name = native.newTextField(0, 0, 260, 60)
name.font = native.newFont( "Consolas", 30 )
name:setReferencePoint(display.CenterReferencePoint)
name.x = w 
name.y = dis[11].y + 70
name.alpha = .3
name.inputType = "default"
name:setTextColor( 0, 0, 0, 255 )
group[2]:insert(name)

dis[1] = display.newEmbossedText("Score: "..stats.uscore.." + WAVE", 10, 10, "Dimitri", 40,{ 255, 255, 255, 255 });
dis[1]:setReferencePoint(display.CenterReferencePoint)
dis[1].x = w
dis[1].y = name.y + 80
dis[1]:setTextColor( 0, 204, 0 )
dis[1]:setEmbossColor( color )
group[2]:insert(dis[1])


dis[3] = display.newImageRect("button/carbut/car.png", 100, 60)
dis[3]:setReferencePoint(display.CenterRightReferencePoint)
dis[3].x = w - 90
dis[3].y = dis[1].y + 70
group[2]:insert(dis[3])

dis[4] = display.newEmbossedText("x "..stats.ucar.." * 2".." = "..(stats.ucar*2), 10, 10, "Dimitri", 40,{ 255, 255, 255, 255 });
dis[4]:setReferencePoint(display.CenterLeftReferencePoint)
dis[4].x = dis[3].x + 20
dis[4].y = dis[3].y
dis[4]:setTextColor( 0, 204, 0 )
dis[4]:setEmbossColor( color )
group[2]:insert(dis[4])

dis[5] = display.newImageRect("button/barrelbut/barrel.png", 70, 70)
dis[5]:setReferencePoint(display.CenterRightReferencePoint)
dis[5].x = w - 90
dis[5].y = dis[3].y  + 80
group[2]:insert(dis[5])

dis[6] = display.newEmbossedText("x "..stats.ubarrel.." * 2".." = "..(stats.ubarrel*2), 10, 10, "Dimitri", 40,{ 255, 255, 255, 255 });
dis[6]:setReferencePoint(display.CenterLeftReferencePoint)
dis[6].x = dis[5].x + 20
dis[6].y = dis[5].y
dis[6]:setTextColor( 0, 204, 0 )
dis[6]:setEmbossColor( color )
group[2]:insert(dis[6])

dis[13] = display.newImageRect("button/laser/laser_1.png" ,130, 60)
dis[13]:setReferencePoint(display.CenterRightReferencePoint)
dis[13].x =  w - 90
dis[13].y = dis[5].y + 80
group[2]:insert(dis[13])

dis[12] = display.newEmbossedText("x "..stats.ulaser.." * 2 ".." = "..(stats.ulaser*2), 10, 10, "Dimitri", 40,{ 255, 255, 255, 255 });
dis[12]:setReferencePoint(display.CenterLeftReferencePoint)
dis[12].x = dis[13].x + 20
dis[12].y = dis[13].y 
dis[12]:setTextColor( 0, 204, 0 )
dis[12]:setEmbossColor( color )
group[2]:insert(dis[12])

dis[7] = display.newEmbossedText("Total = "..number[5], 10, 10, "Dimitri", 50,{ 255, 0, 0, 255 })
dis[7]:setReferencePoint(display.CenterReferencePoint)
dis[7].x = w 
dis[7].y = dis[13].y + 70
dis[7]:setTextColor(0, 204, 0 )
dis[7]:setEmbossColor( color )
group[2]:insert(dis[7])

dis[10] = external.widget.newButton
        {
            defaultFile     = "button/woodbutton/nextbtn.png",
            overFile        = "button/woodbutton/nextbtnover.png",
            id              = "next",
            width           = 180, 
            height          = 63,
            onRelease       = onSceneTouch,
        }
dis[10]:setReferencePoint(display.CenterReferencePoint)
dis[10].x = w
dis[10].y = dis[7].y + 70
group[2]:insert(dis[10])

group[1]:insert(group[2])

function onTouched_(event)
native.setKeyboardFocus(nil)
end
Runtime:addEventListener( "touch", onTouched_ )

----adshow.inneractive ("show")
timer.performWithDelay(1000, function ()
external.adshow.loading("hide") 
end, 1)
end

function scene:exitScene( event )

Runtime:removeEventListener( "touch", onTouched_ )
Runtime:removeEventListener( "key", cancelstats );
group[2]:removeSelf()
group[2] = nil
external.adshow.loading("show")  
end

function scene:destroyScene( event )

print("game destroy via gameover")
----adshow.inneractive ("hide")
group[1]:removeSelf()
group[1] = nil
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "destroyScene", scene )
scene:addEventListener( "exitScene", scene )

return scene