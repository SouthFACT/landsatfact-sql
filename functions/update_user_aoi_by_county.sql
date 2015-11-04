-- Function: public.update_user_aoi_by_county(text, integer)

-- DROP FUNCTION public.update_user_aoi_by_county(text, integer);

CREATE OR REPLACE FUNCTION public.update_user_aoi_by_county(
    nid text,
    county_geoid integer)
  RETURNS void AS
$BODY$
    DECLARE county_geom geometry;
    BEGIN
        SELECT INTO county_geom geom FROM counties WHERE geoid = county_geoid;
        UPDATE user_aoi SET geom = county_geom
        WHERE node_id = nid;
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.update_user_aoi_by_county(text, integer)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.update_user_aoi_by_county(text, integer) TO public;
GRANT EXECUTE ON FUNCTION public.update_user_aoi_by_county(text, integer) TO root;
GRANT EXECUTE ON FUNCTION public.update_user_aoi_by_county(text, integer) TO dataonly;
GRANT EXECUTE ON FUNCTION public.update_user_aoi_by_county(text, integer) TO readonly;
