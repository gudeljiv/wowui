local _, xVermin = ...

local f = CreateFrame('Frame')
f:RegisterEvent('MAIL_SHOW')
f:RegisterEvent('MAIL_INBOX_UPDATE')

f:SetScript(
	'OnEvent',
	function(self, event, ...)
		for mailbox = 1, 50 do
			if _G["MailItem" .. mailbox .. "Button"] and not _G["MailItem" .. mailbox .. "Button"]:HasBeautyBorder() then 
				_G["MailItem" .. mailbox .. "Button"]:CreateBeautyBorder(8)
			end
		end
		
		for attachment = 1, 16 do
			-- local name, itemTexture, count, quality, canUse = GetInboxItem(mailbox, attachment)
			if _G["OpenMailAttachmentButton" .. attachment] and not _G["OpenMailAttachmentButton" .. attachment]:HasBeautyBorder() then 
				_G["OpenMailAttachmentButton" .. attachment]:CreateBeautyBorder(8)
			end
		end
	end
)