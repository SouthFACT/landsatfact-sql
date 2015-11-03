-- View: public.vw_latest_quads_ndmi

-- DROP VIEW public.vw_latest_quads_ndmi;

CREATE OR REPLACE VIEW public.vw_latest_quads_ndmi AS
 SELECT loc.location
   FROM vw_last_days_scenes lds
   JOIN vw_tile_index_ndmi loc ON lds.scene_id::text ~~ (('%'::text || "substring"(loc.oid::text, 1, 6)) || '%'::text);

ALTER TABLE public.vw_latest_quads_ndmi
  OWNER TO root;
GRANT ALL ON TABLE public.vw_latest_quads_ndmi TO root;
GRANT SELECT ON TABLE public.vw_latest_quads_ndmi TO readonly;
GRANT ALL ON TABLE public.vw_latest_quads_ndmi TO dataonly;
