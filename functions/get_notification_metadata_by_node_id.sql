CREATE OR REPLACE FUNCTION public.get_notification_metadata_by_node_id(pass_node_id character varying(30))
  RETURNS SETOF notification_metadata AS
$BODY$

BEGIN

RETURN QUERY EXECUTE

'WITH scenes AS (
    SELECT sb.scene,
                   ua.node_id
    FROM scene_boundaries sb,
                user_aoi ua
    WHERE ua.aoi_type=''subscription''
        AND ua.node_id=$1::character varying(30)
        AND st_intersects(ua.geom, sb.geom)
), extent AS (
    SELECT st_extent(st_transform(ua.geom, 900913))::text AS extent,
                   ua.node_id
    FROM user_aoi ua
    WHERE ua.node_id=$1::character varying(30)
    GROUP BY ua.node_id
)
SELECT DISTINCT scenes.node_id,
                                 p.product_date,
                                 extent.extent,
                                 substring(p.input1::text from 0 for 16) AS input1,
                                 substring(p.input2::text from 0 for 16) AS input2
FROM products p,
           scenes,
           extent
WHERE extent.node_id=scenes.node_id
    AND p.analysis_source=''LCV''
    AND p.input1 SIMILAR TO ''LE(7|8)'' || scenes.scene || ''%''
ORDER BY p.product_date' USING pass_node_id

RETURN;
          
END
$BODY$
LANGUAGE plpgsql VOLATILE;

ALTER FUNCTION public.get_notification_metadata_by_node_id(character varying(30))
  OWNER TO root;
GRANT EXECUTE ON FUNCTION public.get_notification_metadata_by_node_id(character varying(30)) TO public;
GRANT EXECUTE ON FUNCTION public.get_notification_metadata_by_node_id(character varying(30)) TO root;
GRANT EXECUTE ON FUNCTION public.get_notification_metadata_by_node_id(character varying(30)) TO dataonly;
GRANT EXECUTE ON FUNCTION public.get_notification_metadata_by_node_id(character varying(30)) TO readonly;
