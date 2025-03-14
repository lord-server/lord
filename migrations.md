
## Migrate to 2025.03
You should generate sql-script & execute it on your DB.

Copy `races.txt` from the world of server.
The world is usually located in the `worlds` folder in the minetest/luanti folder.

#### Generate For SQLite:
```bash
$ util/races-to-sql.lua races.txt --sqlite > races.sql
```

#### For PostgreSQL:
```bash
$ util/races-to-sql.lua races.txt > races.sql
```
Then execute `races.sql` in your DB.
