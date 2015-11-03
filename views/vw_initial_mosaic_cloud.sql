-- View: public.vw_initial_mosaic_cloud

-- DROP VIEW public.vw_initial_mosaic_cloud;

CREATE OR REPLACE VIEW public.vw_initial_mosaic_cloud AS
 SELECT DISTINCT ON (vw_tile_index_cloud.oid) vw_tile_index_cloud.location
   FROM vw_tile_index_cloud
  WHERE vw_tile_index_cloud.product_date > ('now'::text::date - '18 days'::interval day)
  GROUP BY vw_tile_index_cloud.oid, vw_tile_index_cloud.location, vw_tile_index_cloud.product_date
  ORDER BY vw_tile_index_cloud.oid, vw_tile_index_cloud.product_date;

ALTER TABLE public.vw_initial_mosaic_cloud
  OWNER TO root;
GRANT ALL ON TABLE public.vw_initial_mosaic_cloud TO root;
GRANT SELECT ON TABLE public.vw_initial_mosaic_cloud TO readonly;
GRANT ALL ON TABLE public.vw_initial_mosaic_cloud TO dataonly;
