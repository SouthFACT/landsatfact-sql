# landsatfact-sql
A collection of all the SQL views and SQL functions used by landsatfact.

### Functions
### function [get_countyByGeoid](functions/get_countybygeoid.sql)
Function to get url's of the images of the most recent scene to the users requested date. The intention is to call this twice once for the start date then again for the end date there should be a most recent url for each scene that the CustomRequest_GeoJson intersects.
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

<br><br>
### function [get_scenesMostRecent](functions/get_scenesmostrecent.sql)
Function to get url's of the images of the most recent scene to the users requested date. The intention is to call this twice once for the start date then again for the end date there should be a most recent url for each scene that the CustomRequest_GeoJson intersects.
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
* table of data type [scene_url](README.md#type-scene_url)

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
<br><br>
### function [get_scenesAlternate](functions/get_scenesalternate.sql)
function to get alternate urls for images of the most recent scene to the users requested date in a custom request.  This is only used when the user is not satisfied with scene image.
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
* table of data type [scene_url](README.md#type-scene_url)


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
is_validsceneinersects
------------------------
t
(1 row)
```
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

<br><br>
### function [insert_user_aoi_by_county](functions/insert_user_aoi_by_county.sql)
Used for...
```sql
    insert_user_aoi_by_county(
          node_id text,
          user_id text,
          aoi_name text,
          aoi_type text,
          county_geoid integer)
      RETURNS void
```
<br><br>
### function [insert_user_aoi_by_county](functions/insert_user_aoi_by_county.sql)
Used for...
```sql
    insert_user_aoi_by_county(
          node_id text,
          user_id text,
          aoi_name text,
          aoi_type text,
          county_geoid integer)
      RETURNS void
```
<br><br>
**Note:** replace *some geojson* with [sample GeoJSON](sampledata/buncombecounty.geojson?short_path=f249f19)
```sql
SELECT * FROM is_validSceneInersects('some geojson',4);
```
**Returns:**
```sql
is_validsceneinersects
------------------------
t
(1 row)
```
<br><br>
### function [insert_user_aoi_by_county](functions/insert_user_aoi_by_county.sql)
Used for...
```sql
    insert_user_aoi_by_county(
          node_id text,
          user_id text,
          aoi_name text,
          aoi_type text,
          county_geoid integer)
      RETURNS void
```
<br><br>



### function [insert_user_aoi_by_geojson](functions/insert_user_aoi_by_geojson.sql)
Used for...
```sql
    insert_user_aoi_by_geojson(
          node_id text,
          user_id text,
          aoi_name text,
          aoi_type text,
          geojson text)
      RETURNS void
```
<br><br>
## Views
### view [test_vw_user_notification](views/test_vw_user_notification.sql)

Used for... in function?
```sql
Columns
    aoi_id integer
    product_type character varying (6)
```
<br><br>
### view [vw_archive_product_dates](views/vw_archive_product_dates.sql)

Used for... in function?
```sql
Columns
    product_date date
    user_id character varying (30)
    node_id character varying (30)
    extent text
    lsf_url text
```
<br><br>
### view [vw_download_scenes](views/vw_download_scenes.sql)

Used for... in function?
```sql
Columns
  wrs2 text
  satellite text
  scene_id character varying (35)
  sensor character varying (25)
  acquisition_date date
  browse_url character varying (100)
  "path" integer
  row integer
  cc_full real
  cc_quad_ul real
  cc_quad_ur real
  cc_quad_ll real
  cc_quad_lr real
```
<br><br>
### view [vw_initial_mosaic_cloud](views/vw_initial_mosaic_cloud.sql)

Used for... in function?
```sql
Columns
    location  text
```
<br><br>
### view [vw_initial_mosaic_gap](views/vw_initial_mosaic_gap.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [w_initial_mosaic_ndmi](views/vw_initial_mosaic_ndmi.sql)

Used for... in function
```sql
Columns
    location text
```
<br><br>
### view [vw_initial_mosaic_ndvi](views/vw_initial_mosaic_ndvi.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_initial_mosaic_swir](views/vw_initial_mosaic_swir.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_last_days_products](viewws/vw_last_days_products.sql)

Used for... in function?
```sql
Columns
    product_id character varying (100)
    input1 character varying (40)
    input2 character varying (40)
    product_type character varying (6)
    product_date date
    quad_id input2 character varying (8)
```
<br><br>
### view [vw_last_days_scenes](views/vw_last_days_scenes.sql)

Used for... in function?
```sql
Columns
    scene_id character varying (35)
    sensor character varying (25)
    acquisition_date date
    browse_url character varying (100)
    "path" integer
    row integer
    cc_full real
    cc_quad_ul real
    cc_quad_ur real
    cc_quad_ll real
    cc_quad_lr real
    data_type_l1 character varying (5)
```
<br><br>
### view [vw_latest_quads_cloud](views/vw_latest_quads_cloud.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_cloud_new](views/vw_latest_quads_cloud_new.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_gap](views/vw_latest_quads_gap.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_gap_new](views/vw_latest_quads_gap_new.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_ndmi](views/vw_latest_quads_ndmi.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_ndmi_new](views/vw_latest_quads_ndmi_new.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_ndvi](views/vw_latest_quads_ndvi.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_ndvi_new](views/vw_latest_quads_ndvi_new.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_swir](views/vw_latest_quads_swir.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_swir_new](views/vw_latest_quads_swir_new.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_reclass_products](views/vw_reclass_products.sql)

Used for... in function?
```sql
Columns
    product_id character varying (100)
    geom geometry
```
<br><br>
### view [vw_tile_index_cloud](views/vw_tile_index_cloud.sql)

Used for... in function?
```sql
Columns
    location text
    "oid" character varying (8)
    geom geometry
    product_date date
    srs character varying (600)
```
<br><br>
### view [vw_tile_index_gap](views/vw_tile_index_gap.sql)

Used for... in function?
```sql
Columns
    location text
    "oid" character varying (8)
    geom geometry
    product_date date
    srs character varying (600)
```
<br><br>
### view [vw_tile_index_ndmi](views/vw_tile_index_ndmi.sql)

Used for... in function?
```sql
Columns
    location text
    "oid" character varying (8)
    geom geometry
    product_date date
    srs character varying (600)
```
<br><br>
### view [vw_tile_index_ndvi](views/vw_tile_index_ndvi.sql)

Used for... in function?
```sql
Columns
    location text
    "oid" character varying (8)
    geom geometry
    product_date date
    srs character varying (600)
    quad_id character varying (8)
```
<br><br>
### view [vw_tile_index_swir](views/vw_tile_index_swir.sql)

Used for... in function?
```sql
Columns
    location text
    "oid" character varying (8)
    geom geometry
    product_date date
    srs character varying (600)
```
<br><br>
### view [vw_viewer_quads](views/vw_viewer_quads.sql)

Used for... in function?
```sql
Columns
    "oid" character varying (8)
    geom geometry
    last_update date
    srs character varying (600)
    lsf_url text
    input1 character varying (40)
    input2 character varying (40)
```
<br><br>

### Data Types
### Type [scene_url](datatypes/scene_url.sql)
Data type used to return a table of data from the functions:
* [get_scenesMostRecent](README.md#function-get_scenesmostrecent)
* [get_scenesAlternate](README.md#function-get_scenesalternate)
