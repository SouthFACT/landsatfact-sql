--DROP VIEW public.vw_custom_requests_by_county;
CREATE OR REPLACE VIEW public.vw_custom_requests_by_county AS  
	SELECT 
	  counties.gid,
	  counties.geom,
	  counties.name,
	  count(aoi.aoi_name) total_scene
	FROM
	    user_aoi aoi
	   JOIN counties  on
	     st_intersects(aoi.geom,counties.geom)
	WHERE aoi_type = 'custom_request' AND user_id != '99'AND user_id != '120' AND user_id != '106'
	GROUP BY counties.gid,counties.name,counties.geom
	ORDER BY count(aoi.aoi_name);

ALTER TABLE public.vw_custom_requests_by_county
  OWNER TO root;
GRANT ALL ON TABLE public.vw_custom_requests_by_county TO root;
GRANT SELECT ON TABLE public.vw_custom_requests_by_county TO readonly;
GRANT ALL ON TABLE public.vw_custom_requests_by_county TO dataonly;