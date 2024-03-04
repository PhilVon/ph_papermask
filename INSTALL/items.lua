return {
    ['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0,
		buttons = {
			{
				label = 'Modify',
				close = true,
				action = function(slot)
					pcall(function() return exports.ph_papermask:convert(slot) end)
				end
			}
		},
		client = {
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},
    ["papermask1"] = {
		label = "Paper Mask",
		weight = 1,
		stack = false,
		consume = 0,
		client = {
			anim = { dict = 'mp_masks@standard_car@ps@', clip = 'put_on_mask'},
			usetime = 270,
			export = 'ph_papermask.putonmmask'
		},
	},
	["markerpen"] = {
		label = "Sharpie",
		weight = 1,
		stack = false,
		close = false,
	},
}