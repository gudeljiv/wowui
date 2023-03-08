local _, UZwrCapGTsLE = ...
local fNVhVZpcGHGjsBK = LibStub('DRList-1.0')
local function FBoxrvKWGTIeqg(timestamp, EVENT, DestGUID, pkgmEwFUkbvzJgU, spellID)
	if bit.band(pkgmEwFUkbvzJgU, COMBATLOG_OBJECT_REACTION_HOSTILE) or bit.band(pkgmEwFUkbvzJgU, COMBATLOG_OBJECT_REACTION_NEUTRAL) then
		local JtWUNOWcjuAwMl = fNVhVZpcGHGjsBK:GetCategoryBySpellID(spellID)
		if JtWUNOWcjuAwMl and (fNVhVZpcGHGjsBK:IsPvECategory(JtWUNOWcjuAwMl) or bit.band(pkgmEwFUkbvzJgU, COMBATLOG_OBJECT_TYPE_PLAYER) or bit.band(pkgmEwFUkbvzJgU, COMBATLOG_OBJECT_CONTROL_PLAYER)) then
			local AFrZpwZutNBUMlA = UZwrCapGTsLE.UUoJyMyHvacI[DestGUID]
			if not AFrZpwZutNBUMlA then
				AFrZpwZutNBUMlA = {}
			end
			if not AFrZpwZutNBUMlA.CDFMqgBeepsrM then
				AFrZpwZutNBUMlA.CDFMqgBeepsrM = {}
			end
			local CDFMqgBeepsrM = AFrZpwZutNBUMlA.CDFMqgBeepsrM[JtWUNOWcjuAwMl]
			if EVENT == 'SPELL_AURA_BROKEN' or EVENT == 'SPELL_AURA_BROKEN_SPELL' then
				if CDFMqgBeepsrM then
					CDFMqgBeepsrM.brokenTime = timestamp + 1.3
				end
				return
			end
			if EVENT == 'SPELL_AURA_APPLIED' or (EVENT == 'SPELL_AURA_REFRESH' and timestamp > (CDFMqgBeepsrM and CDFMqgBeepsrM.brokenTime or 0)) then
				if CDFMqgBeepsrM and CDFMqgBeepsrM.xbdNVOgNrNeatm < timestamp then
					CDFMqgBeepsrM.diminished = 100
					CDFMqgBeepsrM.application = 0
					CDFMqgBeepsrM.xbdNVOgNrNeatm = 0
					CDFMqgBeepsrM.brokenTime = 0
				end
				if not CDFMqgBeepsrM then
					AFrZpwZutNBUMlA.CDFMqgBeepsrM[JtWUNOWcjuAwMl] = {
						application = 1,
						diminished = fNVhVZpcGHGjsBK:GetNextDR(1, JtWUNOWcjuAwMl) * 100,
						xbdNVOgNrNeatm = timestamp + fNVhVZpcGHGjsBK:GetResetTime(JtWUNOWcjuAwMl),
						brokenTime = 0
					}
				else
					if CDFMqgBeepsrM.diminished and CDFMqgBeepsrM.diminished ~= 0 then
						CDFMqgBeepsrM.application = CDFMqgBeepsrM.application + 1
						CDFMqgBeepsrM.diminished = fNVhVZpcGHGjsBK:GetNextDR(CDFMqgBeepsrM.application, JtWUNOWcjuAwMl) * 100
						CDFMqgBeepsrM.xbdNVOgNrNeatm = timestamp + fNVhVZpcGHGjsBK:GetResetTime(JtWUNOWcjuAwMl)
						CDFMqgBeepsrM.brokenTime = 0
					end
				end
				CDFMqgBeepsrM = CDFMqgBeepsrM or AFrZpwZutNBUMlA.CDFMqgBeepsrM[JtWUNOWcjuAwMl]
			end
		end
	end
end
function UZwrCapGTsLE.XtVUEsBNTtLmdDl(unitID, JtWUNOWcjuAwMl)
	local sfXZWsWMGRyOEId = UnitGUID(unitID)
	local CDFMqgBeepsrM = UZwrCapGTsLE.UUoJyMyHvacI[sfXZWsWMGRyOEId] and UZwrCapGTsLE.UUoJyMyHvacI[sfXZWsWMGRyOEId].CDFMqgBeepsrM and UZwrCapGTsLE.UUoJyMyHvacI[sfXZWsWMGRyOEId].CDFMqgBeepsrM[JtWUNOWcjuAwMl]
	if CDFMqgBeepsrM and CDFMqgBeepsrM.xbdNVOgNrNeatm and CDFMqgBeepsrM.xbdNVOgNrNeatm >= GetTime() then
		return CDFMqgBeepsrM.application
	end
	return 0
end
function UZwrCapGTsLE.QFVkKliWKllaex()
	local STkFNpecLvtmUZj = 0
	local fNVhVZpcGHGjsBK = {'root', 'stun', 'disorient', 'silence', 'incapacitate'}
	for i, drname in pairs(fNVhVZpcGHGjsBK) do
		STkFNpecLvtmUZj = UZwrCapGTsLE.XtVUEsBNTtLmdDl('target', drname) < 9 and UZwrCapGTsLE.XtVUEsBNTtLmdDl('target', drname) or 9
		STkFNpecLvtmUZj = UZwrCapGTsLE.XtVUEsBNTtLmdDl('mouseover', drname) < 9 and (UZwrCapGTsLE.XtVUEsBNTtLmdDl('mouseover', drname) * 10 + STkFNpecLvtmUZj) or (90 + STkFNpecLvtmUZj)
		STkFNpecLvtmUZj = UZwrCapGTsLE.XtVUEsBNTtLmdDl('focus', drname) < 9 and (UZwrCapGTsLE.XtVUEsBNTtLmdDl('focus', drname) * 100 + STkFNpecLvtmUZj) or (900 + STkFNpecLvtmUZj)
		STkFNpecLvtmUZj = UZwrCapGTsLE.XtVUEsBNTtLmdDl('arena1', drname) < 9 and (UZwrCapGTsLE.XtVUEsBNTtLmdDl('arena1', drname) * 1000 + STkFNpecLvtmUZj) or (9000 + STkFNpecLvtmUZj)
		STkFNpecLvtmUZj = UZwrCapGTsLE.XtVUEsBNTtLmdDl('arena2', drname) < 9 and (UZwrCapGTsLE.XtVUEsBNTtLmdDl('arena2', drname) * 10000 + STkFNpecLvtmUZj) or (90000 + STkFNpecLvtmUZj)
		STkFNpecLvtmUZj = UZwrCapGTsLE.XtVUEsBNTtLmdDl('arena3', drname) < 9 and (UZwrCapGTsLE.XtVUEsBNTtLmdDl('arena3', drname) * 100000 + STkFNpecLvtmUZj) or (900000 + STkFNpecLvtmUZj)
		UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.dkHYwLPujaIfX[i], STkFNpecLvtmUZj)
	end
end
UZwrCapGTsLE.cYArJZtVpaGeJh = {
	'STUN_MECHANIC',
	'DISARM',
	'PACIFYSILENCE',
	'ROOT',
	'FEAR_MECHANIC',
	'SILENCE',
	'CHARM_MECHANIC',
	'CONFUSE',
	'POSSESS_MECHANIC',
	'SCHOOL_INTERRUPT',
	'PACIFY'
}
UZwrCapGTsLE.uYDhplKOyGrZEy = {xTJMOjGqdhFq = 0, PmNxbkRsimEpTEg = 0, oDaIDJiRNPwVBUl = 0}
function UZwrCapGTsLE.UbrfABpYRDwv(frame, STkFNpecLvtmUZj, Debug)
	if UZwrCapGTsLE.ZjaXqpeXRqjxhp[frame:GetName()] ~= STkFNpecLvtmUZj then
		UZwrCapGTsLE.ZjaXqpeXRqjxhp[frame:GetName()] = STkFNpecLvtmUZj
		UZwrCapGTsLE.uYDhplKOyGrZEy.xTJMOjGqdhFq, UZwrCapGTsLE.uYDhplKOyGrZEy.PmNxbkRsimEpTEg, UZwrCapGTsLE.uYDhplKOyGrZEy.oDaIDJiRNPwVBUl = VlpDEWtOqXBff(STkFNpecLvtmUZj)
		frame.t:SetColorTexture(UZwrCapGTsLE.uYDhplKOyGrZEy.xTJMOjGqdhFq, UZwrCapGTsLE.uYDhplKOyGrZEy.PmNxbkRsimEpTEg, UZwrCapGTsLE.uYDhplKOyGrZEy.oDaIDJiRNPwVBUl, 1)
		if Debug then
		end
	end
end
UZwrCapGTsLE.UUoJyMyHvacI = {}
local JuDkTHomXTJsw = {'target', 'boss1', 'boss2', 'boss3', 'boss4', 'boss5', 'focus'}
local GIAXPZymKUFvIF = 30
local qKuYbXwkqArlurH = 300
local SiLvCeGRfssUSOI = 5
local function mfIVkzURAusdVQe(roYiTYPbikSYMm)
	local YtxYUMVCdUlyA = UZwrCapGTsLE.UUoJyMyHvacI[roYiTYPbikSYMm]
	if not YtxYUMVCdUlyA then
		return
	end
	UZwrCapGTsLE.UUoJyMyHvacI[roYiTYPbikSYMm] = nil
	table.wipe(YtxYUMVCdUlyA)
