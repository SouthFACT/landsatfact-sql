--DROP VIEW public.vw_custom_requests_by_county;
CREATE OR REPLACE VIEW public.vw_custom_requests_by_state AS  
	SELECT 
	  states.gid,
	  states.geom,
	  states.dtl_counti,
	  count(aoi.aoi_name) total_scene
	FROM
	    user_aoi aoi
	   JOIN states  on
	     st_intersects(aoi.geom,states.geom)
	WHERE aoi_type = 'custom_request' AND user_id != '99'AND user_id != '120' AND user_id != '106'
	GROUP BY states.gid,states.dtl_counti,states.geom
	ORDER BY count(aoi.aoi_name);

ALTER TABLE public.vw_custom_requests_by_county
  OWNER TO root;
GRANT ALL ON TABLE public.vw_custom_requests_by_state TO root;
GRANT SELECT ON TABLE public.vw_custom_requests_by_state TO readonly;
GRANT ALL ON TABLE public.vw_custom_requests_by_state TO dataonly;