-- Function: public.is_validsceneintersects(text, integer)

-- DROP FUNCTION public.is_validsceneintersects(text, integer);

CREATE OR REPLACE FUNCTION public.is_validsceneintersects(
    customrequest_geojson text,
    allowed_intersections integer)
  RETURNS boolean AS
$BODY$

  --function to ensure data passed only intersects less <= 4 wrs2_codes

  --requires two arguments
  --  CustomRequest_GeoJSON::text the Custom Requtests GeoJSON
  --  allowed_Intersections::integer the maximum number of intersections allowed

  --returns
  --  boolean if <= the allowed intersections
  DECLARE

    is_geomOkay boolean;
  BEGIN

    --check if geojson passed is less the then allowed intersections
    --if not return false otherwise return true
    --this accomplished be select the boolean INTO the varriable is_geomOkay
    SELECT INTO is_geomOkay ((SELECT count(*)
    FROM wrs2_codes AS wrs
    WHERE st_intersects(st_setsrid(ST_GeomFromGeoJSON(CustomRequest_GeoJSON),4326),wrs.geom)) <= allowed_Intersections) as bool;

    --return the boolean check for intersections
    RETURN is_geomOkay;

  END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
ALTER FUNCTION public.is_validsceneintersects(text, integer)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.is_validsceneintersects(text, integer) TO public;
GRANT EXECUTE ON FUNCTION public.is_validsceneintersects(text, integer) TO root;
GRANT EXECUTE ON FUNCTION public.is_validsceneintersects(text, integer) TO dataonly;
GRANT EXECUTE ON FUNCTION public.is_validsceneintersects(text, integer) TO readonly;
