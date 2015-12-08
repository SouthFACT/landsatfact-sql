# Views
PostGreSQL views used by Landsat FACT.

Back to [Table of contents](README.md)

### view [test_vw_user_notification](views/test_vw_user_notification.sql)

Used for... in function?
```sql
Columns
    aoi_id integer
    product_type character varying (6)
```
Back to [Table of contents](README.md)
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
Back to [Table of contents](README.md)
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
Back to [Table of contents](README.md)
<br><br>
### view [vw_initial_mosaic_cloud](views/vw_initial_mosaic_cloud.sql)

Used for... in function?
```sql
Columns
    location  text
```
Back to [Table of contents](README.md)
<br><br>
### view [vw_initial_mosaic_gap](views/vw_initial_mosaic_gap.sql)

Used for... in function?
```sql
Columns
    location text
```
Back to [Table of contents](README.md)
<br><br>
### view [w_initial_mosaic_ndmi](views/vw_initial_mosaic_ndmi.sql)

Used for... in function
```sql
Columns
    location text
```
Back to [Table of contents](README.md)
<br><br>
### view [vw_initial_mosaic_ndvi](views/vw_initial_mosaic_ndvi.sql)

Used for... in function?
```sql
Columns
    location text
```
Back to [Table of contents](README.md)
<br><br>
### view [vw_initial_mosaic_swir](views/vw_initial_mosaic_swir.sql)

Used for... in function?
```sql
Columns
    location text
```
Back to [Table of contents](README.md)
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
Back to [Table of contents](README.md)
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
Back to [Table of contents](README.md)
<br><br>
### view [vw_latest_quads_cloud](views/vw_latest_quads_cloud.sql)

Used for... in function?
```sql
Columns
    location text
```
Back to [Table of contents](README.md)
<br><br>
### view [vw_latest_quads_cloud_new](views/vw_latest_quads_cloud_new.sql)

Used for... in function?
```sql
Columns
    location text
```
Back to [Table of contents](README.md)
<br><br>
### view [vw_latest_quads_gap](views/vw_latest_quads_gap.sql)

Used for... in function?
```sql
Columns
    location text
```
Back to [Table of contents](README.md)
<br><br>
### view [vw_latest_quads_gap_new](views/vw_latest_quads_gap_new.sql)

Used for... in function?
```sql
Columns
    location text
```
Back to [Table of contents](README.md)
<br><br>
### view [vw_latest_quads_ndmi](views/vw_latest_quads_ndmi.sql)

Used for... in function?
```sql
Columns
    location text
```
Back to [Table of contents](README.md)
<br><br>
### view [vw_latest_quads_ndmi_new](views/vw_latest_quads_ndmi_new.sql)

Used for... in function?
```sql
Columns
    location text
```
Back to [Table of contents](README.md)
<br><br>
### view [vw_latest_quads_ndvi](views/vw_latest_quads_ndvi.sql)

Used for... in function?
```sql
Columns
    location text
```
Back to [Table of contents](README.md)
<br><br>
### view [vw_latest_quads_ndvi_new](views/vw_latest_quads_ndvi_new.sql)

Used for... in function?
```sql
Columns
    location text
```
Back to [Table of contents](README.md)
<br><br>
### view [vw_latest_quads_swir](views/vw_latest_quads_swir.sql)

Used for... in function?
```sql
Columns
    location text
```
Back to [Table of contents](README.md)
<br><br>
### view [vw_latest_quads_swir_new](views/vw_latest_quads_swir_new.sql)

Used for... in function?
```sql
Columns
    location text
```
Back to [Table of contents](README.md)
<br><br>
views.md#view-
### view [vw_quilt](views/vw_quilt.sql)
This view represents the first two scenes for the project area that are less than 5% cloud covered.

**NOTES**
* days_ago represents the how many days this scene was acquired
* rank determines the order for the scene (from when it was acquired).
  * 1 is most recent scene.
  * 2 is 2nd most recent scene.

```sql
Columns
  geom geometry
  wrs2_code character varying(6)
  gid integer
  cc_ull real
  scene_id character varying(35)
  acquisition_date date
  days_ago integer
  browse_url character varying(100)
  rank bigint
```
Back to [Table of contents](README.md)
<br><br>
### view [vw_reclass_products](views/vw_reclass_products.sql)

Used for... in function?
```sql
Columns
    product_id character varying (100)
    geom geometry
```
Back to [Table of contents](README.md)
<br><br>
### view [vw_scenes_less_five](views/vw_scenes_less_five.sql)
This view represents all scenes for the project area that are less than 5% cloud covered and where acquired after July 1, 2014.

**NOTES**
* days_ago represents the how many days this scene was acquired
* rank determines the order for the scene (from when it was acquired).
  * 1 is most recent scene.
  * 2 is 2nd most recent scene.
  * and `N` is `N` most recent scene.

```sql
Columns
  geom geometry
  wrs2_code character varying(6)
  gid integer
  cc_ull real
  scene_id character varying(35)
  acquisition_date date
  days_ago integer
  browse_url character varying(100)
  rank bigint
```
Back to [Table of contents](README.md)
<br><br>
### view [vw_tile_index_customrequest](views/vw_tile_index_customrequest.sql)

Used for... in function?
```sql
Columns
    location text
    "oid" character varying (8)
    geom geometry
    product_date date
    srs character varying (600)
    process_date date
```
Back to [Table of contents](README.md)
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
Back to [Table of contents](README.md)
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
Back to [Table of contents](README.md)
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
Back to [Table of contents](README.md)
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
Back to [Table of contents](README.md)
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
Back to [Table of contents](README.md)
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
Back to [Table of contents](README.md)
<br><br>
