# Data Types
PostGreSQL Data Types used by Landsat FACT.

Back to [Table of contents](README.md)

### Type [scene_url](datatypes/scene_url.sql)

```sql
CREATE TYPE scene_url as (
  daysfrom integer,
  cc_full real,
  scene_id character varying(35),
  wrs2_code character varying(6),
  acquistion_date date,
  browse_url character varying(100)
);
```
Data type used to return a table of data from the functions:
* [get_scenesMostRecent](functions.md#function-get_scenesmostrecent)
* [get_scenesAlternate](functions.md#function-get_scenesalternate)

Back to [Table of contents](README.md)
<br><br>