end
function UZwrCapGTsLE.SIzPIiNgMuaytvr()
	local votGICibiyAMkvJ = {}
	for unit, roYiTYPbikSYMm in pairs(UZwrCapGTsLE.CsHlPlAkcfhrcIc) do
		if not votGICibiyAMkvJ[roYiTYPbikSYMm] then
			if not (UZwrCapGTsLE.UUoJyMyHvacI[roYiTYPbikSYMm] and (not UnitExists(unit) or UnitIsDead(unit) or not UnitCanAttack('player', unit))) then
				local XbsuOCrrNVDogK, ZKAuheaqIodJ = UnitHealth(unit), UnitHealthMax(unit)
				UZwrCapGTsLE.RWoRraGyJcOsGo(roYiTYPbikSYMm, XbsuOCrrNVDogK / ZKAuheaqIodJ, unit, GetTime())
			end
			votGICibiyAMkvJ[roYiTYPbikSYMm] = true
		end
	end
	for i, unit in ipairs(JuDkTHomXTJsw) do
		local roYiTYPbikSYMm = UnitGUID(unit)
		if roYiTYPbikSYMm and not votGICibiyAMkvJ[roYiTYPbikSYMm] then
			if not (UZwrCapGTsLE.UUoJyMyHvacI[roYiTYPbikSYMm] and (not UnitExists(unit) or UnitIsDead(unit) or not UnitCanAttack('player', unit) or (UnitHealth(unit) <= 1 and UnitHealthMax(unit) > 1))) then
				local XbsuOCrrNVDogK, ZKAuheaqIodJ = UnitHealth(unit), UnitHealthMax(unit)
				XbsuOCrrNVDogK = XbsuOCrrNVDogK
				ZKAuheaqIodJ = max(1, ZKAuheaqIodJ)
				UZwrCapGTsLE.RWoRraGyJcOsGo(roYiTYPbikSYMm, XbsuOCrrNVDogK / ZKAuheaqIodJ, unit, GetTime())
			end
			votGICibiyAMkvJ[roYiTYPbikSYMm] = true
		end
	end
	for k, v in pairs(UZwrCapGTsLE.UUoJyMyHvacI) do
		if GetTime() - v.lastSeen > 60 then
			mfIVkzURAusdVQe(k)
		end
	end
end
local SqGpuAXFDrsYk = {
	['23775'] = true,
	['120651'] = true,
	['156227'] = true,
	['160966'] = true,
	['161895'] = true,
	['157452'] = true,
	['158041'] = 310126,
	['164698'] = true,
	['177117'] = 355790,
	['176581'] = true
}
function UZwrCapGTsLE.iRimgfhxClBGQy()
	local OiuumCJeqXxdcTE, VLSoopWXgBdaZcM = 3600, false
	for k, v in pairs(UZwrCapGTsLE.UUoJyMyHvacI) do
		local VClfbaZVTayu = k:match('(%d+)-%x-$')
		local jPcdIkeVfiEFM = (SqGpuAXFDrsYk[VClfbaZVTayu] and k ~= UnitGUID('target')) or k ~= UnitGUID(v.unit) or not UnitExists(v.unit) or UnitIsDead(v.unit) or not UnitCanAttack('player', v.unit)
		if not jPcdIkeVfiEFM and v.n > 3 then
			OiuumCJeqXxdcTE = min(OiuumCJeqXxdcTE, ceil(v.lastHealth / v.rate))
			VLSoopWXgBdaZcM = true
		end
	end
	if not VLSoopWXgBdaZcM then
		return qKuYbXwkqArlurH
	end
	return OiuumCJeqXxdcTE
end
function UZwrCapGTsLE.EAjmfGqtOsMfec()
	local OiuumCJeqXxdcTE, VLSoopWXgBdaZcM = 0, false
	for k, v in pairs(UZwrCapGTsLE.UUoJyMyHvacI) do
		local VClfbaZVTayu = k:match('(%d+)-%x-$')
		local jPcdIkeVfiEFM = (SqGpuAXFDrsYk[VClfbaZVTayu] and k ~= UnitGUID('target')) or k ~= UnitGUID(v.unit) or not UnitExists(v.unit) or UnitIsDead(v.unit) or not UnitCanAttack('player', v.unit)
		if not jPcdIkeVfiEFM and v.n > 3 then
			OiuumCJeqXxdcTE = max(OiuumCJeqXxdcTE, ceil(v.lastHealth / v.rate))
			VLSoopWXgBdaZcM = true
		end
	end
	if not VLSoopWXgBdaZcM then
		return qKuYbXwkqArlurH
	end
	return OiuumCJeqXxdcTE
end
function UZwrCapGTsLE.iZgdyOOSDAIo(unit)
	local zhKzMbytLEdtieb = UnitIsTrivial(unit) and SiLvCeGRfssUSOI or qKuYbXwkqArlurH
	local roYiTYPbikSYMm = UnitExists(unit) and UnitCanAttack('player', unit) and UnitGUID(unit)
	if not roYiTYPbikSYMm then
		return zhKzMbytLEdtieb
	end
	local YtxYUMVCdUlyA = UZwrCapGTsLE.UUoJyMyHvacI[roYiTYPbikSYMm]
	if not YtxYUMVCdUlyA then
		return zhKzMbytLEdtieb
	end
	if YtxYUMVCdUlyA.n < 3 or YtxYUMVCdUlyA.rate == 0 then
		return zhKzMbytLEdtieb, YtxYUMVCdUlyA.n
	end
	local XbsuOCrrNVDogK, ZKAuheaqIodJ = UnitHealth(unit), UnitHealthMax(unit)
	XbsuOCrrNVDogK = XbsuOCrrNVDogK
	local ryYAsjVLsoeXG = XbsuOCrrNVDogK / ZKAuheaqIodJ
	if ryYAsjVLsoeXG == 0 then
		return 1, YtxYUMVCdUlyA.n
	end
	return ceil(ryYAsjVLsoeXG / YtxYUMVCdUlyA.rate), YtxYUMVCdUlyA.n
end
function UZwrCapGTsLE.RWoRraGyJcOsGo(roYiTYPbikSYMm, ryYAsjVLsoeXG, unit, time)
	local YtxYUMVCdUlyA = UZwrCapGTsLE.UUoJyMyHvacI[roYiTYPbikSYMm]
	time = time or GetTime()
	if not YtxYUMVCdUlyA or not YtxYUMVCdUlyA.ccGaKeoyYoQgSeen then
		YtxYUMVCdUlyA = YtxYUMVCdUlyA or {}
		UZwrCapGTsLE.UUoJyMyHvacI[roYiTYPbikSYMm] = YtxYUMVCdUlyA
		YtxYUMVCdUlyA.ccGaKeoyYoQgSeen = time
		YtxYUMVCdUlyA.ccGaKeoyYoQgHealth = ryYAsjVLsoeXG
		YtxYUMVCdUlyA.lastSeen = time
		YtxYUMVCdUlyA.lastHealth = ryYAsjVLsoeXG
		YtxYUMVCdUlyA.unit = unit
		YtxYUMVCdUlyA.rate = 0
		YtxYUMVCdUlyA.n = 0
		return
	end
	local XyDwfyibOrrHRND = YtxYUMVCdUlyA.lastHealth - ryYAsjVLsoeXG
	if XyDwfyibOrrHRND > 0 then
		local brPNTyNgPrThg = time - YtxYUMVCdUlyA.lastSeen
		if YtxYUMVCdUlyA.n == 0 then
			YtxYUMVCdUlyA.rate = XyDwfyibOrrHRND / brPNTyNgPrThg
			YtxYUMVCdUlyA.n = 1
		else
			local TkUBsoHPwzZihq = min(YtxYUMVCdUlyA.n, 9)
			local JJNlDcvRwYAUdj = YtxYUMVCdUlyA.rate * TkUBsoHPwzZihq + (XyDwfyibOrrHRND / brPNTyNgPrThg)
			YtxYUMVCdUlyA.n = TkUBsoHPwzZihq + 1
			YtxYUMVCdUlyA.rate = JJNlDcvRwYAUdj / YtxYUMVCdUlyA.n
		end
		YtxYUMVCdUlyA.unit = unit
		YtxYUMVCdUlyA.lastHealth = ryYAsjVLsoeXG
		YtxYUMVCdUlyA.lastSeen = time
	end
end
function UZwrCapGTsLE.wBiUYvoZzMecg()
	for hTUFCwOAKRQG, _ in pairs(UZwrCapGTsLE.BUEUcgcMlrVXqeQ) do
		if UZwrCapGTsLE.zOuHBfiaRNYDPu['stGdMucaNmfwl'] and UZwrCapGTsLE.zOuHBfiaRNYDPu['stGdMucaNmfwl'][hTUFCwOAKRQG] then
			UZwrCapGTsLE.zOuHBfiaRNYDPu['stGdMucaNmfwl'][hTUFCwOAKRQG]:RegisterForClicks('LeftButtonUp', 'LeftButtonDown')
		end
	end
	for hTUFCwOAKRQG = 1, 45 do
		if UZwrCapGTsLE.zOuHBfiaRNYDPu['KsurqIbtJzrVsz'] and UZwrCapGTsLE.zOuHBfiaRNYDPu['KsurqIbtJzrVsz'][hTUFCwOAKRQG] then
			UZwrCapGTsLE.zOuHBfiaRNYDPu['KsurqIbtJzrVsz'][hTUFCwOAKRQG]:RegisterForClicks('LeftButtonUp', 'LeftButtonDown')
		end
	end
