-- Function: public.get_countybygeoid(integer)

-- DROP FUNCTION public.get_countybygeoid(integer);

CREATE OR REPLACE FUNCTION public.get_countybygeoid(countygeoid integer)
  RETURNS text AS
$BODY$

    --select the county with matching geoid and return the geojson.

    --requires one argument
    -- countyGEOID::integer - geoid of a county

    --returns geojson

  DECLARE
    countyGeoJSON json;
  BEGIN


    --I  added the ability to simplify on but it appears it might not be needed
    --if we find the geojson is too big we can addjust

    --select the geojson for matching county into the geojson return varriable countyGeoJSON
	SELECT into countyGeoJSON st_asgeojson(ST_SimplifyPreserveTopology(geom,0))::json
	FROM counties
	WHERE GEOID = countyGEOID;
	RETURN countyGeoJSON;
  END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
ALTER FUNCTION public.get_countybygeoid(integer)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.get_countybygeoid(integer) TO public;
GRANT EXECUTE ON FUNCTION public.get_countybygeoid(integer) TO root;
GRANT EXECUTE ON FUNCTION public.get_countybygeoid(integer) TO dataonly;
GRANT EXECUTE ON FUNCTION public.get_countybygeoid(integer) TO readonly;
