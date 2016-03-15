-- View: public.vw_viewer_quads

-- DROP VIEW public.vw_viewer_quads;

CREATE OR REPLACE VIEW public.vw_viewer_quads AS 
 SELECT landsat_quads.gid AS oid,
    landsat_quads.quad_id,
    landsat_quads.geom,
    vw_quad_latest_update.last_update,
    vw_quad_latest_update.input1,
    vw_quad_latest_update.input1_date,
    vw_quad_latest_update.input2,
    vw_quad_latest_update.input2_date
   FROM landsat_quads
   LEFT JOIN vw_quad_latest_update ON landsat_quads.quad_id::text = vw_quad_latest_update.oid::text;

ALTER TABLE public.vw_viewer_quads
  OWNER TO root;
GRANT ALL ON TABLE public.vw_viewer_quads TO root;
GRANT SELECT ON TABLE public.vw_viewer_quads TO readonly;
GRANT ALL ON TABLE public.vw_viewer_quads TO dataonly;
