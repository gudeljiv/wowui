local _, xVermin = ...

TimeManagerClockButton:SetFrameStrata("HIGH")

TimeManagerClockButton:SetScale(1)
TimeManagerClockTicker:SetScale(0.85)
TimeManagerClockTicker:ClearAllPoints()
TimeManagerClockTicker:SetPoint("CENTER", TimeManagerClockButton, "CENTER", 0, 0)