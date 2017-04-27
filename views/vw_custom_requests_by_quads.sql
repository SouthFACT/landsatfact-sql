--DROP VIEW public.vw_custom_requests_by_county;
CREATE OR REPLACE VIEW public.vw_custom_requests_by_quads AS  
	SELECT 
	  quads.gid,
	  quads.geom,
	  quads.quad_name,
	  count(aoi.aoi_name) total_scene
	FROM
	    user_aoi aoi
	   JOIN landsat_quads quads on
	     st_intersects(aoi.geom,quads.geom)
	WHERE aoi_type = 'custom_request' AND user_id != '99'AND user_id != '120' AND user_id != '106'
	GROUP BY quads.gid,quads.quad_name,quads.geom;

ALTER TABLE public.vw_custom_requests_by_county
  OWNER TO root;
GRANT ALL ON TABLE public.vw_custom_requests_by_quads TO root;
GRANT SELECT ON TABLE public.vw_custom_requests_by_quads TO readonly;
GRANT ALL ON TABLE public.vw_custom_requests_by_quads TO dataonly;