-- View: public.vw_latest_quads_cloud

-- DROP VIEW public.vw_latest_quads_cloud;

CREATE OR REPLACE VIEW public.vw_latest_quads_cloud AS
 SELECT loc.location
   FROM vw_last_days_scenes lds
   JOIN vw_tile_index_cloud loc ON lds.scene_id::text ~~ (('%'::text || "substring"(loc.oid::text, 1, 6)) || '%'::text);

ALTER TABLE public.vw_latest_quads_cloud
  OWNER TO root;
GRANT ALL ON TABLE public.vw_latest_quads_cloud TO root;
GRANT SELECT ON TABLE public.vw_latest_quads_cloud TO readonly;
GRANT ALL ON TABLE public.vw_latest_quads_cloud TO dataonly;
