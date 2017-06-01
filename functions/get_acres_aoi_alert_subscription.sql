-- Function: public.get_acres_aoi_alert_subscription(integer)

-- DROP FUNCTION public.get_acres_aoi_alert_subscription(integer);

CREATE OR REPLACE FUNCTION public.get_acres_aoi_alert_subscription(
    param_aoi_id integer
)
  RETURNS float AS

  --gets the acres of an aoi alert (subscriptions)

  --requires
  --  aoi_id::integer aoi_id unique id for aoi alert

  --returns
	-- the acres

$BODY$
    DECLARE ret_acres float;
    BEGIN
        SELECT INTO ret_acres st_area(ST_Transform(geom,3857)) * 0.000247105
        FROM aoi_alerts WHERE aoi_id = param_aoi_id;

        --return acres
        RETURN ret_acres;

    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.get_acres_aoi_alert_subscription(integer)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.get_acres_aoi_alert_subscription(integer) TO public;
GRANT EXECUTE ON FUNCTION public.get_acres_aoi_alert_subscription(integer) TO root;
GRANT EXECUTE ON FUNCTION public.get_acres_aoi_alert_subscription(integer) TO dataonly;
GRANT EXECUTE ON FUNCTION public.get_acres_aoi_alert_subscription(integer) TO readonly;
