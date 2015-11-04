# landsatfact-sql
A collection of all the SQL views and SQL functions used by landsatfact.

## Views
___
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
### view [vw_download_scenes.sql](views/vw_download_scenes.sql)

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
### view [vw_initial_mosaic_cloud.sql](views/vw_initial_mosaic_cloud.sql)

Used for... in function?
```sql
Columns
    location  text
```
<br><br>
### view [vw_initial_mosaic_gap.sql](views/vw_initial_mosaic_gap.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [w_initial_mosaic_ndmi.sql](views/vw_initial_mosaic_ndmi.sql)

Used for... in function
```sql
Columns
    location text
```
<br><br>
### view [vw_initial_mosaic_ndvi.sql](views/vw_initial_mosaic_ndvi.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_initial_mosaic_swir.sql](views/vw_initial_mosaic_swir.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_last_days_products.sql](viewws/vw_last_days_products.sql)

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
### view [vw_last_days_scenes.sql](views/vw_last_days_scenes.sql)

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
### view [vw_latest_quads_cloud.sql](views/vw_latest_quads_cloud.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_cloud_new.sql](views/vw_latest_quads_cloud_new.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_gap.sql](views/vw_latest_quads_gap.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_gap_new.sql](views/vw_latest_quads_gap_new.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_ndmi.sql](views/vw_latest_quads_ndmi.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_ndmi_new.sql](views/vw_latest_quads_ndmi_new.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_ndvi.sql](views/vw_latest_quads_ndvi.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_ndvi_new.sql](views/vw_latest_quads_ndvi_new.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_swir.sql](views/vw_latest_quads_swir.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_latest_quads_swir_new.sql](views/vw_latest_quads_swir_new.sql)

Used for... in function?
```sql
Columns
    location text
```
<br><br>
### view [vw_reclass_products.sql](views/vw_reclass_products.sql)

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
### view [vw_tile_index_cloud.sql](views/vw_tile_index_cloud.sql)

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
### view [vw_tile_index_gap.sql](views/vw_tile_index_gap.sql)

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
### view [vw_tile_index_ndmi.sql](views/vw_tile_index_ndmi.sql)

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
### view [vw_tile_index_ndvi.sql](views/vw_tile_index_ndvi.sql)

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
### view [vw_tile_index_swir.sql](views/vw_tile_index_swir.sql)

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
### view [vw_viewer_quads.sql](views/vw_viewer_quads.sql)

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
### Functions
---
