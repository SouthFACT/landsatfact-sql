# landsatfact-sql
A collection of all the SQL views and SQL functions used by landsatfact.

### Functions
### function [is_validsceneinersects](functions/is_validsceneinersects       s.sql)
  function to ensure custom request geometry intersects <= n (number) of scenes.  Where n is the number of scenes the custom request geometery is allowed to intersect.

  **requires**
  * CustomRequest_GeoJSON text containing Custom Request GeoJSON
  * allowed_Intersections integer that represents the maximum number of intersections allowed.

  **returns**
  * boolean
    * True if the number of scenes less than or equal to the allowed intersections
    * False if the number of scenes is greater the allowed intersections
  ```sql
      is_validsceneinersects(
            customrequest_geojson text,
            allowed_intersections integer)
        RETURNS boolean
  ```

**Example:**

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
