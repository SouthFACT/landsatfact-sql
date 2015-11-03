-- View: public.vw_initial_mosaic_swir

-- DROP VIEW public.vw_initial_mosaic_swir;

CREATE OR REPLACE VIEW public.vw_initial_mosaic_swir AS
 SELECT DISTINCT ON (vw_tile_index_swir.oid) vw_tile_index_swir.location
   FROM vw_tile_index_swir
  WHERE vw_tile_index_swir.product_date > ('now'::text::date - '18 days'::interval day)
  GROUP BY vw_tile_index_swir.oid, vw_tile_index_swir.location, vw_tile_index_swir.product_date
  ORDER BY vw_tile_index_swir.oid, vw_tile_index_swir.product_date;

ALTER TABLE public.vw_initial_mosaic_swir
  OWNER TO root;
GRANT ALL ON TABLE public.vw_initial_mosaic_swir TO root;
GRANT SELECT ON TABLE public.vw_initial_mosaic_swir TO readonly;
GRANT ALL ON TABLE public.vw_initial_mosaic_swir TO dataonly;
