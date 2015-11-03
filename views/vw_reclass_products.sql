-- View: public.vw_reclass_products

-- DROP VIEW public.vw_reclass_products;

CREATE OR REPLACE VIEW public.vw_reclass_products AS
 SELECT vw_last_days_products.product_id,
    landsat_quads.geom
   FROM vw_last_days_products,
    landsat_quads
  WHERE vw_last_days_products.quad_id::text = landsat_quads.quad_id::text;

ALTER TABLE public.vw_reclass_products
  OWNER TO root;
GRANT ALL ON TABLE public.vw_reclass_products TO root;
GRANT SELECT ON TABLE public.vw_reclass_products TO readonly;
GRANT ALL ON TABLE public.vw_reclass_products TO dataonly;
