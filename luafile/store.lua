local external      = require "luafile.external"
local w_ = display.contentWidth / 2
local h_ = display.contentHeight / 2 
local storyboard = require "storyboard";
local scene      = storyboard.newScene()
local group      = {}
local item       = {}
local buybutton
local backbutton
local numvolume
local barrelnum 
local lasernum 
local livesnum
local coinnum 
local screen
local carnum 
local score
local wave
local time
local tick
local bg
local closebutton
local cancelbutton
local iapback 
local myButton = {}
local startbutton
local control 
local pugong = 0
local params
local finallaser  
local finalcar    
local finalbarrel 
local goto
local iap
local row
local sql

local function none (event)
    
return true  
end

local function removeiap ()
    
    closebutton:removeSelf()
    closebutton = nil
    iapback:removeSelf()
    iapback = nil
    myButton[1]:removeSelf()
    myButton[1] = nil
    myButton[2]:removeSelf()
    myButton[2] = nil
    myButton[3]:removeSelf()
    myButton[3] = nil
    buybutton:setEnabled(true)
    cancelbutton:setEnabled(true)
    backbutton:setEnabled(true)
    startbutton:setEnabled(true)
    item[17]:setEnabled(true)
    item[18]:setEnabled(true)
    item[19]:setEnabled(true)
    item[20]:setEnabled(true)
    iap = "close"
    if control == true  then
        buybutton.alpha = 1
        cancelbutton.alpha = 1
        startbutton.alpha = 0
    end
    --item[22]:setEnabled(true)
    
--    db = sqlite3.open( path_ ) 
--
--    sql = "SELECT * FROM item";
--    
--    for row in db:nrows(sql) do
--    coinnum   = row.coin
--    end

--Runtime:addEventListener( "key", onKeyEvent );
--Runtime:removeEventListener( "key", removeiap );
--db:close()
--
--item[13].text = coinnum
--item[13]:setReferencePoint(display.CenterLeftReferencePoint)
--item[13].x = w_ - 110     

end

local function onKeyEvent ( event )

if event.keyName == "back" and event.phase == "down" and iap == "close" then  
    
    if params.screenfrom == "survival" then
     audio.play(external.sfx.clicksound)
    local scenefrom = 
                {
                effect = "slideRight",
                time = 800,
                params = 
                    {
                        scenename = "store"
                    }
                }
    storyboard.gotoScene( "luafile.gametype", scenefrom )  
    --db:close()
    --adshow.calltapfortap("hide") 
 
    elseif params.screenfrom == "mission" then
       audio.play(external.sfx.clicksound)
    local scenefrom = 
                {
                effect = "slideRight",
                time = 800,
                params = 
                    {
                        scenename = "store",
                        level     = params.level,
                    }
                }
    storyboard.gotoScene( "luafile.levels", scenefrom )  
    --db:close()
    --adshow.calltapfortap("hide")    
    
    end
    return true
    elseif event.keyName == "back" and event.phase == "down" and  iap == "open" then
        removeiap ()
    return true
    end
    
    
end

local function buycoins_ (event)

        iapback = display.newImageRect("items/iapback.png",600,display.contentHeight-(h_+130))
        iapback:setReferencePoint(display.CenterReferencePoint)
        iapback.x = w_
        iapback.y = h_ + 35
