CREATE OR REPLACE VIEW public.vw_customrequets_hung AS
  SELECT
  	aoi_id,
  	(SELECT status FROM custom_request_status_types type where type.custom_request_status_id =  max(cr_dates.custom_request_status_id))::varchar(150) current_status,
  	min(custom_request_date) started_at,
  	max(custom_request_date) stoped_at,
  	'DAYS: ' || EXTRACT(DAYS FROM now()::timestamp -  max(custom_request_date)::timestamp ) || ' HOURS: ' || EXTRACT(HOURS FROM now()::timestamp -  max(custom_request_date)::timestamp ) as time_since_request,
  	(SELECT string_agg(tp,',')::text FROM (SELECT b.scene_id::text as tp FROM custom_request_scenes b WHERE b.aoi_id = cr_dates.aoi_id ) as hold)::text as scenes
  FROM custom_request_dates  cr_dates
  GROUP BY
  	aoi_id
  HAVING
  	max(custom_request_status_id) < 4  AND
  	 (EXTRACT(DAYS FROM now()::timestamp -  max(custom_request_date)::timestamp ) > 0 OR
     EXTRACT(HOURS FROM now()::timestamp -  max(custom_request_date)::timestamp ) > 2)
  ORDER BY
  	EXTRACT(DAYS FROM now()::timestamp -  max(custom_request_date)::timestamp ) DESC,
    EXTRACT(HOURS FROM now()::timestamp -  min(custom_request_date)::timestamp ) DESC;

ALTER TABLE public.vw_customrequets_hung OWNER TO root;
GRANT ALL ON TABLE public.vw_customrequets_hung TO root;
GRANT SELECT ON TABLE public.vw_customrequets_hung TO readonly;
GRANT ALL ON TABLE public.vw_customrequets_hung TO dataonly;
