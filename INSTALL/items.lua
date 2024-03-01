return {
    ['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 1,
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
		stack = true,
		close = true,
		client = {
			disable = { move = true, car = true, combat = true },
			usetime = 500,
			export = 'ph_papermask.putonmmask'
		},
	},
}