--        iapback.alpha = .8
        iap = "open"
        myButton[1] = external.widget.newButton
                {
                    defaultFile     = "button/buybutton/buy.png",
                    overFile        = "button/buybutton/buyover.png",
                    label           = "  $ 0.99 = 500 coin",
                    id              = "coin",
                    font            = "Feast of Flesh BB",
                    fontSize        = 40,
                    labelColor      = { default={51, 51, 51,255}, over={102, 102, 102} },
                    emboss          = true,
                    labelAlign      = "left",
                    width           = display.contentWidth - 200, 
                    height          = 80,
                    emboss          = true,
                    onRelease       = removeiap,
                }
        myButton[1]:setReferencePoint(display.CenterReferencePoint)
        myButton[1].x = w_ - 20
        myButton[1].y = h_ - 50

        myButton[2] = external.widget.newButton
                {
                    defaultFile     = "button/buybutton/buy.png",
                    overFile        = "button/buybutton/buyover.png",
                    label           = "  $ 1.99 = 1000 coin",
                    id              = "coin",
                    font            = "Feast of Flesh BB",
                    fontSize        = 40,
                    labelColor      = { default={51, 51, 51,255}, over={102, 102, 102} },
                    emboss          = true,
                    labelAlign      = "left",
                    width           = display.contentWidth - 200, 
                    height          = 80,
                    emboss          = true,
                    onRelease       = removeiap,
                }
        myButton[2]:setReferencePoint(display.CenterReferencePoint)
        myButton[2].x = w_ - 20
        myButton[2].y = myButton[1].y + 90
        
        myButton[3] = external.widget.newButton
                {
                    defaultFile     = "button/buybutton/buy.png",
                    overFile        = "button/buybutton/buyover.png",
                    label           = "  $ 2.99 = 1500 coin",
                    id              = "coin",
                    font            = "Feast of Flesh BB",
                    fontSize        = 40,
                    labelColor      = { default={51, 51, 51,255}, over={102, 102, 102} },
                    emboss          = true,
                    labelAlign      = "left",
                    width           = display.contentWidth - 200, 
                    height          = 80,
                    emboss          = true,
                    onRelease       = removeiap,
                }
        myButton[3]:setReferencePoint(display.CenterReferencePoint)
        myButton[3].x = w_ - 20
        myButton[3].y = myButton[2].y + 90

        closebutton = external.widget.newButton
                {
                    defaultFile     = "button/buybutton/left.png",
                    overFile        = "button/buybutton/lefttap.png",
                    id              = "coin",
                    width           = 50, 
                    height          = 50,
                    emboss          = true,
                    onRelease       = removeiap,
                }
        closebutton:setReferencePoint(display.CenterLeftReferencePoint)
        closebutton.x = w_ + 230
        closebutton.y = h_ - 90
        
        buybutton:setEnabled(false)
        startbutton:setEnabled(false)
        cancelbutton:setEnabled(false)
        backbutton:setEnabled(false)
        item[17]:setEnabled(false)
        item[18]:setEnabled(false)
        item[19]:setEnabled(false)
        item[20]:setEnabled(false)
        --item[22]:setEnabled(false)
        --Runtime:removeEventListener( "key", onKeyEvent );
        --Runtime:addEventListener( "key", removeiap );
        if control == true  then
            buybutton.alpha = 0
            cancelbutton.alpha = 0
            startbutton.alpha = 1
        end
        

end

local function popupsforcoin ()
    local function onComplete (event)
        if "clicked" == event.action then
            local i = event.index
            if 1 == i then
                buycoins_()
            elseif 2 == i then
                if control == true  then
                buybutton.alpha = 1
                cancelbutton.alpha = 1
                startbutton.alpha = 0
                else
                 startbutton.alpha = 1   
                end
                
            end
        end
        
    end
local alert =   native.showAlert("Need More Coins?","You Would Like to buy more coins?", { "YES", "NO" }, onComplete)  
audio.play(external.sfx.clicksound) 
buybutton.alpha = 0
cancelbutton.alpha = 0
startbutton.alpha = 0
end

local function additem (event)

local switch = event.target
   audio.play(external.sfx.clicksound)
   
    if event.phase == "ended" then
        
       if switch.id == "car" and carnum ~= 30 then

           if coinnum == 0 then
                coinnum = 0
                popupsforcoin ()
           elseif 19 >= coinnum  then
                popupsforcoin ()
           else
                pugong = carnum + 5
               if pugong <= 35 then
                coinnum = coinnum - 20
                item[13]:setReferencePoint(display.CenterLeftReferencePoint)
                item[13].text = coinnum
                item[13].x = w_ - 80  
                
                carnum = carnum + 5
                item[14]:setReferencePoint(display.CenterLeftReferencePoint)
                item[14].text = carnum
                item[14].x = w_ - 35
                
                buybutton.alpha = 1
                cancelbutton.alpha = 1
                startbutton.alpha = 0
                control = true
               else
                   external.adshow.storealert ("Reach Limit of more than 35")
               end 
           end

       elseif switch.id == "barrel" then
            
           if coinnum == 0 then
                coinnum = 0
                popupsforcoin ()
           elseif 24 >= coinnum  then
                popupsforcoin ()
           else
                pugong = barrelnum + 4
               if pugong <= 35 then
                coinnum = coinnum - 25
                item[13]:setReferencePoint(display.CenterLeftReferencePoint)
                item[13].text = coinnum
                item[13].x = w_ - 80 

                barrelnum = barrelnum + 4
                item[15]:setReferencePoint(display.CenterLeftReferencePoint)
                item[15].text = barrelnum
                item[15].x = w_ - 35
                
                buybutton.alpha = 1
                cancelbutton.alpha = 1
                startbutton.alpha = 0
                control = true
               else
                external.adshow.storealert ("Reach Limit of more than 35")
               end
                   
           end
       elseif switch.id == "laser" then    
            
             if coinnum == 0 then
                    coinnum = 0 
                    popupsforcoin ()
             elseif 49 >= coinnum  then
                    popupsforcoin ()
             else
                    pugong = lasernum + 3
               if pugong <= 35 then
                    coinnum = coinnum - 50
                    item[13]:setReferencePoint(display.CenterLeftReferencePoint)
                    item[13].text = coinnum
                    item[13].x = w_ - 80 

                    lasernum = lasernum + 3
                    item[16].text = lasernum
                    item[16]:setReferencePoint(display.CenterLeftReferencePoint)
                    item[16].x = w_ - 35
                    
                    buybutton.alpha = 1
                    cancelbutton.alpha = 1
                    startbutton.alpha = 0
                    control = true
               else
                   external.adshow.storealert ("Reach Limit of more than 35")
               end
            end
            
        elseif switch.id == "coin" then   
            --adshow.inapppurchase("buycoin")
            buycoins_ ()
       end
       
    end
