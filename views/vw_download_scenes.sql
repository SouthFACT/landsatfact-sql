-- View: public.vw_download_scenes

-- DROP VIEW public.vw_download_scenes;

CREATE OR REPLACE VIEW public.vw_download_scenes AS
 SELECT DISTINCT ON ("substring"(landsat_metadata.scene_id::text, 4, 6)) "substring"(landsat_metadata.scene_id::text, 4, 6) AS wrs2,
    "substring"(landsat_metadata.scene_id::text, 3, 1) AS satellite,
    landsat_metadata.scene_id,
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
  ORDER BY "substring"(landsat_metadata.scene_id::text, 4, 6), "substring"(landsat_metadata.scene_id::text, 3, 1);

  ALTER TABLE public.vw_download_scenes OWNER TO root;
  GRANT ALL ON TABLE public.vw_download_scenes TO root;
  GRANT SELECT ON TABLE public.vw_download_scenes TO readonly;
  GRANT ALL ON TABLE public.vw_download_scenes TO dataonly;
