
display.setStatusBar(display.HiddenStatusBar)
local storyboard = require "storyboard"
local scene = storyboard.newScene()
local group
local bg
local carnum 
local barrelnum 
local lasernum 
local coinnum  
local wave
local livesnum 
local score    
local time   
local tick      
local w_ = display.contentWidth / 2
local h_ = display.contentHeight / 2
local adshow     = require "luafile.adshow"
local sql
local function none ( event)

    
end

function scene:createScene( event )
group = self.view

Runtime:addEventListener( "key", none )

end

function scene:enterScene( event )
group = self.view
adshow.loading("hide") 
storyboard.purgeScene("luafile.game") 
storyboard.removeAll()
local numvolume = event.params

local path = system.pathForFile("records.sqlite", system.ResourceDirectory )
db = sqlite3.open( path ) 
--print(path)

sql = "SELECT * FROM item";

for row in db:nrows(sql) do
    
print(row.car.." "..row.barrel.." "..row.laser.." "..row.coin)
carnum    = row.car
barrelnum = row.barrel
lasernum  = row.laser
coinnum   =  row.coin
livesnum  = row.lives
wave      = row.wave
score     = row.score
time      = row.time
tick      = row.tick

end

db:close()
--print("db closed")

local option = {
                effect = "fade",
                time = 400,
                params = {
                        soundv    = numvolume.soundv,
                        scenename = "buymenu",
                        barrel_   = barrelnum,
                        car_      = carnum,
                        laser_    = lasernum,
                        coin_     = coinnum,
                        --lives_    = livesnum,
                        score_    = score,
                        time_     = time,
                        wave_     = wave,
                        tick_     = tick,
                        }
                }
storyboard.gotoScene( "luafile.game", option )

end

function scene:exitScene( event )
    
Runtime:removeEventListener( "key", none )
adshow.loading("show") 
end

function scene:destroyScene( event )
  print("restart distroy")  
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene