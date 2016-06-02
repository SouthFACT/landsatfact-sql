# Functions
A List of PostGreSQL functions used by landsat FACT.

Back to [Table of contents](README.md)

### function [delete_user_aoi_by_nid](functions/delete_user_aoi_by_nid.sql)
Function to delete a record from the subscription/custom request table.  User has indicated they no longer want subscription or cancel's custom request.
```sql
delete_user_aoi_by_nid(nid text) RETURNS void
```
**requires**
* nid text the node_id of a subscription or custom request


**returns**

* Not available for this type of function

**Example:**

```sql
SELECT * FROM delete_user_aoi_by_nid('552');
```
**Returns:**
```sql
delete_user_aoi_by_nid
------------------------------

(1 row)
```
Back to [Table of contents](README.md)
<br><br>
### function [get_aoi_id_by_nodeid](functions/get_aoi_id_by_nodeid.sql)
function gets the aoi_id for the users area of interest (subscription or custom request). The aoi_id is auto created and after insertion of new user_aoi (subscription or custom request)
 this functions provides a way to retrieve the aoi_id based on node_id.

```sql
get_aoi_id_by_nodeid(
    pass_node_id text)
  RETURNS integer
```
**requires**
* node_id text for the custom request


**returns**
*  aoi_id the aoi_id for the node_id

**Example:**

```sql
select * from get_aoi_id_by_nodeid('640');
```
**Returns:**
```sql
get_aoi_id_by_nodeid
----------------------
                 181
(1 row)
```

Back to [Table of contents](README.md)
<br><br>
### function [get_completedcustomrequests](functions/get_completedcustomrequests.sql)
Function to a table or list of completed custom requests..
```sql
get_completedcustomrequests()
  RETURNS SETOF custom_requests_pending
```
**requires**
* Nothing