return true
end

local function onSceneTouch(event)
    audio.play(external.sfx.clicksound)
    local switch = event.target

    if switch.id == "buy" then
        --print(path)
        local tablesetup = "CREATE TABLE IF NOT EXISTS item (id INTEGER PRIMARY KEY, car, barrel,laser,coin,lives);"
        external.adshow.db:exec( tablesetup )
        --print(tablesetup)
        local tablesave_ = [[UPDATE item SET car=']].. carnum ..[[',barrel=']]..barrelnum..[[',laser=']]..lasernum..[[',coin=']]..coinnum..[[',lives=']]..livesnum..[[' WHERE id = 1]]
        external.adshow.db:exec( tablesave_ )
       -- print(tablesave_)
        external.adshow.db:close()
        --print("db closed")

        buybutton.alpha = 0
        cancelbutton.alpha = 0   
        startbutton.alpha = 1
        control = false
        finallaser  = lasernum
        finalcar    = carnum
        finalbarrel = barrelnum
        
    elseif switch.id == "back" then
        if params.screenfrom == "survival" then
            local scenefrom = 
                    {
                        effect = "slideRight",
                        time = 1000,
                        params = 
                        {
                            scenename = "store"
                        }
                    }
        storyboard.gotoScene( "luafile.gametype", scenefrom ) 
        --adshow.calltapfortap("hide") 
        elseif params.screenfrom == "mission" then
           -- print(params.level)
            local scenefrom = 
                    {
                        effect = "slideRight",
                        time = 1000,
                        params = 
                        {
                            scenename = "store",
                            level     = params.level,
                        }
                    }
        storyboard.gotoScene( "luafile.levels", scenefrom ) 
        --adshow.calltapfortap("hide") 
        end
            
    end
end

function scene:createScene( event )
group[1] = self.view
--print(display.contentWidth.." "..display.contentHeight)
bg = display.newImageRect("items/additem.png",display.contentWidth,display.contentHeight)
bg.x = w_
bg.y = h_
group[1]:insert(bg)


Runtime:addEventListener( "key", none );
end

function scene:enterScene( event )
group[1] = self.view
group[2] = display.newGroup()
numvolume = event.params
screen = numvolume.scenename
params = event.params 
Runtime:removeEventListener( "key", none );
Runtime:addEventListener( "key", onKeyEvent );
storyboard.purgeAll()
storyboard.removeAll() 
iap = "close"
goto = ""
sql = "SELECT * FROM item";
for row in external.adshow.db:nrows(sql) do
    
carnum    = row.car
coinnum   = row.coin
wave      = row.wave
lasernum  = row.laser
livesnum  = row.lives
barrelnum = row.barrel
score     = row.score
time      = row.time
tick      = row.tick

end
--print(lasernum)

finallaser  = lasernum
finalcar    = carnum
finalbarrel = barrelnum

item[12] = display.newImageRect("items/money.png",190,76)
item[12]:setReferencePoint(display.CenterRightReferencePoint)
item[12].x = w_ + 25
item[12].y = h_ - 80

