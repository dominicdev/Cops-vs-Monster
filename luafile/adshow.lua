local adshow = {}
local loadingscreen
local loadingwid
local widget = require "widget"
local sqlite3 = require "sqlite3"
local w_ = display.contentWidth / 2
local h_ = display.contentHeight / 2 
local file

adshow.audiostats = true

function adshow.loadall ()
loadingscreen = 
    {
    loadingscreen_1 = nil,
    loadingscreen_2 = nil,
    loadingscreen_3 = nil,
    loadingscreen_4 = nil,
    loadingscreen_5 = nil,
    status_         = 0,
    }    
loadingscreen.loadingscreen_1 = display.newImageRect("background/loadingscreen.png",display.contentWidth,display.contentHeight)
loadingscreen.loadingscreen_1:setReferencePoint(display.CenterReferencePoint)
loadingscreen.loadingscreen_1.x = w_                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
loadingscreen.loadingscreen_1.y = h_
loadingscreen.loadingscreen_1.alpha = 0
loadingscreen.loadingscreen_2 = display.newImageRect("background/load_1.png",display.contentWidth,display.contentHeight)
loadingscreen.loadingscreen_2:setReferencePoint(display.CenterReferencePoint)
loadingscreen.loadingscreen_2.x = w_
loadingscreen.loadingscreen_2.y = h_    
loadingscreen.loadingscreen_2.alpha = 0
loadingscreen.loadingscreen_3 = display.newImageRect("background/load_2.png",display.contentWidth,display.contentHeight)
loadingscreen.loadingscreen_3:setReferencePoint(display.CenterReferencePoint)
loadingscreen.loadingscreen_3.x = w_
loadingscreen.loadingscreen_3.y = h_
loadingscreen.loadingscreen_3.alpha = 0
loadingscreen.loadingscreen_4 = display.newImageRect("background/load_3.png",display.contentWidth,display.contentHeight)
loadingscreen.loadingscreen_4:setReferencePoint(display.CenterReferencePoint)
loadingscreen.loadingscreen_4.x = w_
loadingscreen.loadingscreen_4.y = h_
loadingscreen.loadingscreen_4.alpha = 0
loadingscreen.loadingscreen_5 = display.newImageRect("background/load_4.png",display.contentWidth,display.contentHeight)
loadingscreen.loadingscreen_5:setReferencePoint(display.CenterReferencePoint)
loadingscreen.loadingscreen_5.x = w_
loadingscreen.loadingscreen_5.y = h_
loadingscreen.loadingscreen_5.alpha = 0

loadingwid = widget.newSpinner
{
    left = 0,
    top = 0,
    width = 100,
    height = 100,
}
loadingwid:setReferencePoint(display.CenterReferencePoint)
loadingwid.x = display.contentWidth / 2
loadingwid.y = display.contentHeight - 100
loadingwid:start()  
loadingwid.alpha = 0

end

function adshow.loading (info)

if info == "show" then
    local showing = math.random (1,5)
    if showing == 1 then
        loadingscreen.loadingscreen_1 = display.newImageRect("background/loadingscreen.png",display.contentWidth,display.contentHeight)
        loadingscreen.loadingscreen_1:setReferencePoint(display.CenterReferencePoint)
        loadingscreen.loadingscreen_1.x = w_                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
        loadingscreen.loadingscreen_1.y = h_
        loadingscreen.status_ = showing
    elseif showing == 2 then 
        loadingscreen.loadingscreen_2 = display.newImageRect("background/load_1.png",display.contentWidth,display.contentHeight)
        loadingscreen.loadingscreen_2:setReferencePoint(display.CenterReferencePoint)
        loadingscreen.loadingscreen_2.x = w_
        loadingscreen.loadingscreen_2.y = h_    
        loadingscreen.status_ = showing
    elseif showing == 3 then
        loadingscreen.loadingscreen_3 = display.newImageRect("background/load_2.png",display.contentWidth,display.contentHeight)
        loadingscreen.loadingscreen_3:setReferencePoint(display.CenterReferencePoint)
        loadingscreen.loadingscreen_3.x = w_
        loadingscreen.loadingscreen_3.y = h_
        loadingscreen.status_ = showing
    elseif showing == 4 then
        loadingscreen.loadingscreen_4 = display.newImageRect("background/load_3.png",display.contentWidth,display.contentHeight)
        loadingscreen.loadingscreen_4:setReferencePoint(display.CenterReferencePoint)
        loadingscreen.loadingscreen_4.x = w_
        loadingscreen.loadingscreen_4.y = h_
        loadingscreen.status_ = showing
    elseif showing == 5 then
        loadingscreen.loadingscreen_5 = display.newImageRect("background/load_4.png",display.contentWidth,display.contentHeight)
        loadingscreen.loadingscreen_5:setReferencePoint(display.CenterReferencePoint)
        loadingscreen.loadingscreen_5.x = w_
        loadingscreen.loadingscreen_5.y = h_
        loadingscreen.status_ = showing
    end
    loadingwid = widget.newSpinner
    {
        left = 0,
        top = 0,
        width = 100,
        height = 100,
    }
    loadingwid:setReferencePoint(display.CenterReferencePoint)
    loadingwid.x = display.contentWidth / 2
    loadingwid.y = display.contentHeight - 100
    loadingwid:start()  
