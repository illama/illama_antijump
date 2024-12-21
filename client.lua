local lastJumpTime = 0
local jumpDisabled = false

-- Configuration pour le délai minimum entre les sauts (en millisecondes)
local MinimumJumpDelay = 10000 -- Délai de 1,5 seconde entre les sauts

-- Fonction pour obtenir la vitesse du joueur
local function GetPlayerSpeed()
    local ped = PlayerPedId()
    local vx, vy, vz = table.unpack(GetEntityVelocity(ped))
    return math.sqrt(vx * vx + vy * vy + vz * vz)
end

-- Fonction pour notifier le joueur
local function NotifyPlayer(message)
    if Config.EnableNotifications then
        ESX.ShowNotification(message)
    else
        print(message) -- Affiche dans la console pour débogage
    end
end

-- Thread principal pour gérer le délai de saut
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local isRunning = IsPedRunning(ped)
        local isInVehicle = IsPedInAnyVehicle(ped, false)
        local isClimbing = IsPedClimbing(ped)

        -- Si le joueur est en course et pas dans un véhicule
        if not isInVehicle and isRunning then
            if IsControlJustPressed(0, 22) then -- Touche de saut pressée
                local currentTime = GetGameTimer()
                
                -- Vérifie si le joueur est en train de grimper
                if isClimbing then
                    jumpDisabled = false -- Permet la touche de saut pour grimper
                elseif currentTime - lastJumpTime >= MinimumJumpDelay then
                    lastJumpTime = currentTime
                    jumpDisabled = false -- Permet le saut normal
                else
                    jumpDisabled = true
                    NotifyPlayer("Attendez avant de pouvoir sauter à nouveau")
                    
                    -- Planifie la réactivation du saut après le délai défini
                    Citizen.SetTimeout(MinimumJumpDelay, function()
                        jumpDisabled = false
                    end)
                end
            end
        end

        -- Désactiver le saut seulement si jumpDisabled est vrai et le joueur ne grimpe pas
        if jumpDisabled and not isClimbing then
            DisableControlAction(0, 22, true) -- Désactive la touche de saut (ESPACE)
        end

        Citizen.Wait(0)
    end
end)

-- Vérification supplémentaire pour les ragdolls et animations
AddEventHandler('gameEventTriggered', function(name, args)
    if jumpDisabled and (name == "CEventNetworkStartJump" or name == "CEventStartJump") then
        CancelEvent()
    end
end)
