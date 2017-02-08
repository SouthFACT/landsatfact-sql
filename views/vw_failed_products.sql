-- View: public.vw_failed_products

-- DROP VIEW public.vw_failed_products;

CREATE OR REPLACE VIEW public.vw_failed_products AS
WITH products_fail AS (SELECT
  scene_id,
  date_part('day', age(now(), lsfm.acquisition_date)) days_ago,
  'WRITE PRODUCTS'::text as process,
  CASE WHEN quad_cc > 50 THEN 'True' ELSE
	  CASE WHEN product_id IS null THEN 'False' ELSE 'True' END
  END AS process_status,
  CASE WHEN quad_cc > 50 THEN 'Quad "' || quad_id || '" exceeded cloud cover (' || quad_cc || ') threshold of 50% - product creation skipped' ELSE
	  CASE WHEN product_id IS null THEN 'FAILED! To create product' ELSE 'Product created' END
  END AS process_message
FROM products
	RIGHT JOIN (SELECT
	  scene_id,
	  substr(lsfm.scene_id, 0, 4) || wrs2_code ||  substr(lsfm.scene_id,10, 21) || substr(quad_id,7,8) AS quad,
	  wrs2_code,
	  quad_id,
	  acquisition_date,
	  CASE WHEN substr(quad_id,7,8) = 'UL' THEN cc_quad_ul ELSE
		CASE WHEN substr(quad_id,7,8) = 'UR' THEN cc_quad_ur ELSE
			CASE WHEN substr(quad_id,7,8) = 'LL' THEN cc_quad_ll ELSE
				CASE WHEN substr(quad_id,7,8) = 'LR' THEN cc_quad_lr ELSE 0
				END
			END
		END
	   END AS quad_cc
	FROM landsat_metadata as lsfm
	LEFT OUTER JOIN landsat_quads ON
		substr(lsfm.scene_id, 4, 6) = landsat_quads.wrs2_code
	WHERE landsat_quads.wrs2_code IS NOT NULL
		AND lsfm.acquisition_date >= ('now'::text::date - '3 days'::interval day) AND needs_processing = 'YES' AND  downloaded = 'YES'
	ORDER BY lsfm.scene_id ) as lsfm
   ON trim(input2)::text = trim(lsfm.quad)::text
ORDER BY process, process_status, process_message, days_ago, scene_id)
SELECT DISTINCT * FROM products_fail WHERE process_status = 'False';


ALTER TABLE public.vw_failed_products
  OWNER TO root;
GRANT ALL ON TABLE public.vw_failed_products TO root;
GRANT SELECT ON TABLE public.vw_failed_products TO readonly;
GRANT ALL ON TABLE public.vw_failed_products TO dataonly;
