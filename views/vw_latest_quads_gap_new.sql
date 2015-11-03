-- View: public.vw_latest_quads_gap_new

-- DROP VIEW public.vw_latest_quads_gap_new;

CREATE OR REPLACE VIEW public.vw_latest_quads_gap_new AS
 SELECT vw_tile_index_gap.location
   FROM vw_tile_index_gap
  WHERE vw_tile_index_gap.product_date > ('now'::text::date - '2 days'::interval day);

ALTER TABLE public.vw_latest_quads_gap_new
  OWNER TO root;
GRANT ALL ON TABLE public.vw_latest_quads_gap_new TO root;
GRANT SELECT ON TABLE public.vw_latest_quads_gap_new TO readonly;
GRANT ALL ON TABLE public.vw_latest_quads_gap_new TO dataonly;
