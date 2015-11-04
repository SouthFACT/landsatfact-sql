-- Function: public.update_user_aoi_by_geojson(text, text)

-- DROP FUNCTION public.update_user_aoi_by_geojson(text, text);

CREATE OR REPLACE FUNCTION public.update_user_aoi_by_geojson(
    nid text,
    geojson text)
  RETURNS void AS
$BODY$
    DECLARE area_geojson geometry;
    BEGIN
         area_geojson = ST_Multi(ST_SetSRID(ST_GeomFromGeoJSON(geojson), 4326));
         UPDATE user_aoi SET geom = area_geojson
         WHERE node_id = nid;
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.update_user_aoi_by_geojson(text, text)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.update_user_aoi_by_geojson(text, text) TO public;
GRANT EXECUTE ON FUNCTION public.update_user_aoi_by_geojson(text, text) TO root;
GRANT EXECUTE ON FUNCTION public.update_user_aoi_by_geojson(text, text) TO dataonly;
GRANT EXECUTE ON FUNCTION public.update_user_aoi_by_geojson(text, text) TO readonly;
