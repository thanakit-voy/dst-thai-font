_G = GLOBAL

local FontNames = {
	DEFAULTFONT = _G.DEFAULTFONT,
	DIALOGFONT = _G.DIALOGFONT,
	TITLEFONT = _G.TITLEFONT,
	UIFONT = _G.UIFONT,
	BUTTONFONT = _G.BUTTONFONT,
	NEWFONT = _G.NEWFONT,
	NEWFONT_SMALL = _G.NEWFONT_SMALL,
	NEWFONT_OUTLINE = _G.NEWFONT_OUTLINE,
	NEWFONT_OUTLINE_SMALL = _G.NEWFONT_OUTLINE_SMALL,
	NUMBERFONT = _G.NUMBERFONT,
	TALKINGFONT = _G.TALKINGFONT,
	SMALLNUMBERFONT = _G.SMALLNUMBERFONT,
	BODYTEXTFONT = _G.BODYTEXTFONT,
	CODEFONT = _G.CODEFONT,
	TALKINGFONT_WORMWOOD = _G.TALKINGFONT_WORMWOOD,
	HEADERFONT = _G.HEADERFONT,
	CHATFONT = _G.HEADERFONT,
	CHATFONT_OUTLINE = _G.CHATFONT_OUTLINE,
}

function ApplyLocalizedFonts()

	_G.DEFAULTFONT = FontNames.DEFAULTFONT
	_G.DIALOGFONT = FontNames.DIALOGFONT
	_G.TITLEFONT = FontNames.TITLEFONT
	_G.UIFONT = FontNames.UIFONT
	_G.BUTTONFONT = FontNames.BUTTONFONT
	_G.NEWFONT = FontNames.NEWFONT
	_G.NEWFONT_SMALL = FontNames.NEWFONT_SMALL
	_G.NEWFONT_OUTLINE = FontNames.NEWFONT_OUTLINE
	_G.NEWFONT_OUTLINE_SMALL = FontNames.NEWFONT_OUTLINE_SMALL
	_G.NUMBERFONT = FontNames.NUMBERFONT
	_G.TALKINGFONT = FontNames.TALKINGFONT
	_G.SMALLNUMBERFONT = FontNames.SMALLNUMBERFONT
	_G.BODYTEXTFONT = FontNames.BODYTEXTFONT
	_G.CODEFONT = FontNames.CODEFONT
	_G.TALKINGFONT_WORMWOOD = FontNames.TALKINGFONT_WORMWOOD
	_G.HEADERFONT = FontNames.HEADERFONT
	_G.CHATFONT = FontNames.CHATFONT
	_G.CHATFONT_OUTLINE = FontNames.CHATFONT_OUTLINE


	_G.TheSim:UnloadFont("talkingfont")
	_G.TheSim:UnloadFont("bellefair50")
	_G.TheSim:UnloadFont("bellefair50_outline")
	_G.TheSim:UnloadFont("stint-ucr20")
	_G.TheSim:UnloadFont("stint-ucr50")
	_G.TheSim:UnloadPrefabs({"th".."_fonts_"..modname})

	local LocalizedFontAssets = {}
	table.insert(LocalizedFontAssets, _G.Asset("FONT", MODROOT.."fonts/talkingfont__TH.zip"))
	table.insert(LocalizedFontAssets, _G.Asset("FONT", MODROOT.."fonts/bellefair50__TH.zip"))
	table.insert(LocalizedFontAssets, _G.Asset("FONT", MODROOT.."fonts/bellefair50_outline__TH.zip"))
	table.insert(LocalizedFontAssets, _G.Asset("FONT", MODROOT.."fonts/stint-ucr20__TH.zip"))
	table.insert(LocalizedFontAssets, _G.Asset("FONT", MODROOT.."fonts/stint-ucr50__TH.zip"))

	local LocalizedFontsPrefab = _G.Prefab("common/".."th".."_fonts_"..modname, nil, LocalizedFontAssets)
	_G.RegisterPrefabs(LocalizedFontsPrefab)
	_G.TheSim:LoadPrefabs({"th".."_fonts_"..modname})

	_G.TheSim:LoadFont(MODROOT.."fonts/talkingfont__TH.zip", "talkingfont")
	_G.TheSim:LoadFont(MODROOT.."fonts/bellefair50__TH.zip", "bellefair50")
	_G.TheSim:LoadFont(MODROOT.."fonts/bellefair50_outline__TH.zip", "bellefair50_outline")
	_G.TheSim:LoadFont(MODROOT.."fonts/stint-ucr20__TH.zip", "stint-ucr20")
	_G.TheSim:LoadFont(MODROOT.."fonts/stint-ucr50__TH.zip", "stint-ucr50")

	_G.TheSim:SetupFontFallbacks("bellefair50", _G.DEFAULT_FALLBACK_TABLE)
	_G.TheSim:SetupFontFallbacks("bellefair50_outline", _G.DEFAULT_FALLBACK_TABLE_OUTLINE)

	_G.NUMBERFONT = "stint-ucr50"
	_G.TALKINGFONT = "talkingfont"
	_G.SMALLNUMBERFONT = "stint-ucr20"
	_G.BODYTEXTFONT = "stint-ucr50"
	_G.TALKINGFONT_WORMWOOD = "talkingfont"
	_G.HEADERFONT = "bellefair50"
	_G.CHATFONT = "bellefair50"
	_G.CHATFONT_OUTLINE = "bellefair50_outline"

end

_G.getmetatable( _G.TheSim).__index.UnregisterAllPrefabs = (function()
	local oldUnregisterAllPrefabs = _G.getmetatable( _G.TheSim).__index.UnregisterAllPrefabs
	return function(self, ...)
		oldUnregisterAllPrefabs(self, ...)
		ApplyLocalizedFonts()
	end
end)()

local OldRegisterPrefabs = _G.ModManager.RegisterPrefabs
local function NewRegisterPrefabs(self)
	OldRegisterPrefabs(self)
	ApplyLocalizedFonts()
end
_G.ModManager.RegisterPrefabs=NewRegisterPrefabs

local OldStart = _G.Start --
function _G.Start()
	ApplyLocalizedFonts()
	OldStart()
end