// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_WALKTHORUGH = "PREFS_WALKTHROUGH";
const String PREFS_FIRST_INSTALL = "FIRST_INSTALL";
const String PREFERRED_LANGUAGE = "PREFERRED_LANGUAGE";
const String PREFERRED_THEME = "PREFERRED_THEME";
const String PREFS_FIRST_LAUNCH = "PREFS_FIRST_LAUNCH";
const String PREFS_FIRST_TIME_TOPIC = "PREFS_FIRST_TIME_TOPIC";
const String PREFS_FIRST_TIME_NEWS_SOURCES = "PREFS_FIRST_TIME_NEWS_SOURCES";
const String PREF_DEFAULT_RASHIFAL = "PREF_DEFAULT_RASHIFAL";
const String PREFS_DAILY_RASHIFAL_NOTIFICATION = "checkPrefHoroscopeNotifiy";
const String PREF_RASHIFAL_DAILY_PREFETCH_TIME =
    "checkPrefHoroscopeNotifiyPrefechTime";
const String PREFS_AMESSAGE_FETCHED_TIMESTAMP = "PREF_AMESSAGE_TIMESTAMP";
const String PREFS_CHECKED_UPDATE_TIMESTAMP = "PREF_CHECKED_UPDATE_TIMESTAMP";
const String PREF_RASHIFAL_PREFETCH = "PREF_RASHIFAL_PREFETCH";
const String PREF_NEWS_HOME_FETCH_TIMESTAMP = "PREF_NEWS_HOME_FETCH_TIMESTAMP";
const String PREF_NEWS_PREFERRED_LANG = "PREF_NEWS_PREFERRED_LANG";

const String prefFreshLoad = "PREF_FRESH_LOAD";

const String PREFS_STICKY_NOTIFICATION = "checkPrefStickyNotification";
const String PREF_NORMAL_NOTIFICATION = "checkPrefNormalNotification";

const String PREF_CALENDAR_DAILY_NOTIFICATION = "checkPrefSendNotification";
const String PREFS_EVENT_NOTIFICATION = "PREF_EVENT_NOTIFICATION";
const String PREFS_AUTO_UPDATE = "PREF_AUTO_UPDATE";

const String PREFS_NOTIFICATION_TIMEZONE = "PREF_NOTIFICATION_TIMEZONE";
const String PREFS_NOTIFICATION_TIME = "PREF_NOTIFICATION_TIME";
const String PREF_NOTIFICATION_TIME = "customPrefNotificationTime";

//APP MENU CONFIG
const String PREFS_APP_MENU_CONFIG = "PREF_APP_MENU_CONFIG";
const String PREFS_APP_MENU_DEV_CONFIG = "PREF_APP_MENU_DEV_CONFIG";

const String PREFS_INSTALL_DATE = "PREFS_INSTALL_DATE";
const String PREFS_UPGRADE_DATE = "PREFS_UPGRADE_DATE";
const String PREFS_FCM_TOKEN = "PREFS_FCM_TOKEN";
const String PREFS_FCM_TOKEN_SENT_TIME = "PREFS_FCM_TOKEN_SENT_TIME";
const String PREFS_SELECTED_LANGUAGE = "PREFS_SELECTED_LANGUAGE";
const String PREFS_VERSION_CODE = "PREFS_VERSION_CODE";
const String PREF_AUTH_TOKEN = "PREFS_AUTH_TOKEN";
const String PREF_REFRESH_AUTH_TOKEN = "PREFS_REFRESH_AUTH_TOKEN";
const String PREF_USER_ID = "PREFS_USER_ID";
const String IS_GOOGLE_LOGGEDIN = "IS_GOOGLE_LOGGED_IN";
const String PREF_ERP_CUSTOMER_CODE = "PREF_ERP_CUSTOMER_CODE";
const String PREF_ID = "PREF_ID";

//saved in json form: {"avatar":"image link","full_name":"xyz","email":"xyz@gmail.com"}
const String PREF_USER_DETAILS = "PREFS_USER_DETAIL";
const String PREF_DAYDETAIL_TOOLTIP = "PREFS_DAYDETAIL_TOOLTIP";
const String PREF_CALENDAR_SYNC_TIMESTAMP = "PREF_EVENTSYNC_TIMESTAMP";
const String PREF_NEP_CALENDAR_SYNC_TIMESTAMP = "PREF_NEP_EVENTSYNC_TIMESTAMP";

