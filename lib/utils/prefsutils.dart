import 'package:shared_preferences/shared_preferences.dart';

final String PREFS_WALKTHORUGH = "PREFS_WALKTHROUGH";
final String PREFS_FIRST_INSTALL = "FIRST_INSTALL";
final String PREFERRED_LANGUAGE = "PREFERRED_LANGUAGE";
final String PREFERRED_THEME = "PREFERRED_THEME";
final String PREFS_FIRST_LAUNCH = "PREFS_FIRST_LAUNCH";
final String PREFS_FIRST_TIME_TOPIC = "PREFS_FIRST_TIME_TOPIC";
final String PREFS_FIRST_TIME_NEWS_SOURCES = "PREFS_FIRST_TIME_NEWS_SOURCES";
final String PREF_DEFAULT_RASHIFAL = "PREF_DEFAULT_RASHIFAL";
final String PREFS_DAILY_RASHIFAL_NOTIFICATION = "checkPrefHoroscopeNotifiy";
final String PREF_RASHIFAL_DAILY_PREFETCH_TIME =
    "checkPrefHoroscopeNotifiyPrefechTime";
final String PREFS_AMESSAGE_FETCHED_TIMESTAMP = "PREF_AMESSAGE_TIMESTAMP";
final String PREFS_CHECKED_UPDATE_TIMESTAMP = "PREF_CHECKED_UPDATE_TIMESTAMP";
final String PREF_RASHIFAL_PREFETCH = "PREF_RASHIFAL_PREFETCH";
final String PREF_NEWS_HOME_FETCH_TIMESTAMP = "PREF_NEWS_HOME_FETCH_TIMESTAMP";
final String PREF_NEWS_PREFERRED_LANG = "PREF_NEWS_PREFERRED_LANG";

final String prefFreshLoad = "PREF_FRESH_LOAD";

final String PREFS_STICKY_NOTIFICATION = "checkPrefStickyNotification";
final String PREF_NORMAL_NOTIFICATION = "checkPrefNormalNotification";

final String PREF_CALENDAR_DAILY_NOTIFICATION = "checkPrefSendNotification";
final String PREFS_EVENT_NOTIFICATION = "PREF_EVENT_NOTIFICATION";
final String PREFS_AUTO_UPDATE = "PREF_AUTO_UPDATE";

final String PREFS_NOTIFICATION_TIMEZONE = "PREF_NOTIFICATION_TIMEZONE";
final String PREFS_NOTIFICATION_TIME = "PREF_NOTIFICATION_TIME";
final String PREF_NOTIFICATION_TIME = "customPrefNotificationTime";

//APP MENU CONFIG
final String PREFS_APP_MENU_CONFIG = "PREF_APP_MENU_CONFIG";
final String PREFS_APP_MENU_DEV_CONFIG = "PREF_APP_MENU_DEV_CONFIG";

final String PREFS_INSTALL_DATE = "PREFS_INSTALL_DATE";
final String PREFS_UPGRADE_DATE = "PREFS_UPGRADE_DATE";
final String PREFS_FCM_TOKEN = "PREFS_FCM_TOKEN";
final String PREFS_FCM_TOKEN_SENT_TIME = "PREFS_FCM_TOKEN_SENT_TIME";
final String PREFS_SELECTED_LANGUAGE = "PREFS_SELECTED_LANGUAGE";
final String PREFS_VERSION_CODE = "PREFS_VERSION_CODE";
final String PREF_AUTH_TOKEN = "PREFS_AUTH_TOKEN";
final String PREF_REFRESH_AUTH_TOKEN = "PREFS_REFRESH_AUTH_TOKEN";
final String PREF_USER_ID = "PREFS_USER_ID";
final String IS_GOOGLE_LOGGEDIN = "IS_GOOGLE_LOGGED_IN";
final String PREF_ERP_CUSTOMER_CODE = "PREF_ERP_CUSTOMER_CODE";
final String PREF_ID = "PREF_ID";

//saved in json form: {"avatar":"image link","full_name":"xyz","email":"xyz@gmail.com"}
final String PREF_USER_DETAILS = "PREFS_USER_DETAIL";
final String PREF_DAYDETAIL_TOOLTIP = "PREFS_DAYDETAIL_TOOLTIP";
final String PREF_CALENDAR_SYNC_TIMESTAMP = "PREF_EVENTSYNC_TIMESTAMP";
final String PREF_NEP_CALENDAR_SYNC_TIMESTAMP = "PREF_NEP_EVENTSYNC_TIMESTAMP";

final String PREF_EVENT_SYNC_INTERVAL = "PREF_EVENT_SYNC_INTERVAL";

final String PREF_CALDB_VERSION = "PREF_CALDB_VERSION";
final String PREF_TITHIMAP_VERSION = "PREF_TITHIMAP_VERSION";
final String PREF_HOLIDAY_VERSION = "PREF_HOLIDAY_VERSION";
final String PREF_DATEMAP_VERSION = "PREF_DATEMAP_VERSION";

final String PREF_DAYDETAILS_DATA = "PREF_DAYDETAIL_DATA";

final String PREF_SESSION_COUNTER = "SESSION_COUNTER";
final String PREF_TOOLTIP_SESSION_COUNTER = "PREF_TOOLTIP_SESSION_COUNTER";
final String PREF_RATE_SESSION_COUNTER = "RATE_SESSION_COUNTER";

final bool USER_RATED_US_VALUE = false;
final String USER_RATED_US = "USER_RATED_US";

final String PREFS_RASHIFAL_NOTIFICATION_DISABLED_DAY_TIMESTAMP =
    "PREFS_RASHIFAL_NOTIFICATION_DISABLED_DAY_TIMESTAMP";

