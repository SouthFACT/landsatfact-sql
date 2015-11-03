-- View: public.vw_latest_quads_gap

-- DROP VIEW public.vw_latest_quads_gap;

CREATE OR REPLACE VIEW public.vw_latest_quads_gap AS
 SELECT loc.location
   FROM vw_last_days_scenes lds
   JOIN vw_tile_index_gap loc ON lds.scene_id::text ~~ (('%'::text || "substring"(loc.oid::text, 1, 6)) || '%'::text);

ALTER TABLE public.vw_latest_quads_gap
  OWNER TO root;
GRANT ALL ON TABLE public.vw_latest_quads_gap TO root;
GRANT SELECT ON TABLE public.vw_latest_quads_gap TO readonly;
GRANT ALL ON TABLE public.vw_latest_quads_gap TO dataonly;
