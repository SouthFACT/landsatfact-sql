-- View: public.vw_archive_product_date_range

-- DROP VIEW public.vw_archive_product_date_range;

CREATE OR REPLACE VIEW public.vw_archive_product_date_range AS
 SELECT DISTINCT ("substring"(products.input1::text, 10, 7) || '-'::text) || "substring"(products.input2::text, 10, 7) AS product_date_range,
    products.product_date,
    products.product_type
   FROM products
  WHERE products.is_on_disk = 'YES'
  ORDER BY products.product_date DESC;

ALTER TABLE public.vw_archive_product_date_range
  OWNER TO root;
GRANT ALL ON TABLE public.vw_archive_product_date_range TO root;
GRANT SELECT ON TABLE public.vw_archive_product_date_range TO readonly;
GRANT ALL ON TABLE public.vw_archive_product_date_range TO dataonly;
