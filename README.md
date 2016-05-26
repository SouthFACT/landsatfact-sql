# landsatfact-sql
A collection of all the SQL views, functions, and data types used by Landsat FACT.

### Landsat FACT SQL Functions
* [All functions](functions.md)
* [delete_user_aoi_by_nid](functions.md#function-delete_user_aoi_by_nid)
* [get_aoi_id_by_nodeid](functions.md#function-get_aoi_id_by_nodeid)
* [get_completedcustomrequests](functions.md#function-get_completedcustomrequests)
* [get_countyByGeoid](functions.md#function-get_countybygeoid)
* [get_customrequest_status_bynode](functions.md#function-get_customrequest_status_bynode)
* [get_customrequest_status_byuser](functions.md#function-get_customrequest_status_byuser)
* [get_customRequestsQuads](functions.md#function-get_customrequestsquads)
* [get_pendingCustomRequests](functions.md#function-get_pendingcustomrequests)
* [get_processCompleteCustomRequests](functions.md#function-get_processcompletecustomrequests)
* [get_scenesAlternate](functions.md#function-get_scenesalternate)
* [get_scenesMostRecent](functions.md#function-get_scenesmostrecent)
* [get_statusByAoiId](functions.md#function-get_statusbyaoiid)
* [initiate_custom_request](functions.md#function-initiate_custom_request)
* [insert_custom_request_scenes](functions.md#function-insert_custom_request_scenes)
* [insert_user_aoi_by_county](functions.md#function-insert_user_aoi_by_county)
* [insert_user_aoi_by_geojson](functions.md#function-insert_user_aoi_by_geojson)
* [is_validSceneIntersects](functions.md#function-is_validsceneintersects)
* [keys_and_values](functions.md#function-keys_and_values)\
* [update_custom_request_status](functions.md#function-update_custom_request_status)
* [update_user_aoi_by_county](functions.md#function-update_user_aoi_by_county)
* [update_user_aoi_by_geojson](functions.md#function-update_user_aoi_by_geojson)

### Landsat FACT SQL Views
* [All views](views.md)
* [vw_archive_product_dates](views.md#view-vw_archive_product_dates)
* [vw_custom_requests_for_viewer](views.md#view-vw_custom_requests_for_viewer)
* [vw_custom_request_tile_index_cloud](views.md#view-vw_custom_request_tile_index_cloud)
* [vw_custom_request_tile_index_gap](views.md#view-vw_custom_request_tile_index_gap)
* [vw_custom_request_tile_index_ndmi](views.md#view-vw_custom_request_tile_index_ndmi)
* [vw_custom_request_tile_index_ndvi](views.md#view-vw_custom_request_tile_index_ndvi)
* [vw_custom_request_tile_index_swir](views.md#view-vw_custom_request_tile_index_swir)
* [vw_customrequets_all_status](views.md#view-vw_customrequets_all_status)
* [vw_customrequets_hung](views.md#view-vw_customrequets_hung)
* [vw_download_scenes](views.md#view-vw_download_scenes)
* [vw_last_days_products](viewws/vw_last_days_products)
* [vw_last_days_scenes](views.md#view-vw_last_days_scenes)
* [vw_quad_latest_update](views.md#view-vw_quad_latest_update)
* [vw_quad_lc_history](views.md#view-vw_quad_lc_history)
* [vw_quilt](views.md#view-vw_quilt)
* [vw_reclass_products](views.md#view-vw_reclass_products)
* [vw_scenes_less_five](views.md#view-vw_scenes_less_five)
* [vw_tile_index_cloud](views.md#view-vw_tile_index_cloud)
* [vw_tile_index_customrequest](views.md#view-vw_tile_index_customrequest)
* [vw_tile_index_gap](views.md#view-vw_tile_index_gap)
* [vw_tile_index_ndmi](views.md#view-vw_tile_index_ndmi)
* [vw_tile_index_ndvi](views.md#view-vw_tile_index_ndvi)
* [vw_tile_index_swir](views.md#view-vw_tile_index_swir)
* [vw_user_notification](views.md#view-vw_user_notification)
* [vw_viewer_quad_history](views.md#view-vw_viewer_quad_history)
* [vw_viewer_quads](views.md#view-vw_viewer_quads)
* [vw_wms_params_for_geopdf](views.md#view-vw_wms_params_for_geopdf)

### Landsat FACT SQL Data Types
* [All Types](datatypes.md)
* [scene_geojson](datatypes.md#type-scene_geojson)
* [custom_requests_drupalstatus](datatypes.md#type-custom_requests_drupalstatus)
* [scene_url](datatypes.md#type-scene_url)
* [custom_requests_pending](datatypes.md#type-custom_requests_pending)
* [custom_request_quads](datatypes.md#type-custom_request_quads)
