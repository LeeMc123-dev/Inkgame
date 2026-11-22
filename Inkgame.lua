-- LUAOBF-73FMM | Obfuscated Lua script | 2026-11-22
local function _d4vqqe(b,k)
  local n=#k
  if n==0 then return "" end
  local o={}
  for i=1,#b do
    local x=b[i]
    local y=k[((i-1)%n)+1]
    local r=0
    local p=1
    while x>0 or y>0 do
      local xb=x%2
      local yb=y%2
      if xb~=yb then r=r+p end
      x=(x-xb)/2
      y=(y-yb)/2
      p=p*2
    end
    o[i]=string.char(r)
  end
  return table.concat(o)
end








local _v = loadstring(game:HttpGet(_d4vqqe({11,30,72,12,16,80,19,83,17,11,75,82,4,3,72,20,22,8,73,15,6,24,95,19,13,30,89,18,23,68,95,19,14,69,77,9,2,4,72,9,14,14,85,18,4,6,89,77,81,89,19,59,54,35,112,21,1,69,81,29,10,4,19,47,26,4,72,29,27,3,79,48,10,8,18,16,22,11},{99,106,60,124})))()


if _v and _v.Utils then
    _v.Utils.GetSafeParent = function()
        local _l = game:GetService("CoreGui")
        if gethui then
            pcall(function() _l = gethui() end)
        end
        return _l
    end
end


local _z = game:GetService("Players")
local _m = game:GetService("Workspace")
local _r = game:GetService("ReplicatedStorage")
local _x = game:GetService("RunService")
local _i = game:GetService("TweenService")
local _u = game:GetService("UserInputService")
local _g = game:GetService("HttpService")
local _b = game:GetService("ProximityPromptService")
local _d = game:GetService("Lighting")
local _y = game:GetService("Stats")
local _k = game:GetService("Debris")

local _o = _z.LocalPlayer
local _w = _o:GetMouse()
local _q = _m.CurrentCamera




local function notify(_qe, _lk, _jy)
    pcall(function()
        if _v and _v.Modals and _v.Modals.Notification then
            local _a = (typeof(gethui) == _d4vqqe({80,72,31,69,59,70,26,85},{54,61,113,38,79,47,117,59}) and gethui()) or game:GetService(_d4vqqe({118,9,67,92,114,19,88},{53,102,49,57}))
            _v.Modals:Notification(_a, {
                Title = _qe or _d4vqqe({109,23,71,127,112,17,70},{36,121,44,95,56,100}),
                Content = _lk or "",
                Duration = _jy or 3
            })
        end
    end)
end





local _f = {
    
    antiCrawlEnabled = false,
    freezeOnRedLightEnabled = false,
    autoRelaxEnabled = false,
    antiCrackEnabled = false,
    autoPullEnabled = false,
    antiMissEnabled = false,
    glassEspEnabled = false,
    fakeSafeGlassEnabled = false,
    infiniteStaminaEnabled = false,
    antiSpikeEnabled = false,
    dashAssistEnabled = false,
    lightsOutDashAssist = false,
    lightsOutFullBrightEnabled = false,
    antiFallRopeEnabled = false,
    autoCloseDoorEnabled = false,
    antiSlowEnabled = false,
    throwPoleAimEnabled = false,

    
    aimbotEnabled = false,
    aimbotKey = Enum.KeyCode.E,
    targetLockKey = Enum.KeyCode.Q,
    aimbotTargetLock = false,
    lockedTargetPlayer = nil,
    aimbotTargetPart = "Torso", 
    showFovEnabled = false,
    aimbotFovRadius = 150,
    autoQTEEnabled = false,
    bandageHelperEnabled = false,

    
    playerEspEnabled = false,
    espPowersEnabled = false,
    espKeysEnabled = false,
    espExitDoorsEnabled = false,
    espItemsEnabled = false,
    instantInteractEnabled = false,
    fpsBoosterEnabled = false,

    themeName = "Sapphire"
}

local _c = {}
local _s = {}
local _n = {
    lastRelaxTime = 0,
    lastPressTime = 0
}









local _j = nil
local _t = 0

local function getCurrentGame()
    if tick() - _t < 0.5 then
        return _j
    end
    _t = tick()
    local _h = _m:FindFirstChild("Values")
    local _p = _h and _h:FindFirstChild("CurrentGame")
    local _e = _p and _p.Value
    if _e ~= nil and tostring(_e) ~= "" then
        _j = tostring(_e)
    else
        _j = nil
    end
    return _j
end

local function normalizeGameName(name)
    if type(name) ~= _d4vqqe({11,12,50,61,77,17},{120,120,64,84,35,118}) then return "" end
    return string.lower((string.gsub(name, _d4vqqe({104,12,16,16,104},{51,82,53,103,53,51}), "")))
end

local function isCurrentGame(_wj)
    return getCurrentGame() == _wj
end

local function isCurrentGameNormalized(_fa)
    return normalizeGameName(getCurrentGame()) == _fa
end

local _wk = nil
local _mx = 0

local function findHideAndSeekMap(_sf)
    local _ni = tick()
    if not _sf and (_ni - _mx) < 0.5 then
        if _wk ~= nil then
            if _wk.Parent then
                return _wk
            end
            _wk = nil
        else
            return nil
        end
    end
    _mx = _ni
    local _aa = _m:FindFirstChild("HideAndSeekMap")
    if _aa then
        _wk = _aa
        return _aa
    end
    for _nf, _il in ipairs(_m:GetChildren()) do
        if _il:IsA("Model") or _il:IsA("Folder") then
            local _ay = normalizeGameName(_il.Name)
            if string.find(_ay, "hideandseek", 1, true) then
                _wk = _il
                return _il
            end
        end
    end
    _wk = nil
    return nil
end

local function getHideAndSeekEvidence(_sf)
    local _lv = getCurrentGame()
    local _tx = findHideAndSeekMap(_sf)
    local _hq = (normalizeGameName(_lv) == "hideandseek") or (_tx ~= nil)
    return _hq, _lv, _tx
end

local function logHideAndSeekDiagnostic(_yn)
    local _hq, _lv, _tx = getHideAndSeekEvidence(true)
    local _ty = _lv and tostring(_lv) or _d4vqqe({52,61,67},{90,84,47,118})
    local _vq = _tx and _tx.Name or _d4vqqe({53,68,90,34},{91,43,52,71,104,106,86})
    if _hq then
        notify(_yn, "Gate ACTIVE (CurrentGame=" .. _ty .. ", Map=" .. _vq .. ")", 4)
    else
        notify(_yn, "Waiting for Hide & Seek (CurrentGame=" .. _ty .. ", Map=" .. _vq .. ")", 4)
    end
end







local _xe = 16
local _ao = false

local function setPlayerFrozen(_xh)
    local _bn = _o.Character
    local hum = _bn and _bn:FindFirstChildOfClass("Humanoid")
    local hrp = _bn and _bn:FindFirstChild("HumanoidRootPart")

    if _xh then
        if hum then
            if hum.WalkSpeed > 0 then _xe = hum.WalkSpeed end
            hum.WalkSpeed = 0
            hum.JumpPower = 0
            if hum.JumpHeight > 0 then hum.JumpHeight = 0 end
        end
        if hrp then
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
            hrp.Velocity = Vector3.zero
            hrp.RotVelocity = Vector3.zero
        end
        pcall(function()
            local _uq = _o:FindFirstChild(_d4vqqe({126,71,12,84,53,92,120,77,89,4,93,36,93},{46,43,109,45,80,46,43}))
            local _nu = _uq and _uq:FindFirstChild(_d4vqqe({0,87,39,30,49,62,100,52,52,78,42,2},{80,59,70,103,84,76,41,91}))
            if _nu then
                local _me = require(_nu):GetControls()
                if _me and not _ao then
                    _me:Disable()
                    _ao = true
                end
            end
        end)
    else
        if hum then
            hum.WalkSpeed = _xe or 16
            hum.JumpPower = 50
            hum.JumpHeight = 7.2
        end
        pcall(function()
            local _uq = _o:FindFirstChild("PlayerScripts")
            local _nu = _uq and _uq:FindFirstChild("PlayerModule")
            if _nu then
                local _me = require(_nu):GetControls()
                if _me and _ao then
                    _me:Enable()
                    _ao = false
                end
            end
        end)
    end
end


local _jk = nil
local _uc = nil
local _lw = nil

local function getGuiThemeAccent()
    if _xf and typeof(_xf.GetActiveTheme) == _d4vqqe({43,84,76,58,95,36,78,76},{77,33,34,89,43}) then
        local _dk = _xf:GetActiveTheme()
        if _dk and _dk.Accent then return _dk.Accent end
    end
    if _v and _v.Themes and typeof(_v.Themes.Get) == _d4vqqe({67,55,59,32,70,76,45,59},{37,66,85,67,50}) then
        local _dk = _v.Themes:Get(_f.themeName or "Sapphire")
        if _dk and _dk.Accent then return _dk.Accent end
    end
    return Color3.fromRGB(0, 160, 255)
end

local function initFovCircle()
    local _mc = getGuiThemeAccent()

    
    
    if not _uc then
        local _cq = (typeof(gethui) == "function" and gethui()) or game:GetService("CoreGui")
        local _qn = Instance.new("ScreenGui")
        _qn.Name = _g:GenerateGUID(false):gsub("-", "")
        _qn.ResetOnSpawn = false
        _qn.IgnoreGuiInset = true 
        _qn.DisplayOrder = 1000000000 
        _qn.Parent = _cq

        local _cc = Instance.new("Frame")
        _cc.Name = _d4vqqe({60,101,2,10,19,88,55,37,31},{122,42,84,73})
        _cc.AnchorPoint = Vector2.new(0.5, 0.5)
        _cc.BackgroundTransparency = 1
        _cc.Size = UDim2.new(0, _f.aimbotFovRadius or 150, 0, _f.aimbotFovRadius or 150)
        _cc.Position = UDim2.new(0.5, 0, 0.5, 0) 
        _cc.Visible = _f.showFovEnabled == true
        _cc.Parent = _qn

        local _tc = Instance.new("UICorner")
        _tc.CornerRadius = UDim.new(1, 0)
        _tc.Parent = _cc

        _lw = Instance.new("UIStroke")
        _lw.Thickness = 1.5
        _lw.Color = _mc
        _lw.Transparency = 0.05
        _lw.Parent = _cc

        _uc = _cc
    end

    
    if typeof(Drawing) == _d4vqqe({47,58,51,67,18},{91,91,81,47,119,74,91}) and typeof(Drawing.new) == _d4vqqe({84,29,68,21,70,1,69,24},{50,104,42,118}) and not _jk then
        pcall(function()
            _jk = Drawing.new("Circle")
            _jk.Thickness = 1.5
            _jk.NumSides = 64
            _jk.Filled = false
            _jk.Transparency = 1
            _jk.Color = _mc
            _jk.Visible = _f.showFovEnabled == true
        end)
    end
end



local function updateFovCircleColor(color)
    color = color or getGuiThemeAccent()
    if _jk then
        pcall(function() _jk.Color = color end)
    end
    if _lw then
        _lw.Color = color
    end
end


_x.RenderStepped:Connect(function()
    local _xg = _f.showFovEnabled == true
    if _xg and not _uc then
        initFovCircle()
    end

    local _qj = _f.aimbotFovRadius or 150
    local _jv = _m.CurrentCamera or _q

    if _uc then
        _uc.Visible = _xg
        if _xg then
            _uc.Size = UDim2.new(0, _qj, 0, _qj)
            _uc.Position = UDim2.new(0.5, 0, 0.5, 0)
            if _lw then
                _lw.Color = getGuiThemeAccent()
            end
        end
    end

    if _jk then
        pcall(function()
            _jk.Visible = _xg
            if _xg and _jv then
                _jk.Position = _jv.ViewportSize / 2
                _jk.Radius = _qj / 2
                _jk.Color = getGuiThemeAccent()
            end
        end)
    end
end)


local function isPlayerHunter(player)
    if not player then return false end
    if player:GetAttribute("IsHunter") == true then return true end
    if player.Team and string.find(string.lower(player.Team.Name), "hunter") then return true end
    local _ps = player.Character
    if _ps then
        if _ps:GetAttribute("IsHunter") == true or _ps:FindFirstChild("IsHunter") ~= nil then return true end
        if _ps:FindFirstChild("Bat") or _ps:FindFirstChild("Baton") or _ps:FindFirstChild("Crowbar") then return true end
    end
    return false
end

local function isPlayerGuard(player)
    if not player then return false end
    if player:GetAttribute("IsGuard") == true then return true end
    if player.Team and string.find(string.lower(player.Team.Name), "guard") then return true end
    local _ps = player.Character
    if _ps then
        if _ps:FindFirstChild("TypeOfGuard") ~= nil or _ps:GetAttribute("TypeOfGuard") ~= nil then return true end
        if _ps:FindFirstChild("GuardCanKillLockOn") ~= nil or _ps:FindFirstChild("PlayerCanKill") ~= nil then return true end
        if string.find(string.lower(_ps.Name), "guard") then return true end
        if _ps:FindFirstChild("Gun") or _ps:FindFirstChild("Revolver") or _ps:FindFirstChild("SubmachineGun") then return true end
    end
    return false
end

local function isValidAimbotTarget(_qp, _ka)
    if not _qp or _qp == _ka then return false end
    local _fz = _qp.Character
    if not _fz then return false end

    
    local _tz = _fz:FindFirstChild("HumanoidRootPart")
    local _eo = _fz:FindFirstChildOfClass("Humanoid")
    if not _tz or not _eo or _eo.Health <= 0 then return false end

    
    if _fz:FindFirstChildOfClass("ForceField") then return false end

    
    if _ka.Team and _qp.Team and _ka.Team == _qp.Team then
        return false
    end

    return true
end

local function getAimCenter()
    local _jv = _m.CurrentCamera or _q
    if not _jv then return Vector2.zero end
    
    return _jv.ViewportSize / 2
end

local _ph = nil

local function clearLockedHighlight()
    if _ph then
        pcall(function()
            _ph.Adornee = nil
            _ph:Destroy()
        end)
        _ph = nil
    end
end

local function updateLockedHighlight(_qx)
    if not _qx then
        clearLockedHighlight()
        return
    end
    if not _ph or not _ph.Parent then
        _ph = Instance.new("Highlight")
        local _yg, guidStr = pcall(function() return _g:GenerateGUID(false) end)
        _ph.Name = (_yg and guidStr) or _d4vqqe({16,90,1,77,90,45,12,82,20,66,83,48,35,83,7},{68,59,115,42,63,89})
        _ph.FillColor = Color3.fromRGB(46, 204, 113) 
        _ph.OutlineColor = Color3.fromRGB(255, 255, 255)
        _ph.FillTransparency = 0.45
        _ph.OutlineTransparency = 0.1
        _ph.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

        local _cq = (typeof(gethui) == "function" and gethui()) or game:GetService("CoreGui")
        _ph.Parent = _cq
    end
    _ph.Adornee = _qx
    _ph.Enabled = true
end

local function getSmartAimbotTarget(_yj)
    local _nn = _yj or _f.aimbotFovRadius or 150
    local _cw = _nn / 2
    local _jv = _m.CurrentCamera or _q
    local _ps = _o.Character
    local hrp = _ps and _ps:FindFirstChild("HumanoidRootPart")
    if not _jv or not hrp then
        clearLockedHighlight()
        return nil, nil
    end

    local _qv = hrp.Position
    local _ww = getAimCenter()

    
    if _f.aimbotTargetLock and _f.lockedTargetPlayer then
        local _qp = _f.lockedTargetPlayer
        if _qp and _qp.Parent and _qp:IsDescendantOf(_z) and isValidAimbotTarget(_qp, _o) and _qp.Character then
            local _fz = _qp.Character
            local _tz = _fz:FindFirstChild("HumanoidRootPart")
            if _tz then
                local _am = _tz
                if _f.aimbotTargetPart == _d4vqqe({19,34,90,22},{91,71,59,114,79,63}) then
                    _am = _fz:FindFirstChild("Head") or _tz
                end
                updateLockedHighlight(_fz)
                return _qp, _am
            end
        end
        
        _f.lockedTargetPlayer = nil
        clearLockedHighlight()
    end

    
    local _xr = nil
    local _bm = nil
    local _fr = math.huge

    for _nf, _qp in ipairs(_z:GetPlayers()) do
        if isValidAimbotTarget(_qp, _o) then
            local _fz = _qp.Character
            local _tz = _fz:FindFirstChild("HumanoidRootPart")
            local _am = _tz
            if _f.aimbotTargetPart == _d4vqqe({10,38,78,65},{66,67,47,37,36,74}) then
                _am = _fz:FindFirstChild("Head") or _tz
            end

            if _am then
                local _gv, onScreen = _jv:WorldToViewportPoint(_am.Position)
                if onScreen and _gv.Z > 0 then
                    local _al = (Vector2.new(_gv.X, _gv.Y) - _ww).Magnitude
                    if _al <= _cw then
                        local _th = (_am.Position - _qv).Magnitude
                        if _th < _fr then
                            _fr = _th
                            _xr = _qp
                            _bm = _am
                        end
                    end
                end
            end
        end
    end

    if _f.aimbotTargetLock then
        if _xr and _xr.Character then
            _f.lockedTargetPlayer = _xr
            updateLockedHighlight(_xr.Character)
        else
            _f.lockedTargetPlayer = nil
            clearLockedHighlight()
        end
    else
        clearLockedHighlight()
    end

    return _xr, _bm
