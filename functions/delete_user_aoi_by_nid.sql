-- Function: public.delete_user_aoi_by_nid(text)

-- DROP FUNCTION public.delete_user_aoi_by_nid(text);

CREATE OR REPLACE FUNCTION public.delete_user_aoi_by_nid(nid text)
  RETURNS void AS
$BODY$
    BEGIN
         DELETE FROM user_aoi
         WHERE node_id = nid;
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.delete_user_aoi_by_nid(text)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.delete_user_aoi_by_nid(text) TO public;
GRANT EXECUTE ON FUNCTION public.delete_user_aoi_by_nid(text) TO root;
GRANT EXECUTE ON FUNCTION public.delete_user_aoi_by_nid(text) TO dataonly;
GRANT EXECUTE ON FUNCTION public.delete_user_aoi_by_nid(text) TO readonly;
