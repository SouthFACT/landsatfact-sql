-- DROP VIEW public.vw_custom_request_tile_index_swir;

CREATE OR REPLACE VIEW public.vw_custom_request_tile_index_swir AS
 SELECT '/lsfdata/products/swir/'::text || products.product_id::text AS location,
    extracted_imagery.quad_id AS oid,
    lq.geom,
    products.product_date,
    products.product_type,
    wc.proj_wkt AS srs,
    lq.quad_id,
    c.id AS aoi
   FROM products,
    landsat_quads lq,
    extracted_imagery,
    wrs2_codes wc,
    vw_customrequest_inputs c
  WHERE products.product_type::text = 'SWIR'::text AND
	products.analysis_source::text = 'CR'::text AND
	products.input1::text = extracted_imagery.quad_scene::text AND
	extracted_imagery.quad_id::text = lq.quad_id::text AND
	lq.wrs2_code::text = wc.wrs2_code::text AND
	(c.input1::text = products.input1::text AND
	c.input2::text = products.input2::text)
  ORDER BY c.id, lq.quad_id DESC;

ALTER TABLE public.vw_custom_request_tile_index_swir
  OWNER TO root;
GRANT ALL ON TABLE public.vw_custom_request_tile_index_swir TO root;
GRANT SELECT ON TABLE public.vw_custom_request_tile_index_swir TO readonly;
GRANT ALL ON TABLE public.vw_custom_request_tile_index_swir TO dataonly;
