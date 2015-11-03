-- View: public.vw_latest_quads_cloud_new

-- DROP VIEW public.vw_latest_quads_cloud_new;

CREATE OR REPLACE VIEW public.vw_latest_quads_cloud_new AS
 SELECT vw_tile_index_cloud.location
   FROM vw_tile_index_cloud
  WHERE vw_tile_index_cloud.product_date > ('now'::text::date - '2 days'::interval day);

ALTER TABLE public.vw_latest_quads_cloud_new
  OWNER TO root;
GRANT ALL ON TABLE public.vw_latest_quads_cloud_new TO root;
GRANT SELECT ON TABLE public.vw_latest_quads_cloud_new TO readonly;
GRANT ALL ON TABLE public.vw_latest_quads_cloud_new TO dataonly;
