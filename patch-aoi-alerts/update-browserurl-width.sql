DROP VIEW public.vw_latest_quads_cloud;
DROP VIEW public.vw_latest_quads_gap;
DROP VIEW public.vw_latest_quads_ndmi;
DROP VIEW public.vw_latest_quads_ndvi;
DROP VIEW public.vw_latest_quads_swir;

DROP VIEW public.vw_last_days_scenes;
DROP VIEW public.vw_quilt;
DROP VIEW public.vw_scenes_less_five;

DROP VIEW public.vw_download_scenes;

ALTER TABLE public.landsat_metadata ALTER COLUMN browse_url TYPE character varying(150);
ALTER TABLE public.landsat_metadata ALTER COLUMN  data_type_l1 TYPE character varying(15);


CREATE OR REPLACE VIEW public.vw_last_days_scenes AS
SELECT landsat_metadata.scene_id,
   landsat_metadata.sensor,
   landsat_metadata.acquisition_date,
   landsat_metadata.browse_url,
   landsat_metadata.path,
   landsat_metadata."row",
   landsat_metadata.cc_full,
   landsat_metadata.cc_quad_ul,
   landsat_metadata.cc_quad_ur,
   landsat_metadata.cc_quad_ll,
   landsat_metadata.cc_quad_lr,
   landsat_metadata.data_type_l1
  FROM landsat_metadata
 WHERE landsat_metadata.acquisition_date > ('now'::text::date - '3 days'::interval day)  AND landsat_metadata.download_available = 'YES' and (landsat_metadata.downloaded is null or landsat_metadata.downloaded = 'NO');

ALTER TABLE public.vw_last_days_scenes
  OWNER TO root;
GRANT ALL ON TABLE public.vw_last_days_scenes TO root;
GRANT SELECT ON TABLE public.vw_last_days_scenes TO readonly;
GRANT ALL ON TABLE public.vw_last_days_scenes TO dataonly;


CREATE OR REPLACE VIEW public.vw_latest_quads_cloud AS
 SELECT loc.location
   FROM vw_last_days_scenes lds
   JOIN vw_tile_index_cloud loc ON lds.scene_id::text ~~ (('%'::text || "substring"(loc.oid::text, 1, 6)) || '%'::text);

ALTER TABLE public.vw_latest_quads_cloud
  OWNER TO root;
GRANT ALL ON TABLE public.vw_latest_quads_cloud TO root;
GRANT SELECT ON TABLE public.vw_latest_quads_cloud TO readonly;
GRANT ALL ON TABLE public.vw_latest_quads_cloud TO dataonly;



CREATE OR REPLACE VIEW public.vw_latest_quads_gap AS
 SELECT loc.location
   FROM vw_last_days_scenes lds
   JOIN vw_tile_index_gap loc ON lds.scene_id::text ~~ (('%'::text || "substring"(loc.oid::text, 1, 6)) || '%'::text);

ALTER TABLE public.vw_latest_quads_gap
  OWNER TO root;
GRANT ALL ON TABLE public.vw_latest_quads_gap TO root;
GRANT SELECT ON TABLE public.vw_latest_quads_gap TO readonly;
GRANT ALL ON TABLE public.vw_latest_quads_gap TO dataonly;


CREATE OR REPLACE VIEW public.vw_latest_quads_ndmi AS
 SELECT loc.location
   FROM vw_last_days_scenes lds
   JOIN vw_tile_index_ndmi loc ON lds.scene_id::text ~~ (('%'::text || "substring"(loc.oid::text, 1, 6)) || '%'::text);

ALTER TABLE public.vw_latest_quads_ndmi
  OWNER TO root;
GRANT ALL ON TABLE public.vw_latest_quads_ndmi TO root;
GRANT SELECT ON TABLE public.vw_latest_quads_ndmi TO readonly;
GRANT ALL ON TABLE public.vw_latest_quads_ndmi TO dataonly;



CREATE OR REPLACE VIEW public.vw_latest_quads_ndvi AS
 SELECT loc.location
   FROM vw_last_days_scenes lds
   JOIN vw_tile_index_ndvi loc ON lds.scene_id::text ~~ (('%'::text || "substring"(loc.oid::text, 1, 6)) || '%'::text);

ALTER TABLE public.vw_latest_quads_ndvi
  OWNER TO root;
GRANT ALL ON TABLE public.vw_latest_quads_ndvi TO root;
GRANT SELECT ON TABLE public.vw_latest_quads_ndvi TO readonly;
GRANT ALL ON TABLE public.vw_latest_quads_ndvi TO dataonly;


CREATE OR REPLACE VIEW public.vw_latest_quads_swir AS
 SELECT loc.location
   FROM vw_last_days_scenes lds
   JOIN vw_tile_index_swir loc ON lds.scene_id::text ~~ (('%'::text || "substring"(loc.oid::text, 1, 6)) || '%'::text);

ALTER TABLE public.vw_latest_quads_swir
  OWNER TO root;
GRANT ALL ON TABLE public.vw_latest_quads_swir TO root;
GRANT SELECT ON TABLE public.vw_latest_quads_swir TO readonly;
GRANT ALL ON TABLE public.vw_latest_quads_swir TO dataonly;


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




CREATE OR REPLACE VIEW public.vw_download_scenes AS
 SELECT DISTINCT ON ("substring"(landsat_metadata.scene_id::text, 4, 6)) "substring"(landsat_metadata.scene_id::text, 4, 6) AS wrs2,
    "substring"(landsat_metadata.scene_id::text, 3, 1) AS satellite,
    landsat_metadata.scene_id,
    landsat_metadata.sensor,
    landsat_metadata.acquisition_date,
    landsat_metadata.browse_url,
    landsat_metadata.path,
    landsat_metadata."row",
    landsat_metadata.cc_full,
    landsat_metadata.cc_quad_ul,
    landsat_metadata.cc_quad_ur,
    landsat_metadata.cc_quad_ll,
    landsat_metadata.cc_quad_lr,
    landsat_metadata.data_type_l1
   FROM landsat_metadata
  ORDER BY "substring"(landsat_metadata.scene_id::text, 4, 6), "substring"(landsat_metadata.scene_id::text, 3, 1);

ALTER TABLE public.vw_download_scenes OWNER TO root;
GRANT ALL ON TABLE public.vw_download_scenes TO root;
GRANT SELECT ON TABLE public.vw_download_scenes TO readonly;
GRANT ALL ON TABLE public.vw_download_scenes TO dataonly;
