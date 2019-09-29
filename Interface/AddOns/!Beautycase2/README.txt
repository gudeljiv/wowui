    !!!!!!!!!!!!!!!!!!!!!!!!!!!!! SPECIAL EDITON TO AFTERMATHHUI !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	!!!!!!!!!!!!!!!!!!!!!!!!!!!!! SPECIAL EDITON TO AFTERMATHHUI !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	!!!!!!!!!!!!!!!!!!!!!!!!!!!!! SPECIAL EDITON TO AFTERMATHHUI !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	
    How to use !Beautycase:
    
    CreateBorderLight(framename, borderSize, R, G, B, uL1, uL2, uR1, uR2, bL1, bL2, bR1, bR2)
	
	or 
	
    CreateBorderLight(framename, borderSize, R, G, B, uL1 = uL2, uR1, uR2, bL1, bL2, bR1, bR2)
  
    framename         -> The name of your frame, It must be a frame not a texture
	borderSize   -> The size of the simple square Border. 10, 11 or 12 looks amazing
    R, G, B      -> The colors of the Border. R = Red, G = Green, B = Blue
	bR2 - DOWN 
	bL2 - DOWN
	uL1 - <-- 
    bl1 - <--
	uR1 - -->
	bR1 - -->
	uL2 - UPP
	uR2 - UPP
	
	You can also set your own texture for that specfic border.
	
	CreateBorderLight(framename, 12, .35, .35, .35, 1)
	
	SetTexture(framename, 'Interface\\AddOns\\myaddon\\media\\mytexture.tga')
	
	You can also do ColorBorders, that makes them glow in the dark!
	
	ColorBorder(framename, R, G, B)
