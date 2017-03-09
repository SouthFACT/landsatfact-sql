-- View: public.vw_failed_lcv_quads

-- DROP VIEW public.vw_failed_lcv_quads;

CREATE OR REPLACE VIEW public.vw_failed_lcv_quads AS
WITH potential_quads AS (SELECT
	acquisition_date,
	scene_id,
	added_date,
	CASE WHEN cc_quad_ul < 50 THEN scene_id || 'UL' ELSE null END as quad,
	CASE WHEN cc_quad_ul < 50 THEN 'Quad ' ||  scene_id || 'UL should have been created'  ELSE 'Quad ' ||  scene_id || 'UL was '  || cc_quad_ul || '% and did not meet the cloud threshold of 50%' END  as quad_message
FROM  landsat_metadata
UNION
SELECT
	acquisition_date,
	scene_id,
	added_date,
	CASE WHEN cc_quad_ur < 50 THEN scene_id || 'UR' ELSE null END as quad,
	CASE WHEN cc_quad_ur < 50 THEN 'Quad ' ||  scene_id || 'UR should have been created'  ELSE 'Quad ' ||  scene_id || 'UR was '  || cc_quad_ur || '% and did not meet the cloud threshold of 50%' END  as quad_message
FROM  landsat_metadata
UNION
SELECT
	acquisition_date,
	scene_id,
	added_date,	
	CASE WHEN cc_quad_ll < 50 THEN scene_id || 'LL' ELSE null END as quad,
	CASE WHEN cc_quad_ll < 50 THEN 'Quad ' ||  scene_id || 'LL should have been created'  ELSE 'Quad ' ||  scene_id || 'LL was '  || cc_quad_ll || '% and did not meet the cloud threshold of 50%' END  as quad_message
FROM  landsat_metadata
UNION
SELECT
	acquisition_date,
	scene_id,
	added_date,
	CASE WHEN cc_quad_lr < 50 THEN scene_id || 'LR' ELSE null END as quad,
	CASE WHEN cc_quad_lr < 50 THEN 'Quad ' ||  scene_id || 'LR should have been created'  ELSE 'Quad ' ||  scene_id || 'LR was '  || cc_quad_lr || '% and did not meet the cloud threshold of 50%' END  as quad_message
FROM  landsat_metadata
ORDER BY acquisition_date desc)
SELECT
	scene_id,
	quad,
	now()::date - acquisition_date::date AS days_ago,
	acquisition_date,
	added_date,
	CASE WHEN analysis_source IS NULL THEN 'N/A' ELSE analysis_source END analysis_source,
	CASE WHEN product_id is null THEN
		CASE WHEN strpos( quad_message, 'did not meet the cloud threshold') > 0  THEN 'WARNING' ELSE 'ERROR' END
	ELSE 'INFO' END AS message_level,
	CASE WHEN product_id is null THEN quad_message ELSE 'Quad Created' END AS message
FROM potential_quads
   LEFT OUTER JOIN products
	ON potential_quads.quad = products.input2
WHERE now()::date - acquisition_date::date <= 5 and now()::date - acquisition_date::date  > 0
ORDER BY
	now()::date - acquisition_date::date,
	CASE WHEN product_id is null THEN
		CASE WHEN strpos( quad_message, 'did not meet the cloud threshold') > 0  THEN 'WARNING' ELSE 'ERROR' END
	ELSE 'INFO' END;


ALTER TABLE public.vw_failed_lcv_quads
  OWNER TO root;
GRANT ALL ON TABLE public.vw_failed_lcv_quads TO root;
GRANT SELECT ON TABLE public.vw_failed_lcv_quads TO readonly;
GRANT ALL ON TABLE public.vw_failed_lcv_quads TO dataonly;
