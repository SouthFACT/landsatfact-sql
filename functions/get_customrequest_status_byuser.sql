-- Function: public.get_customrequest_status_byuser(varchar(25))

-- DROP FUNCTION public.get_customrequest_status_byuser(varchar(25));

CREATE OR REPLACE FUNCTION public.get_customrequest_status_byuser(cr_user_id varchar(25) )
    RETURNS SETOF custom_requests_drupalstatus AS
$BODY$

    --get the all status for by the drupal node of a custom request
    -- used to provide status to user in drupal

    --requires one argument
    -- cr_node_id::varchar(25) - drupal node of a custom request

    --returns a postgres table defined by the type custom_requests_drupalstatus
    --  node_id character varying(30) node_id of custom request
    --  user_id character varying(30) user_id of custom request
    --  aoi_name character varying(200) name of custom request
    --  status character varying(150), the current status which in this case should always be "Pending
    --  status_date timestamp without time zone, the date updated

  DECLARE
    cr_status varchar(150);
  BEGIN

  RETURN QUERY EXECUTE
          ' SELECT
    (SELECT ua.node_id FROM user_aoi as ua WHERE ua.aoi_id = cr_dates.aoi_id) as node_id,
    (SELECT ua.user_id FROM user_aoi as ua WHERE ua.aoi_id = cr_dates.aoi_id) as user_id,
    (SELECT ua.aoi_name FROM user_aoi as ua WHERE ua.aoi_id = cr_dates.aoi_id) as aoi_name,
    ( SELECT type.status
           FROM custom_request_status_types type
          WHERE type.custom_request_status_id = cr_dates.custom_request_status_id) AS status,
    cr_dates.custom_request_date::timestamp without time zone as status_date
   FROM custom_request_dates cr_dates
   WHERE (SELECT ua.user_id FROM user_aoi as ua WHERE ua.aoi_id = cr_dates.aoi_id) = $1
  GROUP BY cr_dates.aoi_id, cr_dates.custom_request_status_id
  ORDER BY (SELECT ua.node_id FROM user_aoi as ua WHERE ua.aoi_id = cr_dates.aoi_id), cr_dates.custom_request_date' USING cr_user_id

  RETURN;
  END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
ALTER FUNCTION public.get_customrequest_status_byuser(varchar(25))
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.get_customrequest_status_byuser(varchar(25)) TO public;
GRANT EXECUTE ON FUNCTION public.get_customrequest_status_byuser(varchar(25)) TO root;
GRANT EXECUTE ON FUNCTION public.get_customrequest_status_byuser(varchar(25)) TO dataonly;
GRANT EXECUTE ON FUNCTION public.get_customrequest_status_byuser(varchar(25)) TO readonly;
