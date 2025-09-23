--- @diagnostic disable: missing-return


--- e.g. `"a,b":split(",")` returns `{"a","b"}`
--- @param separator?      string   cannot be empty, default: `","`
--- @param include_empty?  boolean  default: `false`
--- @param max_splits?     number   if it's negative, splits aren't limited, default: `-1`
--- @param sep_is_pattern? boolean  it specifies whether separator is a plain string or a pattern (regex), default: `false`
--- @return string[]
function string:split(separator, include_empty, max_splits, sep_is_pattern) end

--- Returns the string without whitespace pre- and suffixes
--- e.g. `"\n \t\tfoo bar\t ":trim()` returns `"foo bar"`
--- @return string
function string:trim() end
