--- @class ABMDefinition
local ABMDefinition = {
	--- Descriptive label for profiling purposes (optional).
	--- Definitions with identical labels will be listed as one.
	--- @type string
	label             = "Lava cooling",

	--- Apply `action` function to these nodes.
	--- `group:groupname` can also be used here.
	--- @type string[]
	nodenames         = { "default:lava_source" },

	--- Only apply `action` to nodes that have one of, or any
	--- combination of, these neighbors.
	--- If left out or empty, any neighbor will do.
	--- `group:groupname` can also be used here.
	--- @type string[]
	neighbors         = { "default:water_source", "default:water_flowing" },

	--- Only apply `action` to nodes that have no one of these neighbors.
	--- If left out or empty, it has no effect.
	--- `group:groupname` can also be used here.
	--- @type string[]
	without_neighbors = { "default:lava_source", "default:lava_flowing" },

	--- Operation interval in seconds
	--- @type number
	interval          = 10.0,

	--- Probability of triggering `action` per-node per-interval is 1.0 / chance (integers only)
	--- @type number
	chance            = 50,

	--- min and max height levels where ABM will be processed (inclusive)
	--- can be used to reduce CPU usage
	--- @type number
	min_y             = -32768,
	--- min and max height levels where ABM will be processed (inclusive)
	--- can be used to reduce CPU usage
	--- @type number
	max_y             = 32767,

	--- If true, catch-up behavior is enabled: The `chance` value is
	--- temporarily reduced when returning to an area to simulate time lost
	--- by the area being unattended. Note that the `chance` value can often
	--- be reduced to 1.
	--- @type boolean
	catch_up          = true,

	--- Function triggered for each qualifying node.
	--- `active_object_count` is number of active objects in the node's
	--- mapblock.
	--- `active_object_count_wider` is number of active objects in the node's
	--- mapblock plus all 26 neighboring mapblocks. If any neighboring
	--- mapblocks are unloaded an estimate is calculated for them based on
	--- loaded mapblocks.
	--- @type fun(pos:Position, node:NodeTable, active_object_count:number, active_object_count_wider:number)
	action            = function(pos, node, active_object_count, active_object_count_wider) end,
}
