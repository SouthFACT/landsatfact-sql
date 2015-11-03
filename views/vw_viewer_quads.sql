-- View: public.vw_viewer_quads

-- DROP VIEW public.vw_viewer_quads;

CREATE OR REPLACE VIEW public.vw_viewer_quads AS
 SELECT extracted_imagery.quad_id AS oid,
    lq.geom,
    max(products.product_date) AS last_update,
    wc.proj_wkt AS srs,
    products.input1,
    products.input2
   FROM extracted_imagery,
    landsat_quads lq,
    wrs2_codes wc,
    products
  WHERE products.input1::text = extracted_imagery.quad_scene::text AND extracted_imagery.quad_id::text = lq.quad_id::text AND lq.wrs2_code::text = wc.wrs2_code::text
  GROUP BY extracted_imagery.quad_id, lq.geom, wc.proj_wkt, products.input1, products.input2
  ORDER BY max(products.product_date) DESC;

ALTER TABLE public.vw_viewer_quads
  OWNER TO root;
GRANT ALL ON TABLE public.vw_viewer_quads TO root;
GRANT SELECT ON TABLE public.vw_viewer_quads TO readonly;
GRANT ALL ON TABLE public.vw_viewer_quads TO dataonly;
