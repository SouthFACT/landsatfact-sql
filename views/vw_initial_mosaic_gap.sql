-- View: public.vw_initial_mosaic_gap

-- DROP VIEW public.vw_initial_mosaic_gap;

CREATE OR REPLACE VIEW public.vw_initial_mosaic_gap AS
 SELECT DISTINCT ON (vw_tile_index_gap.oid) vw_tile_index_gap.location
   FROM vw_tile_index_gap
  WHERE vw_tile_index_gap.product_date > ('now'::text::date - '18 days'::interval day)
  GROUP BY vw_tile_index_gap.oid, vw_tile_index_gap.location, vw_tile_index_gap.product_date
  ORDER BY vw_tile_index_gap.oid, vw_tile_index_gap.product_date;

ALTER TABLE public.vw_initial_mosaic_gap
  OWNER TO root;
GRANT ALL ON TABLE public.vw_initial_mosaic_gap TO root;
GRANT SELECT ON TABLE public.vw_initial_mosaic_gap TO readonly;
GRANT ALL ON TABLE public.vw_initial_mosaic_gap TO dataonly;