**returns**
* table of data type [custom_requests_pending](datatypes.md#type-custom_requests_pending)
```
  aoi_id integer aoi_id of custom request
  node_id character varying(30) node_id of custom request
  user_id character varying(30) user_id of custom request
  aoi_name character varying(200) name of custom request
  aoi_type character varying(30), aoi type of custom request in this case should always be "custom_request"
  status_id integer the current status id which in this case should always be 1
  status character varying(150), the current status which in this case should always be "Completed"
```

**Example:**

```sql
SELECT * FROM get_completedcustomrequests();
```

**Returns:**
```sql
aoi_id | node_id | user_id |    aoi_name    |    aoi_type    | status_id | status  
--------+---------+---------+----------------+----------------+-----------+---------
   189 | 659     | 3       | Full Test      | custom_request |         4 | Completed
   190 | 660     | 3       | Full Test 2    | custom_request |         4 | Completed
   191 | 661     | 3       | Test With Name | custom_request |         4 | Completed
   192 | 662     | 3       | Test 2         | custom_request |         4 | Completed
   194 | 664     | 99      | test-goal      | custom_request |         4 | Completed
   195 | 665     | 99      | test-ga-cr1    | custom_request |         4 | Completed
   196 | 666     | 99      | test-ga-cr2    | custom_request |         4 | Completed
   197 | 667     | 99      | test-ga-cr3    | custom_request |         4 | Completed
   198 | 668     | 99      | test-ga-cr4    | custom_request |         4 | Completed
(9 rows)
```

Back to [Table of contents](README.md)
<br><br>
### function [get_countyByGeoid](functions/get_countybygeoid.sql)
Function to get GeoJSON for a county by the counties geoid.
```sql
get_countybygeoid(countygeoid integer)
  RETURNS text
```
**requires**
* countygeoid integer the geoid of a county


**returns**
* text that represents the GeoJSON of the county

**Example:**

```sql
SELECT * FROM get_countyByGeoid(37021);
```
**Returns:**
* [sample GeoJSON](sampledata/buncombecounty.geojson?short_path=f249f19)

Back to [Table of contents](README.md)
<br><br>
### function [get_customrequest_status_bynode](functions/get_customrequest_status_bynode.sql)
Function to get the all status's of a custom request for a node.  This is used provide status to a user in Drupal
```sql
CREATE OR REPLACE FUNCTION public.get_customrequest_status_bynode(cr_node_id varchar(25))
    RETURNS SETOF custom_requests_drupalstatus AS
```
**requires**
* cr_node_id::string - node_id of a custom request


**returns**
* table of data type [custom_requests_drupalstatus](datatypes.md#type-custom_requests_drupalstatus)
```
  node_id character varying(30) node_id of custom request
  user_id character varying(30) user_id of custom request
  aoi_name character varying(200) name of custom request
  status character varying(150), the current status which in this case should always be "Pending
 status_date timestamp without time zone, the date updated
```
**Example:**

```sql
SELECT * FROM get_customrequest_status_bynode('700');
```

**Returns:**
```sql
node_id | user_id |  aoi_name  |      status      |        status_date         
---------+---------+------------+------------------+----------------------------
700     | 99      | Daveism BC | Pending          | 2015-12-04 15:29:53.686619
700     | 99      | Daveism BC | Process Start    | 2015-12-04 19:00:01.711851
700     | 99      | Daveism BC | Process Complete | 2015-12-04 19:12:15.794222
700     | 99      | Daveism BC | Completed        | 2015-12-04 19:35:05.778281
(4 rows)
```

Back to [Table of contents](README.md)
br><br>
### function [get_customrequest_status_byuser](functions/get_customrequest_status_byuser.sql)
Function to get the all status's of a custom request for a user.  This is used provide status to a user in Drupal
```sql
CREATE OR REPLACE FUNCTION public.get_customrequest_status_byuser(cr_node_id varchar(25))
    RETURNS SETOF custom_requests_drupalstatus AS
```
**requires**
* cr_node_id::string - node_id of a custom request


**returns**
* table of data type [custom_requests_drupalstatus](datatypes.md#type-custom_requests_drupalstatus)
```
  node_id character varying(30) node_id of custom request
  user_id character varying(30) user_id of custom request
  aoi_name character varying(200) name of custom request
  status character varying(150), the current status which in this case should always be "Pending
 status_date timestamp without time zone, the date updated
```
**Example:**

```sql
SELECT * FROM get_customrequest_status_byuser('99');
```

**Returns:**
```sql
node_id | user_id |                     aoi_name                      |      status      |        status_date         
---------+---------+---------------------------------------------------+------------------+----------------------------
 664     | 99      | test-goal                                         | Pending          | 2015-11-10 15:56:18.172724
 664     | 99      | test-goal                                         | Process Start    | 2015-12-04 16:52:48.168791
 664     | 99      | test-goal                                         | Process Complete | 2015-12-04 16:52:48.182083
 664     | 99      | test-goal                                         | Completed        | 2015-12-04 19:35:03.890516
 665     | 99      | test-ga-cr1                                       | Pending          | 2015-11-10 15:59:04.852561
 665     | 99      | test-ga-cr1                                       | Process Start    | 2015-11-18 20:27:27.852247
 665     | 99      | test-ga-cr1                                       | Process Complete | 2015-11-18 20:34:41.67022
 665     | 99      | test-ga-cr1                                       | Completed        | 2015-12-04 19:35:04.267007
 666     | 99      | test-ga-cr2                                       | Pending          | 2015-11-10 16:15:27.280243
 666     | 99      | test-ga-cr2                                       | Process Start    | 2015-11-18 20:35:10.78902
 666     | 99      | test-ga-cr2                                       | Process Complete | 2015-11-18 20:39:42.643833
 666     | 99      | test-ga-cr2                                       | Completed        | 2015-12-04 19:35:04.639956
 667     | 99      | test-ga-cr3                                       | Pending          | 2015-11-10 16:31:39.831295
 667     | 99      | test-ga-cr3                                       | Process Start    | 2015-11-18 20:40:03.31117
 667     | 99      | test-ga-cr3                                       | Process Complete | 2015-11-18 20:47:58.039083
 667     | 99      | test-ga-cr3                                       | Completed        | 2015-12-04 19:35:05.016011
 668     | 99      | test-ga-cr4                                       | Pending          | 2015-11-10 16:37:37.719004
 668     | 99      | test-ga-cr4                                       | Process Start    | 2015-11-18 20:48:31.099426
 668     | 99      | test-ga-cr4                                       | Process Complete | 2015-11-18 20:51:44.547952
 668     | 99      | test-ga-cr4                                       | Completed        | 2015-12-04 19:35:05.401582
 700     | 99      | Daveism BC                                        | Pending          | 2015-12-04 15:29:53.686619
 700     | 99      | Daveism BC                                        | Process Start    | 2015-12-04 19:00:01.711851
 700     | 99      | Daveism BC                                        | Process Complete | 2015-12-04 19:12:15.794222
 700     | 99      | Daveism BC                                        | Completed        | 2015-12-04 19:35:05.778281
 (24 Rows)
```

Back to [Table of contents](README.md)

<br><br>
### function [get_customRequestQue_by_aoi_id](functions/get_customRequestQue_by_aoi_id.sql)
function to get the que and estimated time based on current average time complete a custom request.

```sql
get_customRequestQue_by_aoi_id(pass_aoi_id text))
    RETURNS text
```
**requires**
* pass_aoi_id::text - aoi_id of a custom request


**returns**
* text message describing in Que and approximate time to complete
```
ret_message
```
**Example:**

```sql
select * from get_customRequestQue_by_aoi_id('454');
```

**Returns:**
```sql
----------------------------------------------------------------------------------------
Your custom request is number 2 in the que and should take about 02:44:00 to complete.
(1 row)

```

Back to [Table of contents](README.md)
<br><br>
### function [get_customRequestQue_by_node_id](functions/get_customRequestQue_by_node_id.sql)
function to get the que and estimated time based on current average time complete a custom request.

```sql
get_customRequestQue_by_node_id(pass_node_id text)
    RETURNS text
```
**requires**
* pass_node_id::text - aoi_id of a custom request


**returns**
* text message describing in Que and approximate time to complete
```
ret_message
```
**Example:**

```sql
select * from get_customRequestQue_by_node_id('1041');
```

**Returns:**
```sql
----------------------------------------------------------------------------------------
Your custom request is number 2 in the que and should take about 02:44:00 to complete.
(1 row)

```

Back to [Table of contents](README.md)
<br><br>
### function [get_customRequestsQuads](functions/get_customrequestsquads.sql)
Function to a table or list of pending custom requests..
```sql
get_customRequestsQuads(cr_aoi_id integer)
  RETURNS SETOF custom_request_quads
```
**requires**
* cr_aoi_id::integer - aoi_id of a custom request


**returns**
* table of data type [custom_request_quads](datatypes.md#type-custom_request_quads)
```
  aoi_id integer aoi_id of custom request,
  quad_id character varying(8) quad id of custom request,
  scene_id character varying(25) scene id of the custom request,
  quad_order bigint quad order use this to determine order of comparsion in change.  1 is first 2 is second,
  wrs2_code character varying(6) wrs2 code of the custom request,
  scene_date date date the scene was taken (derived from the scene id),
  aoi_type character varying(30) the type of the aoi in this case its  "custom_request",
  quad_location text quad location (LL lower left,  UL Upper Left, LR Lower Right, UR Upper Right),
  request_id character varying(100) request id should be username_aoiid.zip,
  current_status_id integer current status id,
  current_status character varying(150) current status should be the highest status (determined by the status id)
           1 "Pending"
           2 "Process Start"
           3 "Process Complete"
           4 "Completed"
```
**Example:**

```sql
SELECT * FROM get_customrequestsquads(194);
```

**Returns:**
```sql
aoi_id | quad_id  |       scene_id        | quad_order | wrs2_code | scene_date |    aoi_type    | quad_location |   request_id    | current_status_id | current_status
--------+----------+-----------------------+------------+-----------+------------+----------------+---------------+-----------------+-------------------+----------------
   194 | 017038LL | LE70170382012003EDC00 |          1 | 017038    | 2012-01-04 | custom_request | LL            | daveism_194.zip |                 1 | Pending
   194 | 017038LL | LE70170382013005EDC00 |          2 | 017038    | 2013-01-06 | custom_request | LL            | daveism_194.zip |                 1 | Pending
   194 | 018038LR | LE70180382011359EDC00 |          1 | 018038    | 2011-12-26 | custom_request | LR            | daveism_194.zip |                 1 | Pending
   194 | 018038LR | LE70180382012362EDC00 |          2 | 018038    | 2012-12-28 | custom_request | LR            | daveism_194.zip |                 1 | Pending
   194 | 018038UR | LE70180382011359EDC00 |          1 | 018038    | 2011-12-26 | custom_request | UR            | daveism_194.zip |                 1 | Pending
   194 | 018038UR | LE70180382012362EDC00 |          2 | 018038    | 2012-12-28 | custom_request | UR            | daveism_194.zip |                 1 | Pending
```

Back to [Table of contents](README.md)

<br><br>
### function [get_customRequestURLByNodeId](functions/get_customRequestURLByNodeId.sql)
function gets the url of custom requestby it's drupal node_id.
 needed for providing download links for custom requests in the drupal status page.
```sql
get_customRequestURLByNodeId(pass_node_id text)
    RETURNS text AS
```
**requires**
*   node_id character varying(30) node_id of custom request

**returns**
```
url of type text
```

**Example:**

```sql
select get_customRequestURLByNodeId('827')
```

**Returns:**
```sql
get_customrequesturlbynodeid
------------------------------
daveism_399.zip
(1 row)
```

Back to [Table of contents](README.md)
<br><br>
### function [get_pendingcustomrequests](functions/get_pendingcustomrequests.sql)
Function to a table or list of pending custom requests..
```sql
get_pendingCustomRequests()
  RETURNS SETOF custom_requests_pending
```
**requires**
* Nothing


**returns**
* table of data type [custom_requests_pending](datatypes.md#type-custom_requests_pending)
```
  aoi_id integer aoi_id of custom request
  node_id character varying(30) node_id of custom request
  user_id character varying(30) user_id of custom request
  aoi_name character varying(200) name of custom request
  aoi_type character varying(30), aoi type of custom request in this case should always be "custom_request"
  status_id integer the current status id which in this case should always be 1
  status character varying(150), the current status which in this case should always be "Pending"
```

**Example:**

```sql
SELECT * FROM get_pendingcustomrequests();
```

**Returns:**
```sql
aoi_id | node_id | user_id |    aoi_name    |    aoi_type    | status_id | status  
--------+---------+---------+----------------+----------------+-----------+---------
   189 | 659     | 3       | Full Test      | custom_request |         1 | Pending
   190 | 660     | 3       | Full Test 2    | custom_request |         1 | Pending
   191 | 661     | 3       | Test With Name | custom_request |         1 | Pending
   192 | 662     | 3       | Test 2         | custom_request |         1 | Pending
   194 | 664     | 99      | test-goal      | custom_request |         1 | Pending
   195 | 665     | 99      | test-ga-cr1    | custom_request |         1 | Pending
   196 | 666     | 99      | test-ga-cr2    | custom_request |         1 | Pending
   197 | 667     | 99      | test-ga-cr3    | custom_request |         1 | Pending
   198 | 668     | 99      | test-ga-cr4    | custom_request |         1 | Pending
(9 rows)
```

Back to [Table of contents](README.md)
<br><br>
### function [get_processcompletecustomrequests](functions/get_processcompletecustomrequests.sql)
Function to a table or list of processing complete custom requests.  these need emails sent.
```sql
get_processcompletecustomrequests()
  RETURNS SETOF custom_requests_pending
```
**requires**
* Nothing


**returns**
* table of data type [custom_requests_pending](datatypes.md#type-custom_requests_pending)
```
  aoi_id integer aoi_id of custom request
  node_id character varying(30) node_id of custom request
  user_id character varying(30) user_id of custom request
  aoi_name character varying(200) name of custom request
  aoi_type character varying(30), aoi type of custom request in this case should always be "custom_request"
  status_id integer the current status id which in this case should always be 3
  status character varying(150), the current status which in this case should always be "Process Complete"
```

**Example:**

```sql
SELECT * FROM get_processcompletecustomrequests();
```

**Returns:**
```sql
aoi_id | node_id | user_id |    aoi_name    |    aoi_type    | status_id | status  
--------+---------+---------+----------------+----------------+-----------+---------
   189 | 659     | 3       | Full Test      | custom_request |         3 | Process Complete
   190 | 660     | 3       | Full Test 2    | custom_request |         3 | Process Complete
   191 | 661     | 3       | Test With Name | custom_request |         3 | Process Complete
   192 | 662     | 3       | Test 2         | custom_request |         3 | Process Complete
   194 | 664     | 99      | test-goal      | custom_request |         3 | Process Complete
   195 | 665     | 99      | test-ga-cr1    | custom_request |         3 | Process Complete
   196 | 666     | 99      | test-ga-cr2    | custom_request |         3 | Process Complete
   197 | 667     | 99      | test-ga-cr3    | custom_request |         3 | Process Complete
   198 | 668     | 99      | test-ga-cr4    | custom_request |         3 | Process Complete
(9 rows)
```

Back to [Table of contents](README.md)
<br><br>
### function [get_scenesAlternate](functions/get_scenesalternate.sql)
function to get alternate images for a custom request.  This is only used when the user is not satisfied with scene image.
```sql
get_scenesAlternate(
  customrequest_geojson text,
  customrequest_date date,
  wrs2_code text)
RETURNS SETOF scene_url
```
**requires**
* customrequest_date date the date passed by the user for the custom request.  agnostic to start or end date date format is yyyy-mm-dd or mm-dd-yyyy or yyyy/mm/dd or mm/dd/yyyy.
* wrs2_code text the wrs2_code of the scene to find alternate images for.

**returns**
* table of data type [scene_url](datatypes.md#type-scene_url)


**Example:**

```sql
SELECT * FROM get_scenesAlternate('2015-10-05','018035');
```
**Returns:**
```sql
ddaysfrom | cc_full |       scene_id        | wrs2_code | acquistion_date |                                      browse_url                                       
----------+---------+-----------------------+-----------+-----------------+---------------------------------------------------------------------------------------
    -4452 |   40.87 | LE70180352003209EDC01 | 018035    | 2003-07-28      | http://earthexplorer.usgs.gov/browse/etm/18/35/2003/LE7018035000320951.jpg
    -4436 |   90.83 | LE70180352003225EDC01 | 018035    | 2003-08-13      | http://earthexplorer.usgs.gov/browse/etm/18/35/2003/LE7018035000322551.jpg
    -4420 |   40.33 | LE70180352003241EDC01 | 018035    | 2003-08-29      | http://earthexplorer.usgs.gov/browse/etm/18/35/2003/LE7018035000324151.jpg
    -4388 |    6.04 | LE70180352003273EDC01 | 018035    | 2003-09-30      | http://earthexplorer.usgs.gov/browse/etm/18/35/2003/LE7018035000327351.jpg
    -4372 |    0.01 | LE70180352003289EDC01 | 018035    | 2003-10-16      | http://earthexplorer.usgs.gov/browse/etm/18/35/2003/LE7018035000328951.jpg
    -4356 |    0.02 | LE70180352003305EDC01 | 018035    | 2003-11-01      | http://earthexplorer.usgs.gov/browse/etm/18/35/2003/LE7018035000330551.jpg
    -4340 |   42.83 | LE70180352003321EDC03 | 018035    | 2003-11-17      | http://earthexplorer.usgs.gov/browse/etm/18/35/2003/LE7018035000332153.jpg
    -4324 |   99.94 | LE70180352003337EDC01 | 018035    | 2003-12-03      | http://earthexplorer.usgs.gov/browse/etm/18/35/2003/LE7018035000333751.jpg
    -4308 |   89.66 | LE70180352003353EDC02 | 018035    | 2003-12-19      | http://earthexplorer.usgs.gov/browse/etm/18/35/2003/LE7018035000335352.jpg
    -4292 |   79.19 | LE70180352004004GNC02 | 018035    | 2004-01-04      | http://earthexplorer.usgs.gov/browse/etm/18/35/2004/LE70180352004004GNC02.jpg
    -4276 |   18.71 | LE70180352004020EDC03 | 018035    | 2004-01-20      | http://earthexplorer.usgs.gov/browse/etm/18/35/2004/LE7018035000402053.jpg
    -4260 |   99.98 | LE70180352004036EDC01 | 018035    | 2004-02-05      | http://earthexplorer.usgs.gov/browse/etm/18/35/2004/LE7018035000403651.jpg
    -4244 |   39.55 | LE70180352004052EDC02 | 018035    | 2004-02-21      | http://earthexplorer.usgs.gov/browse/etm/18/35/2004/LE7018035000405252.jpg
    -4228 |   46.74 | LE70180352004068EDC01 | 018035    | 2004-03-08      | http://earthexplorer.usgs.gov/browse/etm/18/35/2004/LE7018035000406851.jpg
    -4212 |   75.85 | LE70180352004084EDC02 | 018035    | 2004-03-24      | http://earthexplorer.usgs.gov/browse/etm/18/35/2004/LE7018035000408452.jpg
    -4196 |    0.25 | LE70180352004100EDC02 | 018035    | 2004-04-09      | http://earthexplorer.usgs.gov/browse/etm/18/35/2004/LE7018035000410052.jpg
    -4180 |   82.61 | LE70180352004116EDC01 | 018035    | 2004-04-25      | http://earthexplorer.usgs.gov/browse/etm/18/35/2004/LE7018035000411651.jpg
...
```
Back to [Table of contents](README.md)
<br><br>
### function [get_scenesgeojson](functions/get_scenesgeojson.sql)
function to get GeoJSON and wrs2_code for a custom request.
```sql
get_scenesgeojson(
  customrequest_geojson text)
RETURNS SETOF scene_geojson
```
**requires**
* CustomRequest_GeoJSON text containing Custom Request GeoJSON

**returns**
* table of data type [scene_geojson](datatypes.md#type-scene_geojson)

**Example:**

**Note:** replace *some geojson* with [sample GeoJSON](sampledata/buncombecounty.geojson?short_path=f249f19)
```sql
SELECT * FROM get_scenesgeojson('some geojson');
```
**Returns:**
```sql
wrs2_code |                                                                                                                                                                                                                                                               geojson                                                                                                                                                                                                                                                                
-----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
018035    | {"type":"MultiPolygon","coordinates":[[[[-83.6066644360895,35.436244990029],[-83.606995929708,35.4362931795808],[-83.5933060200132,35.485687492988],[-83.5863269355887,35.5108686001641],[-83.2094804449266,36.8705615400183],[-83.2013282032923,36.899975493996],[-83.1887959596316,36.9451928531841],[-83.1884646566187,36.945144690244],[-81.1512965847653,36.6489928315925],[-81.1610615618593,36.6167467491402],[-81.5955104351528,35.18210188414],[-81.6065965355944,35.1454931641921],[-83.6066644360895,35.436244990029]]]]}
(1 row)
```
Back to [Table of contents](README.md)
<br><br>
### function [get_scenesMostRecent](functions/get_scenesmostrecent.sql)
Function to get images for a scene that was taken closest to the users requested date. The intention is to call this twice once for the start date then again for the end date.  There should be a image and url for each scene that the CustomRequest_GeoJson intersects.
```sql
get_scenesMostRecent(
    customrequest_geojson text,
    customrequest_date date)
RETURNS SETOF scene_url
```
**requires**
* CustomRequest_GeoJSON text containing Custom Request GeoJSON
* customrequest_date date the date passed by the user for the custom request.  agnostic to start or end date date format is yyyy-mm-dd or mm-dd-yyyy or yyyy/mm/dd or mm/dd/yyyy.

**returns**
* table of data type [scene_url](datatypes.md#type-scene_url)

**Example:**

**Note:** replace *some geojson* with [sample GeoJSON](sampledata/buncombecounty.geojson?short_path=f249f19)
```sql
SELECT * FROM get_scenesMostRecent('some geojson','2015-10-05');
```
**Returns:**
```sql
daysfrom | cc_full |       scene_id        | wrs2_code | acquistion_date |                                      browse_url                                       |                                                                                                                                                                                                                                                               geojson                                                                                                                                                                                                                                                                
----------+---------+-----------------------+-----------+-----------------+---------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        4 |   73.97 | LC80180352015282LGN00 | 018035    | 2015-10-09      | http://earthexplorer.usgs.gov/browse/landsat_8/2015/018/035/LC80180352015282LGN00.jpg | {"type":"MultiPolygon","coordinates":[[[[-83.6066644360895,35.436244990029],[-83.606995929708,35.4362931795808],[-83.5933060200132,35.485687492988],[-83.5863269355887,35.5108686001641],[-83.2094804449266,36.8705615400183],[-83.2013282032923,36.899975493996],[-83.1887959596316,36.9451928531841],[-83.1884646566187,36.945144690244],[-81.1512965847653,36.6489928315925],[-81.1610615618593,36.6167467491402],[-81.5955104351528,35.18210188414],[-81.6065965355944,35.1454931641921],[-83.6066644360895,35.436244990029]]]]}
(1 row)
```
Back to [Table of contents](README.md)
<br><br>
### function [get_statusByAoiId](functions/get_statusbyaoiid.sql)
Function to get the current status by the aoid of a custom request
```sql
get_statusByAoiId(ccr_aoi_id integer)
      RETURNS text
```
**requires**
* cr_aoi_id integer - aoi_id of a custom request.

**returns**
* cr_status varchar(150) the status of the custom request.

**Example:**

**Note:**
```sql
SELECT * FROM get_statusbyaoiid(198);
```
**Returns:**
```sql
get_statusbyaoiid
-------------------
Pending
(1 row)
```
Back to [Table of contents](README.md)
<br><br>
### function [initiate_custom_request](functions/initiate_custom_request.sql)
initiates the custom request process in the database. writes data to the PostGreSQL database for the Custom request python scripts to begin processing
* updates the table custom_requests with a new custom request
* updates the table custom_request_scenes with all scenes used by the custom request
* updates the table custom_request_dates marks status as pending with the current date

**NOTES**  
assumes that functions [insert_user_aoi_by_county](functions.md#function-insert_user_aoi_by_county) or  [insert_user_aoi_by_geojson](functions.md#function-insert_user_aoi_by_geojson) were called previously.

```sql
  initiate_custom_request(
      aoi_id text,
      user_id text,
      scenes text
      )
    RETURNS boolean
```
**requires**
* aoi_id text the node id of the custom request
* user_id the user_id for the custom request
* scenes as text comma delimited string of scene_ids from the landsat FACT ui

**returns**
* True if succeeds and false if fails

**Example**

```sql
select * from initiate_custom_request('9999','99','LE70180352015274EDC00,LE70180352015274EDC00');
```
**Returns:**
```sql
initiate_custom_request
------------------------------
t
(1 row)
```

Back to [Table of contents](README.md)
<br><br>
### function [insert_custom_request_scenes](functions/insert_custom_request_scenes.sql)
function inserts record into insert_custom_request_scenes to record each scene used by a custom request.
```sql
  insert_custom_request_scenes(
    aoi_id integer,
    scene_id character varying (35))
  RETURNS boolean
```
**requires**
* aoi_id integer the aoi_id of the custom request.
* scene_id character varying (35) the Landsat scene id.

**returns**
* True if succeeds and false if fails

**Example**

```sql
SELECT * FROM insert_custom_request_scenes(144,'LE70180352015274EDC00');
```
**Returns:**
```sql
insert_custom_request_scenes
------------------------------
t
(1 row)
```

Back to [Table of contents](README.md)
<br><br>
### function [insert_user_aoi_by_county](functions/insert_user_aoi_by_county.sql)
inserts a new subscription or custom request into the user_aoi table with a county.

```sql
    insert_user_aoi_by_county(
          node_id text,
          user_id text,
          aoi_name text,
          aoi_type text,
          county_geoid integer)
      RETURNS boolean
```
**requires**
* node_id text the node_id for the subscription or custom request (Drupal)
* user_id text the user_id for the subscription or custom request (Drupal)
* aoi_name text the subscription or custom request name
* aoi_type text the subscription or custom request type (subscription or custom request)
* county_geoid integer the county geoid

**returns**
* True if succeeds and false if fails

**Example**

```sql
SELECT * FROM insert_user_aoi_by_county('552','16','Buncombe County','subscription',37021);
```
**Returns:**
```sql
insert_user_aoi_by_county
------------------------------
t
(1 row)
```

Back to [Table of contents](README.md)
<br><br>
### function [insert_user_aoi_by_geojson](functions/insert_user_aoi_by_geojson.sql)
inserts a new subscription or custom request into the user_aoi with GeoJSON
```sql
    insert_user_aoi_by_geojson(
          node_id text,
          user_id text,
          aoi_name text,
          aoi_type text,
          geojson text)
      RETURNS boolean
```
**requires**
* node_id text the node_id for the subscription or custom request (Drupal)
* user_id text the user_id for the subscription or custom request (Drupal)
* aoi_name text the subscription or custom request name
* aoi_type text the subscription or custom request type (subscription or custom request)
* geojson text the GeoJSON of a shape

**returns**
* True if succeeds and false if fails

**Example**

**Note:** replace *some geojson* with [sample GeoJSON](sampledata/buncombecounty.geojson?short_path=f249f19)
```sql
SELECT * FROM insert_user_aoi_by_geojson('552','16','Buncombe County','subscription','some geojson');
```
**Returns:**
```sql
insert_user_aoi_by_geojson
------------------------------
t
(1 row)
```
Back to [Table of contents](README.md)
<br><br>
### function [is_validSceneIntersects](functions/is_validsceneintersects.sql)
function to ensure custom request geometry intersects <= n (number) of scenes.  Where n is the number of scenes the custom request geometry is allowed to intersect.
```sql
is_validSceneIntersects(
      customrequest_geojson text,
      allowed_intersections integer)
  RETURNS boolean
```
**requires**
* CustomRequest_GeoJSON text containing Custom Request GeoJSON
* allowed_Intersections integer that represents the maximum number of intersections allowed.

**returns**
* boolean
  * True if the number of scenes less than or equal to the allowed intersections
  * False if the number of scenes is greater the allowed intersections


**Example:**

**Note:** replace *some geojson* with [sample GeoJSON](sampledata/buncombecounty.geojson?short_path=f249f19)
```sql
SELECT * FROM is_validSceneIntersects('some geojson',4);
```
**Returns:**
```sql
is_validSceneIntersects
------------------------
t
(1 row)
```
Back to [Table of contents](README.md)
<br><br>


### function [keys_and_values](functions/keys_and_values.sql)
This function handles the addition of a row to the level1_metadata table and putting the row's key in landsat_metadata. It INSERTs the columns and values passed as the first 2 arguments. The third argument is the scene_id key used to identify the row in landsat_metadata to be updated with a foreign key to the new level1_metadata row.
```sql
keys_and_values(
      cols text,
      vals text.
      scene text)
  RETURNS integer
```
**requires**
* cols
* vals
* scene the scene id in text

**returns**
* l1_key integer

**Example:**
```sql
select * from select * from keys_and_values('(reflectance_add_band_5,radiance_maximum_band_3,radiance_maximum_band_4,radiance_maximum_band_5,radiance_maximum_band_6,radiance_maximum_band_7,sun_elevation,radiance_add_band_6_VCID_2,radiance_mult_band_6_VCID_2,reflectance_add_band_4,reflectance_mult_band_3,reflectance_mult_band_5,reflectance_mult_band_4,reflectance_mult_band_7,earth_sun_distance,radiance_add_band_3,radiance_add_band_5,radiance_add_band_4,radiance_add_band_7,radiance_add_band_6,radiance_mult_band_7,radiance_mult_band_6,radiance_mult_band_5,radiance_mult_band_4,radiance_mult_band_3,reflectance_add_band_7,reflectance_maximum_band_7,reflectance_maximum_band_4,reflectance_maximum_band_5,reflectance_add_band_3,reflectance_maximum_band_3)', '(-0.015838,152.9,241.1,31.06,17.04,10.8,59.19782167,3.1628,0.037205,-0.018452,0.0012754,0.001775,0.0029468,0.0016979,1.005131,-5.62165,-1.12622,-6.06929,-0.3939,-0.06709,0.043898,0.067087,0.12622,0.96929,0.62165,-0.015235,0.417722,0.73298,0.436782,-0.011534,0.313698)','LE70310342016112EDC01');
```

**Returns:**
```sql
keys_and_values
------------------------
2000224
(1 row)
```
Back to [Table of contents](README.md)
<br><br>
### function [update_custom_request_status](functions/update_custom_request_status.sql)
function updates the custom_request_dates table with the users status and the current date time.
```sql
  update_custom_request_status(
    aoi_id text,
    status integer)
  RETURNS boolean
```
**requires**
* aoi_id text the node id of the custom request
* status integer where:
  * 1  -"Pending"
  * 2 - "Process Start"
  * 3 - "Process Complete"
  * 4 - "Completed".

**returns**
* true if succeeds and false if fails

**Example:**

```sql
select * from update_custom_request_status('9999',2);
```
**Returns:**
```sql
update_custom_request_status
------------------------
t
(1 row)
```
update table:
```sql
aoi_id |    custom_request_date     | custom_request_status_id
--------+----------------------------+--------------------------
  9999 | 2015-11-09 18:03:01.759427 |                        1
  9999 | 2015-11-09 18:24:11.219049 |                        2
(2 rows)
```
Back to [Table of contents](README.md)
<br><br>
### function [update_user_aoi_by_county](functions/update_user_aoi_by_county.sql)
function to update a geometry in the subscription/custom request table.  Called when user selects a county.
```sql
update_user_aoi_by_county(
    nid text,
    county_geoid integer)
  RETURNS boolean
```
**requires**
* nid text node_id for the custom request or subscription.
* county_geoid integer County geoid for inserting geometry.

**returns**
* True if succeeds and false if fails

**Example:**

```sql
SELECT * FROM update_user_aoi_by_county('552',37021);
```
**Returns:**
```sql
update_user_aoi_by_county
------------------------
t
(1 row)
```
Back to [Table of contents](README.md)
<br><br>
### function [update_user_aoi_by_geojson](functions/update_user_aoi_by_geojson.sql)
function to update a geometry in the subscription/custom request table.  Called when user submits a custom geometry.
```sql
update_user_aoi_by_geojson(
    nid text,
    geojson text)
  RETURNS boolean
```
**requires**
* nid text node_id for the custom request or subscription.
* geojson text GeoJSON text for geometry.

**returns**
* True if succeeds and false if fails

**Example:**

**Note:** replace *some geojson* with [sample GeoJSON](sampledata/buncombecounty.geojson?short_path=f249f19)
```sql
SELECT * FROM update_user_aoi_by_geojson('552','some geojson');
```
**Returns:**
```sql
update_user_aoi_by_county
------------------------
t
(1 row)
```
Back to [Table of contents](README.md)
<br><br>
