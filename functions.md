# Functions
A List of PostGreSQL functions used by landsat FACT.

Back to [Table of contents](README.md)

### function [delete_user_aoi_by_nid](functions/delete_user_aoi_by_nid.sql)
Function to delete a record from the subscription/custom request table.  User has indicated they no longer want subscription or cancel's custom request.
```sql
delete_user_aoi_by_nid(nid text) RETURNS void
```
**requires**
* nid text the node_id of a subscription or custom request


**returns**

* Not available for this type of function

**Example:**

```sql
SELECT * FROM delete_user_aoi_by_nid('552');
```
**Returns:**
```sql
delete_user_aoi_by_nid
------------------------------

(1 row)
```
Back to [Table of contents](README.md)
<br><br>
### function [get_aoi_id_by_nodeid](functions/get_aoi_id_by_nodeid.sql)
function gets the aoi_id for the users area of interest (subscription or custom request). The aoi_id is auto created and after insertion of new user_aoi (subscription or custom request)
 this functions provides a way to retrieve the aoi_id based on node_id.

```sql
get_aoi_id_by_nodeid(
    pass_node_id text)
  RETURNS integer
```
**requires**
* node_id text for the custom request


**returns**
*  aoi_id the aoi_id for the node_id

**Example:**

```sql
select * from get_aoi_id_by_nodeid('640');
```
**Returns:**
```sql
get_aoi_id_by_nodeid
----------------------
                 181
(1 row)
```

Back to [Table of contents](README.md)
<br><br>
<br><br>
### function [get_countyByGeoid](functions/get_countybygeoid.sql)
Function to get GeoJSON for a county by the counties geoid.
```sql
get_countybygeoid(countygeoid integer)
  RETURNS text
```
**requires**
* countygeoid integer the geoid of a county


**returns**
* text that represents the GeoJSON of the county

**Example:**

```sql
SELECT * FROM get_countyByGeoid(37021);
```
**Returns:**
* [sample GeoJSON](sampledata/buncombecounty.geojson?short_path=f249f19)

Back to [Table of contents](README.md)
<br><br>
### function [get_scenesAlternate](functions/get_scenesalternate.sql)
function to get alternate images for a custom request.  This is only used when the user is not satisfied with scene image.
```sql
get_scenesAlternate(
  customrequest_geojson text,
  customrequest_date date,
  wrs2_code text)
RETURNS SETOF scene_url
```
**requires**
* CustomRequest_GeoJSON text containing Custom Request GeoJSON
* customrequest_date date the date passed by the user for the custom request.  agnostic to start or end date date format is yyyy-mm-dd or mm-dd-yyyy or yyyy/mm/dd or mm/dd/yyyy.
* wrs2_code text the wrs2_code of the scene to find alternate images for.

