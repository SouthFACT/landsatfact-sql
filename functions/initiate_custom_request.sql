-- Function: public.initiate_custom_request(text, text, text)

--DROP FUNCTION public.initiate_custom_request(text, text, text);

CREATE OR REPLACE FUNCTION public.initiate_custom_request(
    aoi_id text,
    user_id text,
    scenes text
    )
  RETURNS void AS
$BODY$

/**
	--initiates the custom request process in the database.
	writes data to the postgres database for the Custom request python scripts
	to begin processing

	--requires:
	 aoi_id text the node id of the custom request
	 user_id the user_id for the cusotom request
	 scenes as text comma delimited string of scene_ids from the landsat fact ui

	--returns
	 na
**/
    DECLARE scenes_array TEXT[];
    DECLARE scene TEXT;
    BEGIN
        --update table custom_requests with new
        --custom request
        INSERT INTO custom_requests(request_id, aoi_id)
        VALUES (user_id || '_'  || aoi_id || '.zip',aoi_id::integer);

        --update table custom_request_scenes
        --loop scenes array
        select INTO scenes_array string_to_array(scenes,',');

	FOREACH scene IN ARRAY scenes_array
	LOOP
	    --insert each scene id into the custom request
	    -- scenes table.  there could be up to 8 for each
	    -- request
	    INSERT INTO custom_request_scenes(aoi_id,scene_id)
	    VALUES (aoi_id::integer,scene);
	END LOOP;

	--update table custom_request_dates.  this will mark the first one as pending
	INSERT INTO custom_request_dates(aoi_id, custom_request_date, custom_request_status_id)
	VALUES (aoi_id::integer,now()::timestamp without time zone,1);

    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.initiate_custom_request(text, text, text) OWNER TO root;
GRANT EXECUTE ON FUNCTION public.initiate_custom_request(text, text, text) TO public;
GRANT EXECUTE ON FUNCTION public.initiate_custom_request(text, text, text) TO root;
GRANT EXECUTE ON FUNCTION public.initiate_custom_request(text, text, text) TO dataonly;
GRANT EXECUTE ON FUNCTION public.initiate_custom_request(text, text, text) TO readonly;
