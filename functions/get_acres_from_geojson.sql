-- Function: public.get_acres_from_geojson(text)

-- DROP FUNCTION public.get_acres_from_geojson(text);

CREATE OR REPLACE FUNCTION public.get_acres_from_geojson(
    geojson text)
    RETURNS float AS

    --gets the acres of an geosjon

    --requires
    --  geojson::text text that is actually valid geojson object

    --returns
    -- the acres

$BODY$
DECLARE area_geojson geometry;
DECLARE ret_acres float;
BEGIN
     area_geojson = ST_Multi(ST_SetSRID(ST_GeomFromGeoJSON(geojson), 4326));
     SELECT INTO ret_acres st_area(ST_Transform(area_geojson,102008)) * 0.000247105;

     --return acres
     RETURN ret_acres;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.get_acres_from_geojson(text)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.get_acres_from_geojson(text) TO public;
GRANT EXECUTE ON FUNCTION public.get_acres_from_geojson(text) TO root;
GRANT EXECUTE ON FUNCTION public.get_acres_from_geojson(text) TO dataonly;
GRANT EXECUTE ON FUNCTION public.get_acres_from_geojson(text) TO readonly;