item[13] = display.newText(coinnum,0,0,"BadaBoom BB",40)
item[13]:setReferencePoint(display.CenterLeftReferencePoint)
item[13].x = w_ - 80
item[13].y = item[12].y

item[20] = external.widget.newButton

        {
            defaultFile     = "button/buybutton/addbtn.png",
            overFile        = "button/buybutton/addbtnover.png",
            id              = "coin",
            width           = 76, 
            height          = 76,
            emboss          = true,
            onRelease       = additem,
        }
        
item[20]:setReferencePoint(display.CenterLeftReferencePoint)
item[20].x = w_ + 70
item[20].y = item[12].y

item[2] = display.newImageRect("items/itemcar.png",250,76)
item[2]:setReferencePoint(display.CenterReferencePoint)
item[2].x = w_ - 100
item[2].y = item[20].y + 110

item[3] = display.newImageRect("items/itembarrel.png",250,76)
item[3]:setReferencePoint(display.CenterReferencePoint)
item[3].x = w_ - 100
item[3].y = item[2].y + 100

item[4] = display.newImageRect("items/itemlaser.png",250,76)
item[4]:setReferencePoint(display.CenterReferencePoint)
item[4].x = w_ - 100
item[4].y = item[3].y  + 100

item[14] = display.newText(carnum,0,0,"BadaBoom BB",40);
item[14]:setReferencePoint(display.CenterLeftReferencePoint)
item[14].x = w_ - 35
item[14].y = item[2].y

item[15] = display.newText(barrelnum,0,0,"BadaBoom BB",40);
item[15]:setReferencePoint(display.CenterLeftReferencePoint)
item[15].x = w_ - 35
item[15].y = item[3].y 

item[16] = display.newText(lasernum,0,0,"BadaBoom BB",40);
item[16]:setReferencePoint(display.CenterLeftReferencePoint)
item[16].x = w_ - 35
item[16].y = item[4].y 

item[17] = external.widget.newButton
        {
            defaultFile     = "button/buybutton/addbtn.png",
            overFile        = "button/buybutton/addbtnover.png",
            id              = "car",
            width           = 76, 
            height          = 76,
            emboss          = true,
            onRelease       = additem,
        }
        
item[17]:setReferencePoint(display.CenterLeftReferencePoint)
item[17].x = w_ + 70
item[17].y = item[2].y

item[18] = external.widget.newButton
        {
            defaultFile     = "button/buybutton/addbtn.png",
            overFile        = "button/buybutton/addbtnover.png",
            id              = "barrel",
            width           = 76, 
            height          = 76,
            emboss          = true,
            onRelease       = additem,
        }
item[18]:setReferencePoint(display.CenterLeftReferencePoint)
item[18].x = w_ + 70
item[18].y = item[3].y 

item[19] = external.widget.newButton
        {
            defaultFile     = "button/buybutton/addbtn.png",
            overFile        = "button/buybutton/addbtnover.png",
            id              = "laser",
            width           = 76, 
            height          = 76,
            emboss          = true,
            onRelease       = additem,
        }
item[19]:setReferencePoint(display.CenterLeftReferencePoint)
item[19].x = w_ + 70
item[19].y = item[4].y 

cancelbutton = external.widget.newButton
        {
            defaultFile     = "button/buybutton/cancelbtn.png",
            overFile        = "button/buybutton/cancelbtnover.png",
            width           = 150,
            height          = 62,
            onRelease       = function (event)
            
            if event.phase == "ended" then

                sql = "SELECT * FROM item";
                for row in external.adshow.db:nrows(sql) do

                carnum    = row.car
                coinnum   = row.coin
                wave      = row.wave
                lasernum  = row.laser
                livesnum  = row.lives
                barrelnum = row.barrel
                score     = row.score
                time      = row.time
                tick      = row.tick

                end

                
                item[13].text = coinnum
                item[13]:setReferencePoint(display.CenterLeftReferencePoint)
                item[13].x = w_ - 80
                
                item[14].text = carnum
                item[14]:setReferencePoint(display.CenterLeftReferencePoint)
                item[14].x = w_ - 35
                
                item[15].text = barrelnum
                item[15]:setReferencePoint(display.CenterLeftReferencePoint)
                item[15].x = w_ - 35
                
                item[16].text = lasernum
                item[16]:setReferencePoint(display.CenterLeftReferencePoint)
                item[16].x = w_ - 35
             buybutton.alpha = 0
             cancelbutton.alpha = 0  
             startbutton.alpha = 1
             control = false
            end
            
            end,
        }