const String PREF_EVENT_SYNC_INTERVAL = "PREF_EVENT_SYNC_INTERVAL";

const String PREF_CALDB_VERSION = "PREF_CALDB_VERSION";
const String PREF_TITHIMAP_VERSION = "PREF_TITHIMAP_VERSION";
const String PREF_HOLIDAY_VERSION = "PREF_HOLIDAY_VERSION";
const String PREF_DATEMAP_VERSION = "PREF_DATEMAP_VERSION";

const String PREF_DAYDETAILS_DATA = "PREF_DAYDETAIL_DATA";

const String PREF_SESSION_COUNTER = "SESSION_COUNTER";
const String PREF_TOOLTIP_SESSION_COUNTER = "PREF_TOOLTIP_SESSION_COUNTER";
const String PREF_RATE_SESSION_COUNTER = "RATE_SESSION_COUNTER";

const bool USER_RATED_US_VALUE = false;
const String USER_RATED_US = "USER_RATED_US";

const String PREFS_RASHIFAL_NOTIFICATION_DISABLED_DAY_TIMESTAMP =
    "PREFS_RASHIFAL_NOTIFICATION_DISABLED_DAY_TIMESTAMP";

// Unique id for user to register fcm and for mapping unknown user to logged in
// user
const String PREF_UUID = "PREFS_UUID";
// Old uuid to migrate user when token refresh
const String PREF_OLD_UUID = "PREFS_OLD_UUID";

// To know if Token is sent to server
const String PREF_FCM_SENT = "PREF_FCM_SENT";

//TOOLTIPS
//TOOLTIPS SEARCH RESULTS
const String PREF_SEARCH_TOOLTIP = "PREF_SEARCH_TOOLTIP";
//TOOLTIPS EVENTS HOME
const String PREF_HOME_EVENT_TOOLTIP = "PREF_HOME_EVENT_TOOLTIP";
//TOOLTIP CALENDAR LISTS
const String PREF_TOOLTIP_CALENDARLIST = "PREF_TOOLTIP_CALENDARSLISTS";
//TOOLTIPS SUVASAIT
const String PREF_SUVASAIT_TOOLTIP = "PREF_SUVASAIT_TOOLTIP";

//Version Code on Pref

const String PREF_APP_VERSION = "PREF_APP_VERSION";

//--------------TimesOfNepal----------------------//

const String PREFS_TOP_READ = "PREFERENCE_TOP_READ";
const String PREFS_FOR_YOU = "PREFERENCE_FOR_YOU";
const String PREFS_BREIFING = "PREFERENCE_BREIFING";
const String PREFS_RECENT_NEWS = "PREFERENCE_RECENT_NEWS";
const String PREFS_HOME_PAGE_BRIEF_NEWS = "PREFERENCE_HOME_PAGE_BRIEF_NEWS";

const String PREFS_NOTIFICATION_DISABLED_DAY_TIMESTAMP =
    "PREFS_NOTIFICATION_DISABLED_DAY_TIMESTAMP";

const String prefFirstTimeNewsSource = "isFirstTimeNewsSource";

const String PREFERRED_NEWS_READ_MODE = "PREFERRED_NEWS_READ_MODE";

const String PREFS_USER_SEARCH_HISTORY = "PREF_USER_SEARCH_HISTORY";

const String PREFS_SELECTED_SOURCES = "PREFERENCES_SELECTEDSOURCES";
const String PREFS_SELECTED_CATEGORIES = "PREFERENCES_SELECTEDCATEGORIES";
const String PREFS_SELECTED_SOURCES_LANGUAGE =
    "PREFERENCES_SELECTEDSOURCESLANGUAGE";

const String PREFS_OUR_PRODUCTS = "PREFERENCE_OUR_PRODUCTS";

const String PREFS_USER_NEWS_ANALYTICS = "USER_NEWS_VIEW_ANALYTICS";

const String PREFS_APPENDING_URL = "PREFERENCE_APPENDING_URL";

