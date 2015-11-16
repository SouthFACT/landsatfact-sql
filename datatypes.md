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
  browse_url character varying(100),
  geojson text
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
### Type [custom_request_quads](datatypes/custom_request_quads.sql)

```sql
CREATE TYPE custom_request_quads as (
  aoi_id integer,
  quad_id character varying(8),
  scene_id character varying(25),
  quad_order bigint,
  wrs2_code character varying(6),
  scene_date date,
  aoi_type character varying(30),
  quad_location text,
  request_id character varying(100),
  current_status_id integer,
  current_status character varying(150)
);

```
Data type used to return a table of  custom quads from the functions:
* [get_customrequestsquads](functions.md#function-get_customrequestsquads)

Back to [Table of contents](README.md)
<br><br>
