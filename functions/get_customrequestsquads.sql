
-- Function: public.get_customrequestsquads(integer)

-- DROP FUNCTION public.get_customrequestsquads(integer);

CREATE OR REPLACE FUNCTION public.get_customrequestsquads(cr_aoi_id integer)
  RETURNS SETOF custom_request_quads AS
$BODY$

  --function to a table or list of quads and other information used process custom requests.

  --requires three arguments
  -- cr_aoi_id::integer - aoi_id of a custom request

  --returns a postgres table defined bythe type custom_requests_pending
  --  aoi_id integer aoi_id of custom request,
  --  quad_id character varying(8) quad id of custom request,
  --  scene_id character varying(25) scene id of the custom request,
  --  quad_order bigint quad order use this to determine order of comparsion in change.  1 is first 2 is second,
  --  wrs2_code character varying(6) wrs2 code of the custom request,
  --  scene_date date date the scene was taken (derived from the scene id),
  --  aoi_type character varying(30) the type of the aoi in this case its  "custom_request",
  --  quad_location text quad location (LL lower left,  UL Upper Left, LR Lower Right, UR Upper Right),
  --  request_id character varying(100) request id should be username_aoiid.zip,
  --  current_status_id integer current status id,
  --  current_status character varying(150) current status should be the highest status (determined by the status id)
  --           1 "Pending"
  --           2 "Process Start"
  --           3 "Process Complete"
  --           4 "Completed"

  DECLARE
    aoi_type varchar(100);

  BEGIN
    aoi_type := 'custom_request';

    --select query for geting table custom requests and the quads that are needed fo proccessing "Pending"
  	RETURN QUERY EXECUTE
            'SELECT DISTINCT
	custom_request_scenes.aoi_id,
	quad_id,
	custom_request_scenes.scene_id,
	ROW_NUMBER() OVER(PARTITION BY custom_request_scenes.aoi_id,quad_id ORDER BY wrs2_code,substr(quad_id,7,2),(date (SUBSTR(custom_request_scenes.scene_id::text, 10, 4) || ''-01-01'')::date +  interval ''1 day'' * SUBSTR(custom_request_scenes.scene_id::text, 14, 3)::integer  )::date) quad_order,
	wrs2_code,
        (date (SUBSTR(custom_request_scenes.scene_id::text, 10, 4) || ''-01-01'')::date +  interval ''1 day'' * SUBSTR(custom_request_scenes.scene_id::text, 14, 3)::integer  )::date scene_date,
	(SELECT aoi_type FROM user_aoi where user_aoi.aoi_id =  custom_request_scenes.aoi_id) as aoi_type,
	SUBSTR(quad_id,7,2) as quad_location,
	(SELECT request_id FROM custom_requests WHERE custom_requests.aoi_id = custom_request_scenes.aoi_id) as request_id,
	  (SELECT sub_crd.custom_request_status_id
	   FROM custom_request_dates sub_crd
	    JOIN custom_request_status_types status_types ON
	      sub_crd.custom_request_status_id = status_types.custom_request_status_id
	   WHERE sub_crd.aoi_id = custom_request_scenes.aoi_id
	   ORDER BY sub_crd.custom_request_status_id desc limit 1) as current_status_id,
	  (SELECT status
	   FROM custom_request_dates sub_crd
	    JOIN custom_request_status_types status_types ON
	      sub_crd.custom_request_status_id = status_types.custom_request_status_id
	   WHERE sub_crd.aoi_id = custom_request_scenes.aoi_id
	   ORDER BY sub_crd.custom_request_status_id desc limit 1)  as current_status
FROM landsat_quads
JOIN custom_request_scenes ON
  SUBSTR (custom_request_scenes.scene_id::text, 4, 6) = wrs2_code
WHERE
	(SELECT st_asgeojson(geom) FROM user_aoi WHERE user_aoi.aoi_id = custom_request_scenes.aoi_id) is not null
	AND
	st_intersects(
                    landsat_quads.geom,
                    (SELECT geom FROM user_aoi WHERE user_aoi.aoi_id = custom_request_scenes.aoi_id)
		   )
	AND
	upper((select aoi_type FROM user_aoi where user_aoi.aoi_id =  custom_request_scenes.aoi_id)) = upper($1)
	AND
	custom_request_scenes.aoi_id = $2
ORDER BY
	custom_request_scenes.aoi_id,
	wrs2_code,
	substr(quad_id,7,2),
	(date (SUBSTR(custom_request_scenes.scene_id::text, 10, 4) || ''-01-01'')::date +  interval ''1 day'' * SUBSTR(custom_request_scenes.scene_id::text, 14, 3)::integer  )::date ' USING aoi_type, cr_aoi_id

    RETURN;
  END
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_customrequestsquads(integer)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.get_customrequestsquads(integer) TO public;
GRANT EXECUTE ON FUNCTION public.get_customrequestsquads(integer) TO root;
GRANT EXECUTE ON FUNCTION public.get_customrequestsquads(integer) TO dataonly;
GRANT EXECUTE ON FUNCTION public.get_customrequestsquads(integer) TO readonly;
