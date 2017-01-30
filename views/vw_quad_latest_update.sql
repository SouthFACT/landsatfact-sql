-- View: public.vw_quad_latest_update

-- DROP VIEW public.vw_quad_latest_update;

CREATE OR REPLACE VIEW public.vw_quad_latest_update AS
 WITH latestquads AS (
	SELECT
	  extracted_imagery.quad_id AS oid,
	  lq.geom,
	  max(products.product_date) AS last_update,
	  row_number() OVER (PARTITION BY extracted_imagery.quad_id ORDER BY max(products.product_date) DESC) AS rank,
	  ''::character varying(600) as srs,
	  products.input1,
	  ((substr(products.input1::text, 10, 4) || '-01-01'::text)::date) + (substr(products.input1::text, 14, 3)::integer - 1) AS input1_date,
	  products.input2,
	  ((substr(products.input2::text, 10, 4) || '-01-01'::text)::date) + (substr(products.input2::text, 14, 3)::integer - 1) AS input2_date
	FROM
	   products
           JOIN extracted_imagery ON  products.input1 = extracted_imagery.quad_scene
           JOIN landsat_quads as lq ON  extracted_imagery.quad_id = lq.quad_id
	WHERE
	  products.analysis_source = 'LCV'
	  AND (products.disk_status = 'on_disk' OR products.product_date > '2016-06-11'::date)
	GROUP BY
	   products.input1,
	   products.input2,
	   extracted_imagery.quad_id,
	   lq.geom,
	  ((substr(products.input1::text, 10, 4) || '-01-01'::text)::date) + (substr(products.input1::text, 14, 3)::integer - 1),
	  ((substr(products.input2::text, 10, 4) || '-01-01'::text)::date) + (substr(products.input2::text, 14, 3)::integer - 1)
       )
 SELECT latestquads.oid,
    latestquads.geom,
    latestquads.last_update,
    latestquads.rank,
    latestquads.srs,
    latestquads.input1,
    latestquads.input1_date,
    latestquads.input2,
    latestquads.input2_date
   FROM latestquads
  WHERE latestquads.rank = 1;


ALTER TABLE public.vw_quad_latest_update
  OWNER TO root;
GRANT ALL ON TABLE public.vw_quad_latest_update TO root;
GRANT SELECT ON TABLE public.vw_quad_latest_update TO readonly;
GRANT ALL ON TABLE public.vw_quad_latest_update TO dataonly;
