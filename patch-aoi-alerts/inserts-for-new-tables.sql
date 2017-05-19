--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.14
-- Dumped by pg_dump version 9.4.0
-- Started on 2017-05-08 09:42:38 EDT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--

-- Data for Name: forest_change_type; Type: TABLE DATA; Schema: public; Owner: root
--

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


-- Data for Name: forest_patch_indicator; Type: TABLE DATA; Schema: public; Owner: root
--

INSERT INTO forest_patch_indicator VALUES (0, 'No areas of change greater than an acre.', NULL);
INSERT INTO forest_patch_indicator VALUES (1, 'At least one area of change greater than or equal to an acre.', NULL);
INSERT INTO forest_patch_indicator VALUES (2, 'At least one area of change greater than or equal to five acres.', NULL);



-- Data for Name: analysis_source; Type: TABLE DATA; Schema: public; Owner: root
--
INSERT INTO analysis_source VALUES (0, 'Unknown');
INSERT INTO analysis_source VALUES (1, 'LCV');
INSERT INTO analysis_source VALUES (2, 'Custom Request');
INSERT INTO analysis_source VALUES (3, 'AOI Alert');

-- Data for Name: aoi_alerts_status_types; Type: TABLE DATA; Schema: public; Owner: root
--
INSERT INTO aoi_alerts_status_types (alert_status_id, status, comment) VALUES (1, 'Pending', 'Event needs process but  has not started');
INSERT INTO aoi_alerts_status_types (alert_status_id, status, comment) VALUES (2, 'Process Start', 'Python geoprocessing has started for the event');
INSERT INTO aoi_alerts_status_types (alert_status_id, status, comment) VALUES (3, 'Process Complete', 'Python geoprocessing has completd and the notification is ready to be sent');
INSERT INTO aoi_alerts_status_types (alert_status_id, status, comment) VALUES (4, 'Notification Sent', 'Notification has been sent  to users subscribed to the aoi.');
