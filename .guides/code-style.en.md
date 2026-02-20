# Code Style Guidelines
[Русский](code-style.ru.md) | **English**

We follow generally accepted code-style standards.  
And this document is not a complete description of all code-style rules,
but rather an addition to generally accepted standards in programming languages.

## Our exceptions and additions

### Line length
- Maximum line length: **120 characters**

### Tabs and indentation
- Use **tabs** for indentation
- Use **spaces** for alignment/indentation within lines

**Exception:**  
**4 spaces** instead of tab in the first block with local assignments of external functions:
```lua
local math_floor, math_random, v
····= math.floor, math.random, vector.new
```

### Alignment
- **Tables and structures**: align values vertically for readability
- **Consecutive assignments**: align the `=` signs
- **Array/table elements**: align values

Recommended:
- **Comments to the right of code**: align by column
- **Other alignments** that improve readability and fit well into the code

### Spaces
- **Inside tables**: space after opening brace and before closing `{ a = 1 }`
- **After comma**: always put a space `{ a, b, c }`
- **Around operators**:
  - spaces around `=`, `+`, `-`, `..`, `and`, `or`
  - no spaces around `*`, `/`, `%`, `^`, `..` are allowed
- **In doc-blocks**: always put a space after `---`

Recommendations:
- **In comments**: space after comment markers (`--`): `-- comment`, not `--comment`

### Naming
- **Constants** are written in caps: `MAX_PLAYERS`, `DEFAULT_COLOR`
- **Variables containing "class" description** start with capital letter: `Player`, `World`
- **Other variables** start with lowercase letter in snake_case: `player_name`, `position`

### Quotes
- **Single quotes** are used (in new files and during changes/refactoring)

### Empty lines
- Before `return` from function/method — **1 empty line**
  - **Exception**: if it's the only statement in a code block (in `if`, `for`, `function`, ...) — **0 empty lines**
- Between `local-aliases` block (local assignments of external functions) and `require` block — **1 empty line**
- After `require` block (or after `local-aliases` block if `require` block is absent) — **2 empty lines**
- Before `return` from module/class (from file) — **2 empty lines**
- Between functions/methods — **1 empty line**
  - **Exception**: if these are functions inside a definition block — **0 empty lines** (as between other table elements)

## Examples

### Proper naming and alignment
```lua
local MAX_HEALTH     = 100
local MAX_PLAYERS    = 16
local Player         = setmetatable({}, { __index = parent })
local player_name    = 'alek'
local position       = { x =   0, y =  0, z =   0 }
local spawn_position = { x = 100, y = 32, z = 200 }
```

### Proper formatting
```lua
local require, setmetatable, math_floor, math_random, v          -- this is local-aliases block
    = require, setmetatable, math.floor, math.random, vector.new -- after it 1 empty line - if there's require block or 2 empty lines - if not

local core  = require('core')  -- this is require block
local utils = require('utils') -- before it 1 empty line, because there's local-aliases block; after it 2 empty lines


-- Class/module
local Player = {}

--- Creates new player
--- @param name string
--- @return Player
function Player:new(name)
	local class = self

	self = {
		name   = name,
		health = 100,
		pos    = { x = 0, y = 0, z = 0 }
	}

	return setmetatable(self, { __index = class })
end

--- Returns player name
--- @return string
function Player:get_name()
	return self.name
end

--- Decreases player's health or kills them if health is less than or equal to 0
--- @param amount integer
function Player:take_damage(amount)
	self.health = self.health - amount
	if self.health <= 0 then
		self:die()
	end
end


return Player -- before `return` of module/class (from file) 2 empty lines
```

### Empty lines before function `return`
```lua
local function get_player_name(player)
	return player:get_player_name() -- only statement in `function` block - no empty line before `return`
end

local function get_lower_player_name(player)
	local name
	name = player:get_player_name()
	name = name:lower()

	return name -- not only statement in `function` block - with empty line before `return`
end

local function is_admin(player)
	if minetest.check_player_privs(player, {admin = true}) then
		return true -- only statement in `if` block - no empty line before return
	end

	return false -- this is already second statement in function (first - `if`) - with empty line before return
end

local function process_command(player, cmd)
	if not cmd or cmd == '' then
		minetest.chat_send_player(player:get_player_name(), 'Empty command')

		return false -- `return` is not only in `if` block - with empty line before `return`
	end

	-- command processing...

	return true -- not only - empty line before `return`
end
```
