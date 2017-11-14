-- View: public.vw_list_products_files

-- DROP VIEW public.vw_list_products_files;

CREATE OR REPLACE VIEW public.vw_list_products_files AS
  SELECT
    product_id,
    (SELECT path_data FROM lsf_enviroments limit 1) ||
    '/' ||
    CASE WHEN product_type = 'CLOUD' THEN 'cloud_mask' ELSE
      CASE WHEN product_type = 'GAP' THEN 'gap_mask' ELSE
      CASE WHEN product_type = 'CIRRUS' THEN 'cirrus_mask' ELSE lower(product_type)
    END END END ||
    '/' ||
    product_id as file,
    is_on_disk
  FROM products
  ORDER BY product_date desc;

ALTER TABLE public.vw_list_products_files
  OWNER TO root;
GRANT ALL ON TABLE public.vw_list_products_files TO root;
GRANT SELECT ON TABLE public.vw_list_products_files TO readonly;
GRANT ALL ON TABLE public.vw_list_products_files TO dataonly;
