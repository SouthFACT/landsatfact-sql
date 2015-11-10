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
### Type [custom_requests_pending](datatypes/custom_requests_pending.sql)

```sql
CREATE TYPE custom_requests_pending as (
  aoi_id integer,
  node_id character varying(30),
  user_id character varying(30),
  aoi_name character varying(200),
  aoi_type character varying(30),
  status_id integer,
  status character varying(150),
);

```
Data type used to return a table of pending custom requests from the functions:
* [get_pendingCustomRequests](functions.md#function-get_pendingcustomrequests)

Back to [Table of contents](README.md)
<br><br>
