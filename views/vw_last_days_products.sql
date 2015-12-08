-- View: public.vw_last_days_products

-- DROP VIEW public.vw_last_days_products;

CREATE OR REPLACE VIEW public.vw_last_days_products AS
 SELECT products.product_id,
    products.input1,
    products.input2,
    products.product_type,
    products.product_date,
    extracted_imagery.quad_id
   FROM products
   JOIN extracted_imagery ON products.input2::text = extracted_imagery.quad_scene::text
  WHERE products.product_date > ('now'::text::date - '2 days'::interval day)
  ORDER BY products.product_date DESC;

ALTER TABLE public.vw_last_days_products
  OWNER TO root;
GRANT ALL ON TABLE public.vw_last_days_products TO root;
GRANT SELECT ON TABLE public.vw_last_days_products TO readonly;
GRANT ALL ON TABLE public.vw_last_days_products TO dataonly;