end
function UZwrCapGTsLE.BMouBYRCaehTbD()
	local STkFNpecLvtmUZj = 0
	STkFNpecLvtmUZj = min(UZwrCapGTsLE.iZgdyOOSDAIo('target'), 300) * 1000 + min(UZwrCapGTsLE.iZgdyOOSDAIo('mouseover'), 300)
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.zQCgScxgqgHyN[1], STkFNpecLvtmUZj)
	STkFNpecLvtmUZj = min(UZwrCapGTsLE.iZgdyOOSDAIo('focus'), 300) * 1000 + min(UZwrCapGTsLE.iZgdyOOSDAIo('boss1'), 300)
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.zQCgScxgqgHyN[2], STkFNpecLvtmUZj)
	STkFNpecLvtmUZj = min(UZwrCapGTsLE.iZgdyOOSDAIo('boss2'), 300) * 1000 + min(UZwrCapGTsLE.iZgdyOOSDAIo('boss3'), 300)
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.zQCgScxgqgHyN[3], STkFNpecLvtmUZj)
	STkFNpecLvtmUZj = min(UZwrCapGTsLE.iRimgfhxClBGQy(), 300) * 1000 + min(UZwrCapGTsLE.EAjmfGqtOsMfec(), 300)
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.zQCgScxgqgHyN[4], STkFNpecLvtmUZj)
end
function UZwrCapGTsLE.qYrxQbsphqIqRF(GYYEvfguYJkVif)
	local bZIZdiPkdSsTD = UnitGUID(GYYEvfguYJkVif)
	if bZIZdiPkdSsTD ~= nil then
		local _, _, _, _, _, npc_id, _ = strsplit('-', bZIZdiPkdSsTD)
		GtWEVTqZDSqadgu = UZwrCapGTsLE.neutralcombat[tonumber(npc_id, 10)] == true
	end
	return UnitAffectingCombat(GYYEvfguYJkVif) or GtWEVTqZDSqadgu
end
function UZwrCapGTsLE.yrivStqPSyzl()
	local QzCmOeuXejIirHS, STkFNpecLvtmUZj, odoZFzLiaHFOTr = UnitGUID('player'), 0, 0
	local IZCSoSDktZUIq = {}
	if QzCmOeuXejIirHS ~= nil then
		IZCSoSDktZUIq[QzCmOeuXejIirHS] = 41
	end
	for hTUFCwOAKRQG = 1, 4 do
		QzCmOeuXejIirHS = UnitGUID('party' .. hTUFCwOAKRQG)
		if QzCmOeuXejIirHS ~= nil then
			IZCSoSDktZUIq[QzCmOeuXejIirHS] = hTUFCwOAKRQG
		end
	end
	for hTUFCwOAKRQG = 1, 40 do
		QzCmOeuXejIirHS = UnitGUID('raid' .. hTUFCwOAKRQG)
		if QzCmOeuXejIirHS ~= nil then
			IZCSoSDktZUIq[QzCmOeuXejIirHS] = hTUFCwOAKRQG
		end
	end
	for hTUFCwOAKRQG = 1, 3 do
		QzCmOeuXejIirHS = UnitGUID('arena' .. hTUFCwOAKRQG)
		if QzCmOeuXejIirHS ~= nil then
			IZCSoSDktZUIq[QzCmOeuXejIirHS] = hTUFCwOAKRQG + 41
		end
	end
	QzCmOeuXejIirHS = UnitGUID('targettarget')
	odoZFzLiaHFOTr = QzCmOeuXejIirHS ~= nil and IZCSoSDktZUIq[QzCmOeuXejIirHS] or 0
	STkFNpecLvtmUZj = odoZFzLiaHFOTr
	QzCmOeuXejIirHS = UnitGUID('focustarget')
	odoZFzLiaHFOTr = QzCmOeuXejIirHS ~= nil and IZCSoSDktZUIq[QzCmOeuXejIirHS] or 0
	STkFNpecLvtmUZj = odoZFzLiaHFOTr * 100 + STkFNpecLvtmUZj
	QzCmOeuXejIirHS = UnitGUID('mouseovertarget')
	odoZFzLiaHFOTr = QzCmOeuXejIirHS ~= nil and IZCSoSDktZUIq[QzCmOeuXejIirHS] or 0
	STkFNpecLvtmUZj = odoZFzLiaHFOTr * 10000 + STkFNpecLvtmUZj
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.gllDqREXLRsiua[1], STkFNpecLvtmUZj)
	QzCmOeuXejIirHS = UnitGUID('boss1target')
	odoZFzLiaHFOTr = QzCmOeuXejIirHS ~= nil and IZCSoSDktZUIq[QzCmOeuXejIirHS] or 0
	STkFNpecLvtmUZj = odoZFzLiaHFOTr
	QzCmOeuXejIirHS = UnitGUID('boss2target')
	odoZFzLiaHFOTr = QzCmOeuXejIirHS ~= nil and IZCSoSDktZUIq[QzCmOeuXejIirHS] or 0
	STkFNpecLvtmUZj = odoZFzLiaHFOTr * 100 + STkFNpecLvtmUZj
	QzCmOeuXejIirHS = UnitGUID('boss3target')
	odoZFzLiaHFOTr = QzCmOeuXejIirHS ~= nil and IZCSoSDktZUIq[QzCmOeuXejIirHS] or 0
	STkFNpecLvtmUZj = odoZFzLiaHFOTr * 10000 + STkFNpecLvtmUZj
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.gllDqREXLRsiua[2], STkFNpecLvtmUZj)
	QzCmOeuXejIirHS = UnitGUID('arena1target')
	odoZFzLiaHFOTr = QzCmOeuXejIirHS ~= nil and IZCSoSDktZUIq[QzCmOeuXejIirHS] or 0
	STkFNpecLvtmUZj = odoZFzLiaHFOTr
	QzCmOeuXejIirHS = UnitGUID('arena2target')
	odoZFzLiaHFOTr = QzCmOeuXejIirHS ~= nil and IZCSoSDktZUIq[QzCmOeuXejIirHS] or 0
	STkFNpecLvtmUZj = odoZFzLiaHFOTr * 100 + STkFNpecLvtmUZj
	QzCmOeuXejIirHS = UnitGUID('arena3target')
	odoZFzLiaHFOTr = QzCmOeuXejIirHS ~= nil and IZCSoSDktZUIq[QzCmOeuXejIirHS] or 0
	STkFNpecLvtmUZj = odoZFzLiaHFOTr * 10000 + STkFNpecLvtmUZj
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.gllDqREXLRsiua[3], STkFNpecLvtmUZj)
	QzCmOeuXejIirHS = UnitGUID('target')
	odoZFzLiaHFOTr = QzCmOeuXejIirHS ~= nil and IZCSoSDktZUIq[QzCmOeuXejIirHS] or 0
	STkFNpecLvtmUZj = odoZFzLiaHFOTr
	QzCmOeuXejIirHS = UnitGUID('party1target')
	odoZFzLiaHFOTr = QzCmOeuXejIirHS ~= nil and IZCSoSDktZUIq[QzCmOeuXejIirHS] or 0
	STkFNpecLvtmUZj = odoZFzLiaHFOTr * 100 + STkFNpecLvtmUZj
	QzCmOeuXejIirHS = UnitGUID('party2target')
	odoZFzLiaHFOTr = QzCmOeuXejIirHS ~= nil and IZCSoSDktZUIq[QzCmOeuXejIirHS] or 0
	STkFNpecLvtmUZj = odoZFzLiaHFOTr * 10000 + STkFNpecLvtmUZj
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.gllDqREXLRsiua[4], STkFNpecLvtmUZj)
end
UZwrCapGTsLE.IHhBdfMdcEqY = 0
UZwrCapGTsLE.KYxJhhKwOMrkoM = 0
function UZwrCapGTsLE.byyQfbCzATbdr()
	local STkFNpecLvtmUZj = 0
	local qLwIvzurofRd = 999
	if UZwrCapGTsLE.IHhBdfMdcEqY ~= 0 then
		qLwIvzurofRd = (GetTime() - UZwrCapGTsLE.IHhBdfMdcEqY) * 100
		qLwIvzurofRd = qLwIvzurofRd + 0.5 - (qLwIvzurofRd + 0.5) % 1
		qLwIvzurofRd = qLwIvzurofRd > 999 and 999 or qLwIvzurofRd
	end
	STkFNpecLvtmUZj = qLwIvzurofRd * 100 + UZwrCapGTsLE.KYxJhhKwOMrkoM
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.XFODOULrhCWr, STkFNpecLvtmUZj)
end
function UZwrCapGTsLE.lTlNkcKMXisiOPf()
	local STkFNpecLvtmUZj = 0
	for i = 1, 3 do
		for t = 1, 6 do
			STkFNpecLvtmUZj = '1'
			for j = 1 + (t - 1) * 6, 6 + (t - 1) * 6 do
				STkFNpecLvtmUZj = STkFNpecLvtmUZj .. (select(5, GetTalentInfo(i, j)) or 0)
			end
			UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.jrdymkghcUHTxD[((i - 1) * 6) + t], STkFNpecLvtmUZj)
		end
	end
end
function UZwrCapGTsLE.fxGrQxsHTEWqpW()
	for i = 1, 6 do
		local HQMklsYhlpKLv, _, hjgJZIhXwsyfASb = GetGlyphSocketInfo(i)
		if HQMklsYhlpKLv and hjgJZIhXwsyfASb then
			UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.bRNAtKyrkjKp[i], hjgJZIhXwsyfASb)
		else
			UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.bRNAtKyrkjKp[i], 0)
		end
	end
