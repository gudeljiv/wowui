-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local LibTSMData = select(2, ...).LibTSMData
local OptionalMat = LibTSMData:Init("OptionalMat")



-- ============================================================================
-- Quality Weight
-- ============================================================================

-- Generated with `Tests\quality_reagent_weight.py`
OptionalMat.QualityWeight = {
	["i:188658"] = 10,
	["i:189143"] = 10,
	["i:189541"] = 48,
	["i:189542"] = 48,
	["i:189543"] = 48,
	["i:190099"] = 20,
	["i:190100"] = 20,
	["i:190101"] = 20,
	["i:190311"] = 10,
	["i:190312"] = 14,
	["i:190313"] = 14,
	["i:190314"] = 14,
	["i:190394"] = 3,
	["i:190395"] = 3,
	["i:190396"] = 3,
	["i:190530"] = 48,
	["i:190531"] = 48,
	["i:190532"] = 48,
	["i:190533"] = 78,
	["i:190534"] = 78,
	["i:190535"] = 78,
	["i:190536"] = 33,
	["i:190537"] = 33,
	["i:190538"] = 33,
	["i:191250"] = 10,
	["i:191318"] = 35,
	["i:191319"] = 35,
	["i:191320"] = 35,
	["i:191321"] = 35,
	["i:191322"] = 35,
	["i:191323"] = 35,
	["i:191324"] = 36,
	["i:191325"] = 36,
	["i:191326"] = 36,
	["i:191327"] = 36,
	["i:191328"] = 36,
	["i:191329"] = 36,
	["i:191330"] = 36,
	["i:191331"] = 36,
	["i:191332"] = 36,
	["i:191336"] = 33,
	["i:191337"] = 33,
	["i:191338"] = 33,
	["i:191339"] = 32,
	["i:191340"] = 32,
	["i:191341"] = 32,
	["i:191342"] = 17,
	["i:191343"] = 17,
	["i:191344"] = 17,
	["i:191345"] = 17,
	["i:191346"] = 17,
	["i:191347"] = 17,
	["i:191348"] = 32,
	["i:191349"] = 32,
	["i:191350"] = 32,
	["i:191351"] = 27,
	["i:191352"] = 27,
	["i:191353"] = 27,
	["i:191354"] = 17,
	["i:191355"] = 17,
	["i:191356"] = 17,
	["i:191357"] = 35,
	["i:191358"] = 35,
	["i:191359"] = 35,
	["i:191360"] = 25,
	["i:191361"] = 25,
	["i:191362"] = 25,
	["i:191363"] = 21,
	["i:191364"] = 21,
	["i:191365"] = 21,
	["i:191366"] = 23,
	["i:191367"] = 23,
	["i:191368"] = 23,
	["i:191369"] = 21,
	["i:191370"] = 21,
	["i:191371"] = 21,
	["i:191372"] = 23,
	["i:191373"] = 23,
	["i:191374"] = 23,
	["i:191375"] = 23,
	["i:191376"] = 23,
	["i:191377"] = 23,
	["i:191378"] = 11,
	["i:191379"] = 11,
	["i:191380"] = 11,
	["i:191381"] = 32,
	["i:191382"] = 32,
	["i:191383"] = 32,
	["i:191384"] = 14,
	["i:191385"] = 14,
	["i:191386"] = 14,
	["i:191387"] = 22,
	["i:191388"] = 22,
	["i:191389"] = 22,
	["i:191393"] = 21,
	["i:191394"] = 21,
	["i:191395"] = 21,
	["i:191396"] = 20,
	["i:191397"] = 20,
	["i:191398"] = 20,
	["i:191399"] = 20,
	["i:191400"] = 20,
	["i:191401"] = 20,
	["i:191460"] = 3,
	["i:191461"] = 3,
	["i:191462"] = 3,
	["i:191464"] = 6,
	["i:191465"] = 6,
	["i:191466"] = 6,
	["i:191467"] = 6,
	["i:191468"] = 6,
	["i:191469"] = 6,
	["i:191470"] = 6,
	["i:191471"] = 6,
	["i:191472"] = 6,
	["i:191474"] = 11,
	["i:191475"] = 11,
	["i:191476"] = 11,
	["i:191482"] = 691,
	["i:191483"] = 691,
	["i:191484"] = 691,
	["i:191485"] = 946,
	["i:191486"] = 946,
	["i:191487"] = 946,
	["i:191488"] = 42,
	["i:191489"] = 42,
	["i:191490"] = 42,
	["i:191493"] = 39,
	["i:191494"] = 39,
	["i:191495"] = 39,
	["i:191496"] = 12,
	["i:191497"] = 12,
	["i:191498"] = 12,
	["i:191499"] = 29,
	["i:191500"] = 29,
	["i:191501"] = 29,
	["i:191502"] = 14,
	["i:191503"] = 14,
	["i:191504"] = 14,
	["i:191505"] = 14,
	["i:191506"] = 14,
	["i:191507"] = 14,
	["i:191508"] = 14,
	["i:191509"] = 14,
	["i:191510"] = 14,
	["i:191872"] = 10,
	["i:191873"] = 10,
	["i:192095"] = 4,
	["i:192096"] = 4,
	["i:192097"] = 4,
	["i:192834"] = 20,
	["i:192835"] = 20,
	["i:192836"] = 20,
	["i:192837"] = 25,
	["i:192838"] = 25,
	["i:192839"] = 25,
	["i:192840"] = 25,
	["i:192841"] = 25,
	["i:192842"] = 25,
	["i:192843"] = 25,
	["i:192844"] = 25,
	["i:192845"] = 25,
	["i:192846"] = 25,
	["i:192847"] = 25,
	["i:192848"] = 25,
	["i:192849"] = 15,
	["i:192850"] = 15,
	["i:192851"] = 15,
	["i:192852"] = 108,
	["i:192853"] = 108,
	["i:192855"] = 108,
	["i:192856"] = 108,
	["i:192857"] = 108,
	["i:192858"] = 108,
	["i:192859"] = 108,
	["i:192860"] = 108,
	["i:192861"] = 108,
	["i:192862"] = 108,
	["i:192863"] = 108,
	["i:192865"] = 108,
	["i:192866"] = 88,
	["i:192867"] = 88,
	["i:192868"] = 88,
	["i:192869"] = 254,
	["i:192870"] = 254,
	["i:192871"] = 254,
	["i:192876"] = 26,
	["i:192877"] = 26,
	["i:192878"] = 26,
	["i:192883"] = 21,
	["i:192884"] = 21,
	["i:192885"] = 21,
	["i:192887"] = 291,
	["i:193029"] = 31,
	["i:193030"] = 31,
	["i:193031"] = 31,
	["i:193208"] = 2,
	["i:193210"] = 2,
	["i:193211"] = 2,
	["i:193213"] = 2,
	["i:193214"] = 2,
	["i:193215"] = 2,
	["i:193216"] = 31,
	["i:193217"] = 31,
	["i:193218"] = 31,
	["i:193222"] = 31,
	["i:193223"] = 31,
	["i:193224"] = 31,
	["i:193226"] = 45,
	["i:193227"] = 45,
	["i:193228"] = 45,
	["i:193229"] = 45,
	["i:193230"] = 45,
	["i:193231"] = 45,
	["i:193232"] = 45,
	["i:193233"] = 45,
	["i:193234"] = 45,
	["i:193236"] = 42,
	["i:193237"] = 42,
	["i:193238"] = 42,
	["i:193239"] = 45,
	["i:193240"] = 45,
	["i:193241"] = 45,
	["i:193242"] = 45,
	["i:193243"] = 45,
	["i:193244"] = 45,
	["i:193245"] = 45,
	["i:193246"] = 45,
	["i:193247"] = 45,
	["i:193248"] = 42,
	["i:193249"] = 42,
	["i:193250"] = 42,
	["i:193368"] = 20,
	["i:193369"] = 20,
	["i:193370"] = 20,
	["i:193378"] = 291,
	["i:193379"] = 291,
	["i:193926"] = 9,
	["i:193927"] = 9,
	["i:193928"] = 9,
	["i:193929"] = 54,
	["i:193930"] = 54,
	["i:193931"] = 54,
	["i:193932"] = 29,
	["i:193933"] = 29,
	["i:193934"] = 29,
	["i:193935"] = 117,
	["i:193936"] = 117,
	["i:193937"] = 117,
	["i:193938"] = 117,
	["i:193939"] = 117,
	["i:193940"] = 117,
	["i:194008"] = 123,
	["i:194009"] = 123,
	["i:194010"] = 123,
	["i:194011"] = 218,
	["i:194012"] = 218,
	["i:194013"] = 218,
	["i:194014"] = 218,
	["i:194015"] = 218,
	["i:194016"] = 218,
	["i:194048"] = 34,
	["i:194049"] = 34,
	["i:194050"] = 34,
	["i:194545"] = 2,
	["i:194727"] = 5,
	["i:194728"] = 5,
	["i:194729"] = 5,
	["i:194751"] = 14,
	["i:194752"] = 14,
	["i:194754"] = 42,
	["i:194755"] = 42,
	["i:194756"] = 42,
	["i:194758"] = 14,
	["i:194760"] = 24,
	["i:194761"] = 24,
	["i:194767"] = 34,
	["i:194768"] = 34,
	["i:194846"] = 14,
	["i:194850"] = 14,
	["i:194852"] = 14,
	["i:194855"] = 24,
	["i:194856"] = 14,
	["i:194857"] = 14,
	["i:194858"] = 14,
	["i:194859"] = 34,
	["i:194862"] = 46,
	["i:194863"] = 46,
	["i:194864"] = 46,
	["i:198177"] = 60,
	["i:198178"] = 60,
	["i:198179"] = 60,
	["i:198183"] = 7,
	["i:198184"] = 7,
	["i:198185"] = 7,
	["i:198186"] = 9,
	["i:198187"] = 9,
	["i:198188"] = 9,
	["i:198189"] = 13,
	["i:198190"] = 13,
	["i:198191"] = 13,
	["i:198192"] = 26,
	["i:198193"] = 26,
	["i:198194"] = 26,
	["i:198195"] = 51,
	["i:198196"] = 51,
	["i:198197"] = 51,
	["i:198198"] = 75,
	["i:198199"] = 75,
	["i:198200"] = 75,
	["i:198201"] = 19,
	["i:198202"] = 19,
	["i:198203"] = 19,
	["i:198228"] = 20,
	["i:198229"] = 20,
	["i:198230"] = 20,
	["i:198239"] = 21,
	["i:198240"] = 21,
	["i:198241"] = 21,
	["i:198278"] = 22,
	["i:198279"] = 22,
	["i:198280"] = 22,
	["i:198412"] = 16,
	["i:198413"] = 16,
	["i:198414"] = 16,
	["i:198415"] = 16,
	["i:198416"] = 16,
	["i:198417"] = 16,
	["i:198418"] = 16,
	["i:198419"] = 16,
	["i:198420"] = 16,
	["i:198421"] = 6,
	["i:198422"] = 6,
	["i:198423"] = 6,
	["i:204994"] = 33,
	["i:204995"] = 33,
	["i:204996"] = 33,
	["i:210796"] = 3,
	["i:210797"] = 3,
	["i:210798"] = 3,
	["i:210799"] = 5,
	["i:210800"] = 5,
	["i:210801"] = 5,
	["i:210802"] = 5,
	["i:210803"] = 5,
	["i:210804"] = 5,
	["i:210805"] = 5,
	["i:210806"] = 5,
	["i:210807"] = 5,
	["i:210808"] = 5,
	["i:210809"] = 5,
	["i:210810"] = 5,
	["i:210930"] = 3,
	["i:210931"] = 3,
	["i:210932"] = 3,
	["i:210933"] = 4,
	["i:210934"] = 4,
	["i:210935"] = 4,
	["i:210936"] = 4,
	["i:210937"] = 4,
	["i:210938"] = 4,
	["i:211806"] = 29,
	["i:211807"] = 29,
	["i:211808"] = 29,
	["i:211878"] = 24,
	["i:211879"] = 24,
	["i:211880"] = 24,
	["i:212242"] = 32,
	["i:212243"] = 32,
	["i:212244"] = 32,
	["i:212263"] = 33,
	["i:212264"] = 33,
	["i:212265"] = 33,
	["i:212266"] = 33,
	["i:212267"] = 33,
	["i:212268"] = 33,
	["i:212563"] = 39,
	["i:212564"] = 39,
	["i:212565"] = 39,
	["i:212664"] = 2,
	["i:212665"] = 2,
	["i:212666"] = 2,
	["i:212667"] = 2,
	["i:212668"] = 2,
	["i:212669"] = 2,
	["i:212670"] = 70,
	["i:212672"] = 70,
	["i:212673"] = 70,
	["i:212674"] = 70,
	["i:212675"] = 70,
	["i:212676"] = 70,
	["i:213219"] = 12,
	["i:213220"] = 12,
	["i:213221"] = 12,
	["i:213750"] = 8,
	["i:213751"] = 8,
	["i:213752"] = 8,
	["i:213753"] = 35,
	["i:213754"] = 35,
	["i:213755"] = 35,
	["i:213756"] = 4,
	["i:213757"] = 4,
	["i:213758"] = 4,
	["i:213759"] = 73,
	["i:213760"] = 73,
	["i:213761"] = 73,
	["i:213762"] = 5,
	["i:213763"] = 5,
	["i:213764"] = 5,
	["i:213765"] = 5,
	["i:213766"] = 5,
	["i:213767"] = 5,
	["i:213768"] = 5,
	["i:213769"] = 5,
	["i:213770"] = 5,
	["i:213771"] = 5,
	["i:213772"] = 5,
	["i:213773"] = 5,
	["i:213774"] = 5,
	["i:213775"] = 5,
	["i:213776"] = 5,
	["i:217971"] = 20,
	["i:217972"] = 20,
	["i:217973"] = 20,
	["i:217974"] = 20,
	["i:217975"] = 20,
	["i:217976"] = 20,
	["i:217977"] = 20,
	["i:217978"] = 20,
	["i:217979"] = 20,
	["i:217980"] = 20,
	["i:217981"] = 20,
	["i:217982"] = 20,
	["i:219528"] = 42,
	["i:219529"] = 42,
	["i:219530"] = 42,
	["i:219534"] = 14,
	["i:219535"] = 14,
	["i:219536"] = 14,
	["i:219540"] = 46,
	["i:219541"] = 46,
	["i:219542"] = 46,
	["i:219543"] = 34,
	["i:219544"] = 34,
	["i:219545"] = 34,
	["i:219546"] = 34,
	["i:219547"] = 34,
	["i:219548"] = 34,
	["i:219549"] = 34,
	["i:219550"] = 34,
	["i:219551"] = 34,
	["i:219552"] = 34,
	["i:219553"] = 34,
	["i:219554"] = 34,
	["i:219880"] = 105,
	["i:219881"] = 105,
	["i:219882"] = 105,
	["i:219883"] = 97,
	["i:219884"] = 97,
	["i:219885"] = 97,
	["i:219886"] = 97,
	["i:219887"] = 97,
	["i:219888"] = 97,
	["i:219889"] = 97,
	["i:219890"] = 97,
	["i:219891"] = 97,
	["i:219892"] = 97,
	["i:219893"] = 97,
	["i:219894"] = 97,
	["i:219895"] = 85,
	["i:219896"] = 85,
	["i:219897"] = 85,
	["i:219898"] = 62,
	["i:219899"] = 62,
	["i:219900"] = 62,
	["i:219901"] = 64,
	["i:219902"] = 64,
	["i:219903"] = 64,
	["i:219946"] = 7,
	["i:219947"] = 7,
	["i:219948"] = 7,
	["i:219949"] = 26,
	["i:219950"] = 26,
	["i:219951"] = 26,
	["i:219952"] = 93,
	["i:219954"] = 93,
	["i:219955"] = 93,
	["i:220192"] = 10,
	["i:220193"] = 10,
	["i:220194"] = 10,
	["i:221853"] = 8,
	["i:221854"] = 8,
	["i:221855"] = 8,
	["i:221856"] = 7,
	["i:221857"] = 7,
	["i:221858"] = 7,
	["i:221859"] = 17,
	["i:221860"] = 17,
	["i:221861"] = 17,
	["i:221862"] = 20,
	["i:221863"] = 20,
	["i:221864"] = 20,
	["i:221865"] = 26,
	["i:221866"] = 26,
	["i:221867"] = 26,
	["i:221868"] = 41,
	["i:221869"] = 41,
	["i:221870"] = 41,
	["i:221911"] = 10,
	["i:221912"] = 10,
	["i:221913"] = 10,
	["i:221914"] = 10,
	["i:221915"] = 10,
	["i:221916"] = 10,
	["i:221917"] = 10,
	["i:221918"] = 10,
	["i:221919"] = 10,
	["i:221920"] = 10,
	["i:221921"] = 10,
	["i:221922"] = 10,
	["i:221923"] = 10,
	["i:221924"] = 10,
	["i:221925"] = 10,
	["i:221926"] = 10,
	["i:221927"] = 10,
	["i:221928"] = 10,
	["i:221929"] = 10,
	["i:221930"] = 10,
	["i:221931"] = 10,
	["i:221932"] = 10,
	["i:221933"] = 10,
	["i:221934"] = 10,
	["i:221935"] = 10,
	["i:221936"] = 10,
	["i:221937"] = 10,
	["i:221938"] = 10,
	["i:221939"] = 10,
	["i:221940"] = 10,
	["i:221941"] = 10,
	["i:221942"] = 10,
	["i:221943"] = 10,
	["i:222417"] = 27,
	["i:222418"] = 27,
	["i:222419"] = 27,
	["i:222420"] = 46,
	["i:222421"] = 46,
	["i:222422"] = 46,
	["i:222423"] = 70,
	["i:222424"] = 70,
	["i:222425"] = 70,
	["i:222426"] = 45,
	["i:222427"] = 45,
	["i:222428"] = 45,
	["i:222555"] = 36,
	["i:222556"] = 36,
	["i:222557"] = 36,
	["i:222558"] = 35,
	["i:222559"] = 35,
	["i:222560"] = 35,
	["i:222609"] = 18,
	["i:222610"] = 18,
	["i:222611"] = 18,
	["i:222612"] = 3,
	["i:222613"] = 3,
	["i:222614"] = 3,
	["i:222615"] = 17,
	["i:222616"] = 17,
	["i:222617"] = 17,
	["i:222618"] = 2,
	["i:222619"] = 2,
	["i:222620"] = 2,
	["i:222789"] = 13,
	["i:222790"] = 13,
	["i:222791"] = 13,
	["i:222792"] = 13,
	["i:222793"] = 13,
	["i:222794"] = 13,
	["i:222795"] = 3,
	["i:222796"] = 3,
	["i:222797"] = 3,
	["i:222798"] = 41,
	["i:222799"] = 41,
	["i:222800"] = 41,
	["i:222801"] = 41,
	["i:222802"] = 41,
	["i:222803"] = 41,
	["i:222804"] = 22,
	["i:222805"] = 22,
	["i:222806"] = 22,
	["i:222888"] = 232,
	["i:222889"] = 232,
	["i:222890"] = 232,
	["i:222891"] = 350,
	["i:222892"] = 350,
	["i:222893"] = 350,
	["i:222894"] = 350,
	["i:222895"] = 350,
	["i:222896"] = 350,
	["i:224440"] = 22,
	["i:224441"] = 22,
	["i:224442"] = 22,
	["i:224800"] = 3,
	["i:224801"] = 3,
	["i:224802"] = 3,
	["i:224803"] = 3,
	["i:224804"] = 3,
	["i:224805"] = 3,
	["i:224824"] = 10,
	["i:224826"] = 10,
	["i:224828"] = 7,
	["i:224832"] = 34,
	["i:224833"] = 34,
	["i:224834"] = 34,
	["i:225984"] = 5,
	["i:225985"] = 5,
	["i:225986"] = 5,
	["i:225987"] = 5,
	["i:225988"] = 5,
	["i:225989"] = 5,
	["i:226022"] = 34,
	["i:226023"] = 34,
	["i:226024"] = 34,
	["i:226025"] = 34,
	["i:226026"] = 34,
	["i:226027"] = 34,
	["i:226028"] = 34,
	["i:226029"] = 34,
	["i:226030"] = 34,
	["i:226031"] = 34,
	["i:226032"] = 34,
	["i:226033"] = 34,
	["i:228231"] = 7,
	["i:228232"] = 7,
	["i:228233"] = 10,
	["i:228234"] = 10,
	["i:228235"] = 10,
	["i:228236"] = 10,
	["i:228401"] = 5,
	["i:228402"] = 5,
	["i:228403"] = 5,
	["i:228404"] = 5,
	["i:228405"] = 5,
	["i:228406"] = 5,
}



