-- View: public.vw_latest_quads_ndmi_new

-- DROP VIEW public.vw_latest_quads_ndmi_new;

CREATE OR REPLACE VIEW public.vw_latest_quads_ndmi_new AS
 SELECT vw_tile_index_ndmi.location
   FROM vw_tile_index_ndmi
  WHERE vw_tile_index_ndmi.product_date > ('now'::text::date - '2 days'::interval day);

ALTER TABLE public.vw_latest_quads_ndmi_new
  OWNER TO root;
GRANT ALL ON TABLE public.vw_latest_quads_ndmi_new TO root;
GRANT SELECT ON TABLE public.vw_latest_quads_ndmi_new TO readonly;
GRANT ALL ON TABLE public.vw_latest_quads_ndmi_new TO dataonly;
