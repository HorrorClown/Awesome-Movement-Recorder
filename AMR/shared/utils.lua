--
-- PewX (HorrorClown)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 20.08.2015 - Time: 06:18
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
iDEBUG = true

if CLIENT then
    x, y = guiGetScreenSize()

    function isHover(startX, startY, width, height)
        if isCursorShowing() then
            local pos = {getCursorPosition()}
            return (x*pos[1] >= startX) and (x*pos[1] <= startX + width) and (y*pos[2] >= startY) and (y*pos[2] <= startY + height)
        end
        return false
    end

    --FPS
    local st, counter = getTickCount(), 0
    FPS = 0
    addEventHandler("onClientRender", root,
        function()
            counter = counter + 1
            if getTickCount() - st >= 1000 then
                if FPS ~= counter then
                    FPS = counter
                    Core:getManager("CAMRManager").gui:updateRenderTarget()
                end

                counter = 0
                st = getTickCount()
            end
        end
    )

    function msToTimeString(ms)
        if not ms then return '' end
        return string.format("%01d:%02d:%03d", ms/1000/60, math.fmod(ms/1000, 60), math.fmod(ms, 1000))
    end
end

function toboolean(x)
    if x == "true" or x == 1 or x == "1" or x == true then
        return true
    elseif x == "false" or x == 0 or x == "0" or x == false then
        return false
    end
    return false
end

function debugOutput(sText, nType, cr, cg, cb)
    if iDEBUG then
        outputDebugString(("[%s] %s"):format(SERVER and "Server" or "Client", tostring(sText)), nType or 3, cr, cg, cb)
    end
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end