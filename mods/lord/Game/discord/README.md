# LongPoll APi mod for minetest

### Add this mods to the trusted_mods:
- Open : minetest.confg
- Add : **secure.http_mods = lp_api**

### Add parameters if needed in to minetest.confg
* `lp_api.enabled` - enable/disable (Default: `false`)
* `lp_api.url` - LongPoll server url (Default: `http://localhost:8003`)
* `lp_api.channel_id` - Channel ID in Discord. Rightclick on the Discord text channel you want the bot to interact with and press "Copy ID", and then insert value in this (Default: `minetest`)
* `lp_api.timeout` - Timeout connection (Default: `30`)
* `lp_api.header` - Header if needed (Default: `nil`)
* `lp_api.subscriber.timeout` - Timeout for subscribe (Default: `15`)
* `lp_api.router.cmd` - Support commands or not (Default: `false`)

License
----

MIT
