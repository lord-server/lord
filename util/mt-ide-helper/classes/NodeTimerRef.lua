--- Node Timers: a high resolution persistent per-node timer.
--- Can be gotten via `core.get_node_timer(pos)`.
--- @class NodeTimerRef
NodeTimerRef = {}

---	* set a timer's state
--- * will trigger the node's `on_timer` function after `(timeout - elapsed)` seconds.
--- @param timeout number is in seconds, and supports fractional values (0.1 etc)
--- @param elapsed number is in seconds, and supports fractional values (0.1 etc)
function NodeTimerRef:set(timeout, elapsed) end

--- * start a timer.
--- * equivalent to `set(timeout,0)`.
--- @param timeout number is in seconds, and supports fractional values (0.1 etc)
function NodeTimerRef:start(timeout) end

--- stops the timer
function NodeTimerRef:stop() end
--- returns current timeout in seconds
--- * if `timeout` equals `0`, timer is inactive
--- @return number
function NodeTimerRef:get_timeout() end

--- returns current elapsed time in seconds
--- * the node's `on_timer` function will be called after `(timeout - elapsed)` seconds.
--- @return number
function NodeTimerRef:get_elapsed() end

--- returns boolean state of timer
---	* returns `true` if timer is started, otherwise `false`
--- @return boolean
function NodeTimerRef:is_started() end
