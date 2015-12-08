-- View: public.vw_archive_product_dates

-- DROP VIEW public.vw_archive_product_dates;

CREATE OR REPLACE VIEW public.vw_archive_customrequest_product_dates AS
 SELECT DISTINCT products.product_date,
    products.product_type
   FROM products
  WHERE coalesce(products.analysis_source,'')::text = 'CR'
ORDER BY products.product_date DESC;

ALTER TABLE public.vw_archive_product_dates
  OWNER TO root;
GRANT ALL ON TABLE public.vw_archive_customrequest_product_dates TO root;
GRANT SELECT ON TABLE public.vw_archive_customrequest_product_dates TO readonly;
GRANT ALL ON TABLE public.vw_archive_customrequest_product_dates TO dataonly;
