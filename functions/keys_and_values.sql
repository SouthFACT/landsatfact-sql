CREATE OR REPLACE FUNCTION public.keys_and_values(text, text, text)

  RETURNS integer AS

$BODY$

DECLARE

	cols ALIAS FOR $1;

	vals ALIAS for $2;

	scene ALIAS for $3;

	l1ID integer;

BEGIN

	EXECUTE format('

	INSERT into level1_metadata %s VALUES %s returning level1_id', cols, vals) into l1ID;

	EXECUTE format('

	UPDATE landsat_metadata SET l1_key = %s where scene_id='''||'%s'||'''', l1ID, scene);



	RETURN l1ID;



END

$BODY$

  LANGUAGE plpgsql VOLATILE

  COST 100;