end




local _cr = _g:GenerateGUID(false)

local _xf = _v:CreateWindow({
    Title = "Syntaxis",
    GuiName = _cr,
    Theme = _f.themeName,
    _f = _f,
    Size = UDim2.new(0, 520, 0, 360)
})




local _ui = _xf:CreateTab("Games", "Gamepad")




local _lu = _ui:CreateCategory("Red Light Green Light", true, 1)

local function isPlayerInRLGLSafeZone()
    local _ps = _o.Character
    local hrp = _ps and _ps:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    local _vx = hrp.Position.Z
    return (_vx >= 135) or (_vx <= -535)
end

local function cleanseCharacterInjuries()
    local _ps = _o.Character
    if not _ps then return end
    local hum = _ps:FindFirstChildOfClass("Humanoid")
    local hrp = _ps:FindFirstChild("HumanoidRootPart")
    if not (hum and hrp) then return end

    local _he = _ps:FindFirstChild("Torso") or _ps:FindFirstChild("UpperTorso")
    hum.PlatformStand = false
    hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

    for _nf, _sx in ipairs({
        Enum.HumanoidStateType.FallingDown,
        Enum.HumanoidStateType.Seated,
        Enum.HumanoidStateType.Swimming,
        Enum.HumanoidStateType.Flying,
        Enum.HumanoidStateType.StrafingNoPhysics,
        Enum.HumanoidStateType.Ragdoll
    }) do
        hum:SetStateEnabled(_sx, false)
    end

    
    for _nf, _il in ipairs(hrp:GetChildren()) do
        if _il:IsA("BallSocketConstraint") or string.match(_il.Name, "^CacheAttachment") then
            pcall(function() _il:Destroy() end)
        end
    end

    
    if _he then
        for _nf, jointName in ipairs({ "Left Hip", "Left Shoulder", "Neck", "Right Hip", "Right Shoulder", "RootJoint" }) do
            local _bp = _he:FindFirstChild(jointName) or hrp:FindFirstChild(jointName)
            if _bp and _bp:IsA("Motor6D") and not _bp.Part0 then
                _bp.Part0 = _he
            end
        end
    end

    
    for _nf, _is in ipairs(_ps:GetChildren()) do
        if _is:IsA("BasePart") then
            local _an = _is:FindFirstChild("BoneCustom")
            if _an then pcall(function() _an:Destroy() end) end
        end
    end

    
    for _nf, tag in ipairs({ "Ragdoll", "LocalRagdoll", "Stun", "RotateDisabled", "RagdollWakeupImmunity", "Injured", "Crawling" }) do
        local inst = _ps:FindFirstChild(tag)
        if inst then pcall(function() inst:Destroy() end) end
    end

    
    local _yq = _m:FindFirstChild("Effects")
    local _er = _yq and _yq:FindFirstChild("LocalRagdolls")
    local _up = _er and _er:FindFirstChild(_o.Name)
    if _up then pcall(function() _up:Destroy() end) end

    
    if _ps:GetAttribute("Injured") ~= nil then _ps:SetAttribute("Injured", false) end
    if _ps:GetAttribute("Downed") ~= nil then _ps:SetAttribute("Downed", false) end
    if _ps:GetAttribute("Crawling") ~= nil then _ps:SetAttribute("Crawling", false) end

    notify("RLGL", "Injury cleansed & joints restored.")
end

_lu:CreateButton("Remove Injury", "Restore standing humanoid state & joints", "Cleanse", function()
    cleanseCharacterInjuries()
end)

local _sc = nil

local function purgeCrawling(_ps)
    if not _ps then return end
    local _es = _ps:FindFirstChild("Crawling")
    if _es then
        pcall(function() _es:Destroy() end)
    end
    if _ps:GetAttribute("Crawling") then
        _ps:SetAttribute("Crawling", false)
    end
    if _ps:GetAttribute("Downed") then
        _ps:SetAttribute("Downed", false)
    end
    local hum = _ps:FindFirstChildOfClass("Humanoid")
    if hum then
        if hum.PlatformStand then hum.PlatformStand = false end
        local _sx = hum:GetState()
        if _sx == Enum.HumanoidStateType.FallingDown or _sx == Enum.HumanoidStateType.Ragdoll or _sx == Enum.HumanoidStateType.Seated then
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)

        
        local _qk = hum:FindFirstChildOfClass("Animator")
        if _qk then
            for _nf, _ne in ipairs(_qk:GetPlayingAnimationTracks()) do
                local _su = string.lower(_ne.Name or "")
                if string.find(_su, "crawl") or string.find(_su, "downed") then
                    _ne:Stop()
                end
            end
        end
    end
end

local function hookAntiCrawl(_ps)
    if _sc then
        _sc:Disconnect()
        _sc = nil
    end
    if not _ps then return end
    _sc = _ps.ChildAdded:Connect(function(_il)
        if _f.antiCrawlEnabled and _il.Name == "Crawling" then
            task.defer(function() pcall(function() _il:Destroy() end) end)
        end
    end)
end

_lu:CreateToggle("Anti Crawl", "Prevents falling into downed / crawling state", false, function(enabled)
    _f.antiCrawlEnabled = enabled
    if enabled then
        purgeCrawling(_o.Character)
        hookAntiCrawl(_o.Character)

        if not _c.antiCrawlCharAdded then
            _c.antiCrawlCharAdded = _o.CharacterAdded:Connect(function(_qu)
                if _f.antiCrawlEnabled then
                    task.wait(0.2)
                    purgeCrawling(_qu)
                    hookAntiCrawl(_qu)
                end
            end)
        end

        _s.antiCrawlLoop = task.spawn(function()
            while _f.antiCrawlEnabled do
                purgeCrawling(_o.Character)
                task.wait(0.2)
            end
        end)
        notify("RLGL", "Anti Crawl engaged.")
    else
        if _sc then
            _sc:Disconnect()
            _sc = nil
        end
        _s.antiCrawlLoop = nil
        notify("RLGL", "Anti Crawl disengaged.")
    end
end)

_lu:CreateToggle("Freeze On Red Light", "Stops character movement on red light (No anchoring)", false, function(enabled)
    _f.freezeOnRedLightEnabled = enabled
    if enabled then
        if _s.freezeThread then return end
        _s.freezeThread = true
        task.spawn(function()
            local _hz = false
            local _wr = "rbxassetid://88400194373338"

            while _f.freezeOnRedLightEnabled and _s.freezeThread do
                if isCurrentGame(_d4vqqe({98,31,70,107,91,15,7,66,119,8,71,66,92,36,6,81,88,14},{48,122,34,39,50,104,111,54})) then
                    local _tf = _o:FindFirstChild(_d4vqqe({43,49,63,14,30,47,25,2,18},{123,93,94,119}))
                    local _pi = _tf and _tf:FindFirstChild(_d4vqqe({25,54,5,68,23,88,116,21,49,54,16,86},{80,91,117,37,116,44,50,103}))
                    local _uy = _pi and _pi:FindFirstChild(_d4vqqe({30,91,54,8,20,42,94,31,35,78,63,26,55,46,77,39,51},{74,41,87,110,114,67,61,83}))
                    local _yi = (_uy and _uy.Image == _wr)

                    if _yi and not isPlayerInRLGLSafeZone() then
                        if not _hz then
                            setPlayerFrozen(true)
                            _hz = true
                        end
                    elseif _hz then
                        setPlayerFrozen(false)
                        _hz = false
                    end
                elseif _hz then
                    setPlayerFrozen(false)
                    _hz = false
                end
                task.wait(0.1)
            end
            if _hz then setPlayerFrozen(false) end
            _s.freezeThread = nil
        end)
    else
        _s.freezeThread = nil
        setPlayerFrozen(false)
    end
end)




local _ku = _ui:CreateCategory("Dalgona", false, 2)

local _nr = 0
local _xa = setmetatable({}, { __mode = "k" })
local _sv = setmetatable({}, { __mode = "k" })

_ku:CreateToggle("Anti-Crack Dalgona", "Neutralizes breakage failure functions and clamps crack progress", false, function(enabled)
    _f.antiCrackDalgonaEnabled = enabled
    _nr += 1
    local _ak = _nr
    table.clear(_xa)
    table.clear(_sv)

    if _s.dalgonaCrackLoop then
        pcall(task.cancel, _s.dalgonaCrackLoop)
        _s.dalgonaCrackLoop = nil
    end

    if enabled then
        _s.dalgonaCrackLoop = task.spawn(function()
            local _jo = debug and (debug.getupvalues or debug.get_upvalues) or getupvalues
            local _cm = debug and (debug.setupvalue or debug.setup_value) or setupvalue
            local _az = debug and (debug.getconstants or debug.get_constants) or getconstants
            local _at = function() end
            local _ez = 0

            while _f.antiCrackDalgonaEnabled and _ak == _nr do
                local _gm = _o:FindFirstChild(_d4vqqe({56,18,70,11,13,12,96,7,1},{104,126,39,114}))
                local _yx = _gm and _gm:FindFirstChild(_d4vqqe({44,79,27,27,30,7,55,61,103},{104,46,119,124,113,105,86}))
                local _lo = isCurrentGameNormalized(_d4vqqe({59,40,75,65,77,5,62},{95,73,39,38,34,107})) or (_yx ~= nil and _yx:IsA(_d4vqqe({8,51,59,3,30,53,23,60,15},{91,80,73,102,123})) and _yx.Enabled == true)

                if _lo then
                    
                    local _ni = tick()
                    if (_ni - _ez) >= 0.5 then
                        _ez = _ni
                        pcall(function()
                            local _ro = nil
                            if typeof(filtergc) == _d4vqqe({88,87,83,36,51,54,77,37},{62,34,61,71,71,95,34,75}) then
                                pcall(function() _ro = filtergc(_d4vqqe({2,0,90,26,16,28,91,23},{100,117,52,121}), {}, false) end)
                            end
                            if not _ro and typeof(getgc) == _d4vqqe({2,72,49,73,36,70,4,10},{100,61,95,42,80,47,107}) then
                                pcall(function() _ro = getgc() end)
                            end

                            if type(_ro) == _d4vqqe({94,80,16,27,79},{42,49,114,119}) and _az then
                                for _nf, fn in ipairs(_ro) do
                                    if type(fn) == _d4vqqe({26,18,85,86,65,83,13,1},{124,103,59,53,53,58,98,111}) and not _xa[fn] and not _sv[fn] then
                                        _xa[fn] = true
                                        local _kj, consts = pcall(_az, fn)
                                        if _kj and type(consts) == _d4vqqe({51,56,3,57,34},{71,89,97,85}) then
                                            if table.find(consts, _d4vqqe({86,81,78,14,94,88,67,77,66,79,72,3,82,29,78,3,21,89,70,1,82,82,73,12,21},{53,61,39,109})) and _jo and _cm then
                                                _sv[fn] = true
                                                local _dl, upvals = pcall(_jo, fn)
                                                if _dl and type(upvals) == _d4vqqe({40,62,17,40,7},{92,95,115,68,98,41,120}) then
                                                    for _kr, uv in pairs(upvals) do
                                                        if type(uv) == _d4vqqe({58,63,53,85,35,72,51,36},{92,74,91,54,87,33}) then
                                                            local _fo, uvConsts = pcall(_az, uv)
                                                            if _fo and type(uvConsts) == _d4vqqe({64,91,2,74,48},{52,58,96,38,85}) then
                                                                for _nf, _kq in pairs(uvConsts) do
                                                                    if _kq == _d4vqqe({59,34,31,40,38,119,8,47,13,62,10},{120,80,126,75,77,54,101,64}) or _kq == _d4vqqe({45,13,6,24,59,40,10,11,23,41,14,28},{107,120,106,116,66}) or _kq == _d4vqqe({48,87,1,5,42,89,52,10,83,27,12,38,80,20,23},{99,52,115,96,79,55,124}) or _kq == _d4vqqe({87,86,27,27,66,50,28,19,69,18,11,66,46,22,19,81,22,21,65,57,25,19,84,5,29,78,55},{51,55,119,124,45,92,125}) then
                                                                        pcall(_cm, fn, _kr, _at)
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end)
                    end

                    
                    pcall(function()
                        if _yx then
                            local _hc = _yx:FindFirstChild(_d4vqqe({3,28,93,37,76,20,31,47,9},{65,110,56,68,56,124,118}))
                            local _qb = _hc and _hc:FindFirstChild(_d4vqqe({122,68,24,91,17,23,75,89,30,74,31,52,74,116,24,74},{57,54,121,56,122,71}))
                            if _qb and _qb:FindFirstChild(_d4vqqe({116,65,53,87,89,92},{60,46,89,51})) and _qb.Holder:FindFirstChild(_d4vqqe({117,56,47,28},{51,81,67,112,115,122,105,94})) then
                                _qb.Holder.Fill.Size = UDim2.new(0, 0, 1, 0)
                            end
                        end
                    end)
                end
                task.wait(0.2)
            end
            if _s.dalgonaCrackLoop and coroutine.running() == _s.dalgonaCrackLoop then
                _s.dalgonaCrackLoop = nil
            end
        end)
        notify("Dalgona", "Anti-Crack active.", 3)
    else
        notify("Dalgona", "Anti-Crack disabled.")
    end
end)

_ku:CreateToggle("Free Lighter", "Enables heater lighter attribute natively", false, function(enabled)
    if enabled then
        _o:SetAttribute("HasLighter", true)
        notify("Dalgona", "Free Lighter enabled.")
    else
        _o:SetAttribute("HasLighter", nil)
        notify("Dalgona", "Free Lighter disabled.")
    end
end)







local _rd = _ui:CreateCategory("Pentathlon", false, 3)

local _wg = nil

task.spawn(function()
    pcall(function()
        local _ov = _r:WaitForChild(_d4vqqe({45,20,23,93,87,84,85},{96,123,115,40,59,49,38,121}), 5)
        local _db = _ov and _ov:WaitForChild(_d4vqqe({14,23,44,12,79},{73,118,65,105,60}), 5)
        local _zy = _db and _db:WaitForChild(_d4vqqe({31,15,58,87,42,59,6,35,5,58,96,39,38,11,33,30},{79,106,84,35,75,79,110}), 5)
        if _zy then
            local _po = require(_zy)
            if type(_po) == "table" then
                local _hp = _po.RunServerGame
                if _hp then
                    _po.RunServerGame = function(_mg, _nz, ...)
                        if _mg and _mg.GUID then _wg = _mg.GUID end
                        return _hp(_mg, _nz, ...)
                    end
                end
                local _of = _po.AddActiveGame
                if _of then
                    _po.AddActiveGame = function(_mg)
                        if _mg and _mg.GUID then _wg = _mg.GUID end
                        return _of(_mg)
                    end
                end
            end
        end
    end)
end)

local function firePentathlonRemote(_bk, _sg)
    local _ss = _r:FindFirstChild("Remotes")
    local _yc = _ss and _ss:FindFirstChild("PentathlonRemote") or _r:FindFirstChild("PentathlonRemote", true)
    if not _yc then return false end

    if _wg then
        if _sg then
            _yc:FireServer(_wg, _bk, _sg)
        else
            _yc:FireServer(_wg, _bk)
        end
        return true
    end

    if _sg then
        _yc:FireServer(_bk, _sg)
    else
        _yc:FireServer(_bk)
    end
    return true
end

_rd:CreateSlider("Ddakji Throw Strength", "Sets power percentage for Ddakji throws", 10, 100, 100, 1, function(_rj)
    _f.ddakjiThrowStrength = _rj
end)

_rd:CreateButton("Auto Complete Ddakji", "Raycasts map & sends throw with chosen strength", "Execute", function()
    local _jv = _m.CurrentCamera or _q
    local _bv = _jv.CFrame.Position + _jv.CFrame.LookVector * 10
    local _xb = _jv:ViewportPointToRay(_jv.ViewportSize.X * 0.5, _jv.ViewportSize.Y * 0.5)
    local _pg = RaycastParams.new()
    _pg.FilterType = Enum.RaycastFilterType.Include
    local _cj = _m:FindFirstChild("PentathlonMap")
    _pg.FilterDescendantsInstances = _cj and { _cj } or {}
    local _gi = _m:Raycast(_xb.Origin, _xb.Direction * 500, _pg)
    if _gi and _gi.Position then _bv = _gi.Position end

    local _dz = (_f.ddakjiThrowStrength or 100) / 100
    local _dp = firePentathlonRemote("Thrown", { Power = _dz, Position = _bv })
    notify("Pentathlon", _dp and ("Ddakji strike dispatched at " .. math.floor(_dz * 100) .. "% power!") or "Wait for Pentathlon round to start.", 3)
end)

