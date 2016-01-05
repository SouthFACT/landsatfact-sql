CREATE TYPE custom_requests_drupalstatus as (
  node_id character varying(30),
  user_id character varying(30),
  aoi_name character varying(200),
  status character varying(150),
  status_date timestamp without time zone
);
