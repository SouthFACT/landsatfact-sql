-- View: public.vw_aoi_alerts

-- DROP VIEW public.vw_aoi_alerts;

CREATE OR REPLACE VIEW public.vw_aoi_alerts AS
 SELECT t2.aoi_id,
    t3.product_id
   FROM landsat_quads t1
     JOIN user_aoi t2 ON st_intersects(t1.geom, t2.geom)
     JOIN vw_last_days_products t3 ON t3.input1::text ~~ concat('%', t1.wrs2_code, '%') AND "right"(t3.input1::text, 2) = "right"(t1.quad_id::text, 2) AND (t3.product_type::text = ANY (ARRAY['SWIR'::character varying, 'GAP'::character varying, 'CLOUD'::character varying]::text[]))
  ORDER BY t2.aoi_id, t3.product_type;

  ALTER TABLE public.vw_aoi_alerts OWNER TO root;
  GRANT ALL ON TABLE public.vw_aoi_alerts TO root;
  GRANT SELECT ON TABLE public.vw_aoi_alerts TO readonly;
  GRANT ALL ON TABLE public.vw_aoi_alerts TO dataonly;
