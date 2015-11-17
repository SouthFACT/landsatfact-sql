-- Function: public.insert_custom_request_scenes(integer, character varying (35))

-- DROP FUNCTION public.insert_custom_request_scenes(integer, character varying (35));

CREATE OR REPLACE FUNCTION public.insert_custom_request_scenes(
    aoi_id integer,
    scene_id character varying (35))
  RETURNS boolean AS

  --inserts record into insert_custom_request_scenes to record each scene used by a custom request

  --requires
  --  aoi_id::integer the aoi_id of the cusom request
  --  scene_id::character varying (35) the landsat scene id

  --returns
	-- true if succeeds and false if fails

$BODY$

    BEGIN
        --insert record
        INSERT INTO custom_request_scenes(aoi_id, scene_id)
        VALUES (aoi_id, scene_id);

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
ALTER FUNCTION public.insert_custom_request_scenes(integer, character varying (35)) OWNER TO root;
GRANT EXECUTE ON FUNCTION public.insert_custom_request_scenes(integer, character varying (35)) TO public;
GRANT EXECUTE ON FUNCTION public.insert_custom_request_scenes(integer, character varying (35)) TO root;
GRANT EXECUTE ON FUNCTION public.insert_custom_request_scenes(integer, character varying (35)) TO dataonly;
GRANT EXECUTE ON FUNCTION public.insert_custom_request_scenes(integer, character varying (35)) TO readonly;