-- ============================================================================
-- Info
-- ============================================================================

OptionalMat.Info = {
	["i:173161"] = { statModifier = 32 }, -- Missive of Critical Strike
	["i:173160"] = { statModifier = 36 }, -- Missive of Haste
	["i:173163"] = { statModifier = 40 }, -- Missive of Versatility
	["i:173162"] = { statModifier = 49 }, -- Missive of Mastery
	["i:180055"] = { absItemLevel = 19 }, -- Relic of the Past I
	["i:180057"] = { absItemLevel = 28 }, -- Relic of the Past II
	["i:180058"] = { absItemLevel = 39 }, -- Relic of the Past III
	["i:180059"] = { absItemLevel = 48 }, -- Relic of the Past IV
	["i:180060"] = { absItemLevel = 54 }, -- Relic of the Past V
	["i:183942"] = { absItemLevel = 87 }, -- Novice Crafter's Mark
	["i:173381"] = { absItemLevel = 117 }, -- Crafter's Mark I
	["i:173382"] = { absItemLevel = 168 }, -- Crafter's Mark II
	["i:173383"] = { absItemLevel = 200 }, -- Crafter's Mark III
	["i:173384"] = { absItemLevel = 230 }, -- Crafter's Mark of the Chained Isle
	["i:187741"] = { absItemLevel = 233 }, -- Crafter's Mark IV
	["i:187742"] = { absItemLevel = 262 }, -- Crafter's Mark of the First Ones
	["i:185960"] = { relItemLevels = { [74] = true, [87] = true }, relCraftLevel = 2 }, -- Vestige of Origins
	["i:187784"] = { relItemLevels = { [116] = true }, relCraftLevel = 3 }, -- Vestige of the Eternal
	["i:191781"] = { relItemLevels = { [74] = true }, reqCraftLevels = { [1] = true }, relCraftLevel = 4, ignored = true }, -- Vestige of the Devourers
}



-- ============================================================================
-- Item Level By Rank
-- ============================================================================

OptionalMat.ItemLevelByRank = {
	[1] = 15,
	[2] = 35,
	[3] = 50,
	[4] = 60,
	[5] = 74,
	[6] = 87,
	[7] = 116,
}
