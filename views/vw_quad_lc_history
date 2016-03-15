CREATE OR REPLACE VIEW public.vw_quad_lc_history AS 
 SELECT "substring"(products.product_id::text, 4, 6) || "substring"(products.product_id::text, 22, 2) AS quad_id,
    string_agg(((((((((('<b>'::text || products.product_date::text) || '</b>'::text) || ' | '::text) || products.input1::text) || ' | '::text) || (((substr(products.input1::text, 10, 4) || '-01-01'::text)::date) + (substr(products.input1::text, 14, 3)::integer - 1))) || ' | '::text) || products.input2::text) || ' | '::text) || (((substr(products.input2::text, 10, 4) || '-01-01'::text)::date) + (substr(products.input2::text, 14, 3)::integer - 1)), '<br>'::text ORDER BY products.product_date DESC) AS update_history
   FROM products
  WHERE products.analysis_source::text = 'LCV'::text AND products.product_type::text = 'NDVI'::text
  GROUP BY "substring"(products.product_id::text, 4, 6) || "substring"(products.product_id::text, 22, 2)
  ORDER BY "substring"(products.product_id::text, 4, 6) || "substring"(products.product_id::text, 22, 2);

ALTER TABLE public.vw_quad_lc_history
  OWNER TO root;
GRANT ALL ON TABLE public.vw_quad_lc_history TO root;
GRANT SELECT ON TABLE public.vw_quad_lc_history TO readonly;
GRANT ALL ON TABLE public.vw_quad_lc_history TO dataonly;
