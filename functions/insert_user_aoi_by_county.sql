-- Function: public.insert_user_aoi_by_county(text, text, text, text, integer)

-- DROP FUNCTION public.insert_user_aoi_by_county(text, text, text, text, integer);

CREATE OR REPLACE FUNCTION public.insert_user_aoi_by_county(
    node_id text,
    user_id text,
    aoi_name text,
    aoi_type text,
    county_geoid integer)
  RETURNS boolean AS
$BODY$
    DECLARE county_geom geometry;
    BEGIN
      SELECT INTO county_geom geom FROM counties WHERE geoid = county_geoid;
      INSERT INTO user_aoi(node_id, user_id, aoi_name, aoi_type, geom)
      VALUES (node_id, user_id, aoi_name, aoi_type, county_geom);

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
ALTER FUNCTION public.insert_user_aoi_by_county(text, text, text, text, integer)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.insert_user_aoi_by_county(text, text, text, text, integer) TO public;
GRANT EXECUTE ON FUNCTION public.insert_user_aoi_by_county(text, text, text, text, integer) TO root;
GRANT EXECUTE ON FUNCTION public.insert_user_aoi_by_county(text, text, text, text, integer) TO dataonly;
GRANT EXECUTE ON FUNCTION public.insert_user_aoi_by_county(text, text, text, text, integer) TO readonly;