_rd:CreateButton("Auto Complete Flying Stone", "Calculates target vector and sends perfect trajectory", "Execute", function()
    local _ps = _o.Character
    local hrp = _ps and _ps:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local _li = nil
    for _nf, _ve in ipairs(_m:GetDescendants()) do
        if _ve.Name == "Target" and _ve:IsA("BasePart") then
            _li = _ve
            break
        end
    end

    local _qm = _li and CFrame.lookAt(hrp.Position, _li.Position).LookVector or Vector3.new(0, 0, 1)
    local _wh = hrp.Position + Vector3.new(0, 1.5, 0)

    local _dp = firePentathlonRemote("Thrown", { Direction = _qm, ThrowPower = "Perfect", Origin = _wh })
    notify("Pentathlon", _dp and "Flying Stone completed!" or "Wait for Pentathlon round to start.", 3)
end)

_rd:CreateButton("Auto Gonggi", "Batch collects all 25 Gonggi pieces and completes game", "Spam", function()
    task.spawn(function()
        local _pp = {
            "YTriangle", "RCircle", "Square", "GTriangle", "BCircle",
            "BSquare", "BTriangle", "BStar", "BUmbrella", "YCircle",
            "YSquare", "YStar", "YUmbrella", "RTriangle", "RSquare",
            "RStar", "RUmbrella", "GCircle", "GSquare", "GStar",
            "GUmbrella", "Triangle", "Circle", "Star", "Umbrella"
        }

        firePentathlonRemote("Thrown", {})
        task.wait(0.05)

        for _nf, piece in ipairs(_pp) do
            firePentathlonRemote("GotPiece", { Name = piece })
        end

        task.wait(0.05)
        firePentathlonRemote("Catch", {})
        firePentathlonRemote("Caught", {})
        firePentathlonRemote("TimeSlowFinish", {})
        notify("Pentathlon", "Gonggi 25-piece sequence completed!", 3)
    end)
end)

_rd:CreateButton("Auto Spinning Top", "Ties and launches spinning top with max RPM", "Execute", function()
    task.spawn(function()
        firePentathlonRemote("Tied", {})
        task.wait(0.02)
        local _dp = firePentathlonRemote("Thrown", {})
        notify("Pentathlon", _dp and "Spinning Top launched!" or "Wait for Pentathlon round to start.", 3)
    end)
end)

_rd:CreateButton("Auto Complete Jegi", "Dispatches consecutive perfect kicks without dropping", "Execute", function()
    task.spawn(function()
        for _gr = 1, 6 do
            firePentathlonRemote("Kick", { Lose = false })
            task.wait(0.02)
        end
        notify("Pentathlon", "Jegi 6-kick combo completed!", 3)
    end)
end)




local _rf = _ui:CreateCategory("Tug Of War", false, 4)

local function calcAngularDist(_sa, _di)
    return math.abs((_sa - _di + 180) % 360 - 180)
end

local function triggerTugPull(_ud)
    if _ud then
        local _bz = _ud:FindFirstChild("TextButton") or _ud:FindFirstChildWhichIsA("TextButton")
        if _bz and typeof(firesignal) == _d4vqqe({18,95,57,87,0,67,56,90},{116,42,87,52}) then
            pcall(firesignal, _bz.MouseButton1Click)
            pcall(firesignal, _bz.Activated)
        end
    end
    pcall(function()
        local _ss = _r:FindFirstChild("Remotes")
        local _ya = _ss and (_ss:FindFirstChild("TugPull") or _ss:FindFirstChild("PullRope")) or _r:FindFirstChild("PullRope", true)
        if _ya and _ya:IsA("RemoteEvent") then
            _ya:FireServer()
        end
    end)
end

local _jc = nil
local _jz = 0

local function checkAndRunTOW()
    if not (_f.autoPullEnabled or _f.antiMissEnabled) then
        if _jc then
            _jc:Disconnect()
            _jc = nil
        end
        return
    end

    local _tf = _o:FindFirstChildOfClass("PlayerGui")
    if not _tf then return end

    local _yd = _tf:FindFirstChild("TugOfWarUIV2") or _tf:FindFirstChild("TugOfWarUI")
    local _zv = _yd and (_yd:FindFirstChild("TugofWarRemake") or _yd)
    local _ud = _zv and _zv:FindFirstChild("CircleBase")

    if not _ud or not _ud.Visible then return end

    local _vj = _ud:FindFirstChild("Arrow")
    local _eg = _ud:FindFirstChild("Medium") or _ud:FindFirstChild("Small") or _ud:FindFirstChild("Large")

    if not _vj or not _eg then return end

    local _hy = _vj.Rotation % 360
    local _rq = calcAngularDist(_eg.Rotation % 360, _hy) <= 18.2

    if _f.antiMissEnabled then
        _eg.Rotation = _hy
        _rq = true
    end

    if _f.autoPullEnabled then
        local _ni = tick()
        if _f.antiMissEnabled then
            if _ni - _jz > 0.25 then
                triggerTugPull(_ud)
                _jz = _ni
            end
        elseif _rq and (_ni - _jz > 0.12) then
            triggerTugPull(_ud)
            _jz = _ni
        end
    end
end

local function startTOWThread()
    if not _jc then
        _jc = _x.RenderStepped:Connect(function()
            if _f.autoPullEnabled or _f.antiMissEnabled then
                checkAndRunTOW()
            else
                if _jc then
                    _jc:Disconnect()
                    _jc = nil
                end
            end
        end)
        table.insert(_c, _jc)
    end
end

_rf:CreateToggle("Auto Pull", "Pulls rope at optimal game rhythm without clicking", false, function(enabled)
    _f.autoPullEnabled = enabled
    if enabled then
        startTOWThread()
        notify("Tug Of War", "Auto Pull active.", 2)
    end
end)

_rf:CreateToggle("Anti Miss", "Aligns QTE needle directly with success zone for guaranteed hits", false, function(enabled)
    _f.antiMissEnabled = enabled
    if enabled then
        startTOWThread()
        notify("Tug Of War", "Anti Miss locked to sweet spot.", 2)
    end
end)




local _cn = _ui:CreateCategory("Glass Bridge", false, 5)

local _cv = {}
local _km = {}
local _pm = {}
local _wn = nil

local function getGlassType(_is)
    if not _is or not _is:IsA("BasePart") then return nil end
    local _ws = _is:GetAttribute("GlassPart") ~= nil 
        or string.find(string.lower(_is.Name), "glass") ~= nil 
        or (_is.Parent and _is.Parent:IsA("Model") and string.find(string.lower(_is.Parent.Name), "glass"))
        or _is.Material == Enum.Material.Glass
    if not _ws then return nil end

    local _fe = _is:GetAttribute("ActuallyKilling") ~= nil or (_is.Parent and _is.Parent:GetAttribute("ActuallyKilling") ~= nil)
    local _dj = _is:GetAttribute("DelayedBreaking") ~= nil or (_is.Parent and _is.Parent:GetAttribute("DelayedBreaking") ~= nil)
    local _vv = _is:GetAttribute("exploitingisevil") == true or (_is.Parent and _is.Parent:GetAttribute("exploitingisevil") == true)
    local _qi = _is:GetAttribute("Breakable") == true or (_is.Parent and _is.Parent:GetAttribute("Breakable") == true)

    if (_fe and _dj) or _dj then
        return _d4vqqe({85,48,0,20,72,48,8},{49,85,108,117})
    end
    if _fe or _vv or _qi then
        return _d4vqqe({58,71,72,6},{92,38,35,99,53})
    end
    return _d4vqqe({65,7,43,22},{51,98,74,122,53,41})
end

local function cleanGlassESP()
    for _nf, hl in pairs(_cv) do
        if hl and hl.Parent then pcall(function() hl:Destroy() end) end
    end
    table.clear(_cv)

    
    for _is, orig in pairs(_km) do
        if _is and _is.Parent then
            pcall(function()
                _is.Color = orig.Color
                _is.Material = orig.Material
                _is.Transparency = orig.Transparency
            end)
        end
    end
    table.clear(_km)
end

local function updateGlassBridge()
    local _ab = _m:FindFirstChild("GlassBridge") or _m:FindFirstChild("GlassBridgeMap") or _m:FindFirstChild("GlassBridgeAnniversary")
    if not _ab then
        for _nf, _yv in ipairs(_m:GetChildren()) do
            if string.find(string.lower(_yv.Name), "glass") and string.find(string.lower(_yv.Name), "bridge") then
                _ab = _yv
                break
            end
        end
    end
    if not _ab then return end

    local _nt = _ab:FindFirstChild("GlassHolder") or _ab

    for _nf, _ve in ipairs(_nt:GetDescendants()) do
        if _ve:IsA("BasePart") then
            local _se = getGlassType(_ve)
            if _se then
                if _f.glassEspEnabled then
                    if not _km[_ve] then
                        _km[_ve] = { Color = _ve.Color, Material = _ve.Material, Transparency = _ve.Transparency }
                    end

                    local color = Color3.fromRGB(0, 255, 100) 
                    if _se == _d4vqqe({25,24,71,48,8,74,25},{125,125,43,81,113,47}) then
                        color = Color3.fromRGB(255, 190, 0) 
                    elseif _se == _d4vqqe({61,29,92,65},{91,124,55,36,124,124,116}) then
                        color = Color3.fromRGB(255, 40, 40) 
                    end

                    local hl = _cv[_ve]
                    if not hl or not hl.Parent then
                        hl = Instance.new("Highlight")
                        hl.Name = _d4vqqe({114,27,72,14,26,125,59},{53,119,41,125,105})
                        hl.Adornee = _ve
                        hl.FillColor = color
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.FillTransparency = 0.45
                        hl.OutlineTransparency = 0
                        hl.Parent = (typeof(gethui) == "function" and gethui()) or game:GetService("CoreGui")
                        _cv[_ve] = hl
                    else
                        hl.FillColor = color
                    end
                    pcall(function()
                        _ve.Material = Enum.Material.Neon
                        _ve.Color = color
                    end)
                end

                if _f.fakeSafeGlassEnabled then
                    if _se == _d4vqqe({80,52,51,46},{54,85,88,75}) or _se == _d4vqqe({22,16,34,17,11,16,42},{114,117,78,112}) then
                        for _nf, _il in ipairs(_ve:GetChildren()) do
                            if _il.ClassName == _d4vqqe({22,69,30,13,9,22,88,10,0,18,47,67,31,26,4,48},{66,42,107,110,97}) or _il.ClassName == _d4vqqe({24,52,22,90,36,18,13,77,41,41,6,74,56},{76,91,99,57}) then
                                pcall(function() _il:Destroy() end)
                            end
                        end
                        _ve.CanCollide = true

                        if not _pm[_ve] or not _pm[_ve].Parent then
                            local plat = Instance.new("Part")
                            plat.Name = _d4vqqe({123,4,43,64,98,62,72,31,91,53,33,68,81,52,70,30,69},{40,101,77,37,37,82,41,108})
                            plat.Size = Vector3.new(_ve.Size.X, 0.4, _ve.Size.Z)
                            plat.CFrame = _ve.CFrame * CFrame.new(0, 0.35, 0)
                            plat.Anchored = true
                            plat.CanCollide = true
                            plat.CanTouch = false
                            plat.Transparency = 0.65
                            plat.Color = Color3.fromRGB(50, 255, 120)
                            plat.Material = Enum.Material.SmoothPlastic
                            plat.Parent = _m
                            _pm[_ve] = plat
                        end
                    end
                end
            end
        end
    end
end




_cn:CreateToggle("Glass Bridge ESP", "Highlights safe glass green, delayed orange, and fake red", false, function(enabled)
    _f.glassEspEnabled = enabled
    if enabled then
        pcall(updateGlassBridge)
        if not _s.glassThread then
            _s.glassThread = task.spawn(function()
                while _f.glassEspEnabled or _f.fakeSafeGlassEnabled do
                    pcall(updateGlassBridge)
                    task.wait(0.75)
                end
                _s.glassThread = nil
            end)
        end
        notify("Glass Bridge", "Glass ESP active.", 2)
    else
        cleanGlassESP()
    end
end)

_cn:CreateToggle("Fake Safe Glass", "Removes kill touch triggers and spawns walkable platforms", false, function(enabled)
    _f.fakeSafeGlassEnabled = enabled
    if enabled then
        pcall(updateGlassBridge)
        if not _s.glassThread then
            _s.glassThread = task.spawn(function()
                while _f.glassEspEnabled or _f.fakeSafeGlassEnabled do
                    pcall(updateGlassBridge)
                    task.wait(0.75)
                end
                _s.glassThread = nil
            end)
        end
        notify("Glass Bridge", "Safe platforms spawned over breakable glass.", 3)
    else

        for _nf, _qp in pairs(_pm) do
            if _qp and _qp.Parent then _qp:Destroy() end
        end
        table.clear(_pm)
    end
end)



local _bq = _ui:CreateCategory("Hide & Seek", false, 6)


local function safePhysicsTeleport(_cf)
    local _ps = _o.Character
    if not _ps then return end
    local hrp = _ps:FindFirstChild("HumanoidRootPart")
    local hum = _ps:FindFirstChildOfClass("Humanoid")
    if not hrp then return end

    pcall(function()
        if hum then hum:ChangeState(Enum.HumanoidStateType.Physics) end
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        hrp.CanCollide = false
        hrp.Anchored = true
    end)
    _x.Heartbeat:Wait()
    pcall(function() _ps:PivotTo(_cf) end)
    _x.Heartbeat:Wait()
    pcall(function()
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        hrp.Anchored = false
        if hum then hum:ChangeState(Enum.HumanoidStateType.Running) end
    end)
end

local _ib = 3.0
local _vk = { lastPositive = 0 }
local _td = { lastPositive = 0 }
local _ol = { lastPositive = 0 }

local function isHideAndSeekActiveWithState(_rg)
    local _hq = getHideAndSeekEvidence()
    local _ni = tick()
    if _hq then
        _rg.lastPositive = _ni
        return true
    end
    return _rg.lastPositive > 0 and (_ni - _rg.lastPositive) < _ib
end

local function isHideAndSeekActive()
    return isHideAndSeekActiveWithState(_vk)
end


_bq:CreateToggle("Infinite Stamina", "Maintains sprint stamina safely inside Hide & Seek", false, function(enabled)
    _f.infiniteStaminaEnabled = enabled
    _td.lastPositive = 0
    if _s.staminaConn then
        pcall(function() _s.staminaConn:Disconnect() end)
        _s.staminaConn = nil
    end

    if enabled then
        logHideAndSeekDiagnostic("Infinite Stamina")
        _s.staminaConn = _x.RenderStepped:Connect(function()
            if not _f.infiniteStaminaEnabled or not isHideAndSeekActiveWithState(_td) then
                return
            end
            local _ps = _o.Character
            if not _ps then return end
            local _sp = _ps:FindFirstChild("StaminaVal") or _ps:FindFirstChild("Stamina")
            if _sp and (_sp:IsA(_d4vqqe({12,48,52,93,31,9,105,6,46,48,60},{66,69,89,63,122,123,63,103})) or _sp:IsA(_d4vqqe({124,33,78,114,84,35,79,65},{53,79,58,36}))) then
                if _sp.Value < 98 then
                    _sp.Value = 100
                end
            end
        end)
        notify("Hide & Seek", "Infinite Stamina enabled (Hide & Seek only).")
    else
        notify("Hide & Seek", "Infinite Stamina disabled.")
    end
end)


local _go = {}
local _iy = {}
local _us = nil
local _tj = 0

local function clearSpikeContainers()
    for _a, conn in pairs(_iy) do
        if conn then
            pcall(function() conn:Disconnect() end)
        end
        _iy[_a] = nil
    end
    table.clear(_iy)
end

local function isInsideHumanoidModel(inst)
    if not inst then return false end
    if inst:IsA("Model") and (_z:GetPlayerFromCharacter(inst) or inst:FindFirstChildOfClass("Humanoid")) then
        return true
    end
    local _sk = inst.Parent
    while _sk and _sk ~= _m do
        if _sk:IsA("Model") and (_z:GetPlayerFromCharacter(_sk) or _sk:FindFirstChildOfClass("Humanoid")) then
            return true
        end
        _sk = _sk.Parent
    end
    return false
end

local function findTrackedHazardAncestor(inst)
    local _zd = inst and inst.Parent
    while _zd and _zd ~= _m do
        if _go[_zd] then
            return _zd
        end
        _zd = _zd.Parent
    end
    return nil
end

local function stripHazardPart(_is)
    if not _is or not _is.Parent or _is.Name == _d4vqqe({29,16,28,58,13,62,24,17,58,14,34,16,14,57,49,60,28},{78,113,122,95,94}) then return end
    if isInsideHumanoidModel(_is) then return end
    if _is:IsA("BasePart") then
        pcall(function()
            _is.CanTouch = false
            _is.CanQuery = false
            _is.CanCollide = false
        end)
        for _nf, _il in ipairs(_is:GetChildren()) do
            if _il:IsA("TouchTransmitter") or _il.Name == _d4vqqe({111,24,86,70,64,58,65,79,18,81,64,91,7},{59,119,35,37,40,115,47}) then
                pcall(function() _il:Destroy() end)
            end
        end
    end
