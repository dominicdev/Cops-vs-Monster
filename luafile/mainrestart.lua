
display.setStatusBar(display.HiddenStatusBar)
local storyboard = require "storyboard"
local scene      = storyboard.newScene()
local adshow     = require "luafile.adshow"
local sfx        = require "luafile.sfx"
local sqlite3    = require "sqlite3"
local group
local params
local stageset
local db
local unlocked = "unlocked"
local tounlock  
local score = 0
local levels
local level
local rowid
local unlocking
local star
local coin = 0
local sql
local powers = nil

local function none ()
      
end

function scene:createScene( event )
group = self.view

end

function scene:enterScene( event )
group = self.view
params = event.params
storyboard.purgeAll()
storyboard.removeAll()
Runtime:addEventListener( "key", none )
powers = {
            laser = nil,
            car   = nil,
            barrel= nil,
            }
adshow.loading("hide") 
local path = system.pathForFile("records.sqlite",system.ResourceDirectory  )
db = sqlite3.open( path )  
sql = "SELECT * FROM item";

if params.name ~= "restartbonus" then

for row in db:nrows(sql) do
coin = row.coin
end
stageset = params.stage  
tounlock = stageset + 1
coin = coin + params.coin   
end

if params.name == "restart" then
  local scenefrom = 
        {
        effect  = "fade",
        time    = 1000,
        params  = 
            {
                name        = "restart",
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
                tutorial    = params.tutorial,
                car         = params.car,
                laser       = params.laser,
                barrel      = params.barrel,
                bossbol     = params.bossbol,
                bossing     = params.bossing,
            }
        }
storyboard.gotoScene( "luafile.levelgame",scenefrom)

elseif params.name == "restart_survival" then
 local scenefrom = 
        {
        effect  = "fade",
        time    = 1000,
        params  = 
            {
                name        = "restart",
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
                tutorial    = params.tutorial,
                car         = params.car,
                laser       = params.laser,
                barrel      = params.barrel,
                bossbol     = params.bossbol,
                bossing     = params.bossing,
            }
        }
storyboard.gotoScene( "luafile.survivalgame",scenefrom)   
elseif params.name == "next" then

score = params.score
levels = params.stage
level = params.level
rowid = params.rowid
star  = params.star
local tablesave = [[UPDATE button SET score =']]..score..[[',star=']]..star..[[' WHERE rowid =']]..rowid..[[']]..[[AND level =]]..level..[[]];
db:exec( tablesave )

unlocking = rowid + 1
local tablesave_ = [[UPDATE button SET stats =']]..unlocked..[[' WHERE rowid =']]..unlocking..[[']]..[[AND level =]]..level..[[]];
db:exec( tablesave_ )

