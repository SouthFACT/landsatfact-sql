-- View: public.vw_latest_quads_swir_new

-- DROP VIEW public.vw_latest_quads_swir_new;

CREATE OR REPLACE VIEW public.vw_latest_quads_swir_new AS
 SELECT vw_tile_index_swir.location
   FROM vw_tile_index_swir
  WHERE vw_tile_index_swir.product_date > ('now'::text::date - '2 days'::interval day);

ALTER TABLE public.vw_latest_quads_swir_new
  OWNER TO root;
GRANT ALL ON TABLE public.vw_latest_quads_swir_new TO root;
GRANT SELECT ON TABLE public.vw_latest_quads_swir_new TO readonly;
GRANT ALL ON TABLE public.vw_latest_quads_swir_new TO dataonly;