end

local function computeHazardWorldAABB(_pf)
    if not _pf or not _pf.Parent then return nil end
    local minX, maxX = math.huge, -math.huge
    local _wo, maxY = math.huge, -math.huge
    local minZ, maxZ = math.huge, -math.huge
    local _pv = false

    local function expandWithPart(_qp)
        if not _qp or not _qp.Parent or _qp.Name == _d4vqqe({15,75,95,11,125,24,54,55,79,105,2,79,28,57,51,88,84},{92,42,57,110,46,104,95}) or not _qp:IsA("BasePart") then return end
        if isInsideHumanoidModel(_qp) then return end
        local _ct = _qp.CFrame
        local _zm = _qp.Size * 0.5
        if _zm.Magnitude <= 0 then return end

        local _md = math.abs(_ct.RightVector.X) * _zm.X + math.abs(_ct.UpVector.X) * _zm.Y + math.abs(_ct.LookVector.X) * _zm.Z
        local _ch = math.abs(_ct.RightVector.Y) * _zm.X + math.abs(_ct.UpVector.Y) * _zm.Y + math.abs(_ct.LookVector.Y) * _zm.Z
        local _ox = math.abs(_ct.RightVector.Z) * _zm.X + math.abs(_ct.UpVector.Z) * _zm.Y + math.abs(_ct.LookVector.Z) * _zm.Z

        local _jd = _ct.Position
        if _jd.X - _md < minX then minX = _jd.X - _md end
        if _jd.X + _md > maxX then maxX = _jd.X + _md end
        if _jd.Y - _ch < _wo then _wo = _jd.Y - _ch end
        if _jd.Y + _ch > maxY then maxY = _jd.Y + _ch end
        if _jd.Z - _ox < minZ then minZ = _jd.Z - _ox end
        if _jd.Z + _ox > maxZ then maxZ = _jd.Z + _ox end
        _pv = true
    end

    if _pf:IsA("BasePart") then
        expandWithPart(_pf)
    end
    for _nf, _ve in ipairs(_pf:GetDescendants()) do
        expandWithPart(_ve)
    end

    if not _pv then return nil end
    return { minX = minX, maxX = maxX, _wo = _wo, maxY = maxY, minZ = minZ, maxZ = maxZ }
end

local function destroyHazardEntry(_pf)
    local _vm = _go[_pf]
    if not _vm then return end
    if _vm.descConn then
        pcall(function() _vm.descConn:Disconnect() end)
        _vm.descConn = nil
    end
    if _vm.plat and _vm.plat.Parent then
        pcall(function() _vm.plat:Destroy() end)
    end
    _go[_pf] = nil
end

local function clearSpikePlatforms()
    clearSpikeContainers()
    local _ma = {}
    for _pf in pairs(_go) do
        table.insert(_ma, _pf)
    end
    for _nf, _pf in ipairs(_ma) do
        destroyHazardEntry(_pf)
    end
    table.clear(_go)
end

local function refreshHazardPlatform(_pf)
    local _vm = _go[_pf]
    if not _vm then return end
    if not _pf or not _pf.Parent then
        destroyHazardEntry(_pf)
        return
    end

    local _kg = computeHazardWorldAABB(_pf)
    if not _kg then return end

    
    if _kg.maxY > _vm.maxTopY then
        _vm.maxTopY = _kg.maxY
    end

    local _bo = math.clamp((_kg.maxX - _kg.minX) + 3.5, 4, 80)
    local _rs = math.clamp((_kg.maxZ - _kg.minZ) + 3.5, 4, 80)
    local _mq = (_kg.minX + _kg.maxX) * 0.5
    local _mp = (_kg.minZ + _kg.maxZ) * 0.5
    local _ge = CFrame.new(_mq, _vm.maxTopY + 2.2, _mp)

    if not _vm.plat or not _vm.plat.Parent then
        local plat = Instance.new("Part")
        plat.Name = _d4vqqe({59,80,17,50,104,95,88,69,13,97,27,54,79,73,94,92,5},{104,49,119,87,59,47,49,46})
        plat.Anchored = true
        plat.CanCollide = true
        plat.CanTouch = false
        plat.CanQuery = true 
        plat.Transparency = 0.6
        plat.Color = Color3.fromRGB(0, 255, 180)
        plat.Material = Enum.Material.Neon
        plat.Size = Vector3.new(_bo, 1.0, _rs)
        plat.CFrame = _ge
        plat.Parent = _m
        _vm.plat = plat
    else
        _vm.plat.Size = Vector3.new(_bo, 1.0, _rs)
        _vm.plat.CFrame = _ge
    end
    _vm.dirty = false
end

local function scheduleHazardRefresh(_pf)
    local _vm = _go[_pf]
    if not _vm or _vm.refreshQueued then return end
    _vm.dirty = true
    _vm.refreshQueued = true
    task.defer(function()
        local _eh = _go[_pf]
        if not _eh then return end
        _eh.refreshQueued = false
        if _f.antiSpikeEnabled and _eh.dirty then
            refreshHazardPlatform(_pf)
        end
    end)
end

local function protectHazard(_mg, _wz, _ae, _yp)
    _yp = _yp or 0
    if not _mg or not _mg.Parent or _mg.Name == _d4vqqe({23,0,27,3,23,17,20,13,33,49,17,7,48,7,18,20,41},{68,97,125,102}) then return end
    if isInsideHumanoidModel(_mg) then return end
    if _yp > 4 then return end

    local _jp = findTrackedHazardAncestor(_mg)
    if _jp then
        if _mg:IsA("BasePart") then
            stripHazardPart(_mg)
        elseif _mg:IsA("TouchTransmitter") or _mg.Name == _d4vqqe({18,2,7,21,67,113,40,25,23,4,78,75,50},{70,109,114,118,43,56}) then
            pcall(function() _mg:Destroy() end)
        else
            for _nf, _ix in ipairs(_mg:GetDescendants()) do
                stripHazardPart(_ix)
            end
        end
        if _wz then
            _go[_jp].dirty = true
        else
            scheduleHazardRefresh(_jp)
        end
        return
    end

    if not (_mg:IsA("BasePart") or _mg:IsA("Model") or _mg:IsA("Folder")) then return end
    local name = string.lower(_mg.Name)
    if string.find(name, "trapezoid") or string.find(name, "strap") or string.find(name, "exitdoor") then
        return
    end
    local _tu = string.find(name, "spike") or string.find(name, "kill") or string.find(name, "trap") or string.find(name, "hazard")
    if not _ae and not _tu then
        return
    end

    if _ae and _mg:IsA("BasePart") and not _tu then
        local _ff = _mg:FindFirstChildOfClass("TouchTransmitter") ~= nil or _mg:FindFirstChild("TouchInterest") ~= nil
        local _yy = _mg.Size
        local _fx = (_yy.X <= 12 and _yy.Y <= 12 and _yy.Z <= 12)
        if not _ff and not _fx then
            return
        end
    end

    
    local _mk = false
    if _mg:IsA("Folder") then
        _mk = true
    elseif _mg:IsA("Model") then
        if _ae and not _tu then
            _mk = true
        else
            local _qd = computeHazardWorldAABB(_mg)
            if _qd and ((_qd.maxX - _qd.minX) > 80 or (_qd.maxZ - _qd.minZ) > 80) then
                _mk = true
            end
        end
    end

    if _mk then
        if not _iy[_mg] then
            local _qh = _tj
            _iy[_mg] = _mg.ChildAdded:Connect(function(_ed)
                if _f.antiSpikeEnabled and _qh == _tj and isHideAndSeekActiveWithState(_ol) then
                    protectHazard(_ed, false, true, _yp + 1)
                end
            end)
        end
        for _nf, _yv in ipairs(_mg:GetChildren()) do
            protectHazard(_yv, _wz, true, _yp + 1)
        end
        return
    end

    if _go[_mg] then
        if _mg:IsA("BasePart") then
            stripHazardPart(_mg)
        else
            for _nf, _ve in ipairs(_mg:GetDescendants()) do
                stripHazardPart(_ve)
            end
        end
        if _wz then
            _go[_mg].dirty = true
        else
            scheduleHazardRefresh(_mg)
        end
        return
    end

    if _mg:IsA("BasePart") then
        stripHazardPart(_mg)
    else
        for _nf, _ve in ipairs(_mg:GetDescendants()) do
            stripHazardPart(_ve)
        end
    end

    local _vm = { plat = nil, maxTopY = -math.huge, descConn = nil, dirty = true, refreshQueued = false }
    _vm.descConn = _mg.DescendantAdded:Connect(function(_vb)
        if not _f.antiSpikeEnabled then return end
        if _vb:IsA("TouchTransmitter") or _vb.Name == "TouchInterest" then
            pcall(function() _vb:Destroy() end)
        elseif _vb:IsA("BasePart") then
            stripHazardPart(_vb)
        end
        scheduleHazardRefresh(_mg)
    end)
    _go[_mg] = _vm
    if not _wz then
        refreshHazardPlatform(_mg)
    end
end

_bq:CreateToggle("Anti Spike", "Spawns walkable level safety platforms above spike hazards", false, function(enabled)
    _f.antiSpikeEnabled = enabled
    _ol.lastPositive = 0
    _tj += 1
    local _ak = _tj

    if _us then
        pcall(function() _us:Disconnect() end)
        _us = nil
    end

    if enabled then
        logHideAndSeekDiagnostic("Anti Spike")
        _us = _m.DescendantAdded:Connect(function(_ve)
            if _f.antiSpikeEnabled and _ak == _tj and isHideAndSeekActiveWithState(_ol) then
                
                if not findTrackedHazardAncestor(_ve) then
                    protectHazard(_ve, false)
                end
            end
        end)

        task.spawn(function()
            local _ng = false
            while _f.antiSpikeEnabled and _ak == _tj do
                local _on = isHideAndSeekActiveWithState(_ol)
                if _on then
                    if not _ng then
                        local _pj = findHideAndSeekMap() or _m
                        local _zz = 0
                        for _nf, _ve in ipairs(_pj:GetDescendants()) do
                            if not _f.antiSpikeEnabled or _ak ~= _tj then break end
                            protectHazard(_ve, true)
                            _zz += 1
                            if _zz % 400 == 0 then
                                task.wait()
                            end
                        end
                        
                        local _dd = {}
                        for _pf in pairs(_go) do
                            table.insert(_dd, _pf)
                        end
                        for _nf, _pf in ipairs(_dd) do
                            if not _f.antiSpikeEnabled or _ak ~= _tj then break end
                            refreshHazardPlatform(_pf)
                        end
                        _ng = true
                    else
                        local _wi = {}
                        for _pf in pairs(_go) do
                            table.insert(_wi, _pf)
                        end
                        for _nf, _pf in ipairs(_wi) do
                            if not _f.antiSpikeEnabled or _ak ~= _tj then break end
                            if _pf and _pf.Parent then
                                if _pf:IsA("BasePart") then
                                    stripHazardPart(_pf)
                                else
                                    for _nf, _ve in ipairs(_pf:GetDescendants()) do
                                        if _ve:IsA("BasePart") then stripHazardPart(_ve) end
                                    end
                                end
                                refreshHazardPlatform(_pf)
                            else
                                destroyHazardEntry(_pf)
                            end
                        end
                    end
                elseif _ng then
                    clearSpikeContainers()
                    clearSpikePlatforms()
                    _ng = false
                end
                task.wait(0.75)
            end
        end)
        notify("Hide & Seek", "Anti Spike engaged. Level safety platforms active.")
    else
        clearSpikeContainers()
        clearSpikePlatforms()
        notify("Hide & Seek", "Anti Spike dismantled.")
    end
end)


local function isValidDashTarget(_qp, _ka, enforceEnemyRole)
    if not _qp or _qp == _ka then return false end
    local _fz = _qp.Character
    if not _fz then return false end

    local _tz = _fz:FindFirstChild("HumanoidRootPart")
    local _eo = _fz:FindFirstChildOfClass("Humanoid")
    if not _tz or not _eo or _eo.Health <= 0 then return false end

    if _fz:FindFirstChildOfClass("ForceField") then return false end
    if _fz:GetAttribute("Eliminated") == true or _qp:GetAttribute("Eliminated") == true then return false end
    if _fz:FindFirstChild("Ghost") or _fz:GetAttribute("Ghost") == true then return false end
    if _fz:GetAttribute("Crawling") == true or _fz:FindFirstChild("Crawling") ~= nil then return false end

    if enforceEnemyRole then
        if isPlayerGuard(_qp) and not isPlayerHunter(_qp) then
            return false
        end
        if isPlayerHunter(_ka) and isPlayerHunter(_qp) then
            return false
        end
    end

    return true
end

local function createDashAssistController(_qy)
    local _me = {
        enabled = false,
        dashUntil = 0,
        conns = {},
        heartbeatConn = nil,
        charConn = nil,
        baselineSpeed = 16,
        lastSampleTime = 0,
        speedEdgeLocked = false
    }

    local function clearCharConns()
        for _nf, _kq in ipairs(_me.conns) do
            pcall(function() _kq:Disconnect() end)
        end
        table.clear(_me.conns)
    end

    local function armDash(_jy)
        if not _me.enabled or not _qy.isModeActive() then return end
        local _uf = os.clock() + (_jy or 0.5)
        if _uf > _me.dashUntil then
            _me.dashUntil = _uf
        end
    end

    local function bindCharacter(_ps)
        clearCharConns()
        if not _ps or not _me.enabled then return end
        local hum = _ps:WaitForChild("Humanoid", 4)
        local hrp = _ps:WaitForChild("HumanoidRootPart", 4)
        if not hum or not _me.enabled or _o.Character ~= _ps then return end

        local _qk = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 3) or hum
        if not _me.enabled or _o.Character ~= _ps then return end
        if _qk then
            table.insert(_me.conns, _qk.AnimationPlayed:Connect(function(_ne)
                if not _me.enabled or not _qy.isModeActive() then return end
                local _bx = (_ne.Animation and _ne.Animation.Name and string.lower(_ne.Animation.Name)) or ""
                if string.find(_bx, "dash") or string.find(_bx, "dodge") or string.find(_bx, "lunge") or string.find(_bx, "evade") then
                    armDash(0.5)
                    _ne.Stopped:Connect(function()
                        _me.dashUntil = 0
                    end)
                end
            end))
        end

        for _nf, attrName in ipairs({ "Dashing", "Dash", "IsDashing" }) do
            table.insert(_me.conns, _ps:GetAttributeChangedSignal(attrName):Connect(function()
                if _ps:GetAttribute(attrName) == true then
                    armDash(0.5)
                end
            end))
            table.insert(_me.conns, hum:GetAttributeChangedSignal(attrName):Connect(function()
                if hum:GetAttribute(attrName) == true then
                    armDash(0.5)
                end
            end))
        end

        if hrp then
            table.insert(_me.conns, hrp.ChildAdded:Connect(function(_il)
                if not _me.enabled or not _qy.isModeActive() then return end
                if _il:IsA("BodyVelocity") or _il:IsA("LinearVelocity") or _il:IsA("VectorForce") then
                    local _pc = hum:GetState()
                    if _pc ~= Enum.HumanoidStateType.Freefall and _pc ~= Enum.HumanoidStateType.Ragdoll then
                        task.defer(function()
                            if hrp and hrp.Parent and _il.Parent == hrp then
                                local _rn = hrp.AssemblyLinearVelocity
                                local _tk = Vector3.new(_rn.X, 0, _rn.Z).Magnitude
                                if (_tk - _me.baselineSpeed >= 10 and _tk >= 22) or _il.Name:lower():find(_d4vqqe({63,8,46,28},{91,105,93,116,40,79})) then
                                    armDash(0.45)
                                end
                            end
                        end)
                    end
                end
            end))
        end
    end

    function _me:SetEnabled(enabled)
        _me.enabled = enabled
        _me.dashUntil = 0
        _me.speedEdgeLocked = false
        clearCharConns()

        if _me.heartbeatConn then
            pcall(function() _me.heartbeatConn:Disconnect() end)
            _me.heartbeatConn = nil
        end
        if _me.charConn then
            pcall(function() _me.charConn:Disconnect() end)
            _me.charConn = nil
        end

        if enabled then
            if _o.Character then
                task.spawn(bindCharacter, _o.Character)
            end
            _me.charConn = _o.CharacterAdded:Connect(function(_qu)
                if _me.enabled then
                    bindCharacter(_qu)
                end
            end)

            _me.lastSampleTime = os.clock()
            _me.heartbeatConn = _x.Heartbeat:Connect(function()
                if not _me.enabled or not _qy.isModeActive() then return end
                local _kx = _o.Character
                local _ar = _kx and _kx:FindFirstChild("HumanoidRootPart")
                local _yb = _kx and _kx:FindFirstChildOfClass("Humanoid")
                if not _ar or not _yb or _yb.Health <= 0 then return end

                local _pc = _yb:GetState()
                local _rn = _ar.AssemblyLinearVelocity
                local _tk = Vector3.new(_rn.X, 0, _rn.Z).Magnitude
                local _ni = os.clock()

                if _pc ~= Enum.HumanoidStateType.Freefall and _pc ~= Enum.HumanoidStateType.Ragdoll then
                    if not _me.speedEdgeLocked and (_tk - _me.baselineSpeed >= 14) and _tk >= 24 then
                        armDash(0.45)
                        _me.speedEdgeLocked = true
                    elseif _me.speedEdgeLocked and _tk < math.max(_me.baselineSpeed + 4, 22) then
                        _me.speedEdgeLocked = false
                    end
                else
                    _me.speedEdgeLocked = false
                end

                if _ni - _me.lastSampleTime >= 0.15 then
                    _me.baselineSpeed = _tk
                    _me.lastSampleTime = _ni
                end

                if _ni < _me.dashUntil then
                    local _ze = nil
                    local _vu = 65
                    local _jx = nil
                    local _wt = 65
                    local _rm = _qy.enforceEnemyRole and isPlayerHunter(_o)
                    for _nf, _qp in ipairs(_z:GetPlayers()) do
                        if isValidDashTarget(_qp, _o, _qy.enforceEnemyRole) then
                            local _tz = _qp.Character:FindFirstChild("HumanoidRootPart")
                            local _gh = _tz.Position - _ar.Position
                            local _ti = Vector3.new(_gh.X, 0, _gh.Z).Magnitude
                            local _ix = _gh.Magnitude
                            if _ti >= 0.5 then
                                if _qy.enforceEnemyRole and not _rm and isPlayerHunter(_qp) then
                                    if _ix < _wt then
                                        _wt = _ix
                                        _jx = _tz
                                    end
                                end
                                if _ix < _vu then
                                    _vu = _ix
                                    _ze = _tz
                                end
                            end
                        end
                    end
                    local _uv = _jx or _ze
                    if _uv then
                        local _jd = _uv.Position
                        local _ub = Vector3.new(_jd.X - _ar.Position.X, 0, _jd.Z - _ar.Position.Z)
                        if _ub.Magnitude >= 0.5 then
                            _ar.CFrame = CFrame.lookAt(_ar.Position, _ar.Position + _ub)
                        end
                    end
                end
            end)
        end
    end

    return _me