local addcoin = [[UPDATE item SET coin=']]..coin..[[' WHERE id = 1]]
db:exec( addcoin )

        if rowid == 20 and level == 1 then

            local levelupdate = 2
            local openlevel = "mission_2"
            local row = rowid + 1

            local tablesave_1 = [[UPDATE button SET stats =']]..unlocked..[[' WHERE rowid =']]..row..[[']]..[[AND level =]]..levelupdate..[[]];
            db:exec( tablesave_1)

            local tablesave_2 = [[UPDATE gamestats SET stats =']]..unlocked..[[' WHERE gametype =']]..openlevel..[[']]
            db:exec( tablesave_2)   

            local openlevel = "survival"

            local tablesave_1 = [[UPDATE gamestats SET stats =']]..unlocked..[[' WHERE gametype =']]..openlevel..[[']]
            db:exec( tablesave_1) 

            local scenefrom = {
                                effect  = "fade",
                                time    = 1000,
                                params  = 
                                    {   scenename = "mainrestart",
                                        soundv = params.soundv,

                                    }
                                }
             storyboard.gotoScene( "luafile.gametype",scenefrom)       


        elseif rowid == 40 and level == 2 then

            local openlevel = "bonus"

            local tablesave_1 = [[UPDATE gamestats SET stats =']]..unlocked..[[' WHERE gametype =']]..openlevel..[[']]
            db:exec( tablesave_1) 

            local scenefrom = {
                                effect  = "fade",
                                time    = 1000,
                                params  = 
                                    {   scenename = "mainrestart",
                                        soundv = params.soundv,

                                    }
                                }
             storyboard.gotoScene( "luafile.gametype",scenefrom)   

        else

            local tablesave = [[UPDATE item SET car=']].. params.car ..[[',barrel=']]..params.barrel..[[',laser=']]..params.laser..[[' WHERE id = 1]]
            db:exec( tablesave )
            print(tablesave)
            sql = "SELECT * FROM item WHERE id="..1;

        for row in db:nrows(sql) do
            powers.laser = row.laser
            powers.car   = row.car
            powers.barrel = row.barrel

        end
            local scenefrom 
            sql = "SELECT * FROM button WHERE id="..unlocking.." AND level ="..params.level;
            for row in db:nrows(sql) do
            scenefrom = {
                        effect  = "fade",
                        time    = 1000,
                        params  = 
                                    {
                        stage           = unlocking,
                        monsternum      = row.monsternum,
                        damage          = row.damage,
                        soundv          = params.soundv,
                        speed           = row.speed,
                        masstatus       = row.masstatus,
                        mastermon       = row.mastermon,
                        masdamage       = row.masdamage,
                        masspeed        = row.masspeed,
                        highscore       = row.score,
                        level           = row.level,
                        rowid           = row.id,
                        bigmas          = row.bigmas,
                        bignum          = row.bignum,
                        bigdamage       = row.bigdamage,
                        bigspeed        = row.bigspeed,
                        star            = row.star,
                        monmovstats     = row.monmovstats,
                        movnum          = row.movnum,
                        tutorial        = row.tutorial,
                        laser           = powers.laser,
                        car             = powers.car,
                        barrel          = powers.barrel,
                        bossbol         = row.bossbol,
                        bossing         = row.bossing,
                        }
                    }
            end
            storyboard.gotoScene( "luafile.levelgame",scenefrom)
        end    

    elseif params.name == "menu" then
        score = params.score
        levels = params.stage
        level = params.level
        rowid = params.rowid
        star  = params.star

        local tablesave = [[UPDATE button SET score =']]..score..[[',star=']]..star..[[' WHERE rowid =']]..rowid..[[']]..[[AND level =]]..level..[[]];
        db:exec( tablesave )

        unlocking = rowid + 1
        local tablesave_ = [[UPDATE button SET stats =']]..unlocked..[[' WHERE rowid =']]..unlocking..[[']]..[[AND level =]]..level..[[]];
        db:exec( tablesave_ )

        local addcoin = [[UPDATE item SET coin=']]..coin..[[' WHERE id = 1]]
        db:exec( addcoin )

            if rowid == 20 and level == 1 then

            local levelupdate = 2
            local openlevel = "mission_2"
            local row = rowid + 1

            local tablesave_1 = [[UPDATE button SET stats =']]..unlocked..[[' WHERE rowid =']]..row..[[']]..[[AND level =]]..levelupdate..[[]];
            db:exec( tablesave_1)

            local tablesave_2 = [[UPDATE gamestats SET stats =']]..unlocked..[[' WHERE gametype =']]..openlevel..[[']]
            db:exec( tablesave_2) 

            local openlevel_1 = "survival"
            local tablesave_3 = [[UPDATE gamestats SET stats =']]..unlocked..[[' WHERE gametype =']]..openlevel_1..[[']]
            db:exec( tablesave_3) 
            local scenefrom = {
                        effect  = "fade",
                        time    = 1000,
                        params  = 
                                {   scenename = "mainrestart",
                                    soundv = params.soundv,

                                }
                            }
             storyboard.gotoScene( "luafile.gametype",scenefrom)       


            elseif rowid == 40 and level == 2 then

            local openlevel = "bonus"

            local tablesave_1 = [[UPDATE gamestats SET stats =']]..unlocked..[[' WHERE gametype =']]..openlevel..[[']]
            db:exec( tablesave_1) 

            local scenefrom = {
                                effect  = "fade",
                                time    = 1000,
                                params  = 
                                    {   scenename = "mainrestart",
                                        soundv = params.soundv,

                                    }
                                }
             storyboard.gotoScene( "luafile.gametype",scenefrom)   

            else
                print(params.laser)
            local tablesave = [[UPDATE item SET car=']].. params.car ..[[',barrel=']]..params.barrel..[[',laser=']]..params.laser..[[' WHERE id = 1]]
            db:exec( tablesave )
           -- print(tablesave)
            sql = "SELECT * FROM item WHERE id="..1;                

            local scenefrom = {
                                effect  = "fade",
                                time    = 1000,
                                params  = 
                                    {
                                        soundv = params.soundv,
                                        level  = params.level,
                                        scenename = "mainrestart",
                                    }
                                }
            storyboard.gotoScene( "luafile.levels",scenefrom)   
            audio.play(sfx.backmusic,{loops = 99,channel = 1})
            end
elseif params.name == "restartbonus" then

local scenefrom = {
                effect  = "fade",
                time    = 1000,
                params  = 
                    {
                        soundv = params.soundv,
                        scenename = "mainrestart",
                    }
                }
storyboard.gotoScene( "luafile.bonus",scenefrom)   
end

end

function scene:exitScene( event )
adshow.loading("show") 
db:close()
end

function scene:destroyScene( event )
 -- print("restart destroy")  
Runtime:removeEventListener( "key", none )
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene