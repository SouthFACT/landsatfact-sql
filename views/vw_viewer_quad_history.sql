CREATE OR REPLACE VIEW public.vw_viewer_quad_history AS 
 SELECT landsat_quads.gid AS oid,
    landsat_quads.quad_id,
    landsat_quads.geom,
    vw_quad_lc_history.update_history
   FROM landsat_quads
   LEFT JOIN vw_quad_lc_history ON landsat_quads.quad_id::text = vw_quad_lc_history.quad_id;

ALTER TABLE public.vw_viewer_quad_history
  OWNER TO root;
GRANT ALL ON TABLE public.vw_viewer_quad_history TO root;
GRANT SELECT ON TABLE public.vw_viewer_quad_history TO readonly;
GRANT ALL ON TABLE public.vw_viewer_quad_history TO dataonly;
