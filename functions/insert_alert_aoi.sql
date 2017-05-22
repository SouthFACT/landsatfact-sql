-- Function: public.insert_alert_aoi(text, text, text, boolean)

-- DROP FUNCTION public.insert_alert_aoi(text, text, text, boolean);

CREATE OR REPLACE FUNCTION public.insert_alert_aoi(
    geojson text,
    aoi_name text,
    node_id text,
    aoi_public boolean
  )
  RETURNS integer AS

  --inserts a new record into aoi_alerts for aoi alert notifications

  --requires
  --  geojson::text geojson for the aoi alert
  --  aoi_name::character varying (200) the name of the aoi alert
  --  node_id::character varying (30) the drupal node id of the aoi alert
  --  aoi_public::boolean boolean indicating if the aoi alert is public

  --returns
  -- aoi_id::integer returns the unique identifer of the new records

$BODY$
    DECLARE area_geojson geometry;
    DECLARE ret_aoi_id integer;
    BEGIN
        area_geojson = ST_Multi(ST_SetSRID(ST_GeomFromGeoJSON(geojson), 4326));
        INSERT INTO aoi_alerts(node_id, aoi_name, aoi_public, geom)
        VALUES (node_id, aoi_name, aoi_public, area_geojson) RETURNING aoi_id into ret_aoi_id;

        RETURN ret_aoi_id;

    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.insert_alert_aoi(text, text, text, boolean)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.insert_alert_aoi(text, text, text, boolean) TO public;
GRANT EXECUTE ON FUNCTION public.insert_alert_aoi(text, text, text, boolean) TO root;
GRANT EXECUTE ON FUNCTION public.insert_alert_aoi(text, text, text, boolean) TO dataonly;
GRANT EXECUTE ON FUNCTION public.insert_alert_aoi(text, text, text, boolean) TO readonly;
