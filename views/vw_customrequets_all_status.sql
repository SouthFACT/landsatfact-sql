-- View: public.vw_customrequets_all_status

-- DROP VIEW public.vw_customrequets_all_status;

CREATE OR REPLACE VIEW public.vw_customrequets_all_status AS
  SELECT
    (SELECT ua.node_id FROM user_aoi as ua WHERE ua.aoi_id = cr_dates.aoi_id)::varchar(30) as node_id,
    (SELECT ua.user_id FROM user_aoi as ua WHERE ua.aoi_id = cr_dates.aoi_id)::varchar(30) as user_id,
    (SELECT ua.aoi_name FROM user_aoi as ua WHERE ua.aoi_id = cr_dates.aoi_id)::varchar(200) as aoi_name,
    (SELECT status FROM custom_request_status_types type where type.custom_request_status_id =  max(cr_dates.custom_request_status_id))::varchar(150) status,
    max(custom_request_date)::timestamp without time zone status_date
  FROM custom_request_dates  cr_dates
  GROUP BY
    aoi_id
  ORDER BY
  status_date desc;

ALTER TABLE public.vw_customrequets_all_status OWNER TO root;
GRANT ALL ON TABLE public.vw_customrequets_all_status TO root;
GRANT SELECT ON TABLE public.vw_customrequets_all_status TO readonly;
GRANT ALL ON TABLE public.vw_customrequets_all_status TO dataonly;
