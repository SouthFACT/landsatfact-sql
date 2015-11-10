CREATE TYPE custom_requests_pending as (
  aoi_id integer,
  node_id character varying(30),
  user_id character varying(30),
  aoi_name character varying(200),
  aoi_type character varying(30),
  status_id integer,
  status character varying(150)
);
