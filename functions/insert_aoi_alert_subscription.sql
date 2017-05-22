-- Function: public.insert_aoi_alert_subscription(integer,text)

-- DROP FUNCTION public.insert_aoi_alert_subscription(integer,text);

CREATE OR REPLACE FUNCTION public.insert_aoi_alert_subscription(
    aoi_id integer,
    user_id text
  )
  RETURNS boolean AS

  --inserts a new record into user_aoi_alerts for aoi alert notifications.  this associates a user to an aoi.

  --requires
  --  aoi_id::integer aoi_id unique id for aoi alert
  --  user_id::character varying (30) the user id for the user susbcribing to the alert

  --returns
	-- true if succeeds and false if fails

$BODY$
    DECLARE ret_gid integer;
    BEGIN
        INSERT INTO user_aoi_alerts(aoi_id, user_id)
        VALUES (aoi_id, user_id) RETURNING gid into ret_gid;

        --check if insert was success full
        IF FOUND THEN
           RETURN TRUE;
        ELSE
           RETURN FALSE;
        END IF;


    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.insert_aoi_alert_subscription(integer,text)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.insert_aoi_alert_subscription(integer,text) TO public;
GRANT EXECUTE ON FUNCTION public.insert_aoi_alert_subscription(integer,text) TO root;
GRANT EXECUTE ON FUNCTION public.insert_aoi_alert_subscription(integer,text) TO dataonly;
GRANT EXECUTE ON FUNCTION public.insert_aoi_alert_subscription(integer,text) TO readonly;
