
--- A ColorString is a string that represents a color. It can be one of the following:
---  * a named color, e.g. `"red"`, `"blue"`, `"green"`, etc.
---    (see [CSS Color Module Level 4](https://www.w3.org/TR/css-color-4/#named-colors) for a full list of named colors)
---  * a named color with alpha, e.g. `"red#08"`, `"blue#FF"`, `"green#F"`, etc.
---  * an RGB or RGBA hex color code, e.g. `"#RRGGBB"` or `"#RRGGBBAA"`, where `RR`, `GG`, `BB`, and `AA` are two-digit hexadecimal numbers representing the red, green, blue, and alpha (opacity) components of the color.
---    * e.g. `"#FF0000"` for red, `"#00FF00"` for green, `"#0000FF"` for blue, etc.
---  * a shorthand hex color code, e.g. `"#RGB"` or `"#RGBA"`, where `R`, `G`, `B`, and `A` are single-digit hexadecimal numbers representing the red, green, blue, and alpha (opacity) components of the color.
--- @class ColorString: string



--- A ColorSpec specifies a 32-bit color. It can be written in any of the following forms:
---  * table form: Each element ranging from 0..255 (a, if absent, defaults to 255):
---      `colorspec = {a=255, r=0, g=255, b=0}`
---  * numerical form: The raw integer value of an ARGB8 quad:
---      `colorspec = 0xFF00FF00`
---  * string form: A ColorString (defined above):
---      `colorspec = "green"`
--- @class ColorSpec: {r:number, g:number, b:number, a:number}|ColorString|number