elseif info == "hide" then
    if loadingscreen.status_ == 1 then
        loadingscreen.loadingscreen_1:removeSelf()
        loadingscreen.loadingscreen_1 = nil
    elseif loadingscreen.status_ == 2 then
        loadingscreen.loadingscreen_2:removeSelf()
        loadingscreen.loadingscreen_2 = nil
    elseif loadingscreen.status_ == 3 then
        loadingscreen.loadingscreen_3:removeSelf()
        loadingscreen.loadingscreen_3 = nil
    elseif loadingscreen.status_ == 4 then
        loadingscreen.loadingscreen_4:removeSelf()
        loadingscreen.loadingscreen_4 = nil
    elseif loadingscreen.status_ == 5 then
        loadingscreen.loadingscreen_5:removeSelf()
        loadingscreen.loadingscreen_5 = nil
    end
    loadingwid:removeSelf()
    loadingwid = nil
end

end

adshow.sqlload = false
function adshow.loadsql  ()
 
end

   
adshow.path = system.pathForFile("records.db", system.DocumentsDirectory )
file = io.open( adshow.path)
   if( file == nil )then
       print("NO FILE")
   	-- Doesn't Already Exist, So Copy it In From Resource Directory                          
  local pathSource     = system.pathForFile( "records.db", system.ResourceDirectory )  
  local fileSource = io.open( pathSource, "r" ) 
  local contentsSource = fileSource:read( "*a" )                                  
		--Write Destination File in Documents Directory                                  
		local pathDest = system.pathForFile( "records.db", system.DocumentsDirectory )                 
		local fileDest = io.open( pathDest, "w" )                 
		fileDest:write( contentsSource )                 
		 -- Done                      
		io.close( fileSource )        
		io.close( fileDest )  
   else
      print("FILE Already Exist")
   end
adshow.db = sqlite3.open( adshow.path )



local _H = display.contentHeight
local _W = display.contentWidth

--admob
--local ads = require "ads"

function adshow.calladmob (banstats)
    
--    ads.init( "admob", "a151a821e6c64c3")  
--    if banstats == "show" then
--        --ads.show( "interstitial", { x=0, y=(435*2), testMode=false } )
--        ads.show( "banner", { x=0, y=(435*2), testMode=false ,interval = 60} ) 
--    elseif banstats == "hide" then
--        ads.hide( ) 
--    end

end
local banner = nil

function adshow.callrevmob (bansize)
local RevMob = require("luafile.revmob")
local REVMOB_IDS = { ["Android"] = "51a6f392433111f6e90000f7", ["iPhone OS"] = "51a6f380433111f6e90000e8" }
RevMob.startSession(REVMOB_IDS)

    if bansize == "320x50" then
        banner = RevMob.createBanner({x = display.contentWidth / 2, y = _H - 40, width = _W, height = 96 })
        banner:show()
    elseif bansize == "fullscreen" then
        banner = RevMob.createFullscreen() 
        banner:show()
    elseif bansize == "hide" then
        banner:hide()
    end
end

