-- View: public.vw_latest_quads_swir

-- DROP VIEW public.vw_latest_quads_swir;

CREATE OR REPLACE VIEW public.vw_latest_quads_swir AS
 SELECT loc.location
   FROM vw_last_days_scenes lds
   JOIN vw_tile_index_swir loc ON lds.scene_id::text ~~ (('%'::text || "substring"(loc.oid::text, 1, 6)) || '%'::text);

ALTER TABLE public.vw_latest_quads_swir
  OWNER TO root;
GRANT ALL ON TABLE public.vw_latest_quads_swir TO root;
GRANT SELECT ON TABLE public.vw_latest_quads_swir TO readonly;
GRANT ALL ON TABLE public.vw_latest_quads_swir TO dataonly;
