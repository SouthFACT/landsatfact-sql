-- View: public.vw_quilt

-- DROP VIEW public.vw_quilt;
CREATE OR REPLACE VIEW public.vw_quilt AS 
WITH quilt AS  (SELECT
        wrs.geom as geom,
	wrs.wrs2_code,
	wrs.gid,
	lm.cc_full::real,
	lm.scene_id::character varying(35),
	lm.acquisition_date::date,
	abs(lm.acquisition_date - now()::date )::integer as days_ago,
	lm.browse_url::character varying(100),
	(ROW_NUMBER() OVER(PARTITION BY wrs.wrs2_code ORDER BY lm.acquisition_date::date DESC))::bigint AS rank	
FROM wrs2_codes as wrs
  LEFT JOIN landsat_metadata as lm
    ON wrs2_code = substr(lm.scene_id,4,6)
WHERE lm.cc_full < 5)
SELECT quilt.*
  FROM quilt
 WHERE quilt.rank = 1 or quilt.rank = 2 
 ORDER BY quilt.gid,quilt.rank ;

ALTER TABLE public.vw_quilt OWNER TO root;
GRANT ALL ON TABLE public.vw_quilt TO root;
GRANT SELECT ON TABLE public.vw_quilt TO readonly;
GRANT ALL ON TABLE public.vw_quilt TO dataonly;