const String PREFS_IS_FIRST_TIME = "IS_FIRST_TIME";
const String PREFS_IS_FIRST_TIME_RASHIFAL_PAGE = "IS_FIRST_TIME_RASHIFAL_PAGE";
const String PREFS_ENABLE_FCM_NEWS = "FCM_NEWS_ENABLE";
const String PREFS_ENABLE_FCM_RASHIFAL_NOTIFICATION =
    "FCM_RASHIFAL_NOTIFICATION_ENABLE";

const String PREFS_LAST_ONLINE_TIME = "PREFS_LAST_ONLINE_TIME";
const String PREFS_JWT_TOKEN = "PREFS_JWT_TOKEN";
const String PREFS_FROM_DATE = "PREFS_FROM_DATE";
const String PREFS_TO_DATE = "PREFS_TO_DATE";

const String PREFS_NEWS_WIDGET_REFRESH_TIME = "PREFS_NEWS_WIDGET_REFRESH_TIME";

const String PREFS_REWARDED_AD_AWARDED_TIME = "PREFS_REWARDED_AD_AWARDED_TIME";

const String PREFS_NEWS_LOADER_STATUS = "PREFS_NEWS_LOADER_STATUS";

const String PREFS_LAST_NEWS_FETCHED_TIME = "PREFS_LAST_NEWS_FETCHED_TIME";
const String PREFS_TOP_READ_LAST_NEWS_FETCHED_TIME =
    "PREFS_TOP_READ_LAST_NEWS_FETCHED_TIME";

const String PREFS_CALENDAR_TAB_BEHAVIOUR = "PREFS_CALENDAR_TAB_BEHAVIOUR";

const String PREFS_SERVICES_LAST_FETCH_TIME = "PREFS_SERVICES_LAST_FETCH_TIME";
const String PREFS_SERVICES = "PREFS_SERVICES";

const String PREFS_DEV_MODE_CHECK = "PREFS_DEV_MODE_CHECK";
const String PREFS_ADS_DISABLE = "PREFS_ADS_DISABLE";
const String PREFS_REMOTE_CONFIG_ADS = "PREFS_REMOTE_CONFIG_ADS";

const String PREFS_WEATHER_LOCATION = "PREFS_WEATHER_LOCATION";
const String PREFS_WEATHER_FIRST_OPEN = "PREFS_WEATHER_FIRST_OPEN";
const String PREFS_WEATHER_LAST_FETCH = "PREFS_WEATHER_LAST_FETCH";
const String PREFS_WEATHER_DATA = "PREFS_WEATHER_DATA";

/// Preference to enable/disable weather from the settings page
const String PREFS_WEATHER_ENABLE_SETTINGS = "PREFS_WEATHER_ENABLE_SETTINGS";

class PrefsUtils {
  static SharedPreferences? prefs;

  static Future<SharedPreferences?> getSharedPreferences() async {
    if (prefs == null) {
      return await SharedPreferences.getInstance();
    } else {
      return prefs;
    }
  }

  static Future<String> getString(String key, String defaultValue) async {
    SharedPreferences? prefs = await getSharedPreferences();
    return prefs?.getString(key) ?? defaultValue;
  }

  static Future<int> getInt(String key, int def) async {
    SharedPreferences? prefs = await getSharedPreferences();
    return prefs?.getInt(key) ?? def;
  }

  static Future<bool> getBoolean(String key, bool def) async {
    SharedPreferences? prefs = await getSharedPreferences();
    return prefs?.getBool(key) ?? def;
  }

  static getDouble(String key, {double def = 1}) async {
    SharedPreferences? preferences = await getSharedPreferences();
    return preferences?.getDouble(key) ?? def;
  }

  static putBoolean(String key, bool value) async {
    SharedPreferences? prefs = await getSharedPreferences();
    prefs?.setBool(key, value);
  }

  static putString(String key, String value) async {
    SharedPreferences? prefs = await getSharedPreferences();
    prefs?.setString(key, value);
  }

  static putInt(String key, int value) async {
    SharedPreferences? prefs = await getSharedPreferences();
    prefs?.setInt(key, value);
  }

  static putDouble(String key, double value) async {
    SharedPreferences? prefs = await getSharedPreferences();
    prefs?.setDouble(key, value);
  }
}
