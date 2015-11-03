-- View: public.vw_latest_quads_ndvi_new

-- DROP VIEW public.vw_latest_quads_ndvi_new;

CREATE OR REPLACE VIEW public.vw_latest_quads_ndvi_new AS
 SELECT vw_tile_index_ndvi.location
   FROM vw_tile_index_ndvi
  WHERE vw_tile_index_ndvi.product_date > ('now'::text::date - '2 days'::interval day);

ALTER TABLE public.vw_latest_quads_ndvi_new
  OWNER TO root;
GRANT ALL ON TABLE public.vw_latest_quads_ndvi_new TO root;
GRANT SELECT ON TABLE public.vw_latest_quads_ndvi_new TO readonly;
GRANT ALL ON TABLE public.vw_latest_quads_ndvi_new TO dataonly;
