-- Function: public.update_custom_request_status(text, integer)

--DROP FUNCTION public.update_custom_request_status(text, integer);

CREATE OR REPLACE FUNCTION public.update_custom_request_status(
    aoi_id text,
    status integer
    )
  RETURNS BOOLEAN AS
$BODY$

/**
	--function updates the custom_request_dates table with the users status

	--requires:
	aoi_id text the node id of the custom request
	status integer where:
		1  -"Pending"
		2 - "Process Start"
		3 - "Process Complete"
		4 - "Completed"

	--returns
	-- true if succeeds and false if fails
**/
    BEGIN

  	--update table custom_request_dates.
  	-- sets date to now
  	-- sets stats id to status passed by ui
  	INSERT INTO custom_request_dates(aoi_id, custom_request_date, custom_request_status_id)
  	VALUES (aoi_id::integer,now()::timestamp without time zone,status);

    --check if insert was success full
    IF FOUND THEN
       RETURN TRUE;
    ELSE
       RETURN FALSE;
    END IF;

    --not unique return False
    EXCEPTION WHEN unique_violation THEN
      RETURN FALSE;

    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.update_custom_request_status(text, integer) OWNER TO root;
GRANT EXECUTE ON FUNCTION public.update_custom_request_status(text, integer) TO public;
GRANT EXECUTE ON FUNCTION public.update_custom_request_status(text, integer) TO root;
GRANT EXECUTE ON FUNCTION public.update_custom_request_status(text, integer) TO dataonly;
GRANT EXECUTE ON FUNCTION public.update_custom_request_status(text, integer) TO readonly;
