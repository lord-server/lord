lord = lord or {}

local subscribers = {}

function lord.emit(signal, context)
	local subs_for_this_signal = subscribers[name]
	if not subs_for_this_signal then
		return
	end
	for _, subscriber in ipairs(subs_for_this_signal) do
		subscriber(context)
	end
end

function lord.on(signal, callback)
	subscribers[signal] = subscribers[signal] or {}
	table.insert(subscribers[signal], callback)
end