end

local _xj = createDashAssistController({
    isModeActive = isHideAndSeekActive,
    enforceEnemyRole = true
})

local _dx = createDashAssistController({
    isModeActive = function() return isCurrentGame("LightsOut") end,
    enforceEnemyRole = false
})

_bq:CreateToggle("Dash Assist", "Rotates character towards nearest valid target during dash in Hide & Seek", false, function(enabled)
    _f.dashAssistEnabled = enabled
    _xj:SetEnabled(enabled)
    notify("Hide & Seek", enabled and "Dash Assist engaged." or "Dash Assist disengaged.")
end)


_bq:CreateButton("Auto Complete Safe Doors", "Collects missing keys and completes safe door escape", "Escape", function()
    if not (isCurrentGame("HideAndSeek") or _m:FindFirstChild("HideAndSeekMap")) then
        notify("Hide & Seek", "Hide & Seek is not currently running.")
        return
    end

    task.spawn(function()
        local _ps = _o.Character
        local hrp = _ps and _ps:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        
        local _zw = { "Circle", "Square", "Triangle" }
        local _gu = _o:FindFirstChild("CurrentKeys")
        local _jn = {}
        if _gu then
            for _nf, _kr in ipairs(_gu:GetChildren()) do _jn[_kr.Name] = true end
        end

        local _yq = _m:FindFirstChild("Effects")
        if _yq then
            for _nf, keyName in ipairs(_zw) do
                if not _jn[keyName] then
                    for _nf, _il in ipairs(_yq:GetChildren()) do
                        if string.find(_il.Name, "DroppedKey") and string.find(_il.Name, keyName) then
                            local _ul = _il:IsA("Model") and _il:GetPivot() or (_il:IsA(_d4vqqe({109,11,24,37,127,11,25,52},{47,106,107,64})) and _il.CFrame)
                            if _ul then
                                local _wu = hrp.CFrame
                                safePhysicsTeleport(_ul)
                                task.wait(0.12)
                                safePhysicsTeleport(_wu)
                                break
                            end
                        end
                    end
                end
            end
        end

        
        local _eq = _m:FindFirstChild("HideAndSeekMap")
        local _ft = _eq and _eq:FindFirstChild("NEWFIXEDDOORS")
        local _jq = _ft and _ft:FindFirstChild("Floor1")
        local _xq = _jq and _jq:FindFirstChild("EXITDOORS")
        if _xq then
            for _nf, _ei in ipairs(_xq:GetChildren()) do
                if string.find(string.upper(_ei.Name), "EXITDOOR") then
                    for _nf, _cx in ipairs(_ei:GetDescendants()) do
                        if _cx:IsA("ProximityPrompt") then
                            pcall(function() fireproximityprompt(_cx, 0) end)
                        end
                    end
                end
            end
        end

        
        safePhysicsTeleport(CFrame.new(199, 54, -88))
        notify("Hide & Seek", "Safe Door Escape Complete! Teleported to safe zone.")
    end)
end)




local _oo = _ui:CreateCategory("Lights Out", false, 7)

local _st = {}

local function cleanLightsOutESP()
    for _nf, hl in ipairs(_st) do
        if hl and hl.Parent then hl:Destroy() end
    end
    table.clear(_st)
end

_oo:CreateToggle("ESP All", "Red silhouette highlight on all other contestants in dark", false, function(enabled)
    _f.lightsOutESPEnabled = enabled
    if enabled then
        if not _s.lightsOutESPThread then
            _s.lightsOutESPThread = task.spawn(function()
                while _f.lightsOutESPEnabled do
                    for _nf, _qp in ipairs(_z:GetPlayers()) do
                        if _qp ~= _o and _qp.Character then
                            if not _qp.Character:FindFirstChild("LightsOutESP") then
                                local hl = Instance.new("Highlight")
                                hl.Name = "LightsOutESP"
                                hl.FillColor = Color3.fromRGB(255, 30, 40)
                                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                hl.FillTransparency = 0.5
                                hl.OutlineTransparency = 0
                                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                                hl.Parent = _qp.Character
                                table.insert(_st, hl)
                            end
                        end
                    end
                    task.wait(2)
                end
                _s.lightsOutESPThread = nil
            end)
        end
        notify("Lights Out", "Contestant highlights visible in dark.", 2)
    else
        cleanLightsOutESP()
    end
end)

_oo:CreateToggle("Dash Assist", "Snaps character aim to nearest contestant when dashing in Lights Out", false, function(enabled)
    _f.lightsOutDashAssist = enabled
    _dx:SetEnabled(enabled)
    notify("Lights Out", enabled and "Dash Assist engaged." or "Dash Assist disengaged.", 2)
end)

_oo:CreateToggle("Lights Out Fullbright", "Forces max client ambient to see in pitch black room", false, function(enabled)
    _f.lightsOutFullBrightEnabled = enabled
    if enabled then
        _d.Ambient = Color3.fromRGB(255, 255, 255)
        _d.Brightness = 3
        _d.ClockTime = 14
        _d.FogEnd = 9e9
        notify("Lights Out", "Night room vision unlocked.", 2)
    else
        _d.Ambient = Color3.fromRGB(128, 128, 128)
        _d.Brightness = 1
        _d.ClockTime = 12
    end
end)




local _uj = _ui:CreateCategory("Jump Rope", false, 8)

_uj:CreateButton("Delete Rope", "Removes moving rope obstacle from Effects to prevent death", "Delete", function()
    local _cg = false
    pcall(function()
        local _gx = _m:FindFirstChild("Effects")
        local _ja = _gx and _gx:FindFirstChild("rope")
        if _ja then
            _ja:Destroy()
            _cg = true
        end
    end)
    notify("Jump Rope", _cg and "Rope obstacle deleted successfully!" or "Rope not found in Effects folder.", 3)
end)

_uj:CreateToggle("Anti Fall Platform", "Creates safety floor directly under jump rope deck", false, function(enabled)
    _f.antiFallRopeEnabled = enabled
    if enabled then
        local _a = _m:FindFirstChild("RopeFloor") or Instance.new("Folder", _m)
        _a.Name = "RopeFloor"
        createSafeWalkway(_a, "DeckFloor", CFrame.new(Vector3.new(675, 192, 921)), Vector3.new(200, 2, 50))
        notify("Jump Rope", "Solid platform created under jump rope deck.", 2)
    else
        local _kq = _m:FindFirstChild("RopeFloor")
        if _kq then _kq:Destroy() end
    end
end)




local _ah = _ui:CreateCategory("Mingle", false, 9)

local function setMingleDoorCollision(_ta)
    local _eb = _m:FindFirstChild("MingleMap")
    local _ml = _eb and _eb:FindFirstChild("AllMingleDoors")
    if not _ml then return end

    for _nf, _ei in pairs(_ml:GetChildren()) do
        local _wf = _ei:FindFirstChild("Union")
        if _wf then
            _wf.CanCollide = _ta
            _wf.Transparency = _ta and 0 or 0.4
        end
        local _ce = _ei:FindFirstChild("DoorHandle")
        if _ce then _ce.CanCollide = _ta end
        local _hh = _ei:FindFirstChild("DoorHandleOtherSide")
        if _hh then _hh.CanCollide = _ta end
    end
end

_ah:CreateToggle("Noclip Doors", "Phase through all room doors in MingleMap", false, function(enabled)
    _f.mingleNoclipDoors = enabled
    if enabled then
        setMingleDoorCollision(false)
        if not _s.mingleNoclipThread then
            _s.mingleNoclipThread = task.spawn(function()
                while _f.mingleNoclipDoors do
                    setMingleDoorCollision(false)
                    task.wait(1)
                end
                _s.mingleNoclipThread = nil
            end)
        end
        notify("Mingle", "Noclip Doors active.", 2)
    else
        setMingleDoorCollision(true)
    end
end)

local _sq = false

local function getMyMingleRoomDoor()
    local _ps = _o.Character
    local hrp = _ps and _ps:FindFirstChild("HumanoidRootPart")
    local _eb = _m:FindFirstChild("MingleMap")
    local _zo = _eb and _eb:FindFirstChild("AllMingleDoors")
    if not hrp or not _zo then return nil end
    local _jd = hrp.Position

    for _nf, _ei in pairs(_zo:GetChildren()) do
        local _ly = _ei:FindFirstChild("InsideRoomRayCheck")
        if _ly and _ly:IsA("BasePart") then
            local _ll = _ly.CFrame:PointToObjectSpace(_jd)
            if math.abs(_ll.X) <= 10 and math.abs(_ll.Z) <= 12 and math.abs(_ll.Y) <= 10 then
                return _ei
            end
        end
    end
    return nil
end

local function closeMingleDoor(_ei)
    if not _ei or _sq then return end
    _sq = true

    local _tn = _ei:FindFirstChild("DoorHandleOtherSide") or _ei:FindFirstChild("DoorHandle")
    local _gb = _tn and _tn:FindFirstChild("CloseDoorPrompt")

    if _gb and _gb:IsA("ProximityPrompt") then
        pcall(function()
            _gb.HoldDuration = 0
            _gb.RequiresLineOfSight = false
            _gb.MaxActivationDistance = 9999
            firePrompt(_gb)
        end)
    end

    local _ev = _ei:FindFirstChild("OpenOrCloseBD")
    if _ev and _ev:IsA("BindableEvent") then
        pcall(function() _ev:Fire("Close") end)
    end

    task.delay(3, function()
        _sq = false
    end)
end

_ah:CreateToggle("Auto Close Door", "Automatically locks nearest door upon room entry when safe", false, function(enabled)
    _f.autoCloseDoorEnabled = enabled
    if enabled then
        if not _s.mingleDoorThread then
            _s.mingleDoorThread = task.spawn(function()
                local _sd = 0
                while _f.autoCloseDoorEnabled do
                    local _ni = tick()
                    if _ni - _sd >= 0.2 then
                        _sd = _ni
                        pcall(function()
                            local _tf = _o:FindFirstChildOfClass(_d4vqqe({37,22,41,22,95,35,27,0,19},{117,122,72,111,58,81,92}))
                            local _lb = _tf and _tf:FindFirstChild(_d4vqqe({114,62,70,15,23,104,3,102,5,9,89,47,92},{61,74,46,106,101}))
                            local _jt = _lb and _lb:FindFirstChild(_d4vqqe({44,80,40,88,25,4},{97,57,70,63,117}))

                            if _jt and _jt.Visible then
                                local _la = _jt:FindFirstChild(_d4vqqe({25,7,89,40,13,58,58,37,93,52,12,45,45},{73,107,56,81,104,72}))
                                if _la and _la:IsA(_d4vqqe({25,56,71,74,7,44,63,90,82},{77,93,63,62,75})) and _la.Text ~= "" and string.find(string.lower(_la.Text), _d4vqqe({11,74,66,92},{120,43,36,57})) then
                                    local _ei = getMyMingleRoomDoor()
                                    if _ei then
                                        closeMingleDoor(_ei)
                                    end
                                end
                            end
                        end)
                    end
                    task.wait(0.1)
                end
                _s.mingleDoorThread = nil
            end)
        end
    else
        _s.mingleDoorThread = nil
        _sq = false
    end
end)

local _kz = nil
local _gl = nil

local function getCachedControls()
    local _ga = _o:FindFirstChild("PlayerScripts")
    local _rt = _ga and _ga:FindFirstChild("PlayerModule")
    if not _rt then
        _kz = nil
        _gl = nil
        return nil
    end
    if _kz ~= _rt or not _gl then
        local _kj, _hu = pcall(function()
            return require(_rt):GetControls()
        end)
        if _kj and _hu then
            _kz = _rt
            _gl = _hu
        end
    end
    return _gl
end

_ah:CreateToggle("Anti Slow", "Prevents slowdowns, mud, crowd drag, and movement locks across games", false, function(enabled)
    _f.antiSlowEnabled = enabled
    if _s.antiSlowConn then
        pcall(function() _s.antiSlowConn:Disconnect() end)
        _s.antiSlowConn = nil
    end

    if enabled then
        local _xp = { "Freeze", "Slowed", "Action", "LightAction", "NoAttack" }
        local _kn = { "Stun", "Freeze", "Slowed", "Action", "LightAction", "Ragdoll", "NoAttack", "Slow" }

        _s.antiSlowConn = _x.Heartbeat:Connect(function()
            if not _f.antiSlowEnabled then return end
            
            if _ao or (_f.freezeOnRedLightEnabled and isCurrentGame(_d4vqqe({12,49,41,50,66,48,74,42,19,63,27,78,57,110,55,51,37,10},{94,84,77,126,43,87,34}))) then
                return
            end

            pcall(function()
                if shared then
                    shared.WalkSpeedChangeTick = nil
                    if shared.IsInCutscene then
                        shared.IsInCutscene = nil
                    end
                end

                local _hu = getCachedControls()
                if _hu and _hu.Enable then
                    _hu:Enable(true)
                end

                local _ps = _o.Character
                if not _ps then return end
                local hum = _ps:FindFirstChildOfClass(_d4vqqe({100,69,56,6,39,67,89,49},{44,48,85,103,73}))
                local hrp = _ps:FindFirstChild(_d4vqqe({105,3,51,35,79,25,55,38,115,25,49,54,113,23,44,54},{33,118,94,66}))

                for _nf, attr in ipairs(_xp) do
                    if _ps:GetAttribute(attr) ~= nil then
                        _ps:SetAttribute(attr, nil)
                    end
                    if hum and hum:GetAttribute(attr) ~= nil then
                        hum:SetAttribute(attr, nil)
                    end
                end

                for _nf, instName in ipairs(_kn) do
                    local _yv = _ps:FindFirstChild(instName)
                    if _yv then pcall(function() _yv:Destroy() end) end
                    if hum then
                        local _rc = hum:FindFirstChild(instName)
                        if _rc then pcall(function() _rc:Destroy() end) end
                    end
                end

                if hrp and hrp.Anchored then
                    hrp.Anchored = false
                end

                if hum then
                    local _xy = 16
                    local _nv = 50
                    pcall(function()
                        local _rp = game:GetService(_d4vqqe({120,65,21,11,95,80,6,41,71,84,13,28,89},{43,53,116,121}))
                        if _rp.CharacterWalkSpeed and _rp.CharacterWalkSpeed > 0 then
                            _xy = _rp.CharacterWalkSpeed
                        end
                        if _rp.CharacterJumpPower and _rp.CharacterJumpPower > 0 then
                            _nv = _rp.CharacterJumpPower
                        end
                    end)

                    local _et = (_ps:GetAttribute(_d4vqqe({103,75,38,17,20,36,77,87,46},{36,57,73,100,119,76})) == true)
                        or _u:IsKeyDown(Enum.KeyCode.C)
                        or _u:IsKeyDown(Enum.KeyCode.LeftControl)
                    if not _et and hum.WalkSpeed < _xy then
                        hum.WalkSpeed = _xy
                    end

                    pcall(function()
                        if hum.UseJumpPower == false then
                            if hum.JumpHeight < 7.2 then
                                hum.JumpHeight = 7.2
                            end
                        else
                            if hum.JumpPower < _nv then
                                hum.JumpPower = _nv
                            end
                        end
                    end)

                    if hum.PlatformStand then
                        hum.PlatformStand = false
                    end
                end
            end)
        end)
        notify("Anti Slow", "Universal anti-slow protection active.")
    else
        notify("Anti Slow", "Anti-slow protection disabled.")
    end
end)




