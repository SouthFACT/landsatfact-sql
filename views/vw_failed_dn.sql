-- View: public.vw_failed_dn

-- DROP VIEW public.vw_failed_dn;

CREATE OR REPLACE VIEW public.vw_failed_dn AS
WITH ailed_dn AS (SELECT
  lsfm.scene_id,
  date_part('day', age(now(), lsfm.acquisition_date)) days_ago,
  'WRITE DN'::text as process,
  CASE WHEN minimum_dn.scene_id IS null THEN 'False' ELSE 'True' END AS process_status,
  CASE WHEN minimum_dn.scene_id IS null THEN 'FAILED! To write DN' ELSE 'DN written' END AS process_message
FROM minimum_dn
  RIGHT JOIN (SELECT scene_id, acquisition_date, modified_date
	FROM landsat_metadata
	WHERE landsat_metadata.acquisition_date >= ('now'::text::date - '3 days'::interval day)) AS lsfm
   ON minimum_dn.scene_id = lsfm.scene_id)
SELECT * FROM ailed_dn WHERE process_status = 'False';


ALTER TABLE public.vw_failed_dn
  OWNER TO root;
GRANT ALL ON TABLE public.vw_failed_dn TO root;
GRANT SELECT ON TABLE public.vw_failed_dn TO readonly;
GRANT ALL ON TABLE public.vw_failed_dn TO dataonly;
