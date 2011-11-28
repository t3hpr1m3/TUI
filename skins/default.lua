local F, C = unpack(select(2, ...))

C["skins"] = {
	["default"] = {
		["backdrop"] = {
			bgFile = C["media"].blank,
			edgeFile = C["media"].blank,
			tile = false,
			tileSize = 0,
			edgeSize = 1,
			insets = {
				left = -1,
				right = -1,
				top = -1,
				bottom = -1
			}
		},
		["backdropColor"] = {.1, .1, .1, .8},
		["backdropBorderColor"] = {.6, .6, .6},
		["backdropBorderColorHighlight"] = {.1, .7, .1},
		["buttonSize"] = 30,
		["buttonSpacing"] = 4
	}
}
