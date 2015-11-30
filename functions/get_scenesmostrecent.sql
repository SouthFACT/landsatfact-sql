-- Function: public.get_scenesmostrecent(text, date)

-- DROP FUNCTION public.get_scenesmostrecent(text, date);

CREATE OR REPLACE FUNCTION public.get_scenesmostrecent(
    customrequest_geojson text,
    customrequest_date date)
  RETURNS SETOF scene_url AS
$BODY$
/**
  function to get the url to the images of the most recent scene to the users requested date.
  The intention is to call this twice once for the start date then again for the end date
  there should be a most recent url for each wrs2_code that the CustomRequest_GeoJson intersects

  requires two arguments
     CustomRequest_GeoJson::text - the geojson for the users custom request
     CustomRequest_Date::date - the date passed by the user for the custom request.  agnostic to start or end date
     date format is yyyy-mm-dd or mm-dd-yyyy or yyyy/mm/dd or mm/dd/yyyy

  returns a postgres table defined by the type scene_url
    daysfrom::integer the number days from the requested date
    cc_full::real percent cloud cover of the scene
    scene_id::character varying(35)  the scene id
    wrs2_code::character varying(6)  the wrs2_code
    acquistion_date::date  the date the scene was acquired
    browse_url::character varying(100) the url to scene's image
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
	          (lm.acquisition_date - $2::date )::integer as daysfrom,
	          cc_full::real,
	          lm.scene_id::character varying(35),
	          wrs2_code::character varying(6),
	          lm.acquisition_date::date,
            (CASE WHEN acquisition_date >= ''2015-01-01''::date and substr(lm.scene_id,3,1) = ''8'' THEN
          		(''http://landsat-pds.s3.amazonaws.com/L8/'' || CASE WHEN length(lm.path::text) < 3 THEN (''0'' || lm.path::text) ELSE lm.path::text END || ''/'' || CASE WHEN length(lm.row::text) < 3 THEN (''0''|| lm.row::text) ELSE lm.row::text END || ''/'' || lm.scene_id || ''/'' || lm.scene_id || ''_thumb_small.jpg'')::varchar(150)
          	ELSE
          	  (browse_url)::varchar(150)
          	END)::varchar(150) as browse_url,
            st_asgeojson(geom) as geojson
           FROM wrs2_codes as wrs
             LEFT JOIN landsat_metadata as lm ON
               wrs2_code = substr(lm.scene_id,4,6)
          WHERE wrs2_code = $1 and lm.cc_full < 90
          ORDER BY ABS((lm.acquisition_date -  $2::date)-0),cc_full LIMIT 1' USING wrs2_code_row, CustomRequest_Date;

    END LOOP;
  RETURN;
  END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_scenesmostrecent(text, date)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.get_scenesmostrecent(text, date) TO public;
GRANT EXECUTE ON FUNCTION public.get_scenesmostrecent(text, date) TO root;
GRANT EXECUTE ON FUNCTION public.get_scenesmostrecent(text, date) TO dataonly;
GRANT EXECUTE ON FUNCTION public.get_scenesmostrecent(text, date) TO readonly;