end
function UZwrCapGTsLE.bdsWKKyOGqEBG()
	local STkFNpecLvtmUZj = '1'
	STkFNpecLvtmUZj = STkFNpecLvtmUZj .. ((IsAutoRepeatSpell(5019) or IsAutoRepeatSpell(75)) and '1' or '0')
	local lxKdOjhdKTWQw = GetInventoryItemLink('player', GetInventorySlotInfo('HandsSlot'))
	if lxKdOjhdKTWQw ~= nil then
		local orcMluRFNWAB, _ = select(6, string.find(lxKdOjhdKTWQw, '|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?'))
		if orcMluRFNWAB == '3604' or orcMluRFNWAB == '3603' then
			local VYZDrAbMrMopgXW = GetItemInfoInstant(lxKdOjhdKTWQw)
			if GetItemInfo(VYZDrAbMrMopgXW) ~= nil then
				local yWXTrIKlGZCFfJ, _ = C_Container.GetItemCooldown(VYZDrAbMrMopgXW)
				STkFNpecLvtmUZj = STkFNpecLvtmUZj .. ((yWXTrIKlGZCFfJ > 0) and '0' or '1')
			end
		end
	end
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.ABCUIwJzFwoewuo, BpypylRMdtHh(STkFNpecLvtmUZj))
end
function UZwrCapGTsLE.OOcFUmwrWxiNNVc()
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.AqrNQIVSiJTghom, UnitPower('player', 3))
end
function oTJpEKpEsWzRb()
	local STkFNpecLvtmUZj = 0
	if GetShapeshiftForm(true) then
		STkFNpecLvtmUZj = GetShapeshiftForm(true)
	end
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.TMdUOWyzRjpBaL, STkFNpecLvtmUZj)
end
function qBcrtfaqaAYU()
	local STkFNpecLvtmUZj, bhCrFrxKqPkhI = 0, 0
	if addon_data then
		bhCrFrxKqPkhI = addon_data.player.main_swing_timer * 10
		bhCrFrxKqPkhI = bhCrFrxKqPkhI + 0.5 - (bhCrFrxKqPkhI + 0.5) % 1
	end
	STkFNpecLvtmUZj = bhCrFrxKqPkhI
	bhCrFrxKqPkhI = 0
	if addon_data then
		bhCrFrxKqPkhI = addon_data.player.off_swing_timer * 10
		bhCrFrxKqPkhI = bhCrFrxKqPkhI + 0.5 - (bhCrFrxKqPkhI + 0.5) % 1
	end
	STkFNpecLvtmUZj = STkFNpecLvtmUZj + bhCrFrxKqPkhI * 100
	bhCrFrxKqPkhI = 0
	if addon_data then
		bhCrFrxKqPkhI = addon_data.hunter.shot_timer * 10
		bhCrFrxKqPkhI = bhCrFrxKqPkhI + 0.5 - (bhCrFrxKqPkhI + 0.5) % 1
	end
	STkFNpecLvtmUZj = STkFNpecLvtmUZj + bhCrFrxKqPkhI * 10000
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.YGKrvsEcjgtgo, STkFNpecLvtmUZj)
end
function UZwrCapGTsLE.FjaJtTFlxivrja()
	local STkFNpecLvtmUZj = 0
	STkFNpecLvtmUZj =
		Hekili and Hekili.DisplayPool.Primary.Recommendations[1] and (not Hekili.DisplayPool.Primary.Recommendations[1].time or Hekili.DisplayPool.Primary.Recommendations[1].time <= 0.3) and GetSpellInfo(Hekili.DisplayPool.Primary.Recommendations[1].actionID) and
		UZwrCapGTsLE.ssXIjtpkUQLG[GetSpellInfo(Hekili.DisplayPool.Primary.Recommendations[1].actionID)] or
		0
	STkFNpecLvtmUZj = Hekili and STkFNpecLvtmUZj == 0 and ((Hekili.State.trinket.t1.__ability == Hekili.DisplayPool.Primary.Recommendations[1].actionName and 71) or (Hekili.State.trinket.t2.__ability == Hekili.DisplayPool.Primary.Recommendations[1].actionName and 72)) or STkFNpecLvtmUZj
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.zCZHcMIVXZVh, STkFNpecLvtmUZj)
end
function CQcALUiovotp()
	for cePldaUqaGHUTzac, citemID in pairs(UZwrCapGTsLE.BKuEzVlUuwWP) do
		if cePldaUqaGHUTzac < 11 then
			local STkFNpecLvtmUZj = 0
			local wvuotqPtLrbP, whJUwDTfNmxMrRw, SUldHEGJiklBcV, LlYcVSqjfydoH = 1, 0, 0, 0
			local LlYcVSqjfydoH = GetItemCount(citemID, nil, true)
			LlYcVSqjfydoH = LlYcVSqjfydoH > 9 and 9 or LlYcVSqjfydoH
			if GetItemInfo(citemID) ~= nil and LlYcVSqjfydoH > 0 then
				local yWXTrIKlGZCFfJ, ArNehDLPwAEUuSJ, PEjxgNVwjJPZ = C_Container.GetItemCooldown(citemID)
				if (yWXTrIKlGZCFfJ > 0 and ArNehDLPwAEUuSJ > 0) then
					SUldHEGJiklBcV = ((yWXTrIKlGZCFfJ) + (ArNehDLPwAEUuSJ) - (GetTime())) * 100
					SUldHEGJiklBcV = SUldHEGJiklBcV + 0.5 - (SUldHEGJiklBcV + 0.5) % 1
				end
				local _, loPkUJzmwLkVpG = GetItemSpell(citemID)
				whJUwDTfNmxMrRw = IsUsableItem(citemID) and PEjxgNVwjJPZ == 1 and SUldHEGJiklBcV == 0 and loPkUJzmwLkVpG and 1 or 0
				SUldHEGJiklBcV = SUldHEGJiklBcV > 999999 and 999999 or SUldHEGJiklBcV
			end
			STkFNpecLvtmUZj = wvuotqPtLrbP * 10000000 + whJUwDTfNmxMrRw * 1000000 + LlYcVSqjfydoH * 100000 + SUldHEGJiklBcV
			UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.BQVdGRqlzaosobz[cePldaUqaGHUTzac], STkFNpecLvtmUZj)
		end
	end
end
function EyXGRceBvJJvbgW()
	local STkFNpecLvtmUZj = 0
	local _, GPuQzELQSCEdNN, _, _, _, PrFJQfpcrQEc, _, _ = GetWeaponEnchantInfo()
	STkFNpecLvtmUZj = GPuQzELQSCEdNN and (GPuQzELQSCEdNN > 999000 and 999 or GPuQzELQSCEdNN / 1000) or 0
	STkFNpecLvtmUZj = STkFNpecLvtmUZj + (PrFJQfpcrQEc and (PrFJQfpcrQEc > 999000 and 999000 or math.floor(PrFJQfpcrQEc / 1000) * 1000) or 0)
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.wHeIsYuqHWWAWp, STkFNpecLvtmUZj)
end
function XxUCjjxNxyXex()
	local STkFNpecLvtmUZj, YpRtmpRaWxCW, SIHvRGyDFXWrET = 0, 0, 0
	for i = 1, 4 do
		local ABwyyjvtaxhhiI, uvrUUgjKMrea, yWXTrIKlGZCFfJ, UBZimpmOoUTejmP = GetTotemInfo(i)
		SIHvRGyDFXWrET = 0
		if (ABwyyjvtaxhhiI and yWXTrIKlGZCFfJ > 0 and UBZimpmOoUTejmP > 0) then
			YpRtmpRaWxCW = ((yWXTrIKlGZCFfJ) + (UBZimpmOoUTejmP) - (GetTime())) * 100
			YpRtmpRaWxCW = YpRtmpRaWxCW + 0.5 - (YpRtmpRaWxCW + 0.5) % 1
			YpRtmpRaWxCW = YpRtmpRaWxCW > 9999 and 9999 or YpRtmpRaWxCW <= 0 and 0 or YpRtmpRaWxCW
			for k, v in pairs(UZwrCapGTsLE.XvHADJAfjqowbxc) do
				if GetSpellInfo(v) and uvrUUgjKMrea ~= nil and (string.find(uvrUUgjKMrea:lower(), GetSpellInfo(v):lower()) or string.find(GetSpellInfo(v):lower(), uvrUUgjKMrea:lower())) then
					SIHvRGyDFXWrET = k
				end
			end
		end
		STkFNpecLvtmUZj = ABwyyjvtaxhhiI and (SIHvRGyDFXWrET * 10000 + YpRtmpRaWxCW) or 0
		UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.IOHyEAhHlfyF[i], STkFNpecLvtmUZj)
	end
