-- View: public.vw_latest_quads_ndvi

-- DROP VIEW public.vw_latest_quads_ndvi;

CREATE OR REPLACE VIEW public.vw_latest_quads_ndvi AS
 SELECT loc.location
   FROM vw_last_days_scenes lds
   JOIN vw_tile_index_ndvi loc ON lds.scene_id::text ~~ (('%'::text || "substring"(loc.oid::text, 1, 6)) || '%'::text);

ALTER TABLE public.vw_latest_quads_ndvi
  OWNER TO root;
GRANT ALL ON TABLE public.vw_latest_quads_ndvi TO root;
GRANT SELECT ON TABLE public.vw_latest_quads_ndvi TO readonly;
GRANT ALL ON TABLE public.vw_latest_quads_ndvi TO dataonly;
