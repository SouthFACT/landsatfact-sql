# landsatfact-sql
A collection of all the SQL views and SQL functions used by landsatfact.

### Views
___
### view [test_vw_user_notification](views/test_vw_user_notification.sql)

Used for... in function?
```sql
CREATE OR REPLACE VIEW public.test_vw_user_notification AS
 SELECT DISTINCT user_aoi.aoi_id,
    user_aoi.user_id,
    user_aoi.node_id,
    st_extent(st_transform(user_aoi.geom, 900913))::text AS extent,
    ((((('http://landsatfact-map-dev.nemac.org/?theme=SE&layers='::text || vw_last_days_products.product_type::text) || date_part('year'::text, vw_last_days_products.product_date)) || date_part('month'::text, vw_last_days_products.product_date)) || (( SELECT
                CASE
                    WHEN length(date_part('day'::text, vw_last_days_products.product_date)::text) = 1 THEN '0'::text || date_part('day'::text, vw_last_days_products.product_date)::text
                    ELSE date_part('day'::text, vw_last_days_products.product_date)::text
                END AS date_part))) || ',AA&mask=&alphas=1,1&accgp=G02&basemap=Google%20Streets&extent='::text) || replace(replace(replace(st_extent(st_transform(user_aoi.geom, 900913))::text, 'BOX('::text, ''::text), ')'::text, ''::text), ' '::text, ','::text) AS lsf_url
   FROM landsat_quads,
    vw_last_days_products,
    user_aoi
  WHERE landsat_quads.quad_id::text = vw_last_days_products.quad_id::text AND st_intersects(user_aoi.geom, landsat_quads.geom) AND (vw_last_days_products.product_type::text <> ALL (ARRAY['GAP'::character varying, 'CLOUD'::character varying]::text[]))
  GROUP BY user_aoi.node_id, user_aoi.aoi_id, user_aoi.user_id, vw_last_days_products.product_type, vw_last_days_products.product_date
  ORDER BY user_aoi.user_id, user_aoi.node_id
```


**vw_archive_product_dates:** the SQL is available at [views/vw_archive_product_dates.sql](views/vw_archive_product_dates.sql)

**vw_download_scenes** the SQL is available at [views/vw_download_scenes.sql](views/vw_download_scenes.sql) and is used for..in the landsat fact project.  

**vw_initial_mosaic_cloud** the SQL is available at [views/vw_initial_mosaic_cloud.sql](views/vw_initial_mosaic_cloud.sql) and is used for..in the landsat fact project.and is used for..

**vw_initial_mosaic_gap** the SQL statement is available at [vw_initial_mosaic_gap.sql](views/vw_initial_mosaic_gap.sql) and is used for..in the landsat fact project.

**vw_initial_mosaic_ndmi**  the SQL statement is available at [vw_initial_mosaic_ndmi.sql](views/vw_initial_mosaic_ndmi.sql) and is used for..in the landsat fact project.

**vw_initial_mosaic_ndvi** the SQL statement is available at [vw_initial_mosaic_ndvi.sql](views/vw_initial_mosaic_ndvi.sql) and is used for..in the landsat fact project.

**vw_initial_mosaic_swir** the SQL statement is available at [vw_initial_mosaic_swir.sql](views/vw_initial_mosaic_swir.sql) and is used for..in the landsat fact project.

**vw_last_days_products**  the SQL statement is available at [vw_last_days_products.sql](viewws/vw_last_days_products.sql) and is used for..in the landsat fact project.

** [vw_last_days_scenes.sql](views/vw_last_days_scenes.sql)
> Brief description

** [vw_latest_quads_cloud.sql](views/vw_latest_quads_cloud.sql)
> Brief description

** [vw_latest_quads_cloud_new.sql](views/vw_latest_quads_cloud_new.sql)
> Brief description

** [vw_latest_quads_gap.sql](views/vw_latest_quads_gap.sql)
> Brief description

** [vw_latest_quads_gap_new.sql](views/vw_latest_quads_gap_new.sql)
> Brief description

** [vw_latest_quads_ndmi.sql](views/vw_latest_quads_ndmi.sql)
> Brief description

** [vw_latest_quads_ndmi_new.sql](views/vw_latest_quads_ndmi_new.sql)
> Brief description

** [vw_latest_quads_ndvi.sql](views/vw_latest_quads_ndvi.sql)
> Brief description

** [vw_latest_quads_ndvi_new.sql](views/vw_latest_quads_ndvi_new.sql)
> Brief description

** [vw_latest_quads_swir.sql](views/vw_latest_quads_swir.sql)
> Brief description

** [vw_latest_quads_swir_new.sql](views/vw_latest_quads_swir_new.sql)
> Brief description

** [vw_reclass_products.sql](views/vw_reclass_products.sql)
> Brief description

** [vw_tile_index_cloud.sql](views/vw_tile_index_cloud.sql)
> Brief description

** [vw_tile_index_gap.sql](views/vw_tile_index_gap.sql)
> Brief description

** [vw_tile_index_ndmi.sql](views/vw_tile_index_ndmi.sql)
> Brief description

** [vw_tile_index_ndvi.sql](views/vw_tile_index_ndvi.sql)
> Brief description

** [vw_tile_index_swir.sql](views/vw_tile_index_swir.sql)
> Brief description

** [vw_viewer_quads.sql](views/vw_viewer_quads.sql)
> Brief description

### Functions
---
