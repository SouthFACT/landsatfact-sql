-- View: public.vw_missing_gap

-- DROP VIEW public.vw_missing_gap;
CREATE OR REPLACE VIEW public.vw_missing_gap AS
  with missing as (WITH gaptest as (
  	SELECT
  		replace(pgap.product_id,'_GapMask.tif','') gproduct_id,
  		pgap.product_type as gproduct_type,
  		pgap.product_date as gproduct_date
  	FROM products pgap
  	WHERE (pgap.product_type = 'GAP' and pgap.analysis_source = 'LCV')
  )  SELECT * FROM  gaptest
  	RIGHT JOIN (SELECT
  		replace(pgswir.product_id,'_percent_SWIR.tif','') product_id,
  		pgswir.product_type,
  		pgswir.product_date
  	FROM products pgswir
  	WHERE (pgswir.product_type = 'SWIR' and pgswir.analysis_source = 'LCV')) as pgswir ON gaptest.gproduct_id = pgswir.product_id
  ORDER BY pgswir.product_date)
  SELECT *,
    (SELECT path_data from lsf_enviroments) || '/swir/' ||product_id || '_percent_SWIR.tif'  as swir,
    (SELECT path_data from lsf_enviroments) || '/gap_mask/' ||product_id || '_GapMask.tif'  as gap
    FROM missing WHERE gproduct_id is null order by product_date::date desc;



ALTER TABLE public.vw_missing_gap
  OWNER TO root;
GRANT ALL ON TABLE public.vw_missing_gap TO root;
GRANT SELECT ON TABLE public.vw_missing_gap TO readonly;
GRANT ALL ON TABLE public.vw_missing_gap TO dataonly;
