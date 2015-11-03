-- View: public.vw_initial_mosaic_ndmi

-- DROP VIEW public.vw_initial_mosaic_ndmi;

CREATE OR REPLACE VIEW public.vw_initial_mosaic_ndmi AS
 SELECT DISTINCT ON (vw_tile_index_ndmi.oid) vw_tile_index_ndmi.location
   FROM vw_tile_index_ndmi
  WHERE vw_tile_index_ndmi.product_date > ('now'::text::date - '18 days'::interval day)
  GROUP BY vw_tile_index_ndmi.oid, vw_tile_index_ndmi.location, vw_tile_index_ndmi.product_date
  ORDER BY vw_tile_index_ndmi.oid, vw_tile_index_ndmi.product_date;

ALTER TABLE public.vw_initial_mosaic_ndmi
  OWNER TO root;
GRANT ALL ON TABLE public.vw_initial_mosaic_ndmi TO root;
GRANT SELECT ON TABLE public.vw_initial_mosaic_ndmi TO readonly;
GRANT ALL ON TABLE public.vw_initial_mosaic_ndmi TO dataonly;
