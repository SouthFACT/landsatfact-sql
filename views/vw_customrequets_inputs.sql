
-- DROP VIEW public.vw_customrequest_inputs;

CREATE OR REPLACE VIEW public.vw_customrequest_inputs AS
  WITH aoi as(
    SELECT custom_request_scenes.aoi_id as id
  	FROM custom_request_scenes
  		LEFT JOIN custom_request_dates ON
  			custom_request_dates.aoi_id = custom_request_scenes.aoi_id
  	WHERE custom_request_dates.custom_request_status_id = 4 AND
  	      custom_request_dates.custom_request_date > ('now'::text::date - '45 days'::interval day)
  	GROUP BY custom_request_scenes.aoi_id
  )
  select
  	id,
  	quad_id,
  	MAX( CASE quad_order WHEN 1 THEN scene_id || quad_location ELSE NULL END ) AS input1,
  	MAX( CASE quad_order WHEN 2 THEN scene_id || quad_location ELSE NULL END ) AS input2
  from aoi, get_customrequestsquads(aoi.id) as gq
  group by id,quad_id;

ALTER TABLE public.vw_customrequest_inputs OWNER TO root;
GRANT ALL ON TABLE public.vw_customrequest_inputs TO root;
GRANT SELECT ON TABLE public.vw_customrequest_inputs TO readonly;
GRANT ALL ON TABLE public.vw_customrequest_inputs TO dataonly;
