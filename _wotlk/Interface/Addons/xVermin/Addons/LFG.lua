local _, xVermin = ...

xVermin:CheckIfLoadedWithTimer(
	'GroupBulletinBoardFrame',
	function()
		if not GroupBulletinBoardFrame.SetBackdrop then
			Mixin(GroupBulletinBoardFrame, BackdropTemplateMixin)
		end
		GroupBulletinBoardFrame:CreateBeautyBorder(8)
		GroupBulletinBoardFrame:SetBackdrop(
			{
				bgFile = 'Interface\\Buttons\\WHITE8x8',
				edgeFile = '',
				tile = false,
				tileSize = 0,
				edgeSize = 0,
				insets = {left = 0, right = 0, top = 0, bottom = 0}
			}
		)
		GroupBulletinBoardFrame:SetBackdropColor(0, 0, 0, 0.6)
		GroupBulletinBoardFrame:SetFrameStrata('DIALOG')
	end
)