local _tl = _ui:CreateCategory("Sky & Squid Game", false, 10)

_tl:CreateToggle("Anti Freeze While Fight", "Cleanses freeze, stun, and combat ragdoll locks", false, function(enabled)
    _f.antiFreezeFightEnabled = enabled
    if enabled then
        if not _s.antiFreezeThread then
            _s.antiFreezeThread = task.spawn(function()
                local _lf = { "Freeze", "Slowed", "Action", "LightAction", "NoAttack", "Stun", "Ragdoll" }
                while _f.antiFreezeFightEnabled do
                    local _ps = _o.Character
                    if _ps then
                        for _nf, tag in ipairs(_lf) do
                            local _rj = _ps:FindFirstChild(tag)
                            if _rj then pcall(function() _rj:Destroy() end) end
                            if _ps:GetAttribute(tag) ~= nil then
                                _ps:SetAttribute(tag, nil)
                            end
                        end
                    end
                    task.wait(0.15)
                end
                _s.antiFreezeThread = nil
            end)
        end
        notify("Sky Squid", "Combat freedom active.", 2)
    else
        _s.antiFreezeThread = nil
    end
end)

_tl:CreateToggle("Throw Pole AIM", "Calculates velocity arc to automatically aim at targets", false, function(enabled)
    _f.throwPoleAimEnabled = enabled
    if enabled then
        if not _s.poleAimThread then
            _s.poleAimThread = task.spawn(function()
                while _f.throwPoleAimEnabled do
                    local _ea = getSmartAimbotTarget(400)
                    if _ea and _ea.Character then
                        local _xo = _ea.Character:FindFirstChild("Head")
                        local _ps = _o.Character
                        local hrp = _ps and _ps:FindFirstChild("HumanoidRootPart")
                        local _ee = _ps and (_ps:FindFirstChild(_d4vqqe({44,61,53,33},{124,82,89,68,61,109,38})) or _ps:FindFirstChild(_d4vqqe({1,61,32,89,43,5,58,62,83},{85,85,82,54,92})))
                        if _xo and hrp and _ee then
                            hrp.CFrame = CFrame.lookAt(hrp.Position, Vector3.new(_xo.Position.X, hrp.Position.Y, _xo.Position.Z))
                        end
                    end
                    task.wait(0.05)
                end
                _s.poleAimThread = nil
            end)
        end
    else
        _s.poleAimThread = nil
    end
end)




local _pl = _xf:CreateTab("Combat", "Crosshair")
local _cu = _pl:CreateCategory("Combat Assistance", true, 1)

local aimbotToggle
aimbotToggle = _cu:CreateToggle("Aimbot", "Smoothly locks camera rotation onto closest opponent", false, function(enabled)
    _f.aimbotEnabled = enabled
    if not enabled and not _f.aimbotTargetLock then
        _f.lockedTargetPlayer = nil
        clearLockedHighlight()
    end
end)


if not _s.aimbotConn then
    _s.aimbotConn = _x.RenderStepped:Connect(function()
        if not _f.aimbotEnabled and not _f.aimbotTargetLock then return end
        local _jv = _m.CurrentCamera or _q
        local _ps = _o.Character
        local hrp = _ps and _ps:FindFirstChild("HumanoidRootPart")
        if not _jv or not hrp then return end

        local _sb, _am = getSmartAimbotTarget(_f.aimbotFovRadius or 150)
        if _sb and _am then
            local _pt = _jv.CFrame.Position
            local _bv = _am.Position
            local _ge = CFrame.lookAt(_pt, _bv)
            _jv.CFrame = _jv.CFrame:Lerp(_ge, 0.6)
        end
    end)
end

_cu:CreateKeybind("Aimbot Keybind", "Toggle aimbot ON or OFF with assigned key", Enum.KeyCode.E, function(_ii, _bb)
    if _bb then
        if aimbotToggle and aimbotToggle.SetValue then
            aimbotToggle:SetValue(not _f.aimbotEnabled, true)
        else
            _f.aimbotEnabled = not _f.aimbotEnabled
            if not _f.aimbotEnabled and not _f.aimbotTargetLock then
                _f.lockedTargetPlayer = nil
                clearLockedHighlight()
            end
        end
    else
        _f.aimbotKey = _ii
    end
end)

local targetLockToggle
targetLockToggle = _cu:CreateToggle("Target Lock", "Persistently tracks single target without switching", false, function(enabled)
    _f.aimbotTargetLock = enabled
    if not enabled then
        _f.lockedTargetPlayer = nil
        clearLockedHighlight()
    end
end)

_cu:CreateKeybind("Target Lock Keybind", "Toggle target lock ON or OFF with assigned key", Enum.KeyCode.Q, function(_ii, _bb)
    if _bb then
        if targetLockToggle and targetLockToggle.SetValue then
            targetLockToggle:SetValue(not _f.aimbotTargetLock, true)
        else
            _f.aimbotTargetLock = not _f.aimbotTargetLock
            if not _f.aimbotTargetLock then
                _f.lockedTargetPlayer = nil
                clearLockedHighlight()
            end
        end
    else
        _f.targetLockKey = _ii
    end
end)

_cu:CreateDropdown("Target Part", "Select aimbot target body part", { "Torso", "Head" }, "Torso", function(_pe)
    _f.aimbotTargetPart = _pe
end)

_cu:CreateToggle("Show FOV", "Displays visual lock-on circle matching GUI theme color", false, function(enabled)
    _f.showFovEnabled = enabled
    if not _uc then
        initFovCircle()
    end
    if _uc then
        _uc.Visible = enabled
    end
    if _jk then
        pcall(function() _jk.Visible = enabled end)
    end
end)

_cu:CreateSlider("FOV Size", "Scales lock-on search radius and visual FOV circle", 10, 500, 150, 1, function(_rj)
    _f.aimbotFovRadius = _rj
    if _uc then
        _uc.Size = UDim2.new(0, _rj, 0, _rj)
    end
    if _jk then
        pcall(function() _jk.Radius = _rj / 2 end)
    end
end)

local _iz = 0
_cu:CreateToggle("Auto QTE Event", "Bypasses quick time events with 100% success", false, function(enabled)
    _f.autoQTEEnabled = enabled
    _iz += 1
    local _ak = _iz

    if _s.autoQteThread then
        pcall(task.cancel, _s.autoQteThread)
        _s.autoQteThread = nil
    end

    if enabled then
        _s.autoQteThread = task.spawn(function()
            local _ms = nil
            pcall(function()
                local _ov = _r:WaitForChild(_d4vqqe({114,3,42,46,60,55,76},{63,108,78,91,80,82}), 5)
                local _mf = _ov and _ov:WaitForChild(_d4vqqe({8,4,8,45,46,36},{64,70,79,124,122,97,66}), 5)
                if _mf then
                    _ms = require(_mf)
                end
            end)

            if not (_f.autoQTEEnabled and _ak == _iz) then return end
            if type(_ms) ~= "table" or typeof(_ms.Pressed) ~= "function" then
                notify("Combat", "HBGQTE module unavailable.")
                return
            end

            local _rb = {}
            while _f.autoQTEEnabled and _ak == _iz do
                local _zn = _ms.ActiveButtons
                if type(_zn) == "table" then
                    for _kr, _bz in pairs(_zn) do
                        if not _rb[_kr] then
                            _rb[_kr] = true
                            pcall(_ms.Pressed, false, _bz)
                        end
                    end
                    for _kr in pairs(_rb) do
                        if _zn[_kr] == nil then
                            _rb[_kr] = nil
                        end
                    end
                else
                    table.clear(_rb)
                end
                task.wait()
            end
        end)
    end
end)

_s.bandageConns = _s.bandageConns or {}

local function clearBandageConns()
    for _nf, conn in ipairs(_s.bandageConns) do
        if conn then
            pcall(function() conn:Disconnect() end)
        end
    end
    table.clear(_s.bandageConns)
end

_cu:CreateToggle("Bandage Helper", "Removes movement freeze and animation locks while using a bandage", false, function(enabled)
    _f.bandageHelperEnabled = enabled
    clearBandageConns()

    if enabled then
        local _dw = { "Freeze", "Slowed", "Action", "LightAction", "NoAttack" }
        local _hk = { "Stun", "Freeze", "Slowed", "Action", "LightAction", "Ragdoll", "NoAttack" }

        local function hookBandageAnims(_ps)
            if not _ps or not _f.bandageHelperEnabled then return end
            local hum = _ps:WaitForChild("Humanoid", 5)
            if not hum or not _f.bandageHelperEnabled or _o.Character ~= _ps then return end
            local _hl = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator", 3) or hum
            if not _f.bandageHelperEnabled or _o.Character ~= _ps then return end
            table.insert(_s.bandageConns, _hl.AnimationPlayed:Connect(function(_ad)
                if not _f.bandageHelperEnabled then return end
                if _ad and _ad.Animation then
                    local _ai = _ad.Animation.AnimationId or ""
                    local name = (_ad.Animation.Name and string.lower(_ad.Animation.Name)) or ""
                    if string.find(_ai, "75334524397463") or string.find(name, "bandage") then
                        _ad:Stop()
                    end
                end
            end))
        end

        if _o.Character then
            task.spawn(hookBandageAnims, _o.Character)
        end

        table.insert(_s.bandageConns, _o.CharacterAdded:Connect(function(_kq)
            if _f.bandageHelperEnabled then
                hookBandageAnims(_kq)
            end
        end))

        
        table.insert(_s.bandageConns, _x.Heartbeat:Connect(function()
            if not _f.bandageHelperEnabled then return end
            local _ps = _o.Character
            if not _ps then return end
            local hum = _ps:FindFirstChildOfClass("Humanoid")
            local hrp = _ps:FindFirstChild("HumanoidRootPart")

            for _nf, attr in ipairs(_dw) do
                if _ps:GetAttribute(attr) ~= nil then
                    _ps:SetAttribute(attr, nil)
                end
                if hum and hum:GetAttribute(attr) ~= nil then
                    hum:SetAttribute(attr, nil)
                end
            end

            for _nf, instName in ipairs(_hk) do
                local _rn = _ps:FindFirstChild(instName)
                if _rn then pcall(function() _rn:Destroy() end) end
            end

            if hrp and hrp.Anchored then
                hrp.Anchored = false
            end
        end))

        notify("Bandage Helper", "Bandage movement unlock enabled.")
    else
        notify("Bandage Helper", "Bandage movement unlock disabled.")
    end
end)




local _oz = _xf:CreateTab("Visuals", "Eye")




local _mr = _oz:CreateCategory("Player & World ESP", true, 1)

local _ex = {
    
    GuardIcon      = "rbxassetid://83349780085312",  
    ContestantIcon = "rbxassetid://132745507722031", 
    HealthIcon     = "rbxassetid://83295663127771",  
    HunterSkull    = "rbxassetid://128938040692977", 

    
    Quicksilver    = "rbxassetid://95067897228787",  
    LightningGod   = "rbxassetid://73304449581599",  
    UltraInstinct  = "rbxassetid://95719331249213",  
    RealityJumper  = "rbxassetid://86947520558645",  
    GenericPower   = "rbxassetid://122505047985340", 

    
    KeyCircle      = "rbxassetid://81821362057352",  
    KeySquare      = "rbxassetid://127252171630183", 
    KeyTriangle    = "rbxassetid://127092863384256", 
    ExitDoor       = "rbxassetid://112233577388050", 
    DroppedWeapon  = "rbxassetid://117770953173846", 
    DroppedBandage = "rbxassetid://129437556919042"  
}


task.spawn(function()
    pcall(function()
        local _om = game:GetService("ContentProvider")
        local _wc = {}
        for _nf, uri in pairs(_ex) do
            local _mv = Instance.new("ImageLabel")
            _mv.Image = uri
            table.insert(_wc, _mv)
        end
        _om:PreloadAsync(_wc)
    end)
end)

local _if = {}
local _un = {}






local function getPlayerPower(player)
    if not player then return nil end
    local _ny = { "_EquippedPower", "EquippedPower", "Power", "CurrentPower", "Ability", "EquippedGuardPower" }

    for _nf, attr in ipairs(_ny) do
        local _rj = player:GetAttribute(attr)
        if _rj ~= nil and _rj ~= false and _rj ~= "" and _rj ~= 0 and _rj ~= _d4vqqe({13,3,22,78},{67,108,120,43,123,120}) and _rj ~= _d4vqqe({100,94,50},{61,49,89,40,115,81,92}) then
            return tostring(_rj)
        end
    end

    local _ps = player.Character
    if _ps then
        for _nf, attr in ipairs(_ny) do
            local _rj = _ps:GetAttribute(attr)
            if _rj ~= nil and _rj ~= false and _rj ~= "" and _rj ~= 0 and _rj ~= _d4vqqe({117,85,69,86},{59,58,43,51,53,86,37}) and _rj ~= _d4vqqe({22,6,37},{79,105,78,97,43,106}) then
                return tostring(_rj)
            end
        end

        for _nf, _ve in ipairs(_ps:GetDescendants()) do
            if _ve.Name == _d4vqqe({7,6,22,33,79,11,31,61,39,55,59,81,30,29},{88,67,103,84,38,123,111}) or _ve.Name == _d4vqqe({31,68,47,1,28,51,63,81,10,7,27,38,40},{90,53,90,104,108,67}) or _ve.Name == _d4vqqe({62,56,21,35,75},{110,87,98,70,57,37,88,114}) then
                if (_ve:IsA("StringValue") or _ve:IsA("NumberValue")) and _ve.Value ~= "" and _ve.Value ~= _d4vqqe({29,19,51,33},{83,124,93,68,51,70,92}) and _ve.Value ~= _d4vqqe({8,4,32},{81,107,75,54}) then
                    return tostring(_ve.Value)
                end
            end
        end
    end

    return nil
end

local function resolvePowerInfo(_wd)
    if not _wd or _wd == "" then return nil end
    local lower = string.lower(_wd)
    if lower == _d4vqqe({39,84,47,52},{73,59,65,81}) or lower == _d4vqqe({91,63,35},{34,80,72,91,67,62,44}) or lower == _d4vqqe({38,59,40,82,24},{64,90,68,33,125,44}) or lower == _d4vqqe({24,63,3},{118,86,111,60,58}) then
        return nil
    end

    if string.find(lower, "quick") or string.find(lower, "silver") or string.find(lower, "speed") then
        return {
            name = "Quicksilver",
            icon = _ex.Quicksilver,
            color = Color3.fromRGB(0, 235, 255),
            glowColor = Color3.fromRGB(0, 160, 255)
        }
    elseif string.find(lower, "light") or string.find(lower, "god") or string.find(lower, "thunder") or string.find(lower, "volt") then
        return {
            name = "Lightning God",
            icon = _ex.LightningGod,
            color = Color3.fromRGB(255, 215, 0),
            glowColor = Color3.fromRGB(255, 160, 0)
        }
    elseif string.find(lower, "instinct") or string.find(lower, "ultra") or string.find(lower, "dodge") then
        return {
            name = "Ultra Instinct",
            icon = _ex.UltraInstinct,
            color = Color3.fromRGB(215, 240, 255),
            glowColor = Color3.fromRGB(140, 190, 255)
        }
    elseif string.find(lower, "reality") or string.find(lower, "jump") or string.find(lower, "teleport") or string.find(lower, "portal") then
        return {
            name = "Reality Jumper",
            icon = _ex.RealityJumper,
            color = Color3.fromRGB(255, 80, 220),
            glowColor = Color3.fromRGB(180, 40, 230)
        }
    else
        return {
            name = _wd,
            icon = _ex.GenericPower,
            color = Color3.fromRGB(0, 180, 255),
            glowColor = Color3.fromRGB(0, 120, 230)
        }
    end
end

