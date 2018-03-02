CREATE OR REPLACE VIEW public.vw_custom_requests_by_county_year AS
 SELECT counties.gid,
    counties.geom,
    counties.name,
    count(aoi.aoi_name) AS total_scene
   FROM user_aoi aoi
     JOIN counties ON st_intersects(aoi.geom, counties.geom)
     LEFT OUTER JOIN custom_request_dates crd ON aoi.aoi_id = crd.aoi_id
  WHERE aoi.aoi_type::text = 'custom_request'::text AND aoi.user_id::text <> '99'::text AND
	aoi.user_id::text <> '120'::text AND aoi.user_id::text <> '106'::text AND custom_request_date > '2017-01-31'
  GROUP BY counties.gid, counties.name, counties.geom
  ORDER BY count(aoi.aoi_name);
