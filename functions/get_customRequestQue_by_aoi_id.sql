-- Function: public.get_pendingcustomrequests()

-- DROP FUNCTION public.get_pendingcustomrequests();

CREATE OR REPLACE FUNCTION public.get_customRequestQue_by_aoi_id(pass_aoi_id text)
  RETURNS text AS
$BODY$

  --function to get the que and estimated time based on current average time complete a custom request.

  --requires three arguments
  -- aoi_id

  --returns text of custom request que
  --  time and que for custom reque

  DECLARE
    my_aoi_type varchar(100);
    ret_message text;


  BEGIN
    my_aoi_type := 'custom_request';
    --select query for geting table custom requests which have a status of "Pending"
    WITH getCRQue as (SELECT
    aoi_id,
    ROW_NUMBER() OVER(ORDER BY aoi_id asc) AS Row,
     (WITH countandorder AS
    (SELECT
    	aoi_id,
    	count(DISTINCT(cr.aoi_id)) count,
    	ROW_NUMBER() OVER(ORDER BY aoi_id asc) AS Row
      FROM custom_request_dates as cr
      WHERE  upper((select aoi_type FROM user_aoi where user_aoi.aoi_id = cr.aoi_id)) = upper('custom_request') AND
             (SELECT max(sub_crd.custom_request_status_id) FROM custom_request_dates sub_crd  WHERE sub_crd.aoi_id = cr.aoi_id) < 4
      GROUP By cr.aoi_id
      HAVING EXTRACT(DAYS FROM now()::timestamp -  max(custom_request_date)::timestamp ) < 125)
     SELECT sum(count) from countandorder)
    FROM custom_request_dates as cr
      WHERE  (upper((select aoi_type FROM user_aoi where user_aoi.aoi_id = cr.aoi_id)) = upper('custom_request') AND
             (SELECT max(sub_crd.custom_request_status_id) FROM custom_request_dates sub_crd  WHERE sub_crd.aoi_id = cr.aoi_id) < 4)
      GROUP By cr.aoi_id
      HAVING EXTRACT(DAYS FROM now()::timestamp -  max(custom_request_date)::timestamp ) < 125
      ORDER BY ROW_NUMBER() OVER(ORDER BY aoi_id asc))
      SELECT INTO ret_message ('Your custom request is number ' || row::text ||' in the que and should take about ' || (row * ( WITH TEST AS (SELECT
      	aoi_id,
      	(SELECT status FROM custom_request_status_types type where type.custom_request_status_id =  max(cr_dates.custom_request_status_id))::varchar(150) current_status,
      	min(custom_request_date) started_at,
      	max(custom_request_date) stoped_at,
      	age(max(custom_request_date) , min(custom_request_date)) AS timespent,
      	'DAYS: ' || EXTRACT(DAYS FROM now()::timestamp -  max(custom_request_date)::timestamp ) || ' HOURS: ' || EXTRACT(HOURS FROM now()::timestamp -  max(custom_request_date)::timestamp ) as time_since_request,
      	(SELECT string_agg(tp,',')::text FROM (SELECT b.scene_id::text as tp FROM custom_request_scenes b WHERE b.aoi_id = cr_dates.aoi_id ) as hold)::text as scenes
      FROM custom_request_dates  cr_dates
      GROUP BY
      	aoi_id
      HAVING
      	max(custom_request_status_id) = 4 and EXTRACT(DAYS FROM max(custom_request_date) - min(custom_request_date) ) < 1
      ORDER BY
      	EXTRACT(DAYS FROM now()::timestamp -  max(custom_request_date)::timestamp ) DESC,
        EXTRACT(HOURS FROM now()::timestamp -  min(custom_request_date)::timestamp ) DESC)
     SELECT date_trunc('minute',avg(timespent)) FROM TEST))::text || ' to complete.') as completetion  from getCRQue where aoi_id = pass_aoi_id::integer;

    RETURN ret_message;
  END
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;

ALTER FUNCTION public.get_customRequestQue_by_aoi_id(text)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.get_customRequestQue_by_aoi_id(text) TO public;
GRANT EXECUTE ON FUNCTION public.get_customRequestQue_by_aoi_id(text) TO root;
GRANT EXECUTE ON FUNCTION public.get_customRequestQue_by_aoi_id(text) TO dataonly;
GRANT EXECUTE ON FUNCTION public.get_customRequestQue_by_aoi_id(text) TO readonly;
