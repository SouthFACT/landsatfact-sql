-- View: public.vw_initial_mosaic_ndvi

-- DROP VIEW public.vw_initial_mosaic_ndvi;

CREATE OR REPLACE VIEW public.vw_initial_mosaic_ndvi AS
 SELECT DISTINCT ON (vw_tile_index_ndvi.oid) vw_tile_index_ndvi.location
   FROM vw_tile_index_ndvi
  WHERE vw_tile_index_ndvi.product_date > ('now'::text::date - '18 days'::interval day)
  GROUP BY vw_tile_index_ndvi.oid, vw_tile_index_ndvi.location, vw_tile_index_ndvi.product_date
  ORDER BY vw_tile_index_ndvi.oid, vw_tile_index_ndvi.product_date;

ALTER TABLE public.vw_initial_mosaic_ndvi
  OWNER TO root;
GRANT ALL ON TABLE public.vw_initial_mosaic_ndvi TO root;
GRANT SELECT ON TABLE public.vw_initial_mosaic_ndvi TO readonly;
GRANT ALL ON TABLE public.vw_initial_mosaic_ndvi TO dataonly;
