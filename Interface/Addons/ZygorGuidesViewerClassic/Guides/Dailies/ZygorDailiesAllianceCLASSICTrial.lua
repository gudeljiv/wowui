local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
if UnitFactionGroup("player")~="Alliance" then return end
if ZGV:DoMutex("DailiesACLASSIC") then return end
ZygorGuidesViewer.GuideMenuTier = "TRI"