cancelbutton:setReferencePoint(display.CenterReferencePoint)
cancelbutton.x = w_ + 150
cancelbutton.y = display.contentHeight - (h_*.25)
cancelbutton.alpha = 0
group[2]:insert(cancelbutton)
control = false

buybutton = external.widget.newButton
        {
            defaultFile     = "button/buybutton/storebuybtn.png",
            overFile        = "button/buybutton/storebuybtnover.png",
            id              = "buy",
            width           = 150,
            height          = 62,
            onRelease       = onSceneTouch,
        }
buybutton:setReferencePoint(display.CenterReferencePoint)
buybutton.x = w_ - 150
buybutton.y = display.contentHeight - (h_*.25)
buybutton.alpha = 0
group[2]:insert(buybutton)

startbutton = external.widget.newButton
        {
            defaultFile     = "button/buybutton/storestartbtn.png",
            overFile        = "button/buybutton/storestartbtnover.png",
            font            = "BadaBoom BB",
            width           = 150,
            height          = 62,
            emboss          = true,
            onRelease   = function (event)
                    
                if event.phase == "ended" and params.screenfrom == "mission" then
                    goto = "start"
                    local scenefrom = {
                            effect  = "slideUp",
                            time    = 1000,
                            params  = 
                            {
                                stage           = params.stage,
                                monsternum      = params.monsternum,
                                damage          = params.damage,
                                soundv          = numvolume.soundv,
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
                                tutorial        = params.tutorial,
                                bossing         = params.bossing,
                                bossbol         = params.bossbol,
                                laser           = finallaser,
                                car             = finalcar,
                                barrel          = finalbarrel,
                                
                                                }
                           }
                            storyboard.gotoScene( "luafile.levelgame",scenefrom)
                            audio.stop()
                    
                elseif event.phase == "ended" and params.screenfrom == "survival" then
                    goto = "start"
                    local option = 
                    {
                    effect  = "fade",
                    time    = 800,
                    params  = 
                        {
                            stage           = params.stage,
                            monsternum      = params.monsternum,
                            damage          = params.damage,
                            soundv          = numvolume.soundv,
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
                            tutorial        = params.tutorial,
                            bossing         = params.bossing,
                            bossbol         = params.bossbol,
                            laser           = finallaser,
                            car             = finalcar,
                            barrel          = finalbarrel,

                                    }
                                }
                    storyboard.gotoScene( "luafile.survivalgame", option ) 
                    --adshow.calltapfortap("hide")
                    audio.stop()
                end
            end,}
startbutton.x = w_ 
startbutton.y = display.contentHeight - (h_*.25)
startbutton.alpha = 1
group[2]:insert(startbutton)

backbutton = external.widget.newButton
        {
            defaultFile = "button/orange/left.png",
            overFile    = "button/orange/lefttap.png",
            id          = "back",
            width       = 80, 
            height      = 80,
            emboss      = true,
            onRelease   = onSceneTouch,
        }
 backbutton.x = w_ - 240
 backbutton.y = 80
 backbutton.alpha = 0
 transition.to(backbutton,{alpha = 1,time = 600})

item[13]:setTextColor(0, 0, 0)
item[14]:setTextColor(0, 0, 102)
item[15]:setTextColor(0, 0, 102)
item[16]:setTextColor(0, 0, 102)
group[2]:insert(backbutton)
group[2]:insert(item[4])
group[2]:insert(item[3])
group[2]:insert(item[2])
group[2]:insert(item[20])
group[2]:insert(item[19])
group[2]:insert(item[18])
group[2]:insert(item[17])
group[2]:insert(item[16])
group[2]:insert(item[15])
group[2]:insert(item[14])
group[2]:insert(item[12])
group[2]:insert(item[13])
group[1]:insert(group[2])

timer.performWithDelay( 2000, function() 
--adshow.calltapfortap("show")
--adshow.loading("hide")
end,1)

end

function scene:exitScene( event )
group[1] = self.view
Runtime:removeEventListener( "key", onKeyEvent );

if goto == "start" then
 external.adshow.loading("show")   
end
group[2]:removeSelf()
group[2] = nil
goto = ""
end

function scene:destroyScene( event )
  
group[1]:removeSelf()
group[1] = nil 
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "destroyScene", scene )
scene:addEventListener( "exitScene", scene )



return scene


