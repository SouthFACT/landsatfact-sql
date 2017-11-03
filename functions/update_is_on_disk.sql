-- Function: public.update_is_on_disk(text, text)

-- DROP FUNCTION public.update_is_on_disk(text, text);

CREATE OR REPLACE FUNCTION public.update_is_on_disk(product_id_val text, is_on_disk_val text)
  RETURNS boolean  AS
$BODY$
    DECLARE area_geojson geometry;
    BEGIN

         UPDATE products SET is_on_disk = is_on_disk_val
         WHERE product_id = product_id_val;

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
ALTER FUNCTION public.update_is_on_disk(text, text)
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.update_is_on_disk(text, text) TO public;
GRANT EXECUTE ON FUNCTION public.update_is_on_disk(text, text) TO root;
GRANT EXECUTE ON FUNCTION public.update_is_on_disk(text, text) TO dataonly;
GRANT EXECUTE ON FUNCTION public.update_is_on_disk(text, text) TO readonly;
