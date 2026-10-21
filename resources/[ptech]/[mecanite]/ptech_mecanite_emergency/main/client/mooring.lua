local vehicleConfigs = {}
local states = {}

for modelName, vehicleConfig in pairs(Config.Vehicles) do
    if vehicleConfig.Mooring and vehicleConfig.Mooring.Enabled then
        vehicleConfigs[joaat(modelName)] = vehicleConfig.Mooring
    end
end

local function hasOccupant(vehicle)
    if GetPedInVehicleSeat(vehicle, -1) ~= 0 then
        return true
    end

    for seat = 0, GetVehicleMaxNumberOfPassengers(vehicle) - 1 do
        if GetPedInVehicleSeat(vehicle, seat) ~= 0 then
            return true
        end
    end

    return false
end

local function hasPhysicsControl(vehicle)
    if not NetworkGetEntityIsNetworked(vehicle) then
        return true
    end

    if NetworkHasControlOfEntity(vehicle) then
        return true
    end

    NetworkRequestControlOfEntity(vehicle)
    return false
end

local function horizontalSpeed(velocity)
    return math.sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
end

local function horizontalDistance(first, second)
    local x = first.x - second.x
    local y = first.y - second.y
    return math.sqrt((x * x) + (y * y))
end

local function updateMooring(vehicle, config, now)
    if hasOccupant(vehicle) or (config.OnlyWhenInWater and not IsEntityInWater(vehicle)) then
        states[vehicle] = nil
        return
    end

    if not hasPhysicsControl(vehicle) then
        return
    end

    local position = GetEntityCoords(vehicle)
    local velocity = GetEntityVelocity(vehicle)
    local speed = horizontalSpeed(velocity)
    local state = states[vehicle]

    if not state then
        states[vehicle] = {
            armedAt = now,
            lastPosition = position,
        }
        return
    end

    local moved = horizontalDistance(position, state.lastPosition)
    state.lastPosition = position

    -- 強い衝突や押し出しが起きた車両には一切の減衰をかけず、自由に動かす。
    if speed >= config.ReleaseSpeedMps or moved >= config.ReleaseDistanceM then
        state.armedAt = nil
        state.releaseUntil = now + config.ReleaseCooldownMs
        return
    end

    if state.releaseUntil then
        if now < state.releaseUntil then
            return
        end

        state.releaseUntil = nil
        state.armedAt = now
    end

    if speed > config.PassiveDriftSpeedMps then
        state.armedAt = now
        return
    end

    if now - state.armedAt < config.ArmDelayMs then
        return
    end

    -- Z速度は保ち、水上の浮力・沈み込みには干渉しない。座標固定や衝突設定の変更もしない。
    SetEntityVelocity(
        vehicle,
        velocity.x * config.PassiveVelocityMultiplier,
        velocity.y * config.PassiveVelocityMultiplier,
        velocity.z
    )
end

CreateThread(function()
    while true do
        local now = GetGameTimer()
        local activeVehicles = {}
        local shortestInterval = 500

        for _, vehicle in ipairs(GetGamePool('CVehicle')) do
            local config = vehicleConfigs[GetEntityModel(vehicle)]
            if config then
                activeVehicles[vehicle] = true
                shortestInterval = math.min(shortestInterval, config.ScanIntervalMs)
                updateMooring(vehicle, config, now)
            end
        end

        for vehicle in pairs(states) do
            if not activeVehicles[vehicle] or not DoesEntityExist(vehicle) then
                states[vehicle] = nil
            end
        end

        Wait(shortestInterval)
    end
end)
