-- Function: public.write_aoi_events(integer, float, float, float, float, float, float, integer, text)

-- DROP FUNCTION public.write_aoi_events(integer, float, float, float, float, float, float, integer, text);

CREATE OR REPLACE FUNCTION public.write_aoi_events(
	aoi_id integer,
    acres_change float,
	percent_change float,
	acres_analyzed float,
	percent_analyzed_change float,
	smallest_patch float,
	largest_patch float,
	patch_count integer,
    swirs text
    )
  RETURNS boolean AS
$BODY$

/**
	--records an aoi alert event 
	--requires:
         aoi_id
	 aoi_events table statistics: acres_change, percent_change, acres_analyzed, percent_analyzed_change,
	    smallest_patch, and largest_patch
	 a list of swir files as text comma delimited string of the product_ids used to determine the statistics
	--returns
	 	-- true if succeeds and false if fails
**/
    DECLARE swirs_array TEXT[];
    DECLARE swir TEXT;
    DECLARE event_id integer;
    BEGIN
			
        --update table aoi_events 
        INSERT INTO aoi_events("aoi_event_id", "aoi_id", "acres_change", "percent_change", "acres_analyzed", "percent_analyzed_change", "smallest_patch", "largest_patch")
         	VALUES (DEFAULT, aoi_id, acres_change, percent_change, acres_analyzed, percent_analyzed_change, smallest_patch, largest_patch) 
		RETURNING aoi_event_id into event_id;

        --update table aoi_products
        --loop through swirs 
        select INTO swirs_array string_to_array(swirs,',');
	    FOREACH swir IN ARRAY swirs_array
	    LOOP
	        --insert input1 and input2 contained in the product_id and the
	        --product_name which is the whole product_id into the aoi_products table. 
	        INSERT INTO aoi_products("aoi_event_id", "event_image1", "event_image2", "product_name")
	        VALUES (event_id, substring(swir from 1 for 23), substring(swir from 25 for 23), swir);
		    --check if insert was successful
		    IF NOT FOUND THEN
		       RETURN FALSE;
		    END IF;
	    END LOOP;
 
	--if no error yet return true
	RETURN TRUE; 
      
       --not unique return False
       EXCEPTION WHEN unique_violation THEN
         RETURN FALSE;
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.write_aoi_events(integer, float, float, float, float, float, float, integer, text) OWNER TO root;
GRANT EXECUTE ON FUNCTION public.write_aoi_events(integer, float, float, float, float, float, float, integer, text) TO public;
GRANT EXECUTE ON FUNCTION public.write_aoi_events(integer, float, float, float, float, float, float, integer, text) TO root;
GRANT EXECUTE ON FUNCTION public.write_aoi_events(integer, float, float, float, float, float, float, integer, text) TO dataonly;
GRANT EXECUTE ON FUNCTION public.write_aoi_events(integer, float, float, float, float, float, float, integer, text) TO readonly;
