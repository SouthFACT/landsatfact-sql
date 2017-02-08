-- View: public.vw_failed_l1metadata

-- DROP VIEW public.vw_failed_l1metadata;
CREATE OR REPLACE VIEW public.vw_failed_l1metadata AS
WITH level_1_metadata_fail AS (SELECT
  lsfm.scene_id,
  date_part('day', age(now(), lsfm.acquisition_date)) days_ago,
  'WRITE LEVEL1 METADATA'::text as process,
  CASE WHEN level1_metadata.level1_id IS null THEN  'False'  ELSE 'True' END AS process_status,
  CASE WHEN level1_metadata.level1_id IS null THEN 'FAILED! To write level 1 metadata' ELSE 'Level 1 metadata written' END AS process_message
FROM level1_metadata
  RIGHT JOIN (SELECT scene_id, acquisition_date, modified_date, l1_key
	FROM landsat_metadata
	WHERE landsat_metadata.acquisition_date >= ('now'::text::date - '3 days'::interval day) AND needs_processing = 'YES' AND  downloaded = 'YES') AS lsfm
   ON level1_metadata.level1_id = lsfm.l1_key)
SELECT * FROM level_1_metadata_fail WHERE process_status = 'False';


ALTER TABLE public.vw_failed_l1metadata
  OWNER TO root;
GRANT ALL ON TABLE public.vw_failed_l1metadata TO root;
GRANT SELECT ON TABLE public.vw_failed_l1metadata TO readonly;
GRANT ALL ON TABLE public.vw_failed_l1metadata TO dataonly;