end
function kSkFRgjlGdoOP()
	local STkFNpecLvtmUZj, HfstSSVgsQpTLHY, XwrVgbByMacoQa = 0, 0, 0
	if UnitExists('target') and UnitIsFriend('player', 'target') then
		if UnitInParty('target') then
			if UnitIsUnit('target', 'party1') then
				HfstSSVgsQpTLHY = 1
			elseif UnitIsUnit('target', 'party2') then
				HfstSSVgsQpTLHY = 2
			elseif UnitIsUnit('target', 'party3') then
				HfstSSVgsQpTLHY = 3
			elseif UnitIsUnit('target', 'party4') then
				HfstSSVgsQpTLHY = 4
			end
		end
		if IsInRaid() and UnitInRaid('target') then
			HfstSSVgsQpTLHY = UnitInRaid('target')
		end
		if UnitIsUnit('target', 'player') then
			HfstSSVgsQpTLHY = 41
		end
	end
	if UnitExists('mouseover') and UnitIsFriend('player', 'mouseover') then
		if UnitInParty('mouseover') then
			if UnitIsUnit('mouseover', 'party1') then
				XwrVgbByMacoQa = 1
			elseif UnitIsUnit('mouseover', 'party2') then
				XwrVgbByMacoQa = 2
			elseif UnitIsUnit('mouseover', 'party3') then
				XwrVgbByMacoQa = 3
			elseif UnitIsUnit('mouseover', 'party4') then
				XwrVgbByMacoQa = 4
			end
		end
		if IsInRaid() and UnitInRaid('mouseover') then
			XwrVgbByMacoQa = UnitInRaid('mouseover')
		end
		if UnitIsUnit('mouseover', 'player') then
			XwrVgbByMacoQa = 41
		end
	end
	STkFNpecLvtmUZj = 100 * XwrVgbByMacoQa + HfstSSVgsQpTLHY
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.EZldtEhqYbDQNK, STkFNpecLvtmUZj)
end
function psdJJMjjHDbf()
	local STkFNpecLvtmUZj = 0
	local wvuotqPtLrbP, whJUwDTfNmxMrRw, HuWwDMYxCXsmPwQ = 1, 0, 0
	local lxKdOjhdKTWQw = GetInventoryItemLink('player', GetInventorySlotInfo('Trinket0Slot'))
	if lxKdOjhdKTWQw ~= nil then
		local VYZDrAbMrMopgXW = GetItemInfoInstant(lxKdOjhdKTWQw)
		if GetItemInfo(VYZDrAbMrMopgXW) ~= nil then
			UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.IItpDvlGPtZHQQ[1], VYZDrAbMrMopgXW)
			local yWXTrIKlGZCFfJ, ArNehDLPwAEUuSJ, PEjxgNVwjJPZ = C_Container.GetItemCooldown(VYZDrAbMrMopgXW)
			if (yWXTrIKlGZCFfJ > 0 and ArNehDLPwAEUuSJ > 0) then
				HuWwDMYxCXsmPwQ = ((yWXTrIKlGZCFfJ) + (ArNehDLPwAEUuSJ) - (GetTime())) * 100
				HuWwDMYxCXsmPwQ = HuWwDMYxCXsmPwQ + 0.5 - (HuWwDMYxCXsmPwQ + 0.5) % 1
			end
			if PEjxgNVwjJPZ == 1 then
				local _, loPkUJzmwLkVpG = GetItemSpell(VYZDrAbMrMopgXW)
				if loPkUJzmwLkVpG ~= nil then
					whJUwDTfNmxMrRw = 1
				end
			end
		end
	end
	if HuWwDMYxCXsmPwQ > 999999 then
		HuWwDMYxCXsmPwQ = 999999
	end
	STkFNpecLvtmUZj = wvuotqPtLrbP * 10000000 + whJUwDTfNmxMrRw * 1000000 + HuWwDMYxCXsmPwQ
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.HzSqQeERwdkPH[1], STkFNpecLvtmUZj)
	lxKdOjhdKTWQw = GetInventoryItemLink('player', GetInventorySlotInfo('Trinket1Slot'))
	STkFNpecLvtmUZj = 0
	wvuotqPtLrbP, whJUwDTfNmxMrRw, HuWwDMYxCXsmPwQ = 1, 0, 0
	if lxKdOjhdKTWQw ~= nil then
		local VYZDrAbMrMopgXW = GetItemInfoInstant(lxKdOjhdKTWQw)
		if GetItemInfo(VYZDrAbMrMopgXW) ~= nil then
			UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.IItpDvlGPtZHQQ[2], VYZDrAbMrMopgXW)
			yWXTrIKlGZCFfJ, ArNehDLPwAEUuSJ, PEjxgNVwjJPZ = C_Container.GetItemCooldown(VYZDrAbMrMopgXW)
			if (yWXTrIKlGZCFfJ > 0 and ArNehDLPwAEUuSJ > 0) then
				HuWwDMYxCXsmPwQ = ((yWXTrIKlGZCFfJ) + (ArNehDLPwAEUuSJ) - (GetTime())) * 100
				HuWwDMYxCXsmPwQ = HuWwDMYxCXsmPwQ + 0.5 - (HuWwDMYxCXsmPwQ + 0.5) % 1
			end
			if PEjxgNVwjJPZ == 1 then
				_, loPkUJzmwLkVpG = GetItemSpell(VYZDrAbMrMopgXW)
				if loPkUJzmwLkVpG ~= nil then
					whJUwDTfNmxMrRw = 1
				end
			end
		end
	end
	if HuWwDMYxCXsmPwQ > 999999 then
		HuWwDMYxCXsmPwQ = 999999
	end
	STkFNpecLvtmUZj = wvuotqPtLrbP * 10000000 + whJUwDTfNmxMrRw * 1000000 + HuWwDMYxCXsmPwQ
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.HzSqQeERwdkPH[2], STkFNpecLvtmUZj)
end
function NVmGfEKmqVtI()
	local STkFNpecLvtmUZj = '1'
	for j = 1, 10 do
		STkFNpecLvtmUZj = STkFNpecLvtmUZj .. UZwrCapGTsLE.rkvygcVEqmPM[j]
	end
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.eqGcOqOJPruk, BpypylRMdtHh(STkFNpecLvtmUZj))
end
function FhageGdOcGjwo(s, delimiter)
	result = {}
	for match in (s .. delimiter):gmatch('(.-)' .. delimiter) do
		table.insert(result, match)
	end
	return result
end
function VmeDEyElrSKWxyG(msg, KYfDOQWhFJaSPK)
	local lWOouptAziQV = FhageGdOcGjwo(msg, ' ')
	for i = 1, 10 do
		if UZwrCapGTsLE.soqmXJOEzliw[i] ~= nil then
			if lWOouptAziQV[1] and lWOouptAziQV[1]:lower() == UZwrCapGTsLE.soqmXJOEzliw[i]:lower() then
				if lWOouptAziQV[2] and lWOouptAziQV[2]:lower() == 'on' then
					UZwrCapGTsLE.rkvygcVEqmPM[i] = 1
				elseif lWOouptAziQV[2] and lWOouptAziQV[2]:lower() == 'off' then
					UZwrCapGTsLE.rkvygcVEqmPM[i] = 0
				else
					UZwrCapGTsLE.rkvygcVEqmPM[i] = (UZwrCapGTsLE.rkvygcVEqmPM[i] + 1) % 2
				end
				PlaySound(8959)
				if (UZwrCapGTsLE.rkvygcVEqmPM[i] == 1) then
					RaidNotice_AddMessage(RaidWarningFrame, UZwrCapGTsLE.soqmXJOEzliw[i] .. ': on', ChatTypeInfo['RAID_WARNING'])
					UZwrCapGTsLE.IoPAHgQhDIAv[i].tex:SetColorTexture(0.5, 1, 0, UZwrCapGTsLE.mzxAWvToNmjPOsz)
				else
					RaidNotice_AddMessage(RaidWarningFrame, UZwrCapGTsLE.soqmXJOEzliw[i] .. ': off', ChatTypeInfo['RAID_WARNING'])
					UZwrCapGTsLE.IoPAHgQhDIAv[i].tex:SetColorTexture(UZwrCapGTsLE.ljxYWypolSssQw.r, UZwrCapGTsLE.ljxYWypolSssQw.b, UZwrCapGTsLE.ljxYWypolSssQw.g, UZwrCapGTsLE.mzxAWvToNmjPOsz)
				end
				NVmGfEKmqVtI()
			end
		end
	end
	if lWOouptAziQV[1] and lWOouptAziQV[1]:lower() == 'cast' then
		local aCXTXzECoRdsaqx = string.gsub(msg, 'cast ', '')
		UZwrCapGTsLE.KYxJhhKwOMrkoM = aCXTXzECoRdsaqx and UZwrCapGTsLE.ssXIjtpkUQLG[GetSpellInfo(aCXTXzECoRdsaqx)] or 0
		UZwrCapGTsLE.KYxJhhKwOMrkoM = (aCXTXzECoRdsaqx == 'trinket1' and 51) or (aCXTXzECoRdsaqx == 'trinket2' and 52) or UZwrCapGTsLE.KYxJhhKwOMrkoM
		UZwrCapGTsLE.IHhBdfMdcEqY = GetTime()
	end
	if msg == 'break' then
		local qPhipYotwDErTm, JhEvxTCLuBBWU = 0, 0
		if GetSpellCooldown(61304) ~= nil then
			qPhipYotwDErTm, JhEvxTCLuBBWU = GetSpellCooldown(61304)
		end
		if (qPhipYotwDErTm > 0 and JhEvxTCLuBBWU > 0) then
			BBcbhRodryYwb = (qPhipYotwDErTm) + (JhEvxTCLuBBWU) - (GetTime())
		else
			BBcbhRodryYwb = 0
		end
		if BBcbhRodryYwb > 999999 then
			BBcbhRodryYwb = 0
		end
		UZwrCapGTsLE.crEYyQheFoeaOOG = GetTime() + max(BBcbhRodryYwb, 0.5)
		XtboFViKJIsvaSE()
	end
	if msg == 'break2' then
		UZwrCapGTsLE.crEYyQheFoeaOOG = GetTime() + 1.5
		XtboFViKJIsvaSE()
	end
	if msg == 'break3' then
		UZwrCapGTsLE.crEYyQheFoeaOOG = GetTime() + 3
		XtboFViKJIsvaSE()
	end
	if msg == 'break5' then
		UZwrCapGTsLE.crEYyQheFoeaOOG = GetTime() + 5
		XtboFViKJIsvaSE()
	end
	if msg == 'break10' then
		UZwrCapGTsLE.crEYyQheFoeaOOG = GetTime() + 10
		XtboFViKJIsvaSE()
	end
	if msg == 'xbdNVOgNrNeatm' then
		UZwrCapGTsLE.MobEFYgPRrGk:ClearAllPoints()
		UZwrCapGTsLE.MobEFYgPRrGk:SetPoint('LEFT', UIParent, 'LEFT', 0, 0)
	end
end
function XtboFViKJIsvaSE()
	local STkFNpecLvtmUZj = '1'
	if UZwrCapGTsLE.crEYyQheFoeaOOG <= GetTime() or UZwrCapGTsLE.crEYyQheFoeaOOG == 0 then
		UZwrCapGTsLE.crEYyQheFoeaOOG = 0
		STkFNpecLvtmUZj = STkFNpecLvtmUZj .. '0'
	else
		STkFNpecLvtmUZj = STkFNpecLvtmUZj .. '1'
	end
	UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.MLPjHrComCJHz, BpypylRMdtHh(STkFNpecLvtmUZj))
