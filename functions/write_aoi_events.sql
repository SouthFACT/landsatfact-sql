-- Function: public.write_aoi_events(integer, float, float, float, float, float, float, integer, integer, date, float, text)

-- DROP FUNCTION public.write_aoi_events(integer, float, float, float, float, float, float, integer, integer, date, float, text);

CREATE OR REPLACE FUNCTION public.write_aoi_events(
    aoiID integer,
    acresChange float,
    percentChange float,
    acresAnalyzed float,
    percentAnalyzed float,
    smallestPatch float,
    largestPatch float,
    patchCount integer,
    eventID integer,
    eventDate date,
    maxPatchSeverity float,
    swirs text
    )
  RETURNS boolean AS
$BODY$

/**
	--records an aoi alert event 
	--requires:
	 aoi_id
	 aoi_events table statistics: acres_change, percent_change, acres_analyzed, percent_analyzed_change,
	    smallest_patch, largest_patch, patch_count, and event_date
	 aoi_event_id
	 a list of swir files as text comma delimited string of the product_ids used to determine the statistics
	--returns
	 	-- true if succeeds and false if fails
**/
    DECLARE swirs_array TEXT[];
    DECLARE swir TEXT;
    BEGIN
			
        --update table aoi_events 
        UPDATE aoi_events set ("aoi_id", "acres_change", "percent_change", "acres_analyzed", "percent_analyzed_change", "smallest_patch", "largest_patch", "patch_count",
		      "event_date", "max_patch_severity")
         	= (aoiID, acresChange, percentChange, acresAnalyzed, percentAnalyzed, smallestPatch, largestPatch, patchCount, eventDate, maxPatchSeverity)
		where aoi_event_id=eventID;

        --update table aoi_products
        --loop through swirs 
        select INTO swirs_array string_to_array(swirs,',');
	    FOREACH swir IN ARRAY swirs_array
	    LOOP
	        --insert input1 and input2 contained in the product_id and the
	        --product_name which is the whole product_id into the aoi_products table. 
	        INSERT INTO aoi_products("aoi_event_id", "event_image1", "event_image2", "product_name")
	        VALUES (eventID, substring(swir from 1 for 23), substring(swir from 25 for 23), swir);
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
ALTER FUNCTION public.write_aoi_events(integer, float, float, float, float, float, float, integer, integer, date, float, text) OWNER TO root;
GRANT EXECUTE ON FUNCTION public.write_aoi_events(integer, float, float, float, float, float, float, integer, integer, date, float, text) TO public;
GRANT EXECUTE ON FUNCTION public.write_aoi_events(integer, float, float, float, float, float, float, integer, integer, date, float, text) TO root;
GRANT EXECUTE ON FUNCTION public.write_aoi_events(integer, float, float, float, float, float, float, integer, integer, date, float, text) TO dataonly;
GRANT EXECUTE ON FUNCTION public.write_aoi_events(integer, float, float, float, float, float, float, integer, integer, date, float, text) TO readonly;
