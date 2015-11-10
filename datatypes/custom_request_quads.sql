CREATE TYPE custom_request_quads as (
  aoi_id integer,
  quad_id character varying(8),
  scene_id character varying(25),
  quad_order bigint,
  wrs2_code character varying(6),
  scene_date date,
  aoi_type character varying(30),
  quad_location text,
  request_id character varying(100),
  current_status_id integer,
  current_status character varying(150)
);