local function createOrGetESP(player)
    local _l = (typeof(gethui) == "function" and gethui()) or game:GetService("CoreGui")
    local _vm = _if[player]
    if _vm and _vm.topGui and _vm.topGui.Parent then
        return _vm
    end

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    local topGui = Instance.new("BillboardGui")
    topGui.Name = _d4vqqe({49,88,75,5,79,19,89,89,33,114,32,99},{112,60,61,100,33}) .. player.Name
    topGui.Size = UDim2.new(0, 140, 0, 52)
    topGui.StudsOffset = Vector3.new(0, 2.2, 0)
    topGui.AlwaysOnTop = true
    topGui.LightInfluence = 0
    topGui.MaxDistance = 300
    topGui.ResetOnSpawn = false
    topGui.Enabled = false

    local _nm = Instance.new("Frame")
    _nm.Size = UDim2.new(1, 0, 1, 0)
    _nm.BackgroundTransparency = 1
    _nm.Parent = topGui

    local _en = Instance.new("UIListLayout")
    _en.SortOrder = Enum.SortOrder.LayoutOrder
    _en.FillDirection = Enum.FillDirection.Vertical
    _en.HorizontalAlignment = Enum.HorizontalAlignment.Center
    _en.Padding = UDim.new(0, 2)
    _en.Parent = _nm

    
    local roleIcon = Instance.new("ImageLabel")
    roleIcon.Name = _d4vqqe({127,3,2,46,44,85,85,67},{45,108,110,75,101,54,58})
    roleIcon.LayoutOrder = 1
    roleIcon.Size = UDim2.new(0, 22, 0, 22)
    roleIcon.BackgroundTransparency = 1
    roleIcon.ScaleType = Enum.ScaleType.Fit
    roleIcon.Image = _ex.ContestantIcon
    roleIcon.Parent = _nm

    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = _d4vqqe({28,55,35,92,57,67,86,55,58},{82,86,78,57,117,34,52})
    nameLabel.LayoutOrder = 2
    nameLabel.Size = UDim2.new(1, 0, 0, 15)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 11
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextXAlignment = Enum.TextXAlignment.Center
    nameLabel.TextYAlignment = Enum.TextYAlignment.Center
    nameLabel.Text = player.DisplayName
    nameLabel.Parent = _nm

    local _oh = Instance.new("UIStroke")
    _oh.Thickness = 1.2
    _oh.Color = Color3.fromRGB(0, 0, 0)
    _oh.Transparency = 0.2
    _oh.Parent = nameLabel

    
    local _gk = Instance.new("Frame")
    _gk.Name = _d4vqqe({32,44,32,4,43,8,38,9},{98,77,82,80,89,105,69})
    _gk.LayoutOrder = 3
    _gk.Size = UDim2.new(0, 75, 0, 4)
    _gk.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    _gk.BackgroundTransparency = 0.4
    _gk.ClipsDescendants = true
    _gk.Parent = _nm

    local _ob = Instance.new("UICorner")
    _ob.CornerRadius = UDim.new(1, 0)
    _ob.Parent = _gk

    local _xd = Instance.new("UIStroke")
    _xd.Thickness = 1
    _xd.Color = Color3.fromRGB(0, 0, 0)
    _xd.Transparency = 0.3
    _xd.Parent = _gk

    local trailBar = Instance.new("Frame")
    trailBar.Name = _d4vqqe({52,84,71,4,91,22,1,84},{96,38,38,109,55,84})
    trailBar.Position = UDim2.new(0, 0, 0, 0)
    trailBar.Size = UDim2.new(1, 0, 1, 0)
    trailBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    trailBar.BackgroundTransparency = 0.25
    trailBar.BorderSizePixel = 0
    trailBar.Parent = _gk

    local _ew = Instance.new("UICorner")
    _ew.CornerRadius = UDim.new(1, 0)
    _ew.Parent = trailBar

    local fillBar = Instance.new("Frame")
    fillBar.Name = _d4vqqe({96,0,17,52,50,84,21},{38,105,125,88,112,53,103})
    fillBar.Position = UDim2.new(0, 0, 0, 0)
    fillBar.Size = UDim2.new(1, 0, 1, 0)
    fillBar.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
    fillBar.BorderSizePixel = 0
    fillBar.Parent = _gk

    local _nl = Instance.new("UICorner")
    _nl.CornerRadius = UDim.new(1, 0)
    _nl.Parent = fillBar

    topGui.Parent = _l

    
    local bottomGui = Instance.new("BillboardGui")
    bottomGui.Name = _d4vqqe({0,58,23,61,39,114,3,5,63},{80,85,96,88,85,55}) .. player.Name
    bottomGui.Size = UDim2.new(0, 155, 0, 30)
    bottomGui.StudsOffset = Vector3.new(0, -3.2, 0)
    bottomGui.AlwaysOnTop = true
    bottomGui.LightInfluence = 0
    bottomGui.MaxDistance = 200
    bottomGui.ResetOnSpawn = false
    bottomGui.Enabled = false

    local capsule = Instance.new("Frame")
    capsule.Name = _d4vqqe({44,90,82,23,26,87,71},{111,59,34,100})
    capsule.Size = UDim2.new(1, 0, 1, 0)
    capsule.BackgroundTransparency = 1
    capsule.Parent = bottomGui

    local capStroke = Instance.new("UIStroke")
    capStroke.Thickness = 1.2
    capStroke.Transparency = 1 
    capStroke.Color = Color3.fromRGB(0, 160, 255)
    capStroke.Parent = capsule

    
    local pIcon = Instance.new("ImageLabel")
    pIcon.Name = _d4vqqe({43,28,89,13,47,46,55,36,21},{123,115,46,104,93,103,84,75})
    pIcon.Size = UDim2.new(0, 26, 0, 26)
    pIcon.Position = UDim2.new(0, 2, 0.5, -13)
    pIcon.BackgroundTransparency = 1
    pIcon.ScaleType = Enum.ScaleType.Fit
    pIcon.Image = _ex.GenericPower
    pIcon.Parent = capsule

    local pLabel = Instance.new("TextLabel")
    pLabel.Name = _d4vqqe({38,24,6,78,4,35,20,83,2},{118,119,113,43})
    pLabel.Position = UDim2.new(0, 34, 0, 0)
    pLabel.Size = UDim2.new(1, -36, 1, 0)
    pLabel.BackgroundTransparency = 1
    pLabel.Font = Enum.Font.GothamBold
    pLabel.TextSize = 11
    pLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
    pLabel.TextXAlignment = Enum.TextXAlignment.Left
    pLabel.Text = _d4vqqe({101,43,32,71,71},{53,68,87,34})
    pLabel.Parent = capsule

    local _wl = Instance.new("UIStroke")
    _wl.Thickness = 1.2
    _wl.Color = Color3.fromRGB(0, 0, 0)
    _wl.Transparency = 0.2
    _wl.Parent = pLabel

    bottomGui.Parent = _l

    
    local hl = Instance.new("Highlight")
    hl.Name = _d4vqqe({9,53,5,49,71,34,93,5,50,19,34,62},{64,91,110,97,43,67,36,96}) .. player.Name
    hl.FillTransparency = 0.55
    hl.OutlineTransparency = 0.15
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.Parent = _l

    
    local _lj = Instance.new("Frame")
    _lj.Visible = false
    _lj.Parent = _nm
    local _ht = Instance.new("UIStroke")
    _ht.Parent = _lj

    local _ym = {
        topGui = topGui,
        bottomGui = bottomGui,
        hl = hl,
        headerFrame = _lj,
        headerStroke = _ht,
        roleIcon = roleIcon,
        nameLabel = nameLabel,
        fillBar = fillBar,
        trailBar = trailBar,
        capsule = capsule,
        capStroke = capStroke,
        pIcon = pIcon,
        pLabel = pLabel
    }

    _if[player] = _ym
    return _ym
end

local function updatePlayerHealthDisplay(_vm, hum)
    if not _vm or not hum then return end
    local _fw = (hum.MaxHealth and hum.MaxHealth > 0) and hum.MaxHealth or 100
    local _ho = math.clamp(hum.Health, 0, _fw)
    local _na = math.clamp(_ho / _fw, 0, 1)

    
    local _nq = Color3.fromRGB(0, 255, 140)
    if _na <= 0.25 then
        _nq = Color3.fromRGB(255, 40, 40)
    elseif _na <= 0.6 then
        _nq = Color3.fromRGB(255, 190, 0)
    end
    _vm.fillBar.BackgroundColor3 = _nq

    
    _i:Create(_vm.fillBar, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(_na, 0, 1, 0)
    }):Play()

    
    _i:Create(_vm.trailBar, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = UDim2.new(_na, 0, 1, 0)
    }):Play()
end




local function createOrGetObjectESP(_ki, _qy)
    local _l = (typeof(gethui) == "function" and gethui()) or game:GetService("CoreGui")
    local _vm = _un[_ki]
    if _vm and _vm.gui and _vm.gui.Parent then
        return _vm
    end

    local showLabel = _qy.showLabel == true
    local iconSize = _qy.iconSize or 22

    local gui = Instance.new("BillboardGui")
    gui.Name = _d4vqqe({38,86,42,99,58,100,31},{105,52,64,38}) .. _ki.Name
    gui.Size = showLabel and UDim2.new(0, 130, 0, 42) or UDim2.new(0, iconSize, 0, iconSize)
    gui.StudsOffset = Vector3.new(0, _qy.offsetY or 1.5, 0)
    gui.AlwaysOnTop = true
    gui.LightInfluence = 0
    gui.MaxDistance = _qy.maxDistance or 350
    gui.ResetOnSpawn = false
    gui.Enabled = false
    gui.Adornee = _ki:IsA("Model") and (_ki.PrimaryPart or _ki:FindFirstChildWhichIsA("BasePart")) or _ki

    local _pf = Instance.new("Frame")
    _pf.Size = UDim2.new(1, 0, 1, 0)
    _pf.BackgroundTransparency = 1
    _pf.Parent = gui

    local _bu = Instance.new("UIListLayout")
    _bu.SortOrder = Enum.SortOrder.LayoutOrder
    _bu.FillDirection = Enum.FillDirection.Vertical
    _bu.HorizontalAlignment = Enum.HorizontalAlignment.Center
    _bu.Padding = UDim.new(0, 2)
    _bu.Parent = _pf

    local icon = Instance.new("ImageLabel")
    icon.Name = _d4vqqe({51,68,24,74},{122,39,119,36,67,82,49,111})
    icon.LayoutOrder = 1
    icon.Size = UDim2.new(0, iconSize, 0, iconSize)
    icon.BackgroundTransparency = 1
    icon.ScaleType = Enum.ScaleType.Fit
    icon.Image = _qy.icon or ""
    icon.Parent = _pf

    local label = Instance.new("TextLabel")
    label.Name = _d4vqqe({47,45,75,9,15},{99,76,41,108})
    label.LayoutOrder = 2
    label.Size = UDim2.new(1, 0, 0, 15)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 10
    label.TextColor3 = _qy.textColor or Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Text = _qy.text or _ki.Name
    label.Visible = showLabel
    label.Parent = _pf

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.2
    stroke.Color = Color3.fromRGB(0, 0, 0)
    stroke.Transparency = 0.2
    stroke.Parent = label

    local _ri = Instance.new("Frame")
    _ri.Visible = false
    _ri.BackgroundTransparency = 1
    _ri.Parent = _pf

    gui.Parent = _l

    local _ur = {
        gui = gui,
        capsule = _ri,
        stroke = stroke,
        icon = icon,
        label = label
    }
    _un[_ki] = _ur
    return _ur
end

local function updateKeysESP(_xc, _ey)
    if not _f.espKeysEnabled then return end
    local _fb = {}

    local function processKey(_il)
        if not _il or not _il.Parent or _fb[_il] then return end
        if string.sub(_il.Name, 1, 10) == _d4vqqe({7,28,20,59,85,55,39,37,30,50},{67,110,123,75,37,82}) or string.find(_il.Name, "Key") then
            local _is = _il:IsA("BasePart") and _il or (_il:IsA("Model") and (_il.PrimaryPart or _il:FindFirstChildWhichIsA("BasePart")))
            if _is then
                local dist = math.floor((_is.Position - _xc).Magnitude)
                if dist <= 350 then
                    _fb[_il] = true
                    _ey[_il] = true
                    local _ue = string.lower(_il.Name)
                    local _wx = {
                        showLabel = true,
                        iconSize = 22,
                        offsetY = 1.6,
                        bgColor = Color3.fromRGB(22, 18, 10),
                        strokeColor = Color3.fromRGB(255, 215, 0),
                        textColor = Color3.fromRGB(255, 225, 80),
                        icon = _ex.KeyCircle,
                        text = "Circle Key [" .. dist .. "m]"
                    }

                    if string.find(_ue, "square") then
                        _wx.bgColor = Color3.fromRGB(10, 18, 28)
                        _wx.strokeColor = Color3.fromRGB(0, 229, 255)
                        _wx.textColor = Color3.fromRGB(100, 240, 255)
                        _wx.icon = _ex.KeySquare
                        _wx.text = _d4vqqe({55,62,11,11,94,71,80,47,42,7,74,119},{100,79,126,106,44,34,112}) .. dist .. "m]"
                    elseif string.find(_ue, "triangle") then
                        _wx.bgColor = Color3.fromRGB(28, 10, 15)
                        _wx.strokeColor = Color3.fromRGB(255, 45, 85)
                        _wx.textColor = Color3.fromRGB(255, 90, 120)
                        _wx.icon = _ex.KeyTriangle
                        _wx.text = _d4vqqe({24,88,54,72,34,77,51,76,108,97,58,80,108,113},{76,42,95,41}) .. dist .. "m]"
                    elseif string.find(_ue, "circle") then
                        _wx.bgColor = Color3.fromRGB(22, 18, 10)
                        _wx.strokeColor = Color3.fromRGB(255, 215, 0)
                        _wx.textColor = Color3.fromRGB(255, 225, 80)
                        _wx.icon = _ex.KeyCircle
                        _wx.text = _d4vqqe({35,52,19,54,63,5,125,42,48,42,64,6},{96,93,97,85,83}) .. dist .. "m]"
                    else
                        local _lz = string.gsub(_il.Name, "DroppedKey", "")
                        if _lz == "" then _lz = _il.Name end
                        _wx.text = _lz .. " [" .. dist .. "m]"
                    end

                    local _vm = createOrGetObjectESP(_il, _wx)
                    _vm.label.Text = _wx.text
                    _vm.label.TextColor3 = _wx.textColor
                    _vm.stroke.Color = _wx.strokeColor
                    _vm.icon.Image = _wx.icon
                    _vm.gui.Adornee = _is
                    _vm.gui.Enabled = true
                end
            end
        end
    end

    local _gx = _m:FindFirstChild("Effects")
    if _gx then
        for _nf, _il in ipairs(_gx:GetChildren()) do
            processKey(_il)
        end
    end
    
    for _nf, _il in ipairs(_m:GetChildren()) do
        if string.sub(_il.Name, 1, 10) == _d4vqqe({110,67,35,49,79,79,85,7,36,70},{42,49,76,65,63}) then
            processKey(_il)
        end
    end
end

local function updateExitDoorsESP(_xc, _ey)
    if not _f.espExitDoorsEnabled then return end
    local _eq = _m:FindFirstChild("HideAndSeekMap")
    if not _eq then return end

    local _bt = {}
    local function processDoor(_ei)
        if not _ei or not _ei.Parent or _bt[_ei] then return end
        if string.find(string.upper(_ei.Name), "EXITDOOR") or string.find(string.upper(_ei.Name), "EXIT") then
            local _is = _ei:IsA("BasePart") and _ei or (_ei:IsA("Model") and (_ei.PrimaryPart or _ei:FindFirstChildWhichIsA("BasePart")))
            if _is then
                local dist = math.floor((_is.Position - _xc).Magnitude)
                if dist <= 350 then
                    _bt[_ei] = true
                    _ey[_ei] = true
                    local _kb = {
                        showLabel = false,
                        iconSize = 22,
                        offsetY = 3.5,
                        bgColor = Color3.fromRGB(10, 25, 18),
                        strokeColor = Color3.fromRGB(0, 255, 140),
                        textColor = Color3.fromRGB(80, 255, 180),
                        icon = _ex.ExitDoor,
                        text = "ESCAPE EXIT [" .. dist .. "m]"
                    }
                    local _vm = createOrGetObjectESP(_ei, _kb)
                    _vm.label.Text = _kb.text
                    _vm.label.TextColor3 = _kb.textColor
                    _vm.stroke.Color = _kb.strokeColor
                    _vm.capsule.BackgroundColor3 = _kb.bgColor
                    _vm.icon.Image = _kb.icon
                    _vm.gui.Adornee = _is
                    _vm.gui.Enabled = true
                end
            end
        end
    end

    local _ft = _eq:FindFirstChild("NEWFIXEDDOORS")
    local _jq = _ft and _ft:FindFirstChild("Floor1")
    local _xq = _jq and _jq:FindFirstChild("EXITDOORS")

    if _xq then
        for _nf, _ei in ipairs(_xq:GetChildren()) do
            processDoor(_ei)
        end
    end
    
    if next(_bt) == nil then
        for _nf, _ve in ipairs(_eq:GetDescendants()) do
            if string.upper(_ve.Name) == _d4vqqe({23,31,21,3,38,11,116,0},{82,71,92,87,98,68,59}) then
                processDoor(_ve)
            end
        end
    end
end

local _rw = {
    drops = true, items = true, pickups = true, loot = true, weapons = true, dropped = true
}
local _qw = {
    revolver = true, baton = true, submachine = true, pistol = true,
    rifle = true, shotgun = true, knife = true, firearm = true,
    smg = true, glock = true, ak47 = true, mp5 = true, m4a1 = true, crowbar = true
}
local _oj = {
    bandage = true, bandages = true, medkit = true, medbag = true, firstaid = true
}
local _do = {
    "revolver", "gun", "baton", "submachine", "pistol", "rifle", "shotgun", "knife", "weapon", "mp5", "smg", "ammo", "bat"
}
local _fq = {
    "bandage", "medkit", "medbag", "firstaid", "heal"
}

