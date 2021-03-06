package.preload['json']=(function(...)local a={}local e=string
local u=math
local c=table
local i=error
local d=tonumber
local r=tostring
local s=type
local l=setmetatable
local f=pairs
local h=ipairs
local o=assert
local n=Chipmunk
local n={buffer={}}function n:New()local e={}l(e,self)self.__index=self
e.buffer={}return e
end
function n:Append(e)self.buffer[#self.buffer+1]=e
end
function n:ToString()return c.concat(self.buffer)end
local t={backslashes={['\b']="\\b",['\t']="\\t",['\n']="\\n",['\f']="\\f",['\r']="\\r",['"']='\\"',['\\']="\\\\",['/']="\\/"}}function t:New()local e={}e.writer=n:New()l(e,self)self.__index=self
return e
end
function t:Append(e)self.writer:Append(e)end
function t:ToString()return self.writer:ToString()end
function t:Write(e)local n=s(e)if n=="nil"then
self:WriteNil()elseif n=="boolean"then
self:WriteString(e)elseif n=="number"then
self:WriteString(e)elseif n=="string"then
self:ParseString(e)elseif n=="table"then
self:WriteTable(e)elseif n=="function"then
self:WriteFunction(e)elseif n=="thread"then
self:WriteError(e)elseif n=="userdata"then
self:WriteError(e)end
end
function t:WriteNil()self:Append("null")end
function t:WriteString(e)self:Append(r(e))end
function t:ParseString(n)self:Append('"')self:Append(e.gsub(n,'[%z%c\\"/]',function(n)local t=self.backslashes[n]if t then return t end
return e.format("\\u%.4X",e.byte(n))end))self:Append('"')end
function t:IsArray(t)local n=0
local i=function(e)if s(e)=="number"and e>0 then
if u.floor(e)==e then
return true
end
end
return false
end
for e,t in f(t)do
if not i(e)then
return false,'{','}'else
n=u.max(n,e)end
end
return true,'[',']',n
end
function t:WriteTable(e)local i,t,o,n=self:IsArray(e)self:Append(t)if i then
for t=1,n do
self:Write(e[t])if t<n then
self:Append(',')end
end
else
local n=true;for e,t in f(e)do
if not n then
self:Append(',')end
n=false;self:ParseString(e)self:Append(':')self:Write(t)end
end
self:Append(o)end
function t:WriteError(n)i(e.format("Encoding of %s unsupported",r(n)))end
function t:WriteFunction(e)if e==Null then
self:WriteNil()else
self:WriteError(e)end
end
local r={s="",i=0}function r:New(n)local e={}l(e,self)self.__index=self
e.s=n or e.s
return e
end
function r:Peek()local n=self.i+1
if n<=#self.s then
return e.sub(self.s,n,n)end
return nil
end
function r:Next()self.i=self.i+1
if self.i<=#self.s then
return e.sub(self.s,self.i,self.i)end
return nil
end
function r:All()return self.s
end
local n={escapes={['t']='\t',['n']='\n',['f']='\f',['r']='\r',['b']='\b',}}function n:New(n)local e={}e.reader=r:New(n)l(e,self)self.__index=self
return e;end
function n:Read()self:SkipWhiteSpace()local n=self:Peek()if n==nil then
i(e.format("Nil string: '%s'",self:All()))elseif n=='{'then
return self:ReadObject()elseif n=='['then
return self:ReadArray()elseif n=='"'then
return self:ReadString()elseif e.find(n,"[%+%-%d]")then
return self:ReadNumber()elseif n=='t'then
return self:ReadTrue()elseif n=='f'then
return self:ReadFalse()elseif n=='n'then
return self:ReadNull()elseif n=='/'then
self:ReadComment()return self:Read()else
i(e.format("Invalid input: '%s'",self:All()))end
end
function n:ReadTrue()self:TestReservedWord{'t','r','u','e'}return true
end
function n:ReadFalse()self:TestReservedWord{'f','a','l','s','e'}return false
end
function n:ReadNull()self:TestReservedWord{'n','u','l','l'}return nil
end
function n:TestReservedWord(n)for o,t in h(n)do
if self:Next()~=t then
i(e.format("Error reading '%s': %s",c.concat(n),self:All()))end
end
end
function n:ReadNumber()local n=self:Next()local t=self:Peek()while t~=nil and e.find(t,"[%+%-%d%.eE]")do
n=n..self:Next()t=self:Peek()end
n=d(n)if n==nil then
i(e.format("Invalid number: '%s'",n))else
return n
end
end
function n:ReadString()local n=""o(self:Next()=='"')while self:Peek()~='"'do
local e=self:Next()if e=='\\'then
e=self:Next()if self.escapes[e]then
e=self.escapes[e]end
end
n=n..e
end
o(self:Next()=='"')local t=function(n)return e.char(d(n,16))end
return e.gsub(n,"u%x%x(%x%x)",t)end
function n:ReadComment()o(self:Next()=='/')local n=self:Next()if n=='/'then
self:ReadSingleLineComment()elseif n=='*'then
self:ReadBlockComment()else
i(e.format("Invalid comment: %s",self:All()))end
end
function n:ReadBlockComment()local n=false
while not n do
local t=self:Next()if t=='*'and self:Peek()=='/'then
n=true
end
if not n and
t=='/'and
self:Peek()=="*"then
i(e.format("Invalid comment: %s, '/*' illegal.",self:All()))end
end
self:Next()end
function n:ReadSingleLineComment()local e=self:Next()while e~='\r'and e~='\n'do
e=self:Next()end
end
function n:ReadArray()local t={}o(self:Next()=='[')local n=false
if self:Peek()==']'then
n=true;end
while not n do
local o=self:Read()t[#t+1]=o
self:SkipWhiteSpace()if self:Peek()==']'then
n=true
end
if not n then
local n=self:Next()if n~=','then
i(e.format("Invalid array: '%s' due to: '%s'",self:All(),n))end
end
end
o(']'==self:Next())return t
end
function n:ReadObject()local r={}o(self:Next()=='{')local t=false
if self:Peek()=='}'then
t=true
end
while not t do
local o=self:Read()if s(o)~="string"then
i(e.format("Invalid non-string object key: %s",o))end
self:SkipWhiteSpace()local n=self:Next()if n~=':'then
i(e.format("Invalid object: '%s' due to: '%s'",self:All(),n))end
self:SkipWhiteSpace()local l=self:Read()r[o]=l
self:SkipWhiteSpace()if self:Peek()=='}'then
t=true
end
if not t then
n=self:Next()if n~=','then
i(e.format("Invalid array: '%s' near: '%s'",self:All(),n))end
end
end
o(self:Next()=="}")return r
end
function n:SkipWhiteSpace()local n=self:Peek()while n~=nil and e.find(n,"[%s/]")do
if n=='/'then
self:ReadComment()else
self:Next()end
n=self:Peek()end
end
function n:Peek()return self.reader:Peek()end
function n:Next()return self.reader:Next()end
function n:All()return self.reader:All()end
function encode(n)local e=t:New()e:Write(n)return e:ToString()end
function decode(e)local e=n:New(e)return e:Read()end
function Null()return Null
end
a.encode=encode
a.decode=decode
return a
end)package.preload['revmob_messages']=(function(...)local e={NO_ADS="No ads for this device/country right now, or your App ID is paused.",APP_IDLING="Is your ad unit paused? Please, check it in the RevMob Console.",NO_SESSION="The method RevMob.startSession(REVMOB_IDS) has not been called.",UNKNOWN_REASON="Ad was not received because a timeout or for an unknown reason: ",UNKNOWN_REASON_CORONA="Ad was not received for an unknown reason. Is your internet connection working properly? It also may be a timeout or a temporary issue in the server. Please, try again later. If this error persist, please contact us for more details.",INVALID_DEVICE_ID="Device requirements not met.",INVALID_APPID="App not recognized due to invalid App ID.",INVALID_PLACEMENTID="No ads because you type an invalid Placement ID.",OPEN_MARKET="Opening market",AD_NOT_LOADED="Ad is not loaded yet to be shown. It will appear as soon as the ad is loaded."}return e end)package.preload['revmob_events']=(function(...)local e={AD_RECEIVED="adReceived",AD_NOT_RECEIVED="adNotReceived",AD_DISPLAYED="adDisplayed",AD_CLICKED="adClicked",AD_CLOSED="adClosed",INSTALL_RECEIVED="installReceived",INSTALL_NOT_RECEIVED="installNotReceived",UNKNOWN_ERROR="unknownError"}return e end)package.preload['revmob_about']=(function(...)local e={VERSION="5.3.1",DEBUG=false}local n=function()if"Android"==system.getInfo("platformName")then
return"corona-android"elseif"iPhone OS"==system.getInfo("platformName")then
return"corona-ios"else
return"corona"end
end
e.NAME=n()return e end)package.preload['revmob_log']=(function(...)local e
e={NONE=0,RELEASE=1,INFO=2,DEBUG=3,level=2,setLevel=function(n)assert(type(n)=="number","level expects a number")assert(n>=e.NONE and n<=e.INFO)e.level=n
end,release=function(n)if e.level>=e.RELEASE then
print("[RevMob] "..tostring(n))io.output():flush()end
end,info=function(n)if e.level>=e.INFO then
print("[RevMob] "..tostring(n))io.output():flush()end
end,debug=function(n)if e.level>=e.DEBUG then
print("[RevMob Debug] "..tostring(n))io.output():flush()end
end,infoTable=function(n)if e.level>=e.INFO then
for n,t in pairs(n)do e.info(tostring(n)..': '..tostring(t))end
end
end,debugTable=function(n)if e.level>=e.DEBUG then
for t,n in pairs(n)do e.debug(tostring(t)..': '..tostring(n))end
end
end}return e
end)package.preload['revmob_utils']=(function(...)require('revmob_about')local function t(n,e,t)timer.performWithDelay(1,function()display.loadRemoteImage(n,"GET",e,t,system.TemporaryDirectory)end)end
local e
e={left=function()return display.screenOriginX end,top=function()return display.screenOriginY end,right=function()return display.viewableContentWidth-display.screenOriginX end,bottom=function()return display.viewableContentHeight-display.screenOriginY end,width=function()return e.right()-e.left()end,height=function()return e.bottom()-e.top()end}local n={}n.loadAsset=t
n.Screen=e
return n end)package.preload['revmob_context']=(function(...)local o=require('json')local t=require('revmob_about')local e=require('revmob_log')local l=require('revmob_device')local a=require('revmob_cache')local n
n={social={},setUserLocationLatitude=function(t)if type(t)=="number"then
n.social.latitude=t
else
e.release("Invalid userLocationLatitude")end
end,setUserLocationLongitude=function(t)if type(t)=="number"then
n.social.longitude=t
else
e.release("Invalid userLocationLongitude")end
end,setUserLocationAccuracy=function(t)if type(t)=="number"then
n.social.accuracy=t
else
e.release("Invalid userLocationAccuracy")end
end,setUserGender=function(t)if t~=nil and(t=='male'or t=='female')then
n.social.gender=t
else
e.release("Invalid userGender")end
end,getUserGender=function()return n.social.gender
end,setUserAgeRangeMin=function(t)if type(t)=="number"and t>0 then
n.social.age_range_min=t
else
e.release("Invalid userAgeRangeMin")end
end,getUserAgeRangeMin=function()return n.social.age_range_min
end,setUserAgeRangeMax=function(t)if type(t)=="number"and t>0 then
n.social.age_range_max=t
else
e.release("Invalid userAgeRangeMax")end
end,getUserAgeRangeMax=function()return n.social.age_range_max
end,setUserBirthday=function(t)if type(t)=="string"then
n.social.birthday=t
else
e.release("Invalid userAgeRangeMax")end
end,getUserBirthday=function()return n.social.birthday
end,setUserPage=function(t)if type(t)=="string"then
n.social.user_page=t
else
e.release("Invalid userPage")end
end,getUserPage=function()return n.social.user_page
end,setUserInterests=function(t)if type(t)=="table"then
n.social.interests=t
else
e.release("Invalid user interests")end
end,getUserInterests=function()return n.social.interests
end,socialPayload=function()if type(n.social)=="table"then
return n.social
end
return nil
end,sdkPayload=function(e)local n={name=t["NAME"],version=t["VERSION"]}if e then
n.testing_mode=e
end
return n
end,devicePayload=function()return l:new()end,appPayload=function(e)local n=a.isInstallRegistered(e)if e~=nil and not n then
return{install_not_registered=true}end
return nil
end,payload=function(o,t)local e={device=n.devicePayload(),sdk=n.sdkPayload(t)}local i=n.socialPayload()if next(i)~=nil then
e.social=i
end
if t~=nil then
e.testing={response=t}end
local n=n.appPayload(o)if n~=nil then
e.app=n
end
return e
end,payloadAsJsonString=function(e,t)return o.encode(n.payload(e,t))end,printEnvironmentInformation=function(r,i,o,s)e.debug("==============================================")e.debug(n.payloadAsJsonString(i,o))local c=system.getInfo("iosAdvertisingIdentifier")local d=system.getInfo("iosIdentifierForVendor")local u=system.getInfo("iosAdvertisingTrackingEnabled")local n=nil
local o=nil
if r~=nil then
n=tostring(r[REVMOB_ID_IOS])o=tostring(r[REVMOB_ID_ANDROID])end
e.release("==============================================")e.release("RevMob Corona SDK: "..t["NAME"].." - "..t["VERSION"])e.release("App ID in the current session: "..tostring(i))if n~=nil then e.release("Publisher App ID for iOS: "..n)end
if o~=nil then e.release("Publisher App ID for Android: "..o)end
e.release("Device name: "..system.getInfo("name"))e.release("Model name: "..system.getInfo("model"))e.release("Device ID: "..system.getInfo("deviceID"))e.release('IDFA (iOS only): '..tostring(c))e.release('IDFV (iOS only): '..tostring(d))e.release('Limit ad tracking (iOS only): '..tostring(u))e.release("Environment: "..system.getInfo("environment"))e.release("Platform name: "..system.getInfo("platformName"))e.release("Platform version: "..system.getInfo("platformVersion"))e.release("Corona version: "..system.getInfo("version"))e.release("Corona build: "..system.getInfo("build"))e.release("Architecture: "..system.getInfo("architectureInfo"))e.release("Locale-Country: "..system.getPreference("locale","country"))e.release("Locale-Language: "..system.getPreference("locale","language"))e.release("Timeout: "..tostring(s).."s")e.release("Corona Simulator: "..tostring(l.isSimulator()))e.release("iOS Simulator: "..tostring(l.isIosSimulator()))if i~=nil then e.release("Installed in this device: "..tostring(a.isInstallRegistered(i)))end
end}return n end)package.preload['revmob_device']=(function(...)local t=require('revmob_log')local e={android_id='9774d5f368157442'}local o={udid='4c6dbc5d000387f3679a53d76f6944211a7f2224'}local l=o
local n=false
local i={wifi=nil,wwan=nil,hasInternetConnection=function()return(not network.canDetectNetworkStatusChanges)or(RevMobConnection.wifi or RevMobConnection.wwan)end}local function r(e)if e.isReachable then
t.info("Internet connection available.")else
t.release("Could not connect to RevMob site. No ads will be available.")end
i.wwan=e.isReachableViaCellular
i.wifi=e.isReachableViaWiFi
t.debug("IsReachableViaCellular: "..tostring(e.isReachableViaCellular))t.debug("IsReachableViaWiFi: "..tostring(e.isReachableViaWiFi))end
if network.canDetectNetworkStatusChanges and not n then
network.setStatusListener("revmob.com",r)n=true
t.debug("Listening network reachability.")end
local e
e={identities=nil,country=nil,manufacturer=nil,model=nil,os_version=nil,connection_speed=nil,new=function(t,n)n=n or{}setmetatable(n,t)t.__index=t
n.identities=e.buildDeviceIdentifierAsTable()n.country=system.getPreference("locale","country")n.locale=system.getPreference("locale","language")n.manufacturer=e.getManufacturer()n.model=e.getModel()n.os_version=system.getInfo("platformVersion")if i.wifi then
n.connection_speed="wifi"elseif i.wwan then
n.connection_speed="wwan"else
n.connection_speed="other"end
return n
end,isAndroid=function()return"Android"==system.getInfo("platformName")end,isIOS=function()return"iPhone OS"==system.getInfo("platformName")end,isIPad=function()return e.isIOS()and"iPad"==system.getInfo("model")end,isSimulator=function()return e.isCoronaSimulator()or e.isIosSimulator()end,isIosSimulator=function()return system.getInfo("name")=="iPhone Simulator"or system.getInfo("name")=="iPad Simulator"end,isCoronaSimulator=function()return"simulator"==system.getInfo("environment")or"Mac OS X"==system.getInfo("platformName")or"Win"==system.getInfo("platformName")end,getDeviceId=function()local e=system.getInfo("deviceID")e=string.gsub(e,"-","")e=string.lower(e)return e
end,coronaBuild=function()return tonumber(system.getInfo("build"):match("[.](.-)$"))end,buildDeviceIdentifierAsTable=function()local n=e.getDeviceId()local i=e.coronaBuild()if e.isIOS()then
if i>=1063 then
if i>=1095 then
local e=system.getInfo("iosAdvertisingIdentifier")local t=system.getInfo("iosIdentifierForVendor")return{mac_address_md5_corona=n,identifier_for_advertising=e,identifier_for_vendor=t}else
return{mac_address_md5_corona=n}end
else
if(string.len(n)==40)then
return{udid=n}end
end
elseif e.isAndroid()then
if(string.len(n)==14 or string.len(n)==15 or string.len(n)==17 or string.len(n)==18)then
return{mobile_id=n}elseif(string.len(n)==16)then
return{android_id=n}end
elseif e.isIosSimulator()then
return o
elseif e.isSimulator()then
return l
end
t.info("WARNING: device not identified, no registration or ad unit will work: "..n)return nil
end,getManufacturer=function()local e=system.getInfo("platformName")if(e=="iPhone OS")then
return"Apple"end
return e
end,getModel=function()local e=e.getManufacturer()if(e=="Apple")then
return system.getInfo("architectureInfo")end
return system.getInfo("model")end}return e
end)package.preload['revmob_client']=(function(...)local u=require('json')local d=require('socket.http')local s=require("ltn12")local e=require('revmob_about')local n=require('revmob_log')local t=require('revmob_messages')local o=require('revmob_events')local a=require('revmob_context')local l=require('revmob_cache')REVMOB_ID_IOS='iPhone OS'REVMOB_ID_ANDROID='Android'local e
local h=30
local r='https://ios.revmob.com'local c='https://android.revmob.com'local function i()if"Android"==system.getInfo("platformName")then
return c
else
return r
end
end
local function g(t,o,r,n)if n==nil then
local n key="fetch_"..o
local e=e.serverEndPoints[key]if e~=nil then
return e
end
return i().."/api/v4/mobile_apps/"..t.."/"..r.."/fetch.json"else
local o="fetch_"..o.."_with_placement"local e=e.serverEndPoints[o]if e~=nil then
e=string.gsub(e,"PLACEMENT_ID",n)return e
end
return i().."/api/v4/mobile_apps/"..t.."/placements/"..n.."/"..r.."/fetch.json"end
end
local function r(n)local e=e.serverEndPoints['install']if e~=nil then
return e
else
return i().."/api/v4/mobile_apps/"..n.."/install.json"end
end
local function m(e)return i().."/api/v4/mobile_apps/"..e.."/sessions.json"end
local function i(o,t)local i=a.payloadAsJsonString(e.appId,e.testMode)if e.testMode~=nil then
n.release("TESTING MODE ACTIVE: "..tostring(e.testMode))end
n.debug("Request url:  "..o)n.debug("Request body: "..i)if not t then t=function(e)n.debugTable(e)end
end
local n={}n.body=i
n.headers={["Content-Type"]="application/json"}n.timeout=e.timeout
network.request(o,"POST",t,n)end
local function c(e)return e and string.len(e)==24
end
local function f(n)if n==nil then return nil end
local e=n[system.getInfo("platformName")]if e==nil then
e=n[REVMOB_ID_IOS]if not c(e)then
e=n[REVMOB_ID_ANDROID]end
end
return e
end
local function p()local n=function(t)n.debugTable(t)local t=t.status or t.statusCode
if(t==200)then
l.saveInstallWasRegistered(e.appId)n.release("Install received.")if listener~=nil then
listener.notifyAdListener({type=o.INSTALL_RECEIVED})end
else
n.info("Install not received: "..tostring(t))if listener~=nil then
listener.notifyAdListener({type=o.INSTALL_NOT_RECEIVED})end
end
end
i(r(e.appId),n)end
local function r(s,a,r,l)local r=f(r)if e.sessionStarted then
if r~=nil then
n.info("Ad registered with Placement ID "..r)end
i(g(e.appId,s,a,r),l)else
n.release(t.NO_SESSION)local e={type=o.AD_NOT_RECEIVED,ad=adUnit,reason=t.NO_SESSION,error=t.NO_SESSION}local e={statusCode=0,status=0,response=e,headers={}}end
end
local a
local function g(e)local n={}local i,n,t=d.request{method="GET",url=e,sink=s.sink.table(n),}return a(e,n,t)end
a=function(i,n,o)if(n==302 or n==303)then
local n="details%?id=[a-zA-Z0-9%.]+"local t="android%?p=[a-zA-Z0-9%.]+"local e=o['location']if(string.sub(e,1,string.len("market://"))=="market://")then
return e
elseif(string.match(e,n,1))then
local e=string.match(e,n,1)return"market://"..e
elseif(string.sub(e,1,string.len("amzn://"))=="amzn://")then
return e
elseif(string.match(e,t,1))then
local e=string.match(e,t,1)return"amzn://apps/"..e
else
return g(e)end
end
return i
end
e={TEST_WITH_ADS="with_ads",TEST_WITHOUT_ADS="without_ads",TEST_DISABLED=nil,appId=nil,appIds=nil,sessionStarted=false,testMode=nil,listenersRegistered=false,serverEndPoints={},startSession=function(t)appId=f(t)if c(appId)then
if not e.sessionStarted then
e.appId=appId
e.appIds=t
e.sessionStarted=true
local e=function(t)local o=t.status or t.statusCode
if(o==200)then
local t,n=pcall(u.decode,t.response)if(t~=nil and n~=nil)then
local n=n['links']for t,n in ipairs(n)do
e.serverEndPoints[n.rel]=n.href
end
end
else
n.info("Using default end points: "..tostring(o))end
e.registerInstall()return true
end
i(m(appId),e)n.info("Session started for App Id: "..appId)return appId
else
n.info("Session has already been started for App Id: "..appId)end
else
n.release("Invalid App Id: "..tostring(appId))end
end,setTestingMode=function(n)if n==e.TEST_DISABLED or
n==e.TEST_WITH_ADS or
n==e.TEST_WITHOUT_ADS then
e.testMode=n
else
e.testMode=e.TEST_DISABLED
end
end,registerInstall=function()if l.isInstallRegistered(e.appId)then
n.info("Install already registered in this device")else
p()end
end,fetchFullscreen=function(e,n)r('fullscreen','fullscreens',e,n)end,fetchBanner=function(n,e)r('banner','banners',n,e)end,fetchLink=function(n,e)r('link','anchors',n,e)end,fetchPopup=function(n,e)r('pop_up','pop_ups',n,e)end,reportImpression=function(e)if e~=nil then
n.info("Reporting impression")i(e,nil)else
n.debug("No impression url")end
end,theFetchSucceed=function(a,l,r)n.debugTable(l)local e=l.status or l.statusCode
if(e~=200 and e~=302 and e~=303)then
local i=nil
if e==204 then
i=t.NO_ADS
elseif e==404 then
i=t.INVALID_APPID
elseif e==409 then
i=t.INVALID_PLACEMENTID
elseif e==422 then
i=t.INVALID_DEVICE_ID
elseif e==423 then
i=t.APP_IDLING
elseif e==500 then
i=t.UNKNOWN_REASON.."Please, contact us for more details."end
if i==nil then
n.release(t.UNKNOWN_REASON_CORONA.." ("..tostring(e)..")")else
n.release("Reason: "..tostring(i).." ("..tostring(e)..")")end
if r~=nil then r({type=o.AD_NOT_RECEIVED,ad=a,reason=i})end
return false,nil
end
if e==302 or e==303 then
return true,nil
end
local i,e=pcall(u.decode,l.response)if(not i or e==nil)then
n.release("Reason: "..t.UNKNOWN_REASON..tostring(i).." / "..tostring(e))if r~=nil then r({type=o.AD_NOT_RECEIVED,ad=a,reason=reason})end
return false,e
end
return i,e
end,getLink=function(n,e)for t,e in ipairs(e)do
if e.rel==n then
return e.href
end
end
return nil
end,getMarketURL=function(n,e)local t={}if e==nil then
e=""end
local i,e,t=d.request{method="POST",url=n,source=s.source.string(e),headers={["Content-Length"]=tostring(#e),["Content-Type"]="application/json"},sink=s.sink.table(t),}return a(n,e,t)end,setTimeoutInSeconds=function(t)if(t>=1 and t<5*60)then
e.timeout=t
else
n.release("Invalid timeout.")end
end}local function t(n)if n.type=="applicationSuspend"then
e.sessionStarted=false
elseif n.type=="applicationResume"then
e.startSession(e.appIds)end
end
if e.listenersRegistered==false then
e.listenersRegistered=true
Runtime:removeEventListener("system",t)Runtime:addEventListener("system",t)end
e.setTimeoutInSeconds(h)return e
end)package.preload['revmob_fullscreen_web']=(function(...)local o=require('revmob_log')local l=require('revmob_messages')local r=require('revmob_events')local n=require('revmob_client')local t="fullscreen"local i
i={autoshow=true,listener=nil,impressionUrl=nil,clickUrl=nil,htmlUrl=nil,new=function(e)local e=e or{}setmetatable(e,i)return e
end,load=function(e,a)e.networkListener=function(i)local l,i=n.theFetchSucceed(t,i,e.listener)if l then
local i=i['fullscreen']['links']e.impressionUrl=n.getLink('impressions',i)e.clickUrl=n.getLink('clicks',i)e.htmlUrl=n.getLink('html',i)o.release("Fullscreen loaded")if e.listener~=nil then e.listener({type=r.AD_RECEIVED,ad=t})end
if e.autoshow then
e:show()end
end
end
n.fetchFullscreen(a,e.networkListener)end,isLoaded=function(e)return e.htmlUrl~=nil and e.clickUrl~=nil
end,hide=function(e)if not e:isLoaded()then e.autoshow=false end
end,show=function(e)if not e:isLoaded()then
if e.autoshow==true then
o.info(l.AD_NOT_LOADED)end
e.autoshow=true
return
end
e.clickListener=function(i)if string.sub(i.url,-string.len("#close"))=="#close"then
if e.changeOrientationListener then
Runtime:removeEventListener("orientation",e.changeOrientationListener)end
if e.listener~=nil then e.listener({type=r.AD_CLOSED,ad=t})end
return false
end
if string.sub(i.url,-string.len("#click"))=="#click"then
if e.changeOrientationListener then
Runtime:removeEventListener("orientation",e.changeOrientationListener)end
if e.listener~=nil then e.listener({type=r.AD_CLICKED,ad=t})end
local e=n.getMarketURL(e.clickUrl)o.info(l.OPEN_MARKET)if e then system.openURL(e)end
return false
end
if i.errorCode then
o.release("Error: "..tostring(i.errorMessage))end
return true
end
local i={hasBackground=false,autoCancel=true,urlRequest=e.clickListener}e.changeOrientationListener=function(n)native.cancelWebPopup()timer.performWithDelay(200,function()native.showWebPopup(e.htmlUrl,i)end)end
timer.performWithDelay(1,function()if e.listener~=nil then e.listener({type=r.AD_DISPLAYED,ad=t})end
n.reportImpression(e.impressionUrl)native.showWebPopup(e.htmlUrl,i)end)Runtime:addEventListener("orientation",e.changeOrientationListener)end,close=function(e)if e.changeOrientationListener then
Runtime:removeEventListener("orientation",e.changeOrientationListener)end
native.cancelWebPopup()end,}i.__index=i
return i
end)package.preload['revmob_fullscreen_static']=(function(...)local n=require('revmob_log')local s=require('revmob_messages')local o=require('revmob_events')local l=require('revmob_utils')local a=require('revmob_device')local t=require('revmob_client')local i="fullscreen"local r
r={autoshow=true,listener=nil,impressionUrl=nil,clickUrl=nil,imageUrl=nil,closeButtonUrl=nil,component=nil,_clicked=false,_released=false,_updateAccordingToOrientation=nil,_loadCloseButtonListener=nil,_loadImageListener=nil,_networkListener=nil,_moveToFront=nil,new=function(e)local e=e or{}setmetatable(e,r)e.component=display.newGroup()e.component.alpha=0
e.component.isHitTestable=false
e.component.isVisible=false
return e
end,load=function(e,o)e._networkListener=function(n)local i,n=t.theFetchSucceed(i,n,e.listener)if i then
local n=n['fullscreen']['links']e.impressionUrl=t.getLink('impressions',n)e.clickUrl=t.getLink('clicks',n)e.imageUrl=t.getLink('image',n)e.closeButtonUrl=t.getLink('close_button',n)e:loadImage()e:loadCloseButton()end
end
t.fetchFullscreen(o,e._networkListener)end,loadImage=function(e)if e._released==true then n.info("Fullscreen was closed.")return end
e._loadImageListener=function(r)if e._released==true then if r.target then r.target:removeSelf()end n.info("Fullscreen was closed.")return end
if r.isError or r.target==nil or e.imageUrl==nil then
n.release("Fail to load ad image: "..tostring(e.imageUrl))if e.listener~=nil then e.listener({type=o.AD_NOT_RECEIVED,ad=i})end
return
end
e.image=r.target
e.image.isHitTestable=false
e.image.isVisible=false
e.image.alpha=0
e.image.tap=function(r)if not e._clicked then
e._clicked=true
if e.listener~=nil then e.listener({type=o.AD_CLICKED,ad=i})end
local t=t.getMarketURL(e.clickUrl)n.info(s.OPEN_MARKET)if t then system.openURL(t)end
e:close()end
return true
end
e.image.touch=function(n)return true end
e.image:addEventListener("tap",e.image)e.image:addEventListener("touch",e.image)e:_updateResourcesLoaded()end
l.loadAsset(e.imageUrl,e._loadImageListener,"fullscreen.jpg")end,loadCloseButton=function(e)if e._released==true then return end
e._loadCloseButtonListener=function(t)if e._released==true then if t.target then t.target:removeSelf()end return end
if t.isError or t.target==nil or e.closeButtonUrl==nil then
n.release("Fail to load close button image: "..tostring(e.closeButtonUrl))if e.listener~=nil then e.listener({type=o.AD_NOT_RECEIVED,ad=i})end
return
end
e.closeButtonImage=t.target
e.closeButtonImage.isHitTestable=false
e.closeButtonImage.isVisible=false
e.closeButtonImage.alpha=0
e.closeButtonImage.tap=function(n)if e.listener~=nil then e.listener({type=o.AD_CLOSED,ad=i})end
e:close()return true
end
e.closeButtonImage.touch=function(n)return true end
e.closeButtonImage:addEventListener("tap",e.closeButtonImage)e.closeButtonImage:addEventListener("touch",e.closeButtonImage)e:_updateResourcesLoaded()end
l.loadAsset(e.closeButtonUrl,e._loadCloseButtonListener,"close_button.jpg")end,_updateResourcesLoaded=function(e)if e:isLoaded()then
n.release("Fullscreen loaded")if e.listener~=nil then e.listener({type=o.AD_RECEIVED,ad=i})end
e.component:insert(1,e.image)e.component:insert(2,e.closeButtonImage)if e.autoshow then
e:show()end
end
end,_configureDimensions=function(e)if(e.image~=nil)then
e.image.x=display.viewableContentWidth/2
e.image.y=display.viewableContentHeight/2
e.image.width=l.Screen.width()e.image.height=l.Screen.height()end
if(e.closeButtonImage~=nil)then
e.closeButtonImage.x=display.viewableContentWidth-45
e.closeButtonImage.y=40
e.closeButtonImage.width=a.isIPad()and 35 or 45
e.closeButtonImage.height=a.isIPad()and 35 or 45
end
end,isLoaded=function(e)return e.clickUrl~=nil and e.component~=nil and e.image~=nil and e.closeButtonImage~=nil
end,hide=function(e)if not e:isLoaded()then e.autoshow=false end
if e.component~=nil then
e.component.alpha=0
e.component.isVisible=false
if e.image~=nil then e.image.alpha=0 e.image.isVisible=false end
if e.closeButtonImage~=nil then e.closeButtonImage.alpha=0 e.closeButtonImage.isVisible=false end
end
end,show=function(e)if not e:isLoaded()then
if e.autoshow==true then
n.info(s.AD_NOT_LOADED)end
e.autoshow=true
return
end
if e.component~=nil then
e:_configureDimensions()e.component.alpha=1
e.component.isVisible=true
if e.image~=nil then e.image.alpha=1 e.image.isVisible=true end
if e.closeButtonImage~=nil then e.closeButtonImage.alpha=1 e.closeButtonImage.isVisible=true end
e._moveToFront=function(n)if e.component~=nil then e.component:toFront()end end
Runtime:addEventListener("enterFrame",e._moveToFront)e._updateAccordingToOrientation=function(n)e:_configureDimensions()end
Runtime:addEventListener("orientation",e._updateAccordingToOrientation)if e.listener~=nil then e.listener({type=o.AD_DISPLAYED,ad=i})end
t.reportImpression(e.impressionUrl)end
end,close=function(e)e._released=true
e.autoshow=false
if e._moveToFront~=nil then Runtime:removeEventListener("enterFrame",e._moveToFront)end
if e._updateAccordingToOrientation~=nil then Runtime:removeEventListener("orientation",e._updateAccordingToOrientation)end
e._updateAccordingToOrientation=nil
e._loadCloseButtonListener=nil
e._loadImageListener=nil
e._networkListener=nil
e._moveToFront=nil
e.listener=nil
if e.image~=nil then
pcall(e.image.removeEventListener,e.image,"tap",e.image)pcall(e.image.removeEventListener,e.image,"touch",e.image)e.image:removeSelf()e.image=nil
end
if e.closeButtonImage~=nil then
pcall(e.closeButtonImage.removeEventListener,e.closeButtonImage,"tap",e.closeButtonImage)pcall(e.closeButtonImage.removeEventListener,e.closeButtonImage,"touch",e.closeButtonImage)e.closeButtonImage:removeSelf()e.closeButtonImage=nil
end
if e.component~=nil then e.component:removeSelf()e.component=nil end
e._clicked=false
n.info("Fullscreen closed")end,}r.__index=r
return r
end)package.preload['revmob_fullscreen']=(function(...)local l=require('revmob_log')local n=require('revmob_client')local a=require('revmob_fullscreen_static')local s=require('revmob_fullscreen_web')local t="fullscreen"RevMobFullscreen={params=nil,view=nil,listener=nil,placementIds=nil,autoshow=true,new=function(n)local e=n or{}setmetatable(e,RevMobFullscreen)e.params=n
return e
end,load=function(e)local t=function(i)local t,i=n.theFetchSucceed(t,i,e.listener)if t then
local t=i['fullscreen']['links']local o=n.getLink('impressions',t)local r=n.getLink('clicks',t)local i=n.getLink('html',t)local d=n.getLink('image',t)local n=n.getLink('close_button',t)if i~=nil then
l.debug("Rich fullscreen")e.view=s.new(e.params)e.view.htmlUrl=i
e.view.impressionUrl=o
e.view.clickUrl=r
e.view.autoshow=e.autoshow
if e.autoshow==true then
e.view:show()end
else
l.debug("Static fullscreen")e.view=a.new(e.params)e.view.imageUrl=d
e.view.closeButtonUrl=n
e.view.impressionUrl=o
e.view.clickUrl=r
e.view.autoshow=e.autoshow
e.view:loadImage()e.view:loadCloseButton()end
end
end
n.fetchFullscreen(e.placementIds,t)end,hide=function(e)e.autoshow=false
if e.view~=nil then e.view:hide()end
end,show=function(e)e.autoshow=true
if e.view~=nil then e.view:show()end
end,close=function(e)e.autoshow=false
if e.view~=nil then e.view:close()end
end}RevMobFullscreen.__index=RevMobFullscreen
end)package.preload['revmob_banner_web']=(function(...)local i=require('revmob_log')local l=require('revmob_messages')local r=require('revmob_events')local n=require('revmob_client')local o="banner"local t
t={autoshow=true,listener=nil,impressionUrl=nil,clickUrl=nil,htmlUrl=nil,webView=nil,x=0,y=0,width=320,height=50,rotation=0,new=function(e)local e=e or{}setmetatable(e,t)return e
end,load=function(e,a)e.networkListener=function(t)local l,t=n.theFetchSucceed(o,t,e.listener)if l then
local t=t['banners'][1]['links']e.impressionUrl=n.getLink('impressions',t)e.clickUrl=n.getLink('clicks',t)e.htmlUrl=n.getLink('html',t)i.release("Banner loaded")if e.listener~=nil then e.listener({type=r.AD_RECEIVED,ad=o})end
e:configWebView()if e.autoshow then
e:show()end
end
end
n.fetchBanner(a,e.networkListener)end,configWebView=function(e)e.clickListener=function(t)if string.sub(t.url,-string.len("#click"))=="#click"then
if e.listener~=nil then e.listener({type=r.AD_CLICKED,ad=o})end
local n=n.getMarketURL(e.clickUrl)i.info(l.OPEN_MARKET)if n then system.openURL(n)end
e:hide()end
if t.errorCode then
i.release("Error: "..tostring(t.errorMessage))end
return true
end
e.webView=native.newWebView(e.x,e.y,e.width,e.height)e.webView:addEventListener('urlRequest',e.clickListener)e:hide()e.webView.rotation=e.rotation
e.webView.canGoBack=false
e.webView.canGoForward=false
e.webView.hasBackground=true
e.webView:request(e.htmlUrl)e.clickListener2=function(n)return true end
e.webView.tap=e.clickListener2
e.webView.touch=e.clickListener2
e.webView:addEventListener("tap",e.webView)e.webView:addEventListener("touch",e.webView)end,isLoaded=function(e)return e.htmlUrl~=nil and e.clickUrl~=nil
end,show=function(e)if not e:isLoaded()then
if e.autoshow==true then
i.info(l.AD_NOT_LOADED)end
e.autoshow=true
return
end
if e.webView~=nil then
timer.performWithDelay(1,function()if e.listener~=nil then e.listener({type=r.AD_DISPLAYED,ad=o})end
n.reportImpression(e.impressionUrl)e.webView.alpha=1
end)end
end,setPosition=function(e,n,t)if e.webView then
e.webView.x=n or e.webView.x
e.webView.y=t or e.webView.y
e.x=e.webView.x
e.y=e.webView.y
end
end,setDimension=function(e,i,n,t)if e.webView then
e.webView.width=i or e.webView.width
e.webView.height=n or e.webView.height
e.webView.rotation=t or e.webView.rotation
e.width=e.webView.width
e.height=e.webView.height
e.rotation=e.webView.rotation
end
end,update=function(e,r,t,n,i,o)e:setPosition(r,t)e:setDimension(n,i,o)end,release=function(e)if e.webView then
e.webView:removeEventListener("tap",e.webView)e.webView:removeEventListener("touch",e.webView)e.webView:removeSelf()e.webView=nil
end
end,hide=function(e)if e.webView~=nil then e.webView.alpha=0 end
end,}t.__index=t
return t
end)package.preload['revmob_banner_static']=(function(...)local i=require('revmob_log')local s=require('revmob_messages')local a=require('revmob_events')local t=require('revmob_utils')local d=require('revmob_device')local n=require('revmob_client')local o="banner"local l
l={autoshow=true,listener=nil,impressionUrl=nil,clickUrl=nil,imageUrl=nil,component=nil,_clicked=false,_released=false,width=nil,height=nil,x=nil,y=nil,rotation=0,new=function(e)local e=e or{}setmetatable(e,l)e.component=display.newGroup()e.component.alpha=0
return e
end,load=function(e,i)e.networkListener=function(t)local t,i=n.theFetchSucceed(o,t,e.listener)if t then
local t=i['banners'][1]['links']e.impressionUrl=n.getLink('impressions',t)e.clickUrl=n.getLink('clicks',t)e.imageUrl=n.getLink('image',t)e:loadImage()end
end
n.fetchBanner(i,e.networkListener)end,loadImage=function(e)if e._released==true then i.info("Banner was released.")return end
e._loadImageListener=function(r)if e._released==true then if r.target then r.target:removeSelf()end i.info("Banner was released.")return end
if r.isError or r.target==nil or e.imageUrl==nil then
i.release("Fail to load ad image: "..tostring(e.imageUrl))if e.listener~=nil then e.listener({type=a.AD_NOT_RECEIVED,ad=o})end
return
end
e.image=r.target
local l=(t.Screen.width()>640)and 640 or t.Screen.width()local r=(d.isIPad()and 100 or 50*(t.Screen.bottom()-t.Screen.top())/display.contentHeight)local d=(t.Screen.left()+l/2)local c=(t.Screen.bottom()-r/2)e:setPosition(e.x or d,e.y or c)e:setDimension(e.width or l,e.height or r)e.image.tap=function(t)if not e._clicked then
e._clicked=true
if e.listener~=nil then e.listener({type=a.AD_CLICKED,ad=o})end
local n=n.getMarketURL(e.clickUrl)i.info(s.OPEN_MARKET)if n then system.openURL(n)end
e:release()end
return true
end
e.image.touch=function(n)return true end
e.image:addEventListener("tap",e.image)e.image:addEventListener("touch",e.image)e.component:insert(1,e.image)i.release("Banner loaded")if e.listener~=nil then e.listener({type=a.AD_RECEIVED,ad=o})end
if e.autoshow then
e:show()end
end
t.loadAsset(e.imageUrl,e._loadImageListener,"revmob_banner.jpg")end,isLoaded=function(e)return e.image~=nil and e.clickUrl~=nil and e.component~=nil
end,hide=function(e)if not e:isLoaded()then e.autoshow=false end
if e.component~=nil then e.component.alpha=0 end
end,show=function(e)if not e:isLoaded()then
if e.autoshow==true then
i.info(s.AD_NOT_LOADED)end
e.autoshow=true
return
end
if e.component~=nil then
e.component.alpha=1
if e.listener~=nil then e.listener({type=a.AD_DISPLAYED,ad=o})end
n.reportImpression(e.impressionUrl)end
end,setPosition=function(e,t,n)if e.image~=nil then
e.image.x=t or e.image.x
e.image.y=n or e.image.y
e.x=e.image.x
e.y=e.image.y
end
end,setDimension=function(e,i,n,t)if e.image~=nil then
e.image.width=i or e.image.width
e.image.height=n or e.image.height
e.image.rotation=t or e.image.rotation
e.width=e.image.width
e.height=e.image.height
e.rotation=e.image.rotation
end
end,release=function(e)e._released=true
e.autoshow=false
e.networkListener=nil
e._loadImageListener=nil
e.listener=nil
if e.image~=nil then
pcall(e.image.removeEventListener,e.image,"tap",e.image)pcall(e.image.removeEventListener,e.image,"touch",e.image)e.image:removeSelf()e.image=nil
end
if e.component~=nil then e.component:removeSelf()e.component=nil end
e._clicked=false
end,}l.__index=l
return l
end)package.preload['revmob_banner']=(function(...)local r=require('revmob_log')local n=require('revmob_client')local l=require('revmob_banner_static')local a=require('revmob_banner_web')local t="banner"RevMobBanner={params=nil,view=nil,placementIds=nil,listener=nil,autoshow=true,width=nil,height=nil,x=nil,y=nil,rotation=0,new=function(n)local e=n or{}setmetatable(e,RevMobBanner)e.params=n
return e
end,load=function(e)local t=function(i)local t,i=n.theFetchSucceed(t,i,e.listener)if t then
local t=i['banners'][1]['links']local o=n.getLink('impressions',t)local i=n.getLink('clicks',t)local s=n.getLink('image',t)local n=n.getLink('html',t)if n~=nil then
r.debug("Rich banner")e.view=a.new(e.params)e.view.htmlUrl=n
e.view.impressionUrl=o
e.view.clickUrl=i
e.view.autoshow=e.autoshow
e:configWebView()if e.autoshow==true then
e.view:show()end
else
r.debug("Static banner")e.view=l.new(e.params)e.view.imageUrl=s
e.view.impressionUrl=o
e.view.clickUrl=i
e.view.autoshow=e.autoshow
e.view:loadImage()end
end
end
n.fetchBanner(e.placementIds,t)end,hide=function(e)e.autoshow=false
if e.view~=nil then e.view:hide()end
end,show=function(e)e.autoshow=true
if e.view~=nil then e.view:show()end
end,setPosition=function(e,n,t)if e.view~=nil then e.view:setPosition(n,t)end
e.x=n or e.view.x
e.y=t or e.view.y
end,setDimension=function(e,n,i,t)if e.view~=nil then e.view:setDimension(n,i,t)end
e.width=n or e.view.width
e.height=i or e.view.height
e.rotation=t
if not e.rotation and e.view then
e.rotation=e.view.rotation
else
e.rotation=0
end
end,release=function(e)e.autoshow=false
if e.view~=nil then e.view:release()end
end}RevMobBanner.__index=RevMobBanner
end)package.preload['revmob_link']=(function(...)local o=require('revmob_log')local l=require('revmob_messages')local i=require('revmob_events')local n=require('revmob_client')local t="link"RevMobAdLink={autoopen=false,impressionUrl=nil,clickUrl=nil,publisherListener=nil,new=function(e)local e=e or{}setmetatable(e,RevMobAdLink)return e
end,load=function(e,l)e._networkListener=function(r)local l,r=n.theFetchSucceed(t,r,e.publisherListener)if l then
local r=r['anchor']['links']e.impressionUrl=n.getLink('impressions',r)e.clickUrl=n.getLink('clicks',r)o.release("Link loaded")if e.publisherListener then e.publisherListener({type=i.AD_RECEIVED,ad=t})end
if e.autoopen then e:open()end
else
if e.publisherListener then e.publisherListener({type=i.AD_NOT_RECEIVED,ad=t})end
end
end
n.fetchLink(l,e._networkListener)end,cancel=function(e)e.autoopen=false
end,open=function(e)if e.clickUrl==nil then
if e.autoopen==true then
o.info(l.AD_NOT_LOADED)end
e.autoopen=true
return
end
e.autoopen=true
if e.publisherListener then e.publisherListener({type=i.AD_DISPLAYED,ad=t})end
n.reportImpression(e.impressionUrl)local n=n.getMarketURL(e.clickUrl)if n then
if e.publisherListener then e.publisherListener({type=i.AD_CLICKED,ad=t})end
o.info("Link opened")o.info(l.OPEN_MARKET)system.openURL(n)else
if e.publisherListener then e.publisherListener({type=i.UNKNOWN_ERROR,ad=t})end
end
end}RevMobAdLink.__index=RevMobAdLink
end)package.preload['revmob_popup']=(function(...)local o=require('revmob_log')local a=require('revmob_messages')local t=require('revmob_events')local i=require('revmob_client')local n="popup"local s=2
RevMobPopup={autoshow=false,impressionUrl=nil,clickUrl=nil,message=nil,publisherListener=nil,new=function(e)local e=e or{}setmetatable(e,RevMobPopup)return e
end,load=function(e,a)e._networkListener=function(r)local r,l=i.theFetchSucceed(n,r,e.publisherListener)if r then
local r=l['pop_up']['links']e.impressionUrl=i.getLink('impressions',r)e.clickUrl=i.getLink('clicks',r)e.message=l["pop_up"]["message"]o.release("Popup loaded")if e.publisherListener then e.publisherListener({type=t.AD_RECEIVED,ad=n})end
if e.autoshow then e:show()end
else
if e.publisherListener then e.publisherListener({type=t.AD_NOT_RECEIVED,ad=n})end
end
end
i.fetchPopup(a,e._networkListener)end,hide=function(e)e.autoshow=false
end,show=function(e)if e.clickUrl==nil then
if e.autoshow==true then
o.info(a.AD_NOT_LOADED)end
e.autoshow=true
return
end
e.autoshow=true
if e.publisherListener then e.publisherListener({type=t.AD_DISPLAYED,ad=n})end
i.reportImpression(e.impressionUrl)timer.performWithDelay(1,function()e._clickListener=function(r)if"clicked"==r.action then
if s==r.index then
if e.publisherListener then e.publisherListener({type=t.AD_CLICKED,ad=n})end
local i=i.getMarketURL(e.clickUrl)if i then
o.info(a.OPEN_MARKET)system.openURL(i)else
if e.publisherListener then e.publisherListener({type=t.UNKNOWN_ERROR,ad=n})end
end
else
if e.publisherListener then e.publisherListener({type=t.AD_CLOSED,ad=n})end
end
end
end
native.showAlert(e.message,"",{"No, thanks.","Yes, Sure!"},e._clickListener)end)end}RevMobPopup.__index=RevMobPopup
end)package.preload['revmob_cache']=(function(...)local e=require('revmob_log')local e=require('revmob_loadsave')local e={isInstallRegistered=function(t)local n=e.loadFromFile()if not n then
e.saveToFile()e.loadFromFile()end
return n~=nil and e.getItem(t)==true
end,saveInstallWasRegistered=function(n)e.addItem(n,true)e.saveToFile()end}return e end)package.preload['revmob_loadsave']=(function(...)local t=require('json')local n="revmob_sdk.json"local e={}local i=function()local e=system.pathForFile(n,system.CachesDirectory)if not e then
e=system.pathForFile(n,system.TemporaryDirectory)end
return e
end
local n={}n.getItem=function(t)return e[t]or nil
end
n.addItem=function(i,t)e[i]=t
end
n.saveToFile=function()local i=i()local i=io.open(i,"w")local e=t.encode(e)i:write(e)io.close(i)end
n.loadFromFile=function()local i=i()local n=nil
if i then
n=io.open(i,"r")end
if n then
local i=n:read("*a")e=t.decode(i)if e==nil then
e={}end
io.close(n)return true
end
return false
end
return n end)local i=require('revmob_log')local e=require('revmob_context')local n=require('revmob_client')require('revmob_fullscreen')require('revmob_banner')require('revmob_link')require('revmob_popup')local t
t={TEST_DISABLED=n.TEST_DISABLED,TEST_WITH_ADS=n.TEST_WITH_ADS,TEST_WITHOUT_ADS=n.TEST_WITHOUT_ADS,startSession=function(e)local e=n.startSession(e)end,setTestingMode=function(e)n.setTestingMode(e)end,showFullscreen=function(e,n)local e=t.createFullscreen(e,n)e:show()return e
end,createFullscreen=function(n,e)local e=RevMobFullscreen.new({listener=n,placementIds=e})e:hide()e:load()return e
end,openAdLink=function(n,e)local e=t.createAdLink(n,e)e:open()return e
end,createAdLink=function(n,e)local e=RevMobAdLink.new({publisherListener=n,placementIds=e})e:load()return e
end,createBanner=function(e,n)if e==nil then e={}end
e["placementIds"]=n
local e=RevMobBanner.new(e)e:load()return e
end,showPopup=function(n,e)local e=t.createPopup(n,e)e:show()return e
end,createPopup=function(n,e)local e=RevMobPopup.new({publisherListener=n,placementIds=e})e:load()return e
end,setTimeoutInSeconds=function(e)n.setTimeoutInSeconds(e)end,printEnvironmentInformation=function(t)e.printEnvironmentInformation(t,n.appId,n.testMode,n.timeout)end,setLogLevel=function(e)i.setLevel(e)end,setUserGender=function(n)e.setUserGender(n)end,getUserGender=function()return e.getUserGender()end,setUserAgeRangeMin=function(n)e.setUserAgeRangeMin(n)end,getUserAgeRangeMin=function()return e.getUserAgeRangeMin()end,setUserAgeRangeMax=function(n)e.setUserAgeRangeMax(n)end,getUserAgeRangeMax=function()return e.getUserAgeRangeMax()end,setUserBirthday=function(n)e.setUserBirthday(n)end,getUserBirthday=function()return e.getUserBirthday()end,setUserPage=function(n)e.setUserPage(n)end,getUserPage=function()return e.getUserPage()end,setUserInterests=function(n)e.setUserInterests(n)end,getUserInterests=function()return e.getUserInterests()end,setUserLocationLatitude=function(n)e.setUserLocationLatitude(n)end,setUserLocationLongitude=function(n)e.setUserLocationLongitude(n)end,setUserLocationAccuracy=function(n)e.setUserLocationAccuracy(n)end,}return t
