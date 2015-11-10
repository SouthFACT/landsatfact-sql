-- Function: public.get_statusbyaoiid(integer)

-- DROP FUNCTION public.get_statusbyaoiid(integer);

CREATE OR REPLACE FUNCTION public.get_statusbyaoiid(cr_aoi_id integer)
  RETURNS text AS
$BODY$

    --get the status by the aoid of a custom request

    --requires one argument
    -- cr_aoi_id::integer - aoi_id of a custom request

    --returns cr_status varchar(150)

  DECLARE
    cr_status varchar(150);
  BEGIN
      --select the status for the matching aoid into the return varriable cr_status
      SELECT INTO cr_status (SELECT status FROM custom_request_status_types as type where type.custom_request_status_id  = cr_date.custom_request_status_id )::varchar(150)
      FROM custom_request_dates cr_date
      WHERE aoi_id = cr_aoi_id;
      RETURN cr_status;
  END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
ALTER FUNCTION public.get_statusbyaoiid(integer)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.get_statusbyaoiid(integer) TO public;
GRANT EXECUTE ON FUNCTION public.get_statusbyaoiid(integer) TO root;
GRANT EXECUTE ON FUNCTION public.get_statusbyaoiid(integer) TO dataonly;
GRANT EXECUTE ON FUNCTION public.get_statusbyaoiid(integer) TO readonly;
