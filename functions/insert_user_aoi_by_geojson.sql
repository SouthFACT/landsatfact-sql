-- Function: public.insert_user_aoi_by_geojson(text, text, text, text, text)

-- DROP FUNCTION public.insert_user_aoi_by_geojson(text, text, text, text, text);

CREATE OR REPLACE FUNCTION public.insert_user_aoi_by_geojson(
    node_id text,
    user_id text,
    aoi_name text,
    aoi_type text,
    geojson text)
  RETURNS boolean AS
$BODY$
    DECLARE area_geojson geometry;
    BEGIN
        area_geojson = ST_Multi(ST_SetSRID(ST_GeomFromGeoJSON(geojson), 4326));
        INSERT INTO user_aoi(node_id, user_id, aoi_name, aoi_type, geom)
        VALUES (node_id, user_id, aoi_name, aoi_type, area_geojson);

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
ALTER FUNCTION public.insert_user_aoi_by_geojson(text, text, text, text, text)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.insert_user_aoi_by_geojson(text, text, text, text, text) TO public;
GRANT EXECUTE ON FUNCTION public.insert_user_aoi_by_geojson(text, text, text, text, text) TO root;
GRANT EXECUTE ON FUNCTION public.insert_user_aoi_by_geojson(text, text, text, text, text) TO dataonly;
GRANT EXECUTE ON FUNCTION public.insert_user_aoi_by_geojson(text, text, text, text, text) TO readonly;
