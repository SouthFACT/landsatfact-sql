-- View: public.vw_scenes_less_five

-- DROP VIEW public.vw_scenes_less_five;
CREATE OR REPLACE VIEW public.vw_scenes_less_five AS
SELECT
        wrs.geom as geom,
	wrs.wrs2_code,
	wrs.gid,
	lm.cc_full::real,
	lm.scene_id::character varying(35),
	lm.acquisition_date::date,
	abs(lm.acquisition_date - now()::date )::integer as days_ago,
	lm.browse_url::character varying(100),
	(ROW_NUMBER() OVER(PARTITION BY wrs.wrs2_code ORDER BY lm.acquisition_date::date))::bigint AS rank
FROM wrs2_codes as wrs
  LEFT JOIN landsat_metadata as lm
    ON wrs2_code = substr(lm.scene_id,4,6)
WHERE lm.cc_full < 5 and lm.acquisition_date > '2014-07-01'::date
ORDER BY  wrs.gid,(ROW_NUMBER() OVER(PARTITION BY wrs.wrs2_code ORDER BY lm.acquisition_date::date))::bigint ;

ALTER TABLE public.vw_scenes_less_five OWNER TO root;
GRANT ALL ON TABLE public.vw_scenes_less_five TO root;
GRANT SELECT ON TABLE public.vw_scenes_less_five TO readonly;
GRANT ALL ON TABLE public.vw_scenes_less_five TO dataonly;
