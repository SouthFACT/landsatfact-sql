-- View: public.test_vw_user_notification

-- DROP VIEW public.test_vw_user_notification;

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
  ORDER BY user_aoi.user_id, user_aoi.node_id;

ALTER TABLE public.test_vw_user_notification
  OWNER TO root;
GRANT ALL ON TABLE public.test_vw_user_notification TO root;
GRANT SELECT ON TABLE public.test_vw_user_notification TO readonly;
GRANT ALL ON TABLE public.test_vw_user_notification TO dataonly;
