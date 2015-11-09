-- Function: public.get_aoi_id_by_nodeid(text)

-- DROP FUNCTION public.get_aoi_id_by_nodeid(text);

CREATE OR REPLACE FUNCTION public.get_aoi_id_by_nodeid(
    pass_node_id text)
  RETURNS integer AS
$BODY$
/**
  function gets the aoi_id of user area of interest (subscription or custom request) and returns it's aoi_id.
   needed for adding custom requests.  aoi_id is auto created and after insertion of new user_aoi (subscription or custom request)
   this functions provides a way to retrie the aoi_id based on node_id.

  requires one argument
      node_id for the custom request

  returns integer
	   aoi_id the aoi_id for the node_id
 **/

  DECLARE
    ret_aoi_id integer;

  BEGIN


	--return the aoid
	SELECT INTO ret_aoi_id user_aoi.aoi_id
	FROM user_aoi
	WHERE user_aoi.node_id = pass_node_id;

	--return aoi_id
	RETURN ret_aoi_id;

  END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.get_aoi_id_by_nodeid(text) OWNER TO root;
GRANT EXECUTE ON FUNCTION public.get_aoi_id_by_nodeid(text) TO public;
GRANT EXECUTE ON FUNCTION public.get_aoi_id_by_nodeid(text) TO root;
GRANT EXECUTE ON FUNCTION public.get_aoi_id_by_nodeid(text) TO dataonly;
GRANT EXECUTE ON FUNCTION public.get_aoi_id_by_nodeid(text) TO readonly;
