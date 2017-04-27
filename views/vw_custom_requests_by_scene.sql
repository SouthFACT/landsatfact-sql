--DROP VIEW public.vw_custom_requests_by_county;
CREATE OR REPLACE VIEW public.vw_custom_requests_by_scene AS  
	SELECT 
	  scenes.gid,
	  scenes.geom,
	  scenes.scene,
	  count(aoi.aoi_name) total_scene
	FROM
	    user_aoi aoi
	   JOIN scene_boundaries scenes on
	     st_intersects(aoi.geom,scenes.geom)
	WHERE aoi_type = 'custom_request' AND user_id != '99'AND user_id != '120' AND user_id != '106'
	GROUP BY scenes.gid,scenes.scene,scenes.geom;

ALTER TABLE public.vw_custom_requests_by_county
  OWNER TO root;
GRANT ALL ON TABLE public.vw_custom_requests_by_scene TO root;
GRANT SELECT ON TABLE public.vw_custom_requests_by_scene TO readonly;
GRANT ALL ON TABLE public.vw_custom_requests_by_scene TO dataonly;