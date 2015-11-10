-- Function: public.get_pendingcustomrequests()

-- DROP FUNCTION public.get_pendingcustomrequests();

CREATE OR REPLACE FUNCTION public.get_pendingcustomrequests()
  RETURNS SETOF custom_requests_pending AS
$BODY$

  --function to a table or list of pending custom requests.

  --requires three arguments
  -- nothing

  --returns a postgres table defined bythe type custom_requests_pending
  --  aoi_id integer aoi_id of custom request
  --  node_id character varying(30) node_id of custom request
  --  user_id character varying(30) user_id of custom request
  --  aoi_name character varying(200) name of custom request
  --  aoi_type character varying(30), aoi type of custom request in this case should always be "custom_request"
  --  status_id integer the current status id which in this case should always be 1
  --  status character varying(150), the current status which in this case should always be "Pending"

  DECLARE
    aoi_type varchar(100);

  BEGIN
    aoi_type := 'custom_request';
    --select query for geting table custom requests which have a status of "Pending"
  	RETURN QUERY EXECUTE
            'SELECT
    cr.aoi_id,
    (SELECT node_id FROM user_aoi where user_aoi.aoi_id = cr.aoi_id) as node_id,
    (SELECT user_id FROM user_aoi where user_aoi.aoi_id = cr.aoi_id) as user_id,
    (SELECT aoi_name FROM user_aoi where user_aoi.aoi_id = cr.aoi_id) as aoi_name,
    (SELECT aoi_type FROM user_aoi where user_aoi.aoi_id = cr.aoi_id) as aoi_type,
    (SELECT sub_crd.custom_request_status_id
     FROM custom_request_dates sub_crd
      JOIN custom_request_status_types status_types ON
        sub_crd.custom_request_status_id = status_types.custom_request_status_id
     WHERE sub_crd.aoi_id = cr.aoi_id
     ORDER BY sub_crd.custom_request_status_id desc limit 1) as status_id,
    (SELECT status
     FROM custom_request_dates sub_crd
      JOIN custom_request_status_types status_types ON
        sub_crd.custom_request_status_id = status_types.custom_request_status_id
     WHERE sub_crd.aoi_id = cr.aoi_id
     ORDER BY sub_crd.custom_request_status_id desc limit 1)
  FROM custom_request_dates as cr
  WHERE  upper((select aoi_type FROM user_aoi where user_aoi.aoi_id = cr.aoi_id)) = upper($1)
  GROUP BY cr.aoi_id
  ORDER BY cr.aoi_id,
    (SELECT status
     FROM custom_request_dates sub_crd
      JOIN custom_request_status_types status_types ON
        sub_crd.custom_request_status_id = status_types.custom_request_status_id
     WHERE sub_crd.aoi_id = cr.aoi_id
     ORDER BY sub_crd.custom_request_status_id desc limit 1);' USING aoi_type

    RETURN;
  END
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_pendingcustomrequests()
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.get_pendingcustomrequests() TO public;
GRANT EXECUTE ON FUNCTION public.get_pendingcustomrequests() TO root;
GRANT EXECUTE ON FUNCTION public.get_pendingcustomrequests() TO dataonly;
GRANT EXECUTE ON FUNCTION public.get_pendingcustomrequests() TO readonly;
