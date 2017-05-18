CREATE TABLE "aoi_alerts_status_types" (
  "alert_status_id" integer,
  "status" character varying(150),
  "comment" character varying(255),
  PRIMARY KEY ("alert_status_id")
);


CREATE INDEX "aoi_alerts_status_types_alert_status_id" ON  "aoi_alerts_status_types" ("alert_status_id");

CREATE SEQUENCE public.aoi_alerts_status_types_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 2
  CACHE 1;
  
ALTER TABLE public.aoi_alerts_status_types_seq
  OWNER TO root;
  
GRANT ALL ON SEQUENCE public.aoi_alerts_status_types_seq TO root;
GRANT SELECT ON SEQUENCE public.aoi_alerts_status_types_seq TO readonly;
GRANT ALL ON SEQUENCE public.aoi_alerts_status_types_seq TO dataonly;

ALTER TABLE public.aoi_alerts_status_types ALTER COLUMN alert_status_id SET NOT NULL;
ALTER TABLE public.aoi_alerts_status_types ALTER COLUMN alert_status_id SET DEFAULT nextval('aoi_alerts_status_types_seq'::regclass);


CREATE TABLE "user_aoi_alerts" (
  "gid" integer
  "aoi_id" integer,
  "user_id" character varying(30),
  "modified_date" date,
  "added_date" date,  
  PRIMARY KEY ("gid")
);

CREATE TRIGGER edit BEFORE INSERT OR UPDATE
   ON public.user_aoi_alerts FOR EACH ROW
   EXECUTE PROCEDURE public.edit_stamp();

CREATE TRIGGER add BEFORE INSERT
   ON public.user_aoi_alerts FOR EACH ROW
   EXECUTE PROCEDURE public.add_stamp();

CREATE INDEX "FK_user_aoi_alerts_user_id" ON  "user_aoi_alerts" ("user_id");

CREATE SEQUENCE public.user_aoi_alerts_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 2
  CACHE 1;
  
ALTER TABLE public.user_aoi_alerts_seq
  OWNER TO root;
  
GRANT ALL ON SEQUENCE public.user_aoi_alerts_seq TO root;
GRANT SELECT ON SEQUENCE public.user_aoi_alerts_seq TO readonly;
GRANT ALL ON SEQUENCE public.user_aoi_alerts_seq TO dataonly;

ALTER TABLE public.user_aoi_alerts ALTER COLUMN gid SET NOT NULL;
ALTER TABLE public.user_aoi_alerts ALTER COLUMN gid SET DEFAULT nextval('user_aoi_alerts_seq'::regclass);


CREATE TABLE "aoi_alerts" (
  "aoi_id" integer,
  "node_id" character varying(30),
  "aoi_name" character varying(200),
  "aoi_public" boolean,
  "geom"  geometry(MultiPolygon,4326),
  "modified_date" date,
  "added_date" date,
  PRIMARY KEY ("aoi_id")
);

CREATE TRIGGER edit BEFORE INSERT OR UPDATE
   ON public.aoi_alerts FOR EACH ROW
   EXECUTE PROCEDURE public.edit_stamp();

CREATE TRIGGER add BEFORE INSERT
   ON public.aoi_alerts FOR EACH ROW
   EXECUTE PROCEDURE public.add_stamp();

   
CREATE TABLE "aoi_events" (
  "aoi_event_id" integer,
  "aoi_id" integer,
  "node_id" character varying(30),
  "event_date" date,
  "acres_change" float,
  "percent_change" float,
  "acres_analyzed" float,
  "percent_analyzed_change" float,
  "change_type_id" integer,
  "smallest_patch" float,
  "largest_patch" float,
  "patch_count" integer,
  "patch_indicator_id" integer,
  "max_patch_severity" float,
  "min_patch_severity" float,  
  "alert_status_id" integer,
  "modified_date" date,
  "added_date" date,
  PRIMARY KEY ("aoi_event_id", "aoi_id")
);

CREATE INDEX "FK_aoi_events_alert_status_id" ON  "aoi_events" ("alert_status_id");
CREATE INDEX "FK_aoi_events_alert_aoi_id" ON  "aoi_events" ("aoi_id");

CREATE SEQUENCE public.aoi_event_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE public.aoi_event_id_seq
  OWNER TO root;
  
