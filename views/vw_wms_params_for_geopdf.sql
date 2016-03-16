CREATE OR REPLACE VIEW public.vw_wms_params_for_geopdf AS 
 SELECT user_aoi.aoi_id,
    st_extent(st_transform(user_aoi.geom, 3857))::text AS extent,
    user_aoi.aoi_type
   FROM user_aoi
  WHERE user_aoi.aoi_type::text = 'custom_request'::text
  GROUP BY user_aoi.aoi_id, user_aoi.aoi_type;

ALTER TABLE public.vw_wms_params_for_geopdf
  OWNER TO root;
GRANT ALL ON TABLE public.vw_wms_params_for_geopdf TO root;
GRANT SELECT ON TABLE public.vw_wms_params_for_geopdf TO readonly;
GRANT ALL ON TABLE public.vw_wms_params_for_geopdf TO dataonly;
