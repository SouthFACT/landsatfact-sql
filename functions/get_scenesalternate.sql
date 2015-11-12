-- Function: public.get_scenesalternate(text, date, text)

-- DROP FUNCTION public.get_scenesalternate(text, date, text);

CREATE OR REPLACE FUNCTION public.get_scenesalternate(
    customrequest_date date,
    wrs2_code text)
  RETURNS SETOF scene_url AS
$BODY$

  --function to get alternate urls for images of the most recent scene to the users requested date for wrs2s_code

  -- the intention is this would be run once for start date and then again for the end date.
  -- if the user wants to change the date that was originally offered.

  --requires three arguments
  --   CustomRequest_Date::date - the date passed by the user for the custom request.
  --   wrs2_code::text wrs2_code to find alternate urls for

  --returns a postgres table defined bythe type scene_url
  --  daysfrom::integer the number days from the requested date
  --  cc_full::real percent cloud cover of the scene
  --  scene_id::character varying(35)  the scene id
  --  wrs2_code::character varying(6)  the wrs2_code
  --  acquistion_date::date  the date the scene was acquired
  --  browse_url::character varying(100) the url to scene's image

  BEGIN


    	--return query that gets the a list of alternate images for ordered by date
      -- the days from defines the number of days beofre after the user defined date
	--that intersect the input geometry for the current wrs2_code

	--Note: for some reason postgresql requires casting of the requested date even though it was already casted.
	RETURN QUERY EXECUTE
          'SELECT
	          (lm.acquisition_date - $2::date )::integer as daysfrom,
	          cc_full::real,
	          lm.scene_id::character varying(35),
	          wrs2_code::character varying(6),
	          lm.acquisition_date::date,
	          lm.browse_url::character varying(100)
           FROM wrs2_codes as wrs
             LEFT JOIN landsat_metadata as lm ON
               wrs2_code = substr(lm.scene_id,4,6)
          WHERE wrs2_code = $1
          ORDER BY lm.acquisition_date' USING wrs2_code, CustomRequest_Date;
  RETURN;
  END
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_scenesalternate(date, text) OWNER TO root;
GRANT EXECUTE ON FUNCTION public.get_scenesalternate(date, text) TO public;
GRANT EXECUTE ON FUNCTION public.get_scenesalternate(date, text) TO root;
GRANT EXECUTE ON FUNCTION public.get_scenesalternate(date, text) TO dataonly;
GRANT EXECUTE ON FUNCTION public.get_scenesalternate(date, text) TO readonly;
