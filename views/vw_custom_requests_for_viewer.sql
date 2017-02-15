CREATE OR REPLACE VIEW public.vw_custom_requests_for_viewer AS 
 SELECT extracted_imagery.quad_id AS oid,
    lq.geom,
    products.product_date,
    products.product_type,
    wc.proj_wkt AS srs,
    lq.quad_id,
    c.aoi_id AS aoi,
    rtrim(custom_requests.request_id::text, '.zip'::text) AS request_id,
    custom_request_dates.custom_request_date
   FROM products,
    landsat_quads lq,
    extracted_imagery,
    wrs2_codes wc,
    custom_request_scenes c,
    custom_requests,
    custom_request_dates
  WHERE custom_request_dates.custom_request_date > ('now'::text::date - '45 days'::interval day) AND products.analysis_source::text = 'CR'::text AND products.input1::text = extracted_imagery.quad_scene::text AND extracted_imagery.quad_id::text = lq.quad_id::text AND lq.wrs2_code::text = wc.wrs2_code::text AND c.scene_id::text = extracted_imagery.scene_id::text AND custom_requests.aoi_id = c.aoi_id AND custom_request_dates.aoi_id = c.aoi_id AND custom_request_dates.custom_request_status_id = 4;

ALTER TABLE public.vw_custom_requests_for_viewer
  OWNER TO root;
GRANT ALL ON TABLE public.vw_custom_requests_for_viewer TO root;
GRANT SELECT ON TABLE public.vw_custom_requests_for_viewer TO readonly;
GRANT ALL ON TABLE public.vw_custom_requests_for_viewer TO dataonly;
