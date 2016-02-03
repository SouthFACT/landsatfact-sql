CREATE OR REPLACE VIEW public.vw_customrequets_inputs AS
  WITH aoi as(
  SELECT aoi_id as id from custom_request_scenes group by aoi_id
  )
  select
  	id,
  	quad_id,
  	MAX( CASE quad_order WHEN 1 THEN scene_id || quad_location ELSE NULL END ) AS input1,
  	MAX( CASE quad_order WHEN 2 THEN scene_id || quad_location ELSE NULL END ) AS input2
  from aoi, get_customrequestsquads(aoi.id) as gq
  group by id,quad_id;

ALTER TABLE public.vw_customrequets_hung OWNER TO root;
GRANT ALL ON TABLE public.vw_customrequets_hung TO root;
GRANT SELECT ON TABLE public.vw_customrequets_hung TO readonly;
GRANT ALL ON TABLE public.vw_customrequets_hung TO dataonly;