end
UZwrCapGTsLE.NGfVHqOmXtps = CreateFrame('Frame', 'ijaht', UIParent)
UZwrCapGTsLE.NGfVHqOmXtps:SetSize(1900, 1)
UZwrCapGTsLE.NGfVHqOmXtps:SetPoint('TOPLEFT', 0, 0)
UZwrCapGTsLE.NGfVHqOmXtps:SetIgnoreParentScale(true)
UZwrCapGTsLE.NGfVHqOmXtps:SetIgnoreParentAlpha(true)
UZwrCapGTsLE.NGfVHqOmXtps.t = UZwrCapGTsLE.NGfVHqOmXtps:CreateTexture()
UZwrCapGTsLE.NGfVHqOmXtps.t:SetColorTexture(0, 0, 0, 1)
UZwrCapGTsLE.NGfVHqOmXtps.t:SetAllPoints(UZwrCapGTsLE.NGfVHqOmXtps)
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('ADDON_LOADED')
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('PLAYER_ENTERING_WORLD')
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('PLAYER_STARTED_LOOKING')
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('PLAYER_STARTED_TURNING')
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('PLAYER_STOPPED_TURNING')
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('PLAYER_STOPPED_LOOKING')
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('PLAYER_ENTERING_WORLD')
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('UNIT_SPELLCAST_SENT')
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('UI_ERROR_MESSAGE')
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('LOSS_OF_CONTROL_ADDED')
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('PLAYER_LOGOUT')
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('ZONE_CHANGED_NEW_AREA')
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('NAME_PLATE_UNIT_ADDED')
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('NAME_PLATE_UNIT_REMOVED')
UZwrCapGTsLE.NGfVHqOmXtps:RegisterEvent('UNIT_POWER_UPDATE')
UZwrCapGTsLE.NGfVHqOmXtps:SetFrameStrata('TOOLTIP')
local KtbyYLhlHWVoTNO = CreateFrame('frame')
KtbyYLhlHWVoTNO:RegisterEvent('VARIABLES_LOADED')
KtbyYLhlHWVoTNO:RegisterEvent('UI_SCALE_CHANGED')
KtbyYLhlHWVoTNO:SetScript(
	'OnEvent',
	function(self, event, ...)
		local URUbrVyDTPoog = select(2, GetPhysicalScreenSize())
		URUbrVyDTPoog = 768 / URUbrVyDTPoog
		if UZwrCapGTsLE.NGfVHqOmXtps:GetScale() ~= URUbrVyDTPoog then
			UZwrCapGTsLE.NGfVHqOmXtps:SetScale(URUbrVyDTPoog)
			WckAaWaYMQHXTg()
		end
	end
)
function UZwrCapGTsLE.BrPSyzPqYpIY(frame, offset)
	frame:SetSize(1, 1)
	frame:SetPoint('TOPLEFT', offset, 0)
	frame.t = frame:CreateTexture()
	frame.t:SetColorTexture(0, 0, 0, 1)
	frame.t:SetAllPoints(frame)
	frame:Show()
	return frame
end
UZwrCapGTsLE.zOuHBfiaRNYDPu = {}
UZwrCapGTsLE.zOuHBfiaRNYDPu['ijaht'] = CreateFrame('Frame', 'ijaht' .. 2, UIParent)
function xGLMhNjSzOhTl()
	UZwrCapGTsLE.xIcbTXhmozFZELQ = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'xIcbTXhmozFZELQ', UZwrCapGTsLE.NGfVHqOmXtps), 0)
	UZwrCapGTsLE.JixTzbrXUddUA = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'JixTzbrXUddUA', UZwrCapGTsLE.NGfVHqOmXtps), 1)
	UZwrCapGTsLE.KIhTHJDTuLDyhf = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'KIhTHJDTuLDyhf', UZwrCapGTsLE.NGfVHqOmXtps), 2)
	UZwrCapGTsLE.ZQHFHiYNfVat = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'ZQHFHiYNfVat', UZwrCapGTsLE.NGfVHqOmXtps), 3)
	UZwrCapGTsLE.UbhWAtCVNEry = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'UbhWAtCVNEry', UZwrCapGTsLE.NGfVHqOmXtps), 4)
	UZwrCapGTsLE.NihFtXXLdPSl = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'NihFtXXLdPSl', UZwrCapGTsLE.NGfVHqOmXtps), 5)
	UZwrCapGTsLE.crhXuNGuCWwS = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'crhXuNGuCWwS', UZwrCapGTsLE.NGfVHqOmXtps), 6)
	UZwrCapGTsLE.vqKrsGStqrFDRWE = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'vqKrsGStqrFDRWE', UZwrCapGTsLE.NGfVHqOmXtps), 7)
	UZwrCapGTsLE.EqsDbKYOiilKSdr = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'EqsDbKYOiilKSdr', UZwrCapGTsLE.NGfVHqOmXtps), 8)
	UZwrCapGTsLE.HzSqQeERwdkPH = {}
	for i = 1, 2 do
		UZwrCapGTsLE.HzSqQeERwdkPH[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'HzSqQeERwdkPH' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 8 + i)
	end
	UZwrCapGTsLE.eqGcOqOJPruk = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'eqGcOqOJPruk', UZwrCapGTsLE.NGfVHqOmXtps), 11)
	UZwrCapGTsLE.WHlOiIaBSKbly = {}
	for i = 1, 5 do
		UZwrCapGTsLE.WHlOiIaBSKbly[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'WHlOiIaBSKbly' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 11 + i)
	end
	UZwrCapGTsLE.rMcvRwqNLIrLhCM = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'rMcvRwqNLIrLhCM', UZwrCapGTsLE.NGfVHqOmXtps), 17)
	UZwrCapGTsLE.biZElxVHqBTQVKN = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'biZElxVHqBTQVKN', UZwrCapGTsLE.NGfVHqOmXtps), 18)
	UZwrCapGTsLE.MLPjHrComCJHz = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'MLPjHrComCJHz', UZwrCapGTsLE.NGfVHqOmXtps), 22)
	UZwrCapGTsLE.TMdUOWyzRjpBaL = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'TMdUOWyzRjpBaL', UZwrCapGTsLE.NGfVHqOmXtps), 23)
	UZwrCapGTsLE.lkSXffmYtEzrz = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'lkSXffmYtEzrz', UZwrCapGTsLE.NGfVHqOmXtps), 24)
	UZwrCapGTsLE.wHeIsYuqHWWAWp = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'wHeIsYuqHWWAWp', UZwrCapGTsLE.NGfVHqOmXtps), 30)
	UZwrCapGTsLE.xikboQduPIxoTPz = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'xikboQduPIxoTPz', UZwrCapGTsLE.NGfVHqOmXtps), 31)
	UZwrCapGTsLE.EZldtEhqYbDQNK = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'EZldtEhqYbDQNK', UZwrCapGTsLE.NGfVHqOmXtps), 32)
	UZwrCapGTsLE.rtGSwTBtrGKhE = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'rtGSwTBtrGKhE', UZwrCapGTsLE.NGfVHqOmXtps), 33)
	UZwrCapGTsLE.XqaKxxrzfzQpcP = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'XqaKxxrzfzQpcP', UZwrCapGTsLE.NGfVHqOmXtps), 34)
	UZwrCapGTsLE.wDutOBBIJIbPPh = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'wDutOBBIJIbPPh', UZwrCapGTsLE.NGfVHqOmXtps), 35)
	UZwrCapGTsLE.zCZHcMIVXZVh = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'zCZHcMIVXZVh', UZwrCapGTsLE.NGfVHqOmXtps), 36)
	UZwrCapGTsLE.fOucRCpUQfmUHwp = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'fOucRCpUQfmUHwp', UZwrCapGTsLE.NGfVHqOmXtps), 37)
	UZwrCapGTsLE.XQUUvUrsRoqIlL = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'XQUUvUrsRoqIlL', UZwrCapGTsLE.NGfVHqOmXtps), 40)
	UZwrCapGTsLE.JekVwDGCbYzF = {}
	for i = 1, 3 do
		UZwrCapGTsLE.JekVwDGCbYzF[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'JekVwDGCbYzF' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 40 + i)
	end
	UZwrCapGTsLE.PAPBWUzRNRuMvXR = {}
	for i = 1, 6 do
		UZwrCapGTsLE.PAPBWUzRNRuMvXR[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'PAPBWUzRNRuMvXR' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 43 + i)
	end
	UZwrCapGTsLE.ZMTymsDFOdCyXtv = {}
	for i = 1, 60 do
		UZwrCapGTsLE.ZMTymsDFOdCyXtv[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'ZMTymsDFOdCyXtv' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 49 + i)
	end
	UZwrCapGTsLE.YGKrvsEcjgtgo = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'YGKrvsEcjgtgo', UZwrCapGTsLE.NGfVHqOmXtps), 110)
	UZwrCapGTsLE.jrdymkghcUHTxD = {}
	for i = 1, 18 do
		UZwrCapGTsLE.jrdymkghcUHTxD[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'jrdymkghcUHTxD' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 110 + i)
	end
	UZwrCapGTsLE.bRNAtKyrkjKp = {}
	for i = 1, 6 do
		UZwrCapGTsLE.bRNAtKyrkjKp[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'bRNAtKyrkjKp' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 128 + i)
	end
	UZwrCapGTsLE.ABCUIwJzFwoewuo = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'ABCUIwJzFwoewuo', UZwrCapGTsLE.NGfVHqOmXtps), 135)
	UZwrCapGTsLE.AqrNQIVSiJTghom = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'AqrNQIVSiJTghom', UZwrCapGTsLE.NGfVHqOmXtps), 136)
	UZwrCapGTsLE.IItpDvlGPtZHQQ = {}
	for i = 1, 2 do
		UZwrCapGTsLE.IItpDvlGPtZHQQ[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'IItpDvlGPtZHQQ' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 177 + i)
	end
	UZwrCapGTsLE.MOKrXMrtzzWT = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'MOKrXMrtzzWT', UZwrCapGTsLE.NGfVHqOmXtps), 180)
	UZwrCapGTsLE.TXATdjtdoKrqhaq = {}
	for i = 1, 16 do
		UZwrCapGTsLE.TXATdjtdoKrqhaq[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'TXATdjtdoKrqhaq' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 181 + i)
	end
	UZwrCapGTsLE.hgVNHldPpqDp, UZwrCapGTsLE.sJgqfDbsiGkt = {}, {}
	for i = 1, 255 do
		UZwrCapGTsLE.hgVNHldPpqDp[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'hgVNHldPpqDp' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 197 + 2 * i)
		UZwrCapGTsLE.sJgqfDbsiGkt[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'sJgqfDbsiGkt' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 198 + 2 * i)
	end
	UZwrCapGTsLE.uAvzudmbSCGQY, UZwrCapGTsLE.NEcpBmJNdbVk = {}, {}
	for i = 1, 255 do
		UZwrCapGTsLE.NEcpBmJNdbVk[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'uAvzudmbSCGQY' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 708 + 2 * i)
		UZwrCapGTsLE.uAvzudmbSCGQY[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'uAvzudmbSCGQY' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 709 + 2 * i)
	end
	UZwrCapGTsLE.UfLliUkfBQSLuWr = {}
	for i = 1, 55 do
		UZwrCapGTsLE.UfLliUkfBQSLuWr[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'UfLliUkfBQSLuWr' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 1219 + i)
	end
	UZwrCapGTsLE.qVzbAsJkXasA = {}
	for i = 1, 51 do
		UZwrCapGTsLE.qVzbAsJkXasA[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'qVzbAsJkXasA' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 1274 + i)
	end
	UZwrCapGTsLE.qcjmsVYqjzrBvB = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'qcjmsVYqjzrBvB', UZwrCapGTsLE.NGfVHqOmXtps), 1331)
	UZwrCapGTsLE.XFODOULrhCWr = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'XFODOULrhCWr', UZwrCapGTsLE.NGfVHqOmXtps), 1332)
	UZwrCapGTsLE.IOHyEAhHlfyF = {}
	for i = 1, 4 do
		UZwrCapGTsLE.IOHyEAhHlfyF[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'IOHyEAhHlfyF' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 1332 + i)
	end
	UZwrCapGTsLE.gllDqREXLRsiua = {}
	for i = 1, 4 do
		UZwrCapGTsLE.gllDqREXLRsiua[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'gllDqREXLRsiua' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 1338 + i)
	end
	UZwrCapGTsLE.zQCgScxgqgHyN = {}
	for i = 1, 4 do
		UZwrCapGTsLE.zQCgScxgqgHyN[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'zQCgScxgqgHyN' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 1342 + i)
	end
	UZwrCapGTsLE.dkHYwLPujaIfX = {}
	for i = 1, 5 do
		UZwrCapGTsLE.dkHYwLPujaIfX[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'dkHYwLPujaIfX' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 1346 + i)
	end
	UZwrCapGTsLE.mWJwSTMFGfPDcH = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'mWJwSTMFGfPDcH', UZwrCapGTsLE.NGfVHqOmXtps), 1352)
	UZwrCapGTsLE.RiirycKcctWby = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'RiirycKcctWby', UZwrCapGTsLE.NGfVHqOmXtps), 1353)
	UZwrCapGTsLE.LoYWporrlEWETs = {}
	for i = 1, 16 do
		UZwrCapGTsLE.LoYWporrlEWETs[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'LoYWporrlEWETs' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 1354 + i)
	end
	UZwrCapGTsLE.fqosmeaJejOVl = {}
	for i = 1, 16 do
		UZwrCapGTsLE.fqosmeaJejOVl[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'fqosmeaJejOVl' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 1370 + i)
	end
	UZwrCapGTsLE.BQVdGRqlzaosobz = {}
	for i = 1, 10 do
		UZwrCapGTsLE.BQVdGRqlzaosobz[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'BQVdGRqlzaosobz' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 1386 + i)
	end
	UZwrCapGTsLE.kflrJGpYUYuOKs = {}
	for i = 1, 10 do
		UZwrCapGTsLE.kflrJGpYUYuOKs[i] = UZwrCapGTsLE.BrPSyzPqYpIY(CreateFrame('Frame', 'kflrJGpYUYuOKs' .. i, UZwrCapGTsLE.NGfVHqOmXtps), 1396 + i)
	end