// Unique id for user to register fcm and for mapping unknown user to logged in
// user
final String PREF_UUID = "PREFS_UUID";
// Old uuid to migrate user when token refresh
final String PREF_OLD_UUID = "PREFS_OLD_UUID";

// To know if Token is sent to server
final String PREF_FCM_SENT = "PREF_FCM_SENT";

//TOOLTIPS
//TOOLTIPS SEARCH RESULTS
final String PREF_SEARCH_TOOLTIP = "PREF_SEARCH_TOOLTIP";
//TOOLTIPS EVENTS HOME
final String PREF_HOME_EVENT_TOOLTIP = "PREF_HOME_EVENT_TOOLTIP";
//TOOLTIP CALENDAR LISTS
final String PREF_TOOLTIP_CALENDARLIST = "PREF_TOOLTIP_CALENDARSLISTS";
//TOOLTIPS SUVASAIT
final String PREF_SUVASAIT_TOOLTIP = "PREF_SUVASAIT_TOOLTIP";

//Version Code on Pref

final String PREF_APP_VERSION = "PREF_APP_VERSION";

//--------------TimesOfNepal----------------------//

final String PREFS_TOP_READ = "PREFERENCE_TOP_READ";
final String PREFS_FOR_YOU = "PREFERENCE_FOR_YOU";
final String PREFS_BREIFING = "PREFERENCE_BREIFING";
final String PREFS_RECENT_NEWS = "PREFERENCE_RECENT_NEWS";
final String PREFS_HOME_PAGE_BRIEF_NEWS = "PREFERENCE_HOME_PAGE_BRIEF_NEWS";

final String PREFS_NOTIFICATION_DISABLED_DAY_TIMESTAMP =
    "PREFS_NOTIFICATION_DISABLED_DAY_TIMESTAMP";

final String prefFirstTimeNewsSource = "isFirstTimeNewsSource";

final String PREFERRED_NEWS_READ_MODE = "PREFERRED_NEWS_READ_MODE";

final String PREFS_USER_SEARCH_HISTORY = "PREF_USER_SEARCH_HISTORY";

final String PREFS_SELECTED_SOURCES = "PREFERENCES_SELECTEDSOURCES";
final String PREFS_SELECTED_CATEGORIES = "PREFERENCES_SELECTEDCATEGORIES";
final String PREFS_SELECTED_SOURCES_LANGUAGE =
    "PREFERENCES_SELECTEDSOURCESLANGUAGE";

final String PREFS_OUR_PRODUCTS = "PREFERENCE_OUR_PRODUCTS";

final String PREFS_USER_NEWS_ANALYTICS = "USER_NEWS_VIEW_ANALYTICS";

final String PREFS_APPENDING_URL = "PREFERENCE_APPENDING_URL";

final String PREFS_IS_FIRST_TIME = "IS_FIRST_TIME";
final String PREFS_IS_FIRST_TIME_RASHIFAL_PAGE = "IS_FIRST_TIME_RASHIFAL_PAGE";
final String PREFS_ENABLE_FCM_NEWS = "FCM_NEWS_ENABLE";
final String PREFS_ENABLE_FCM_RASHIFAL_NOTIFICATION =
    "FCM_RASHIFAL_NOTIFICATION_ENABLE";

final String PREFS_LAST_ONLINE_TIME = "PREFS_LAST_ONLINE_TIME";
final String PREFS_JWT_TOKEN = "PREFS_JWT_TOKEN";
final String PREFS_FROM_DATE = "PREFS_FROM_DATE";
final String PREFS_TO_DATE = "PREFS_TO_DATE";

final String PREFS_NEWS_WIDGET_REFRESH_TIME = "PREFS_NEWS_WIDGET_REFRESH_TIME";

final String PREFS_REWARDED_AD_AWARDED_TIME = "PREFS_REWARDED_AD_AWARDED_TIME";

final String PREFS_NEWS_LOADER_STATUS = "PREFS_NEWS_LOADER_STATUS";

final String PREFS_LAST_NEWS_FETCHED_TIME = "PREFS_LAST_NEWS_FETCHED_TIME";
final String PREFS_TOP_READ_LAST_NEWS_FETCHED_TIME =
    "PREFS_TOP_READ_LAST_NEWS_FETCHED_TIME";

final String PREFS_CALENDAR_TAB_BEHAVIOUR = "PREFS_CALENDAR_TAB_BEHAVIOUR";

final String PREFS_SERVICES_LAST_FETCH_TIME = "PREFS_SERVICES_LAST_FETCH_TIME";
final String PREFS_SERVICES = "PREFS_SERVICES";

final String PREFS_DEV_MODE_CHECK = "PREFS_DEV_MODE_CHECK";
final String PREFS_ADS_DISABLE = "PREFS_ADS_DISABLE";
final String PREFS_REMOTE_CONFIG_ADS = "PREFS_REMOTE_CONFIG_ADS";

final String PREFS_WEATHER_LOCATION = "PREFS_WEATHER_LOCATION";
final String PREFS_WEATHER_FIRST_OPEN = "PREFS_WEATHER_FIRST_OPEN";
final String PREFS_WEATHER_LAST_FETCH = "PREFS_WEATHER_LAST_FETCH";
final String PREFS_WEATHER_DATA = "PREFS_WEATHER_DATA";

/// Preference to enable/disable weather from the settings page
final String PREFS_WEATHER_ENABLE_SETTINGS = "PREFS_WEATHER_ENABLE_SETTINGS";

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

  static getDouble(String key, {double def: 1}) async {
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
