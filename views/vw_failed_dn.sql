-- View: public.vw_failed_dn

-- DROP VIEW public.vw_failed_dn;

CREATE OR REPLACE VIEW public.vw_failed_dn AS
WITH failed_dn AS (SELECT
  lsfm.scene_id,
  (now()::date - lsfm.acquisition_date)::double precision days_ago,
  'WRITE DN'::text as process,
  CASE WHEN minimum_dn.scene_id IS null THEN 'False' ELSE 'True' END AS process_status,
  CASE WHEN minimum_dn.scene_id IS null THEN 'FAILED! To write DN' ELSE 'DN written' END AS process_message
FROM minimum_dn
  RIGHT JOIN (SELECT scene_id, acquisition_date, modified_date
	FROM landsat_metadata
	WHERE now()::date - landsat_metadata.acquisition_date::date <= 6 and now()::date - landsat_metadata.acquisition_date::date  > 0) AS lsfm
   ON minimum_dn.scene_id = lsfm.scene_id)
SELECT * FROM failed_dn WHERE process_status = 'False';


ALTER TABLE public.vw_failed_dn
  OWNER TO root;
GRANT ALL ON TABLE public.vw_failed_dn TO root;
GRANT SELECT ON TABLE public.vw_failed_dn TO readonly;
GRANT ALL ON TABLE public.vw_failed_dn TO dataonly;