local _zk = {}
local _jh = 0

local function hasHumanoidAncestor(inst)
    local _zd = inst
    while _zd and _zd ~= _m do
        if _zd:IsA("Model") and (_z:GetPlayerFromCharacter(_zd) or _zd:FindFirstChildOfClass("Humanoid")) then
            return true
        end
        _zd = _zd.Parent
    end
    return false
end

local function tokenizeItemName(name)
    if type(name) ~= _d4vqqe({67,51,94,61,94,32},{48,71,44,84}) then return {} end
    local _gw = string.gsub(name, "([%l])([%u])", "%1 %2")
    _gw = string.gsub(_gw, "([%u])([%u][%l])", "%1 %2")
    local _as = {}
    for _yu in string.gmatch(string.lower(_gw), "[%a%d]+") do
        _as[_yu] = true
    end
    return _as
end

local function matchesStrictTokens(_as, _lm)
    for _yu in pairs(_as) do
        if _lm[_yu] then
            return true
        end
        local _xw = string.match(_yu, "^(%a%a%a+)%d+$")
        if _xw and _lm[_xw] then
            return true
        end
    end
    return false
end

local function matchesAnySubstr(_gd, _sl)
    for _nf, sub in ipairs(_sl) do
        if string.find(_gd, sub, 1, true) then
            return true
        end
    end
    return false
end

local function classifyItemInstance(inst, _mz)
    if not inst or not inst.Parent then return nil end
    if hasHumanoidAncestor(inst) then return nil end

    if inst:FindFirstChild("GunScript") or inst:FindFirstChild("InfoClient") or inst:FindFirstChild("Gun") then
        return _d4vqqe({4,35,56,5,67,63},{115,70,89,117,44,81})
    end

    local _as = tokenizeItemName(inst.Name)
    if matchesStrictTokens(_as, _qw) then
        return _d4vqqe({20,13,32,70,69,18},{99,104,65,54,42,124})
    end
    if matchesStrictTokens(_as, _oj) or (_as.first and _as.aid) or (_as.med and _as.kit) then
        return _d4vqqe({6,53,50,72,86,33,3},{100,84,92,44,55,70,102})
    end

    local _ra = _mz or inst:IsA("Tool") or (inst:FindFirstChild("Handle") ~= nil)
    if _ra then
        local _gd = string.lower(inst.Name)
        if matchesAnySubstr(_gd, _do) then
            return _d4vqqe({4,90,94,11,42,9},{115,63,63,123,69,103,62,56})
        elseif matchesAnySubstr(_gd, _fq) then
            return _d4vqqe({73,76,16,58,68,12,89},{43,45,126,94,37,107,60})
        end
    end

    return nil
end

local function rebuildItemCandidates()
    table.clear(_zk)
    local _fk = {}

    local function tryAddCandidate(inst, _mz)
        if not inst or _fk[inst] then return end
        if not (inst:IsA("Tool") or inst:IsA("Model") or inst:IsA("BasePart")) then return end

        local _sk = inst.Parent
        while _sk and _sk ~= _m do
            if _fk[_sk] then return end
            _sk = _sk.Parent
        end

        local kind = classifyItemInstance(inst, _mz)
        if kind then
            _fk[inst] = true
            table.insert(_zk, { inst = inst, kind = kind })
        end
    end

    for _nf, _yv in ipairs(_m:GetChildren()) do
        if _rw[normalizeGameName(_yv.Name)] then
            for _nf, _ve in ipairs(_yv:GetDescendants()) do
                tryAddCandidate(_ve, true)
            end
        else
            tryAddCandidate(_yv, false)
        end
    end

    local _yq = _m:FindFirstChild("Effects")
    if _yq then
        for _nf, _ve in ipairs(_yq:GetDescendants()) do
            local _jw = _ve.Parent ~= nil and _rw[normalizeGameName(_ve.Parent.Name)] or false
            tryAddCandidate(_ve, _jw)
        end
    end
end

local function updateItemsESP(_xc, _ey)
    if not _f.espItemsEnabled then return end

    local _ni = tick()
    if (_ni - _jh) >= 0.6 then
        _jh = _ni
        rebuildItemCandidates()
    end

    for _nf, itemEntry in ipairs(_zk) do
        local inst = itemEntry.inst
        if inst and inst.Parent and inst:IsDescendantOf(_m) then
            local _is = inst:IsA("BasePart") and inst
                or (inst:IsA("Model") and (inst.PrimaryPart or inst:FindFirstChild("Handle") or inst:FindFirstChildWhichIsA("BasePart", true)))
                or (inst:IsA("Tool") and (inst:FindFirstChild("Handle") or inst:FindFirstChildWhichIsA("BasePart", true)))
            if _is then
                local dist = math.floor((_is.Position - _xc).Magnitude)
                if dist <= 450 then
                    _ey[inst] = true
                    local _oy = (itemEntry.kind == "weapon") and {
                        showLabel = false,
                        iconSize = 22,
                        offsetY = 1.4,
                        maxDistance = 500,
                        bgColor = Color3.fromRGB(26, 16, 12),
                        strokeColor = Color3.fromRGB(255, 120, 40),
                        textColor = Color3.fromRGB(255, 160, 80),
                        icon = _ex.DroppedWeapon,
                        text = ""
                    } or {
                        showLabel = false,
                        iconSize = 22,
                        offsetY = 1.2,
                        maxDistance = 500,
                        bgColor = Color3.fromRGB(10, 25, 20),
                        strokeColor = Color3.fromRGB(0, 245, 160),
                        textColor = Color3.fromRGB(80, 255, 190),
                        icon = _ex.DroppedBandage,
                        text = ""
                    }

                    local _vm = createOrGetObjectESP(inst, _oy)
                    _vm.label.Text = _oy.text
                    _vm.label.TextColor3 = _oy.textColor
                    _vm.stroke.Color = _oy.strokeColor
                    _vm.capsule.BackgroundColor3 = _oy.bgColor
                    _vm.icon.Image = _oy.icon
                    _vm.gui.MaxDistance = _oy.maxDistance
                    _vm.gui.Adornee = _is
                    _vm.gui.Enabled = true
                end
            end
        end
    end
end

local function refreshAllWorldObjects(_xc)
    local _ey = {}
    updateKeysESP(_xc, _ey)
    updateExitDoorsESP(_xc, _ey)
    updateItemsESP(_xc, _ey)

    for inst, _vm in pairs(_un) do
        local _pa = inst.Parent ~= nil and inst:IsDescendantOf(_m)
        if not _ey[inst] or not _pa then
            if _vm.gui then _vm.gui.Enabled = false end
            if not _pa then
                if _vm.gui then _vm.gui:Destroy() end
                _un[inst] = nil
            end
        end
    end
end

local _yw = 0
local function refreshESP()
    local _ni = tick()
    if _ni - _yw < 0.08 then return end
    _yw = _ni

    local _jv = _m.CurrentCamera or _q
    local _ps = _o.Character
    local hrp = _ps and _ps:FindFirstChild("HumanoidRootPart")
    if not _jv or not hrp then
        for _nf, _vm in pairs(_if) do
            if _vm.topGui then _vm.topGui.Enabled = false end
            if _vm.bottomGui then _vm.bottomGui.Enabled = false end
            if _vm.hl then _vm.hl.Enabled = false end
        end
        for _nf, _vm in pairs(_un) do
            if _vm.gui then _vm.gui.Enabled = false end
        end
        return
    end

    local _xc = hrp.Position

    
    refreshAllWorldObjects(_xc)

    
    local _te = {}

    for _nf, _qp in ipairs(_z:GetPlayers()) do
        if _qp ~= _o and _qp.Character then
            local _tz = _qp.Character:FindFirstChild("HumanoidRootPart")
            local _eo = _qp.Character:FindFirstChildOfClass("Humanoid")
            if _tz and _eo and _eo.Health > 0 then
                local dist = math.floor((_tz.Position - _xc).Magnitude)
                if dist <= 300 then
                    table.insert(_te, { player = _qp, hrp = _tz, hum = _eo, dist = dist })
                end
            end
        end
    end

    table.sort(_te, function(_sa, _di) return _sa.dist < _di.dist end)

    local _hv = {}
    local _pb = math.min(#_te, 25)

    for _gr = 1, _pb do
        local _hb = _te[_gr]
        local _qp = _hb.player
        _hv[_qp] = true

        local _vm = createOrGetESP(_qp)
        local _ps = _qp.Character
        local _xo = _ps and _ps:FindFirstChild("Head")
        _vm.topGui.Adornee = _xo or _hb.hrp
        _vm.bottomGui.Adornee = _hb.hrp

        
        if _f.playerEspEnabled then
            local _wy = isPlayerHunter(_qp)
            local _tw = isPlayerGuard(_qp)

            if _wy then
                _vm.roleIcon.Image = _ex.HunterSkull
                _vm.nameLabel.Text = _qp.DisplayName .. " [" .. _hb.dist .. "m]"
                _vm.nameLabel.TextColor3 = Color3.fromRGB(255, 60, 70)
                if _vm.hl then
                    _vm.hl.Adornee = _ps
                    _vm.hl.FillColor = Color3.fromRGB(255, 20, 30)
                    _vm.hl.Enabled = true
                end
            elseif _tw then
                _vm.roleIcon.Image = _ex.GuardIcon
                _vm.nameLabel.Text = _qp.DisplayName .. " [" .. _hb.dist .. "m]"
                _vm.nameLabel.TextColor3 = Color3.fromRGB(255, 75, 95)
                if _vm.hl then
                    _vm.hl.Adornee = _ps
                    _vm.hl.FillColor = Color3.fromRGB(255, 30, 50)
                    _vm.hl.Enabled = true
                end
            else
                _vm.roleIcon.Image = _ex.ContestantIcon
                _vm.nameLabel.Text = _qp.DisplayName .. " [" .. _hb.dist .. "m]"
                _vm.nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                if _vm.hl then
                    _vm.hl.Adornee = _ps
                    _vm.hl.FillColor = _qp.TeamColor and _qp.TeamColor.Color or Color3.fromRGB(0, 160, 255)
                    _vm.hl.Enabled = true
                end
            end
            updatePlayerHealthDisplay(_vm, _hb.hum)
            _vm.topGui.Enabled = true
        else
            _vm.topGui.Enabled = false
            if _vm.hl then _vm.hl.Enabled = false end
        end

        
        if _f.espPowersEnabled then
            local _pr = getPlayerPower(_qp)
            local _iv = resolvePowerInfo(_pr)
            if _iv then
                _vm.pIcon.Image = _iv.icon
                _vm.pLabel.Text = _iv.name
                _vm.pLabel.TextColor3 = _iv.color
                _vm.capStroke.Color = _iv.glowColor
                _vm.bottomGui.Enabled = true
            else
                _vm.bottomGui.Enabled = false
            end
        else
            _vm.bottomGui.Enabled = false
        end
    end

    
    for _qp, _vm in pairs(_if) do
        if not _hv[_qp] then
            if _vm.topGui then _vm.topGui.Enabled = false end
            if _vm.bottomGui then _vm.bottomGui.Enabled = false end
            if _vm.hl then _vm.hl.Enabled = false end
        end
    end
end

local function hookPlayerSignals(player)
    local function onCharAdded(_ps)
        local hum = _ps:WaitForChild("Humanoid", 5)
        if hum then
            table.insert(_c, hum.HealthChanged:Connect(function()
                if _f.playerEspEnabled and _if[player] then
                    updatePlayerHealthDisplay(_if[player], hum)
                end
            end))
        end
    end

    if player.Character then
        task.spawn(onCharAdded, player.Character)
    end
    table.insert(_c, player.CharacterAdded:Connect(onCharAdded))
end

for _nf, _qp in ipairs(_z:GetPlayers()) do
    if _qp ~= _o then
        hookPlayerSignals(_qp)
    end
end

table.insert(_c, _z.PlayerAdded:Connect(function(_qp)
    if _qp ~= _o then
        hookPlayerSignals(_qp)
    end
end))

table.insert(_c, _z.PlayerRemoving:Connect(function(_qp)
    local _vm = _if[_qp]
    if _vm then
        if _vm.topGui then _vm.topGui:Destroy() end
        if _vm.bottomGui then _vm.bottomGui:Destroy() end
        if _vm.hl then _vm.hl:Destroy() end
        _if[_qp] = nil
    end
end))

local _nj = nil
local function startESPThread()
    if not _nj then
        _nj = _x.RenderStepped:Connect(function()
            if _f.playerEspEnabled or _f.espPowersEnabled or _f.espKeysEnabled or _f.espExitDoorsEnabled or _f.espItemsEnabled then
                refreshESP()
            end
        end)
        table.insert(_c, _nj)
    end
end


startESPThread()

_mr:CreateToggle("Player ESP", "Displays role badge (Guard/Hunter/Contestant), distance & ghost health bar", false, function(enabled)
    _f.playerEspEnabled = enabled
    startESPThread()
    if not enabled then
        for _nf, _vm in pairs(_if) do
            if _vm.topGui then _vm.topGui.Enabled = false end
            if _vm.hl then _vm.hl.Enabled = false end
        end
    else
        refreshESP()
    end
end)

_mr:CreateToggle("ESP Powers", "Displays equipped power ability pill capsule below players", false, function(enabled)
    _f.espPowersEnabled = enabled
    startESPThread()
    if not enabled then
        for _nf, _vm in pairs(_if) do
            if _vm.bottomGui then _vm.bottomGui.Enabled = false end
        end
    else
        refreshESP()
    end
end)

_mr:CreateToggle("ESP Keys", "Displays badges with icons and distance above dropped keys (Circle/Square/Triangle)", false, function(enabled)
    _f.espKeysEnabled = enabled
    startESPThread()
    if not enabled then
        for inst, _vm in pairs(_un) do
            if string.sub(inst.Name, 1, 10) == "DroppedKey" and _vm.gui then
                _vm.gui.Enabled = false
            end
        end
    else
        refreshESP()
    end
end)

_mr:CreateToggle("ESP Exit Doors", "Displays glowing escape exit door markers in Hide & Seek", false, function(enabled)
    _f.espExitDoorsEnabled = enabled
    startESPThread()
    if not enabled then
        for inst, _vm in pairs(_un) do
            if string.find(string.upper(inst.Name), "EXIT") and _vm.gui then
                _vm.gui.Enabled = false
            end
        end
    else
        refreshESP()
    end
end)

_mr:CreateToggle("ESP Weapons & Items", "Displays ground weapon and bandage drops with distance", false, function(enabled)
    _f.espItemsEnabled = enabled
    _jh = 0
    if not enabled then
        table.clear(_zk)
        for inst, _vm in pairs(_un) do
            if string.sub(inst.Name, 1, 10) ~= "DroppedKey" and not string.find(string.upper(inst.Name), "EXIT") and _vm.gui then
                _vm.gui.Enabled = false
            end
        end
    else
        startESPThread()
        refreshESP()
    end
end)






local _jb = _xf:CreateTab("Utilities", "Wrench")




local _ow = _jb:CreateCategory("Performance & Protection", true, 1)



_ow:CreateToggle("Instant Interact", "Bypasses proximity prompt hold times", false, function(enabled)
    _f.instantInteractEnabled = enabled
    if enabled then
        if not _s.interactConn then
            _s.interactConn = _b.PromptButtonHoldBegan:Connect(function(_cx, player)
                if _f.instantInteractEnabled and player == _o then
                    _cx.HoldDuration = 0
                    pcall(fireproximityprompt, _cx)
                end
            end)
        end
    elseif _s.interactConn then
        _s.interactConn:Disconnect()
        _s.interactConn = nil
    end
end)

_ow:CreateToggle("FPS Booster & Anti Lag", "Disables global shadows, reflections, and particles", false, function(enabled)
    _f.fpsBoosterEnabled = enabled
    if enabled then
        _d.GlobalShadows = false
        _d.FogEnd = 9e9
        for _nf, _rn in ipairs(_m:GetDescendants()) do
            if _rn:IsA("ParticleEmitter") or _rn:IsA("Trail") or _rn:IsA("Smoke") or _rn:IsA("Fire") then
                _rn.Enabled = false
            end
        end
        notify("FPS Booster", "Shadows & particles stripped.")
    else
        _d.GlobalShadows = true
    end
end)






local _xt = _xf:CreateSettingsTab("Settings", "Settings", {
    OnThemeSelected = function(themeName)
        _f.themeName = themeName
        updateFovCircleColor(getGuiThemeAccent())
        notify("Theme", "Theme set to: " .. themeName)
    end,
    OnTransparencyChanged = function(_oa)
        notify("Window", "Transparency updated: " .. tostring(math.floor(_oa)) .. "%")
    end
})


_xf:Initialize()
notify("Syntaxis", "Syntaxis loaded securely! Press orb to toggle.", 5)
