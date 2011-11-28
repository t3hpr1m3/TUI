TUI["CONSTANTS"]["skins"] = {}
TUI["CONSTANTS"]["skins"]["default"] = {
	["backdrop"] = {
		bgFile = TUI["CONSTANTS"]["media"].blank,
		edgeFile = TUI["CONSTANTS"]["media"].blank,
		tile = true,
		tileSize = 16,
		edgeSize = 1 * TUI.mult,
		insets = {
			left = -1 * TUI.mult,
			right = -1 * TUI.mult,
			top = -1 * TUI.mult,
			bottom = -1 * TUI.mult
		}
	},
	["backdropColor"] = {.1, .1, .1, .9},
	["backdropBorderColor"] = {.6, .6, .6, 1},
	["backdropBorderColorHighlight"] = {.1, .7, .1, 1},
	["buttonSize"] = 32 * TUI.mult,
	["buttonSpacing"] = 4 * TUI.mult
}