local TOP = 1
local CENTER = 2
local BOTTOM = 3
local LEFT = 1
local RIGHT = 3  
local tapfortap = require "plugin.tapfortap"

tapfortap.initialize("8e57b002ff2dfd221b5bcf968f5fe221")

tapfortap.prepareAppWall()
local tapfor = false   
function adshow.calltapfortap (banshow)
    if tapfor == false then
        tapfor = true
    end
    if banshow == "show" then
        tapfortap.createAdView(BOTTOM, CENTER, 0, 0, 1)
    elseif banshow == "hide" then
        tapfortap.removeAdView()
    elseif banshow == "appwall" then
        tapfortap.showAppWall()
    end

end

--inneractive
function adshow.inneractive (adtype)
--local adNetwork = "inneractive"
--local appID = "8appstudio_MonsterDefense_Android"
--   ads.init( adNetwork, appID)
--   if adtype == "show" then
--    ads.show( "banner", { x=0, y=display.contentHeight - 50, interval=60, testMode=true } )
--   elseif adtype == "hide" then
--   ads.hide()    
--    end
end

function adshow.inapppurchase (addcoin)
print(addcoin)
end

--flurry 
--local analytics = require "analytics"
--local application_key = "XQXQ8Y4QY362ZNP3PYVB"
--analytics.init(application_key )
--function adshow.callflurry (action)
--        analytics.logEvent(action)
--end


--local cb = require "luafile.chartboost"
--
--local cbappId = "4f7aa26ef77659d869000003"
--local cbappSignature = "ee759deefd871ff6e2411c7153dbedefa4aabe38"
--
--local delegate = {
--    shouldRequestInterstitial = function(location) print("Chartboost: shouldRequestInterstitial " .. location .. "?"); return true end,
--    shouldDisplayInterstitial = function(location) print("Chartboost: shouldDisplayInterstitial " .. location .. "?"); return true end,
--    didCacheInterstitial = function(location) print("Chartboost: didCacheInterstitial " .. location); return end,
--    didFailToLoadInterstitial = function(location) print("Chartboost: didFailToLoadInterstitial " .. location); return end,
--    didDismissInterstitial = function(location) print("Chartboost: didDismissInterstitial " .. location); return end,
--    didCloseInterstitial = function(location) print("Chartboost: didCloseInterstitial " .. location); return end,
--    didClickInterstitial = function(location) print("Chartboost: didClickInterstitial " .. location); return end,
--    didShowInterstitial = function(location) print("Chartboost: didShowInterstitial " .. location); return end,
--    shouldDisplayLoadingViewForMoreApps = function() return true end,
--    shouldRequestMoreApps = function() print("Chartboost: shouldRequestMoreApps"); return true end,
--    shouldDisplayMoreApps = function() print("Chartboost: shouldDisplayMoreApps"); return true end,
--    didCacheMoreApps = function() print("Chartboost: didCacheMoreApps"); return end,
--    didFailToLoadMoreApps = function() print("Chartboost: didFailToLoadMoreApps"); return end,
--    didDismissMoreApps = function() print("Chartboost: didDismissMoreApps"); return end,
--    didCloseMoreApps = function() print("Chartboost: didCloseMoreApps"); return end,
--    didClickMoreApps = function() print("Chartboost: didClickMoreApps"); return end,
--    didShowMoreApps = function() print("Chartboost: didShowMoreApps"); return end,
--    shouldRequestInterstitialsInFirstSession = function() return true end
--}
--
--cb.create{appId = cbappId,
--    appSignature = cbappSignature,
--    delegate = delegate,
--    appVersion = "1.0",
--    appBundle = "com.chartboost.cbtest"}
--cb.startSession()
--
--cb.cacheMoreApps()

function adshow.showmore (event)
--  local function networkListener( event )
--        if ( event.isError ) then
--                print( "Network error!")
--        else
--                cb.showMoreApps()
--                print ( "Connected" )
--        end
--    end
--    network.request( "https://encrypted.google.com", "GET", networkListener )
end
local buyobjects = nil

function adshow.prestart (event)
buyobjects = {}
end

function adshow.storealert (limiter)
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
    new(limiter, 1500)
end

return adshow