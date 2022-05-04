//Event channel for stream events.
// ignore_for_file: constant_identifier_names

const INTENT_STREAM_SUBSCRIPTION_CHANNEL = "np.com.nepalipatro.intent.stream";
const FLUTTER_EVENT_CHANNEL_NAME = "flutter_event_channel";
//Default channel for native component communication.
const DEFAULT_CHANNEL_NP = "np.com.nepalipatro.channel";

/*//NOT USED.
const CHANNEL_BACKGROUND_MANAGER_PLUGIN=DEFAULT_CHANNEL_NP;
//not used.
const CHANNEL_BACKGROUND_MANAGER_PLUGIN_BACKGROUND=DEFAULT_CHANNEL_NP;*/

const CHANNEL_METHOD_LINK_ACTIONS = "link_actions";
const CHANNEL_METHOD_STOP_TTS = "stop_tts";
const CHANNEL_METHOD_INTENT_ACTIONS = "intent_actions";
const CHANNEL_METHOD_UTILS = "utils";
//METHOD FOR REINITIALIZING ALARMS.
const CHANNEL_METHOD_REINIT_EVENTS_ALARM = "channel_method_reinit_alarms";
//METHOD TO NOTIFY NATIVE PLATFORM ON PREFERENCES CHANGES.
const CHANNEL_METHOD_NOTIFICATION_PREF_CHANGED = "notification_prefs_changed";
const CHANNEL_METHOD_TEST = "test";
const CHANNEL_CLEAR_DATA = "CLEAR_ALL_DATA";
//METHOD TO CALL update current fcm token to backend.
const CHANNEL_METHOD_UPDATE_FCM = "update_fcm";
const CHANNEL_METHOD_HANDLE_FCM = "handle_fcm";
//METHOD CALL FOR OPENING URL IN NATIVE WEBBROWSER.
const CHANNEL_METHOD_OPEN_URL = "method_open_url";
const CHANNEL_METHOD_IOS_SET_SHARED_CONTAINER_PREF =
    "set_shared_container_pref";
const CHANNEL_METHOD_UPDATE_ALL_WIDGETS = "channel_method_update_all_alarms";
const CHANNEL_METHOD_IOS_BACKGROUND_FETCH = "ios_background_fetch";

/*
const CHANNEL_BACKGROUNDMANAGER_METHOD_SERVICE_INITIALIZATION="np.com.nepalipatro.channel.backgroundmanager_plugin_initialize";
const CHANNEL_BACKGROUNDMANAGER_METHOD_SERVICE_REGISTER="np.com.nepalipatro.channel.backgroundmanager_plugin_register";
const CHANNEL_BACKGROUNDMANAGER_METHOD_SERVICE_INIATIALIZED_ACK="np.com.nepalipatro.channel.backgroundmanager_plugin_initialized_ack";
const CHANNEL_BACKGROUNDMANAGER_METHOD_SERVICE_DATA_RESULT="np.com.nepalipatro.channel.backgroundmanager_plugin_method_service_data_result";
const CHANNEL_BACKGROUUNDMANAGER_METHOD_SERVICE_PROMOTE_TO_FORGROUND="np.com.nepalipatro.channel.backgroundmanager_plugin_promotetoforground";
const CHANNEL_BACKGROUNDMANAGER_METHOD_SERVICE_DEMOTE_TO_BACKGROUND="np.com.nepalipatro.channel.backgroundmanager_plugin_demote_to_background";
*/

//Method action used to check if the given app is installed or not.
//Android: Need to pass package name.
//Ios: Need to pass bundleId
const CHANNEL_METHODACTION_APPINSTALLED = "app_install";
//Method action used to open certain app.Need to pass package name for which app to open.
//Android: Need to pass package name.
//Ios: Need to pass bundleId
const CHANNEL_METHODACTION_APPOPEN = "open_app";

/*Method used to get wifi mac address of the device.*/
const CHANNEL_METHODACTION_GET_DEVICE_MAC = "get_device_mac";
const CHANNEL_METHODACTION_OPEN_MARKET = "action_open_market";
const CHANNEL_METHODACTION_INTENT_VIEW = "action_intent_view";
const CHANNEL_METHODACTION_INTENT_MAIL = "mail";
const CHANNEL_METHODACTION_INTENT_PHONE = "phone";
const CHANNEL_METHODACTION_GETFCM_TOKEN = "get_fcm_token";
const CHANNEL_METHODACTION_GET_APP_SDK_VERSION = "get_app_sdk_code";
const CHANNEL_METHODACTION_GET_FCM_TOKEN = "get_fcm_token";
const CHANNEL_METHODACTION_IOS_SHARED_CONTAINER_PATH = "shared_container_path";
const CHANNEL_METHODACTION_IOS_SET_SHARED_CONTAINER_PREFERRED_LANGUAGE =
    "set_shared_container_preferred_language";
