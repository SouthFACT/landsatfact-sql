

-- Function: public.get_customRequestURLByNodeId(text)

-- DROP FUNCTION public.get_customRequestURLByNodeId(text);

CREATE OR REPLACE FUNCTION public.get_customRequestURLByNodeId(
    pass_node_id text)
  RETURNS text AS
$BODY$
/**
  function gets the url of custom requestby it's drupal node_id.
   needed for providing download links for custom requests in the drupal status page. 
  requires one argument
      node_id for the custom request
  returns text
	   download url
 **/

  DECLARE
    ret_url text;

  BEGIN 


	--return the aoid
	SELECT INTO ret_url CR.request_id
	FROM custom_requests CR
		JOIN user_aoi AOI ON CR.aoi_id = AOI.aoi_id
	WHERE AOI.node_id = pass_node_id;

	--return aoi_id
	RETURN ret_url;

  END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.get_customRequestURLByNodeId(text) OWNER TO root;
GRANT EXECUTE ON FUNCTION public.get_customRequestURLByNodeId(text) TO public;
GRANT EXECUTE ON FUNCTION public.get_customRequestURLByNodeId(text) TO root;
GRANT EXECUTE ON FUNCTION public.get_customRequestURLByNodeId(text) TO dataonly;
GRANT EXECUTE ON FUNCTION public.get_customRequestURLByNodeId(text) TO readonly;