GRANT ALL ON SEQUENCE public.aoi_event_id_seq TO root;
GRANT SELECT ON SEQUENCE public.aoi_event_id_seq TO readonly;
GRANT ALL ON SEQUENCE public.aoi_event_id_seq TO dataonly;

ALTER TABLE public.aoi_events ALTER COLUMN aoi_event_id SET NOT NULL;
ALTER TABLE public.aoi_events ALTER COLUMN aoi_event_id SET DEFAULT nextval('aoi_event_id_seq'::regclass);

CREATE TRIGGER edit BEFORE INSERT OR UPDATE
   ON public.aoi_events FOR EACH ROW
   EXECUTE PROCEDURE public.edit_stamp();

CREATE TRIGGER add BEFORE INSERT
   ON public.aoi_events FOR EACH ROW
   EXECUTE PROCEDURE public.add_stamp();
   
CREATE TABLE "aoi_products" (
  "gid" integer,
  "event_image_id" integer,
  "event_image1" character varying(50),
  "event_image2" character varying(50),
   "product_name" character varying(150),
  "modified_date" date,
  "added_date" date,
  PRIMARY KEY ("gid")
);

ALTER TABLE public.aoi_products
  OWNER TO root;

  
CREATE SEQUENCE public.aoi_products_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

GRANT ALL ON SEQUENCE public.aoi_products_seq TO root;
GRANT SELECT ON SEQUENCE public.aoi_products_seq TO readonly;
GRANT ALL ON SEQUENCE public.aoi_products_seq TO dataonly;

ALTER TABLE public.aoi_products ALTER COLUMN gid SET NOT NULL;
ALTER TABLE public.aoi_products ALTER COLUMN gid SET DEFAULT nextval('aoi_products_seq'::regclass);

CREATE TRIGGER edit BEFORE INSERT OR UPDATE
   ON public.aoi_products FOR EACH ROW
   EXECUTE PROCEDURE public.edit_stamp();

CREATE TRIGGER add BEFORE INSERT
   ON public.aoi_products FOR EACH ROW
   EXECUTE PROCEDURE public.add_stamp();
      
CREATE TABLE "forest_change_type" (
  "change_type_id" integer,
  "change_type" character varying(150),
  PRIMARY KEY ("change_type_id")
);

CREATE TABLE "forest_patch_indicator" (
  "patch_indicator_id" integer,
  "patch_indicator_name" character varying(150),
  "patch_indicator_infographic" character varying(150),
  PRIMARY KEY ("patch_indicator_id")
);


CREATE TABLE "analysis_source" (
  "analysis_source_id" int,
  "analysis_source_code" character varying(10),
  PRIMARY KEY ("analysis_source_id")
);

CREATE INDEX "FK_analysis_source_analysis_source_code" ON  "analysis_source" ("analysis_source_code");

CREATE TRIGGER edit BEFORE INSERT OR UPDATE
   ON public.products FOR EACH ROW
   EXECUTE PROCEDURE public.edit_stamp();

CREATE TRIGGER add BEFORE INSERT
   ON public.products FOR EACH ROW
   EXECUTE PROCEDURE public.add_stamp()
   
--insert default values
INSERT INTO forest_change_type VALUES (0, 'Unknown');
INSERT INTO forest_change_type VALUES (1, 'Forest Harvesting');
INSERT INTO forest_change_type VALUES (2, 'Forest Pest');
INSERT INTO forest_change_type VALUES (3, 'Wildfire');
INSERT INTO forest_change_type VALUES (4, 'Prescribed Fire');
INSERT INTO forest_change_type VALUES (5, 'Storm Damage');
INSERT INTO forest_change_type VALUES (6, 'Tornado');
INSERT INTO forest_change_type VALUES (7, 'Flooding');
INSERT INTO forest_change_type VALUES (8, 'Land Clearing for Agriculture');
INSERT INTO forest_change_type VALUES (9, 'Land Clearing for Road or Land Development');
INSERT INTO forest_change_type VALUES (10, 'Data Anamoly / No Change Observed');
INSERT INTO forest_change_type VALUES (11, 'Other');

INSERT INTO forest_patch_indicator VALUES (0, 'No areas of change greater than an acre.', NULL);
INSERT INTO forest_patch_indicator VALUES (1, 'At least one area of change greater than or equal to an acre.', NULL);
INSERT INTO forest_patch_indicator VALUES (2, 'At least one area of change greater than or equal to five acres.', NULL);


   