end
function dYVewiBrEBKKlo(self, brPNTyNgPrThg)
	if UZwrCapGTsLE.swaIqhVdLRyE == false then
		UZwrCapGTsLE.swaIqhVdLRyE = true
		UZwrCapGTsLE.ACaCyGUvyRMXm = UZwrCapGTsLE.ACaCyGUvyRMXm + brPNTyNgPrThg
		UZwrCapGTsLE.kUFmQqSZLIgOVw = UZwrCapGTsLE.kUFmQqSZLIgOVw + brPNTyNgPrThg
		if UZwrCapGTsLE.ACaCyGUvyRMXm >= UZwrCapGTsLE.YHRCxbHcwMykmI / 1000 then
			if UZwrCapGTsLE.alPUSkrHwkcfc then
				UZwrCapGTsLE.jlOZAEtWgfTYf()
				DoEXubWxSprrOV()
				UZwrCapGTsLE.alPUSkrHwkcfc = false
			end
			if UZwrCapGTsLE.OBVIJmtOTesNW and not UnitAffectingCombat('Player') then
				UZwrCapGTsLE.OBVIJmtOTesNW = false
				UZwrCapGTsLE.qirXpIVRbrXcE()
				UZwrCapGTsLE.bKgfpmEKEOlKk()
				UZwrCapGTsLE.wBiUYvoZzMecg()
			end
			suwsoIgBgfiLKZ()
			wURoDorvuNaVgh()
			dOaMVMtDDodzgW()
			cZVKALOSpOJz()
			for i = 1, GetNumGroupMembers() do
				HVgPCLhmiTkph(103 + 3 * i, 105 + 3 * i, 'raid' .. i)
			end
			for i = 1, GetNumGroupMembers() do
				fKrsMxrpIFqmYfC(103 + 3 * i, 105 + 3 * i, 'raid' .. i)
			end
			UZwrCapGTsLE.ACaCyGUvyRMXm = 0
			UZwrCapGTsLE.lTlNkcKMXisiOPf()
			UZwrCapGTsLE.fxGrQxsHTEWqpW()
		end
		if UZwrCapGTsLE.kUFmQqSZLIgOVw >= UZwrCapGTsLE.FSkXKzhIVztfV / 1000 then
			XtboFViKJIsvaSE()
			UZwrCapGTsLE.yrivStqPSyzl()
			UZwrCapGTsLE.byyQfbCzATbdr()
			UZwrCapGTsLE.SIzPIiNgMuaytvr()
			UZwrCapGTsLE.BMouBYRCaehTbD()
			qBcrtfaqaAYU()
			TrHsGrYkteXHB()
			UZwrCapGTsLE.bdsWKKyOGqEBG()
			UZwrCapGTsLE.OOcFUmwrWxiNNVc()
			PbsasAGsDjEukVx()
			EDraKfCgjQihlx()
			NbFjMGJugchDb()
			ppTGZlSdtSVl()
			UZwrCapGTsLE.xLdaHIyHYgssV()
			SuDkUzoNXiKagxY()
			wccyNSocLyeyBgF()
			ByFFVgEKOvfPLSb()
			NxtHDBhZPRKzrRg()
			UZwrCapGTsLE.FjaJtTFlxivrja()
			CQcALUiovotp()
			UZwrCapGTsLE.QFVkKliWKllaex()
			oTJpEKpEsWzRb()
			EyXGRceBvJJvbgW()
			XxUCjjxNxyXex()
			kSkFRgjlGdoOP()
			HVgPCLhmiTkph(1, 15, 'player')
			HVgPCLhmiTkph(16, 25, 'target')
			HVgPCLhmiTkph(26, 35, 'focus')
			HVgPCLhmiTkph(36, 45, 'arena1')
			HVgPCLhmiTkph(46, 55, 'arena2')
			HVgPCLhmiTkph(56, 65, 'arena3')
			for i = 1, 4 do
				HVgPCLhmiTkph(56 + 10 * i, i * 10 + 65, 'party' .. i)
			end
			for i = 1, 4 do
				HVgPCLhmiTkph(223 + 3 * i, i * 3 + 225, 'boss' .. i)
			end
			HVgPCLhmiTkph(238, 240, 'pet')
			HVgPCLhmiTkph(241, 250, 'mouseover')
			oeXfhijjvfIubeb()
			fKrsMxrpIFqmYfC(1, 15, 'player')
			fKrsMxrpIFqmYfC(16, 25, 'target')
			fKrsMxrpIFqmYfC(26, 35, 'focus')
			fKrsMxrpIFqmYfC(36, 45, 'arena1')
			fKrsMxrpIFqmYfC(46, 55, 'arena2')
			fKrsMxrpIFqmYfC(56, 65, 'arena3')
			for i = 1, 4 do
				fKrsMxrpIFqmYfC(56 + 10 * i, i * 10 + 65, 'party' .. i)
			end
			for i = 1, 4 do
				fKrsMxrpIFqmYfC(223 + 3 * i, i * 3 + 225, 'boss' .. i)
			end
			fKrsMxrpIFqmYfC(238, 240, 'pet')
			fKrsMxrpIFqmYfC(241, 250, 'mouseover')
			RYKyKGcWzjrqAlH()
			jyhCLaKmsHDfP()
			LMKdPtoVgxYXfA()
			IAEVLfqgPvjcK()
			psdJJMjjHDbf()
			LtIuqoyOzxwoS('player')
			LtIuqoyOzxwoS('target')
			LtIuqoyOzxwoS('focus')
			LtIuqoyOzxwoS('mouseover')
			UZwrCapGTsLE.kUFmQqSZLIgOVw = 0
			UZwrCapGTsLE.aNkhddXPdfHgVU = (UZwrCapGTsLE.aNkhddXPdfHgVU + 1) % 1000
			UZwrCapGTsLE.UbrfABpYRDwv(UZwrCapGTsLE.qcjmsVYqjzrBvB, UZwrCapGTsLE.aNkhddXPdfHgVU)
		end
		UZwrCapGTsLE.swaIqhVdLRyE = false
	end
