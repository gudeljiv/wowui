local E, L, V, P, G = unpack(ElvUI)
local BL = E:GetModule('Blizzard')

local _G = _G
local hooksecurefunc = hooksecurefunc
local GetVehicleUIIndicator = GetVehicleUIIndicator
local GetVehicleUIIndicatorSeat = GetVehicleUIIndicatorSeat

local function SetPosition(_, _, relativeTo)
	local mover = _G.VehicleSeatIndicator.mover
	if mover and relativeTo ~= mover then
		_G.VehicleSeatIndicator:ClearAllPoints()
		_G.VehicleSeatIndicator:Point('TOPLEFT', mover, 'TOPLEFT', 0, 0)
	end
end

local function VehicleSetUp(vehicleID)
	local size = E.db.general.vehicleSeatIndicatorSize
	_G.VehicleSeatIndicator:Size(size)

	if not vehicleID then return end

	local _, numIndicators = GetVehicleUIIndicator(vehicleID)
	if numIndicators then
		local fourth = size * 0.25

		for i = 1, numIndicators do
			local button = _G['VehicleSeatIndicatorButton'..i]
			button:Size(fourth)

			local _, xOffset, yOffset = GetVehicleUIIndicatorSeat(vehicleID, i)
			button:ClearAllPoints()
			button:Point('CENTER', button:GetParent(), 'TOPLEFT', xOffset * size, -yOffset * size)
		end
	end
end

function BL:UpdateVehicleFrame()
	VehicleSetUp(_G.VehicleSeatIndicator.currSkin)
end

function BL:PositionVehicleFrame()
	local indicator = _G.VehicleSeatIndicator
	if not indicator.PositionVehicleFrameHooked then
		hooksecurefunc(indicator, 'SetPoint', SetPosition)
		hooksecurefunc('VehicleSeatIndicator_SetUpVehicle', VehicleSetUp)

		indicator:ClearAllPoints()
		indicator:SetPoint('TOPRIGHT', _G.MinimapCluster, 'BOTTOMRIGHT', 0, 0)
		indicator:Size(E.db.general.vehicleSeatIndicatorSize)

		E:CreateMover(indicator, 'VehicleSeatMover', L["Vehicle Seat Frame"], nil, nil, nil, nil, nil, 'general,blizzUIImprovements')
		indicator.PositionVehicleFrameHooked = true
	end

	BL:UpdateVehicleFrame()

	if E.Retail and E.private.actionbar.enable then -- fix a taint when actionbars in use
		indicator.UnloadTextures = function(frame) -- removes UIParent_ManageFramePositions()
			frame.BackgroundTexture:SetTexture()
			frame.currSkin = nil

			frame:HideButtons()
			frame:UpdateShownState()

			_G.DurabilityFrame:SetAlerts()
		end
	end
end
