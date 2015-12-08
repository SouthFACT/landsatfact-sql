CREATE OR REPLACE VIEW public.vw_tile_index_customrequest AS
	SELECT
	  '/lsfdata/products/'::text ||
		(CASE WHEN product_type = 'GAP'OR  product_type = 'CLOUD'
			THEN  lower(product_type) || '_mask' ELSE  lower(product_type)    END) ::text
		||  '/'::text || products.product_id::text AS location,
	    extracted_imagery.quad_id AS oid,
	    lq.geom,
	    products.product_date,
	    wc.proj_wkt AS srs,
	    extracted_imagery.process_date,
			(((date (SUBSTR(products.input1::text, 10, 4) || '-01-01')::date +  interval '1 day' * SUBSTR(products.input1::text, 14, 3)::integer  )::date -  interval '1 day')::date)::text || '_' ||
		  (((date (SUBSTR(products.input2::text, 10, 4) || '-01-01')::date +  interval '1 day' * SUBSTR(products.input2::text, 14, 3)::integer  )::date -  interval '1 day')::date)::text scene_dates
	   FROM products,
	    landsat_quads lq,
	    extracted_imagery,
	    wrs2_codes wc
	  WHERE analysis_source = 'CR'
	  AND products.input1::text = extracted_imagery.quad_scene::text
	  AND extracted_imagery.quad_id::text = lq.quad_id::text
	  AND lq.wrs2_code::text = wc.wrs2_code::text
	ORDER BY products.product_date DESC;

ALTER TABLE public.vw_tile_index_customrequest OWNER TO root;
GRANT ALL ON TABLE public.vw_tile_index_customrequest TO root;
GRANT SELECT ON TABLE public.vw_tile_index_customrequest TO readonly;
GRANT ALL ON TABLE public.vw_tile_index_customrequest TO dataonly;
