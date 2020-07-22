local i, n = 0
for b = 0, 4 do
	for s = 1, GetContainerNumSlots(b) do
		ClearCursor()
		i = {GetContainerItemInfo(b, s)}
		n = i[7]
		if n and string.find(n, "9d9d9d") then
			PickupContainerItem(b, s)
			DeleteCursorItem()
		end
	end
end
