-- Function: public.get_scenesgeojson(text)

-- DROP FUNCTION public.get_scenesgeojson(text);

CREATE OR REPLACE FUNCTION public.get_scenesgeojson(
    customrequest_geojson text)
  RETURNS SETOF scene_geojson AS
$BODY$
/**
  function to get GeoJSON and wrs2_code for a custom request. that the CustomRequest_GeoJson intersects

  requires one arguments
     CustomRequest_GeoJson::text - the geojson for the users custom request

  returns a postgres table defined by the type scene_url
    wrs2_code::character varying(6)  the wrs2_code
    geojson::text as the scene GeoJSON
 **/

  DECLARE
    wrs2_code_row character varying(6);
    CustomRequest_Geom geometry;

  BEGIN

    --convert the geojson to postgis geom
    CustomRequest_Geom = st_setsrid(ST_GeomFromGeoJSON(CustomRequest_GeoJson),4326);

    --loop a list of unique wrs2_codes that intersect the user geomerty and get the most recent scene url for each code
    FOR wrs2_code_row IN
	--select statement to get a list of unique wrs2_codes that intersects the users geometry
	EXECUTE
		'SELECT wrs2_code
		FROM wrs2_codes as wrs
		  LEFT JOIN landsat_metadata as lm
		    ON wrs2_code = substr(lm.scene_id,4,6)
		 WHERE st_intersects (wrs.geom,$1)
		 GROUP BY wrs2_code' USING CustomRequest_Geom

    LOOP
    	--return query that gets the most recent unique scene(s) from the requested date
	--that intersect the input geometry for the current wrs2_code

	--Note: for some reason postgresql requires casting of the requested date even though it was already casted.ß
	RETURN QUERY EXECUTE
          'SELECT
	          wrs2_code::character varying(6),
            st_asgeojson(geom)::text as geojson
           FROM wrs2_codes
          WHERE wrs2_code = $1
          ORDER BY wrs2_codes' USING wrs2_code_row;

    END LOOP;
  RETURN;
  END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_scenesgeojson(text) OWNER TO root;
GRANT EXECUTE ON FUNCTION public.get_scenesgeojson(text) TO public;
GRANT EXECUTE ON FUNCTION public.get_scenesgeojson(text) TO root;
GRANT EXECUTE ON FUNCTION public.get_scenesgeojson(text) TO dataonly;
GRANT EXECUTE ON FUNCTION public.get_scenesgeojson(text) TO readonly;