end
ijaht = {}
function zPEYzbFWVUyd(self, event, ...)
	if event == 'ZONE_CHANGED_NEW_AREA' then
		for MyKey in pairs(UZwrCapGTsLE.ZjaXqpeXRqjxhp) do
			UZwrCapGTsLE.ZjaXqpeXRqjxhp[MyKey] = nil
		end
	elseif event == 'ADDON_LOADED' then
		local TKzkdyOmaIjB, TIpxbXUdrYYYter, LAMtQhlOOKdbAyZ, XXHZvUwpSgbmaL = ...
		if (TKzkdyOmaIjB == 'ijaht') then
			xGLMhNjSzOhTl()
			CaZYQuuNWkdhr()
			SetCVar('synchronizeSettings', '0')
			WckAaWaYMQHXTg()
			NVmGfEKmqVtI()
			SLASH_IJAHT1 = '/ijaht'
			SlashCmdList['IJAHT'] = VmeDEyElrSKWxyG
			if (UZwrCapGTsLE.MobEFYgPRrGk and UZwrCapGTsLE.MobEFYgPRrGk ~= 0) then
				if (#ijaht ~= 0) then
					az1 = ijaht[1]
					az3 = ijaht[2]
					az4 = ijaht[3]
					if az1 == 'LEFT' or az1 == 'CENTER' or az1 == 'RIGHT' then
						rgYogrlqTLgblY = ijaht[4]
					elseif az1 == 'TOP' or az1 == 'TOPLEFT' or az1 == 'TOPRIGHT' then
						rgYogrlqTLgblY = ijaht[4] - UZwrCapGTsLE.MobEFYgPRrGk:GetHeight()
					elseif az1 == 'BOTTOM' or az1 == 'BOTTOMLEFT' or az1 == 'BOTTOMRIGHT' then
						rgYogrlqTLgblY = ijaht[4] + UZwrCapGTsLE.MobEFYgPRrGk:GetHeight()
					end
					UZwrCapGTsLE.dtypBVWRArDXbkG = ijaht[7] or 1
					riGWccoJHQWZDe()
					UZwrCapGTsLE.MobEFYgPRrGk:ClearAllPoints()
					UZwrCapGTsLE.MobEFYgPRrGk:SetPoint(az1, UIParent, az3, az4, rgYogrlqTLgblY)
				end
			end
		end
	elseif event == 'PLAYER_STARTED_LOOKING' then
		UZwrCapGTsLE.USCVGfzjiWRPq = true
	elseif event == 'PLAYER_STARTED_TURNING' then
		UZwrCapGTsLE.VvDprpmLrTkW = true
	elseif event == 'PLAYER_STOPPED_TURNING' then
		UZwrCapGTsLE.VvDprpmLrTkW = false
	elseif event == 'PLAYER_STOPPED_LOOKING' then
		UZwrCapGTsLE.USCVGfzjiWRPq = false
	elseif event == 'PLAYER_ENTERING_WORLD' then
		SetCVar('nameplateMaxDistance', 41)
		SetCVar('nameplateShowAll', '1')
		SetCVar('Contrast', 50)
		SetCVar('Brightness', 50)
		SetCVar('Gamma', 1.0)
		SetCVar('colorblindSimulator', 0)
		SetCVar('ffxAntiAliasingMode', 0)
		SetCVar('doNotFlashLowHealthWarning', 1)
		if GetCVar('nameplateShowEnemies') == '0' then
			SetCVar('nameplateShowEnemies', '1')
		end
		if GetCVar('nameplateShowFriends') == '1' then
			SetCVar('nameplateShowFriends', '0')
		end
	elseif event == 'UI_ERROR_MESSAGE' then
		local _, plRXvGiGwdyXT = ...
		if plRXvGiGwdyXT == SPELL_FAILED_NOT_BEHIND or plRXvGiGwdyXT == SPELL_FAILED_NOT_INFRONT then
			UZwrCapGTsLE.IKWlcTrbOVAPhh = GetTime()
		end
		if (plRXvGiGwdyXT == ERR_BADATTACKFACING) then
			UZwrCapGTsLE.RqRiVzzNxVaNRjm = GetTime()
		end
	elseif event == 'NAME_PLATE_UNIT_ADDED' then
		local HROOPSlpMYOhOL = ...
		local UXrPIWHbmXajQu = UnitGUID(HROOPSlpMYOhOL)
		UZwrCapGTsLE.CsHlPlAkcfhrcIc[HROOPSlpMYOhOL] = UXrPIWHbmXajQu
	elseif event == 'NAME_PLATE_UNIT_REMOVED' then
		local HROOPSlpMYOhOL = ...
		UZwrCapGTsLE.CsHlPlAkcfhrcIc[HROOPSlpMYOhOL] = nil
	elseif event == 'COMBAT_LOG_EVENT_UNFILTERED' then
		local _, CSDOIMNDTuXsz, _, fYlmwPsTMaSLb, NbPuDGufhlGPY, bfVOleAvUuNpE, _, rcwMeLtYVErWf, fsZsyfrZkRIRKi, pkgmEwFUkbvzJgU, _, fApOsaGzYurAr, VDcXBJwWAKKDHwh, _, crSdgbrJVxEtl, _, _, bwtQABIojwicoB = CombatLogGetCurrentEventInfo()
		if (CSDOIMNDTuXsz == 'SPELL_AURA_BROKEN' or CSDOIMNDTuXsz == 'SPELL_AURA_BROKEN_SPELL' or CSDOIMNDTuXsz == 'SPELL_AURA_APPLIED' or CSDOIMNDTuXsz == 'SPELL_AURA_REFRESH') and (crSdgbrJVxEtl == 'DEBUFF' or bwtQABIojwicoB == 'DEBUFF') then
			FBoxrvKWGTIeqg(GetTime(), CSDOIMNDTuXsz, rcwMeLtYVErWf, pkgmEwFUkbvzJgU, fApOsaGzYurAr)
		end
		if fYlmwPsTMaSLb == UnitGUID('player') then
			if CSDOIMNDTuXsz == 'SPELL_CAST_START' or CSDOIMNDTuXsz == 'SPELL_CAST_SUCCESS' then
				UZwrCapGTsLE.JXsPvGpZoTRi = UZwrCapGTsLE.RPqhFJMdxobc
				UZwrCapGTsLE.XTQkGjdmJWlRc = UZwrCapGTsLE.pqeIMcvomRril
				if UZwrCapGTsLE.pqeIMcvomRril == VDcXBJwWAKKDHwh then
					UZwrCapGTsLE.RPqhFJMdxobc = UZwrCapGTsLE.RPqhFJMdxobc + 1
				else
					UZwrCapGTsLE.RPqhFJMdxobc = 1
				end
				UZwrCapGTsLE.pqeIMcvomRril = VDcXBJwWAKKDHwh
			elseif CSDOIMNDTuXsz == 'SPELL_CAST_FAILED' then
				if UZwrCapGTsLE.pqeIMcvomRril == VDcXBJwWAKKDHwh then
					UZwrCapGTsLE.pqeIMcvomRril = UZwrCapGTsLE.XTQkGjdmJWlRc
					UZwrCapGTsLE.RPqhFJMdxobc = UZwrCapGTsLE.JXsPvGpZoTRi
				end
				local kDOFacFEJBbqJOw = crSdgbrJVxEtl
				if (kDOFacFEJBbqJOw == SPELL_FAILED_UNIT_NOT_INFRONT) then
					UZwrCapGTsLE.RqRiVzzNxVaNRjm = GetTime()
				end
				if (kDOFacFEJBbqJOw == SPELL_FAILED_LINE_OF_SIGHT) then
					UZwrCapGTsLE.NENbluWkcKDv = GetTime()
				end
			elseif CSDOIMNDTuXsz == 'SPELL_CAST_SUCCESS' then
				UZwrCapGTsLE.RqRiVzzNxVaNRjm = 0
				UZwrCapGTsLE.NENbluWkcKDv = 0
			end
		end
	elseif event == 'LOSS_OF_CONTROL_ADDED' then
		local yvDmfkqdHcoyYf = ...
		local DPASUFlftaGXR = C_LossOfControl.GetActiveLossOfControlData(...)
		local CGvubumzdmMm = DPASUFlftaGXR.locType
		if CGvubumzdmMm then
			UZwrCapGTsLE.gWKbJUWLFrhsI[CGvubumzdmMm] = DPASUFlftaGXR.spellID
			if DPASUFlftaGXR.timeRemaining then
				UZwrCapGTsLE.UstOPpQRMhOjddJ[CGvubumzdmMm] = DPASUFlftaGXR.timeRemaining + GetTime()
			else
				UZwrCapGTsLE.UstOPpQRMhOjddJ[CGvubumzdmMm] = 99
			end
			UZwrCapGTsLE.guTWDWuqGWRBbVX[CGvubumzdmMm] = false
		end
	elseif event == 'UNIT_POWER_UPDATE' then
		local JkEwJHfrdtwO, ardtMokBULoKrxG = ...
		if UZwrCapGTsLE.UCblmJqVCKbBDQp == 0 and JkEwJHfrdtwO == 'player' and ardtMokBULoKrxG == 'ENERGY' then
			UZwrCapGTsLE.UCblmJqVCKbBDQp = GetTime() + 2
		end
	end
end
UZwrCapGTsLE.NGfVHqOmXtps:SetScript('OnEvent', zPEYzbFWVUyd)
UZwrCapGTsLE.NGfVHqOmXtps:SetScript('OnUpdate', dYVewiBrEBKKlo)
