-- View: public.vw_last_days_scenes

-- DROP VIEW public.vw_last_days_scenes;

CREATE OR REPLACE VIEW public.vw_last_days_scenes AS
 SELECT landsat_metadata.scene_id,
    landsat_metadata.sensor,
    landsat_metadata.acquisition_date,
    landsat_metadata.browse_url,
    landsat_metadata.path,
    landsat_metadata."row",
    landsat_metadata.cc_full,
    landsat_metadata.cc_quad_ul,
    landsat_metadata.cc_quad_ur,
    landsat_metadata.cc_quad_ll,
    landsat_metadata.cc_quad_lr,
    landsat_metadata.data_type_l1
   FROM landsat_metadata
  WHERE landsat_metadata.acquisition_date > ('now'::text::date - '2 days'::interval day);

ALTER TABLE public.vw_last_days_scenes
  OWNER TO root;
GRANT ALL ON TABLE public.vw_last_days_scenes TO root;
GRANT SELECT ON TABLE public.vw_last_days_scenes TO readonly;
GRANT ALL ON TABLE public.vw_last_days_scenes TO dataonly;
