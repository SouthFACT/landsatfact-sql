-- View: public.vw_tile_index_ndvi

-- DROP VIEW public.vw_tile_index_ndvi;

CREATE OR REPLACE VIEW public.vw_tile_index_ndvi AS
 SELECT (SELECT path_data from lsf_enviroments) || '/ndvi/16bit/'::text || products.product_id::text AS location,
    extracted_imagery.quad_id AS oid,
    lq.geom,
    products.product_date,
    wc.proj_wkt AS srs,
    lq.quad_id
   FROM products,
    landsat_quads lq,
    extracted_imagery,
    wrs2_codes wc
  WHERE products.product_type::text = 'NDVI'::text AND products.input1::text = extracted_imagery.quad_scene::text AND extracted_imagery.quad_id::text = lq.quad_id::text AND lq.wrs2_code::text = wc.wrs2_code::text;

ALTER TABLE public.vw_tile_index_ndvi
  OWNER TO root;
GRANT ALL ON TABLE public.vw_tile_index_ndvi TO root;
GRANT SELECT ON TABLE public.vw_tile_index_ndvi TO readonly;
GRANT ALL ON TABLE public.vw_tile_index_ndvi TO dataonly;
