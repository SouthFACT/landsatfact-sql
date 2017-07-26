-- View: public.vw_archive_product_dates

-- DROP VIEW public.vw_archive_product_dates;

CREATE OR REPLACE VIEW public.vw_archive_product_dates AS 
 SELECT DISTINCT products.product_date,
    products.product_type
   FROM products
  WHERE (products.disk_status::text = 'on_disk'::text OR products.product_date > '2016-06-11'::date) AND COALESCE(products.analysis_source, ''::character varying)::text <> 'CR'::text AND products.product_date <= '2016-12-13'::date
  ORDER BY products.product_date DESC;


ALTER TABLE public.vw_archive_product_dates
  OWNER TO root;
GRANT ALL ON TABLE public.vw_archive_product_dates TO root;
GRANT SELECT ON TABLE public.vw_archive_product_dates TO readonly;
GRANT ALL ON TABLE public.vw_archive_product_dates TO dataonly;
