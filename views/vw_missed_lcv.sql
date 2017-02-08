-- View: public.vw_missed_lcv

-- DROP VIEW public.vw_missed_lcv;
CREATE OR REPLACE VIEW public.vw_missed_lcv AS
WITH missed_lcv AS (SELECT
  lsfm.scene_id,
  date_part('day', age(now(), lsfm.acquisition_date)) days_ago,
  'LCV MISSED'::text as process,
  CASE WHEN downloaded IS null THEN 'False' ELSE 'True' END AS process_status,
  CASE WHEN downloaded IS null THEN 'FAILED! Missed in LCV, scene was not downloaded or download was not available.' ELSE 'Downloaded' END AS process_message
FROM landsat_metadata AS lsfm
WHERE lsfm.acquisition_date >= ('now'::text::date - '5 days'::interval day) )
SELECT * FROM missed_lcv WHERE process_status = 'False';



ALTER TABLE public.vw_missed_lcv
  OWNER TO root;
GRANT ALL ON TABLE public.vw_missed_lcv TO root;
GRANT SELECT ON TABLE public.vw_missed_lcv TO readonly;
GRANT ALL ON TABLE public.vw_missed_lcv TO dataonly;