**returns**
* table of data type [scene_url](datatypes.md#type-scene_url)


**Example:**

**Note:** replace *some geojson* with [sample GeoJSON](sampledata/buncombecounty.geojson?short_path=f249f19)
```sql
SELECT * FROM get_scenesAlternate('some geojson','2015-10-05','018035');
```
**Returns:**
```sql
daysfrom | cc_full |       scene_id        | wrs2_code | acquistion_date |                                      browse_url                                       
----------+---------+-----------------------+-----------+-----------------+---------------------------------------------------------------------------------------
       -4 |   97.39 | LE70180352015274EDC00 | 018035    | 2015-10-01      | http://earthexplorer.usgs.gov/browse/etm/18/35/2015/LE70180352015274EDC00.jpg
       12 |    0.04 | LE70180352015290EDC00 | 018035    | 2015-10-17      | http://earthexplorer.usgs.gov/browse/etm/18/35/2015/LE70180352015290EDC00_REFL.jpg
      -12 |   27.83 | LC80180352015266LGN00 | 018035    | 2015-09-23      | http://earthexplorer.usgs.gov/browse/landsat_8/2015/018/035/LC80180352015266LGN00.jpg
      -20 |    0.04 | LE70180352015258EDC00 | 018035    | 2015-09-15      | http://earthexplorer.usgs.gov/browse/etm/18/35/2015/LE70180352015258EDC00_REFL.jpg
      -28 |    38.7 | LC80180352015250LGN00 | 018035    | 2015-09-07      | http://earthexplorer.usgs.gov/browse/landsat_8/2015/018/035/LC80180352015250LGN00.jpg
      -36 |   99.54 | LE70180352015242EDC00 | 018035    | 2015-08-30      | http://earthexplorer.usgs.gov/browse/etm/18/35/2015/LE70180352015242EDC00.jpg
      -44 |    59.8 | LC80180352015234LGN00 | 018035    | 2015-08-22      | http://earthexplorer.usgs.gov/browse/landsat_8/2015/018/035/LC80180352015234LGN00.jpg
      -52 |   24.05 | LE70180352015226EDC00 | 018035    | 2015-08-14      | http://earthexplorer.usgs.gov/browse/etm/18/35/2015/LE70180352015226EDC00.jpg
      -60 |   80.65 | LC80180352015218LGN00 | 018035    | 2015-08-06      | http://earthexplorer.usgs.gov/browse/landsat_8/2015/018/035/LC80180352015218LGN00.jpg
      -68 |   54.56 | LE70180352015210EDC00 | 018035    | 2015-07-29      | http://earthexplorer.usgs.gov/browse/etm/18/35/2015/LE70180352015210EDC00.jpg
```
Back to [Table of contents](README.md)
<br><br>
### function [get_scenesMostRecent](functions/get_scenesmostrecent.sql)
Function to get images for a scene that was taken closest to the users requested date. The intention is to call this twice once for the start date then again for the end date.  There should be a image and url for each scene that the CustomRequest_GeoJson intersects.
```sql
get_scenesMostRecent(
    customrequest_geojson text,
    customrequest_date date)
RETURNS SETOF scene_url
```
**requires**
* CustomRequest_GeoJSON text containing Custom Request GeoJSON
* customrequest_date date the date passed by the user for the custom request.  agnostic to start or end date date format is yyyy-mm-dd or mm-dd-yyyy or yyyy/mm/dd or mm/dd/yyyy.

**returns**
* table of data type [scene_url](datatypes.md#type-scene_url)

**Example:**

**Note:** replace *some geojson* with [sample GeoJSON](sampledata/buncombecounty.geojson?short_path=f249f19)
```sql
SELECT * FROM get_scenesMostRecent('some geojson','2015-10-05');
```
**Returns:**
```sql
daysfrom | cc_full |       scene_id        | wrs2_code | acquistion_date |                                  browse_url                                   
----------+---------+-----------------------+-----------+-----------------+-------------------------------------------------------------------------------
      -4 |   97.39 | LE70180352015274EDC00 | 018035    | 2015-10-01      | http://earthexplorer.usgs.gov/browse/etm/18/35/2015/LE70180352015274EDC00.jpg
(1 row)
```
Back to [Table of contents](README.md)
<br><br>
### function [initiate_custom_request](functions/initiate_custom_request.sql)
initiates the custom request process in the database. writes data to the PostGreSQL database for the Custom request python scripts to begin processing
* updates the table custom_requests with a new custom request
* updates the table custom_request_scenes with all scenes used by the custom request
* updates the table custom_request_dates marks status as pending with the current date

**NOTES**  
assumes that functions [insert_user_aoi_by_county](functions.md#function-insert_user_aoi_by_county) or  [insert_user_aoi_by_geojson](functions.md#function-insert_user_aoi_by_geojson) were called previously.

```sql
  initiate_custom_request(
      aoi_id text,
      user_id text,
      scenes text
      )
    RETURNS void
```
**requires**
* aoi_id text the node id of the custom request
* user_id the user_id for the custom request
* scenes as text comma delimited string of scene_ids from the landsat FACT ui

**returns**

Not Available for insert function

**Example**

```sql
select * from initiate_custom_request('9999','99','LE70180352015274EDC00,LE70180352015274EDC00');
```
**Returns:**
```sql
initiate_custom_request
------------------------------

(1 row)
```

Back to [Table of contents](README.md)
<br><br>
### function [insert_custom_request_scenes](functions/insert_custom_request_scenes.sql)
function inserts record into insert_custom_request_scenes to record each scene used by a custom request.
```sql
  insert_custom_request_scenes(
    aoi_id integer,
    scene_id character varying (35))
  RETURNS void
```
**requires**
* aoi_id integer the aoi_id of the custom request.
* scene_id character varying (35) the Landsat scene id.

**returns**

Not Available for insert function

**Example**

```sql
SELECT * FROM insert_custom_request_scenes(144,'LE70180352015274EDC00');
```
**Returns:**
```sql
insert_custom_request_scenes
------------------------------

(1 row)
```

Back to [Table of contents](README.md)
<br><br>
### function [insert_user_aoi_by_county](functions/insert_user_aoi_by_county.sql)
inserts a new subscription or custom request into the user_aoi table with a county.

```sql
    insert_user_aoi_by_county(
          node_id text,
          user_id text,
          aoi_name text,
          aoi_type text,
          county_geoid integer)
      RETURNS void
```
**requires**
* node_id text the node_id for the subscription or custom request (Drupal)
* user_id text the user_id for the subscription or custom request (Drupal)
* aoi_name text the subscription or custom request name
* aoi_type text the subscription or custom request type (subscription or custom request)
* county_geoid integer the county geoid

**returns**

* Not Available for insert function

**Example**

```sql
SELECT * FROM insert_user_aoi_by_county('552','16','Buncombe County','subscription',37021);
```
**Returns:**
```sql
insert_user_aoi_by_county
------------------------------

(1 row)
```

Back to [Table of contents](README.md)
<br><br>
### function [insert_user_aoi_by_geojson](functions/insert_user_aoi_by_geojson.sql)
inserts a new subscription or custom request into the user_aoi with GeoJSON
```sql
    insert_user_aoi_by_geojson(
          node_id text,
          user_id text,
          aoi_name text,
          aoi_type text,
          geojson text)
      RETURNS void
```
**requires**
* node_id text the node_id for the subscription or custom request (Drupal)
* user_id text the user_id for the subscription or custom request (Drupal)
* aoi_name text the subscription or custom request name
* aoi_type text the subscription or custom request type (subscription or custom request)
* geojson text the GeoJSON of a shape

**returns**

* Not Available for insert function

**Example**

**Note:** replace *some geojson* with [sample GeoJSON](sampledata/buncombecounty.geojson?short_path=f249f19)
```sql
SELECT * FROM insert_user_aoi_by_geojson('552','16','Buncombe County','subscription','some geojson');
```
**Returns:**
```sql
insert_user_aoi_by_geojson
------------------------------

(1 row)
```
Back to [Table of contents](README.md)
<br><br>
### function [is_validSceneIntersects](functions/is_validsceneintersects.sql)
function to ensure custom request geometry intersects <= n (number) of scenes.  Where n is the number of scenes the custom request geometry is allowed to intersect.
```sql
is_validSceneIntersects(
      customrequest_geojson text,
      allowed_intersections integer)
  RETURNS boolean
```
**requires**
* CustomRequest_GeoJSON text containing Custom Request GeoJSON
* allowed_Intersections integer that represents the maximum number of intersections allowed.

**returns**
* boolean
  * True if the number of scenes less than or equal to the allowed intersections
  * False if the number of scenes is greater the allowed intersections


**Example:**

**Note:** replace *some geojson* with [sample GeoJSON](sampledata/buncombecounty.geojson?short_path=f249f19)
```sql
SELECT * FROM is_validSceneIntersects('some geojson',4);
```
**Returns:**
```sql
is_validSceneIntersects
------------------------
t
(1 row)
```
Back to [Table of contents](README.md)
<br><br>
### function [update_custom_request_status](functions/update_custom_request_status.sql)
function updates the custom_request_dates table with the users status and the current date time.
```sql
  update_custom_request_status(
    aoi_id text,
    status integer)
  RETURNS void
```
**requires**
* aoi_id text the node id of the custom request
* status integer where:
  * 1  -"Pending"
  * 2 - "Process Start"
  * 3 - "Process Complete"
  * 4 - "Completed".

**returns**

* Not Available for this type of function.

**Example:**

```sql
select * from update_custom_request_status('9999',2);
```
**Returns:**
```sql
update_custom_request_status
------------------------
t
(1 row)
```
update table:
```sql
aoi_id |    custom_request_date     | custom_request_status_id
--------+----------------------------+--------------------------
  9999 | 2015-11-09 18:03:01.759427 |                        1
  9999 | 2015-11-09 18:24:11.219049 |                        2
(2 rows)
```
Back to [Table of contents](README.md)
<br><br>
### function [update_user_aoi_by_county](functions/update_user_aoi_by_county.sql)
function to update a geometry in the subscription/custom request table.  Called when user selects a county.
```sql
update_user_aoi_by_county(
    nid text,
    county_geoid integer)
  RETURNS void
```
**requires**
* nid text node_id for the custom request or subscription.
* county_geoid integer County geoid for inserting geometry.

**returns**

* Not Available for this type of function.

**Example:**

```sql
SELECT * FROM update_user_aoi_by_county('552',37021);
```
**Returns:**
```sql
update_user_aoi_by_county
------------------------
t
(1 row)
```
Back to [Table of contents](README.md)
<br><br>
### function [update_user_aoi_by_geojson](functions/update_user_aoi_by_geojson.sql)
function to update a geometry in the subscription/custom request table.  Called when user submits a custom geometry.
```sql
update_user_aoi_by_geojson(
    nid text,
    geojson text)
  RETURNS void
```
**requires**
* nid text node_id for the custom request or subscription.
* geojson text GeoJSON text for geometry.

**returns**

* Not Available for this type of function.

**Example:**

**Note:** replace *some geojson* with [sample GeoJSON](sampledata/buncombecounty.geojson?short_path=f249f19)
```sql
SELECT * FROM update_user_aoi_by_geojson('552','some geojson');
```
**Returns:**
```sql
update_user_aoi_by_county
------------------------
t
(1 row)
```
Back to [Table of contents](README.md)
<br><br>
