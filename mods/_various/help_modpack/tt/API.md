# Tooltip API
This API explains how to handle the extended item tooltips (`description` field).

## Fields

Add these to the item definition.

* `_tt_ignore`: If `true`, the `description` of this item won't be altered at all
* `_tt_help`: Custom help text

Once this mod had overwritten the `description` field of an item was overwritten, it will save the original (unaltered) `description` in the `_tt_original_description` field.

## `tt.register_snippet(func)`

Register a custom snippet function.
`func` is a function of the form `func(itemstring)`.
It will be called for (nearly) every itemstring.

Returns: Two values, the first one is required.
1st return value: A string you want to append to this item or `nil` if nothing shall be appended.
2nd return value: If nil, `tt` will take of the text color. If a ColorString in `"#RRGGBB"` format, entire text is colorized in this color. Return `false` to force `tt` to not apply text any colorization (useful if you want to call `minetest.colorize` yourself.

Example:

```
tt.register_snippet(function(itemstring)
	if minetest.get_item_group(itemstring, "magic") == 1 then
		return "This item is magic"
	end
end)
```
