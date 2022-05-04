// ignore_for_file: non_constant_identifier_names, prefer_const_declarations, constant_identifier_names

/*
final String REMOTE_CONFIG_MENU_DEFAULT =
    "{\"home\":[\"home\",\"rashifal\",\"calendar\",\"news\",\"more\"],\"more\":[\"events\",\"conversion\",\"forex\",\"subhasait\",\"blog\",\"governmentholiday\",\"divider\",\"addon\",\"settings\",\"checkupdate\",\"aboutus\",\"other_apps\",\"feedback\",\"connectwithus\",\"version_history\",\"privacy\",\"faq\"]}";
*/

final String INIT_CONFIG_MENU_MAP = "INIT_CONFIG_MENU_MAP";
final String INIT_CONFIG_MENU_MAP_IOS = "INIT_CONFIG_MENU_MAP_IOS";
final String REMOTE_CONFIG_MENU_DEFAULT =
    "{\"home\":[\"home\",\"rashifal\",\"calendar\",\"news\",\"more\"],\"more\":[\"my_calendars\",\"kundali\",\"shows\",\"radio\",\"divider\",\"weather\",\"bullion\",\"conversion\",\"unit_conversion\",\"forex\",\"subhasait\",\"blog\",\"governmentholiday\",\"divider\",\"settings\",\"checkupdate\",\"aboutus\",\"feedback\",\"connectwithus\",\"subscriptions\",\"privacy\",\"termsofservice\",\"faq\"]}";

final String INIT_CONFIG_MENU_MAP_DEV = "INIT_CONFIG_MENU_MAP_DEV";
final String REMOTE_CONFIG_MENU_DEV_DEFAULT =
    "{\"home\":[\"home\",\"rashifal\",\"calendar\",\"news\",\"more\"],\"more\":[\"subscriptions\",\"paramarsha\",\"divider\",\"my_calendars\",\"conversion\",\"shows\",\"forex\",\"subhasait\",\"blog\",\"governmentholiday\",\"live_tv\",\"bullion\",\"kundali\",\"unit_conversion\",\"radio\",\"weather\",\"marketplace\",\"divider\",\"settings\",\"checkupdate\",\"aboutus\",\"feedback\",\"connectwithus\",\"privacy\",\"termsofservice\",\"faq\"]}";

//AMESSAGE
final String INIT_CHECK_AMESSAGE_INTERVAL = "INIT_CHECK_AMESSAGE_INTERVAL";
final String INIT_CALENDAR_SYNC_INTERVAL = "INIT_CALENDAR_SYNC_INTERVAL";
final String INIT_INTERSTITIAL_SHOW_DEFAULT = "INIT_INTERSTITIAL_SHOW_DEFAULT";
final String INIT_INTERSTITIAL_NEWS_COUNT = "INIT_INTERSTITIAL_NEWS_COUNT";
final String INIT_INTERSTITIAL_SHOW_COUNT_v2 =
    "INIT_INTERSTITIAL_SHOW_COUNT_V2";
final String INIT_INTERSTITIAL_SHOW_TIMEOUT = "INIT_INTERSTITIAL_SHOW_TIMEOUT";
final double INITE_CHECK_AMESSAGE_INTERVAL_DEFAULT = 86400;
final double INIT_CALENDAR_SYNC_INTERVAL_DEFAULT = 3600;
final String INIT_CHECK_BLOG_INTERVAL = "INIT_CHECK_BLOG_INTERVAL";
final double INITE_CHECK_BLOG_INTERVAL_DEFAULT = 86400;

//CHECK UPDATE
final String INIT_CHECK_UPDATE_INTERVAL = "INIT_CHECK_UPDATE";
final double INIT_CHECK_UPDATE_INTERVAL_DEFAULT = 86400;

//RASHIFAL
final String INIT_RASHIFAL_TTS = "INIT_RASHIFAL_TTS";
final bool INIT_RASHIFAL_TTS_DEFAULT = true;

//TODAY IMPE
final String TODAY_DISPLAY_LIMIT_IMPE = "TODAY_DISPLAY_LIMIT_IMPE";
final int TODAY_DISPLAY_LIMIT_IMPE_DEFAULT = 6;

//ADS
final int INIT_INTERSTITIAL_SHOW_DEFAULT_VALUE = 1;
final int INIT_INTERSTITIAL_NEWS_COUNT_VALUE = 5;
final int INIT_INTERSTITIAL_SHOW_COUNT_VALUE = 4;
final int INIT_INTERSTITIAL_SHOW_TIMEOUT_value = 120;

final String HOME_LIST_OF_EVENTS = "HOME_LIST_OF_EVENTS";
final int HOME_LIST_OF_EVENTS_DEFAULT_VALUE = 4;

//DATEMAPPINGS
final String REMOTE_CONFIG_DATE_MAPPING = "INIT_DATE_MAPPING";
final String REMOTE_CONFIG_DATE_MAPPING_DEFAULT =
    "1900|18430412|333433122122334333212122343432212122343432221123333433212122334333212122343432221122343432221213333433212122334333212122343432221122343432221213334333212122334342212122343432221123243432221213334333212122334432212122343432221123243432221213334333212122334432212122343432221123333433122113334333212122334432212122343432221123333433122122334333212122343432212122343432221123333433212122334333212122343432221122343432221213333433212122334333212122343432221122343432221213333433212122334333212122343432221123243432221213334333212122334342212122343432221123243432221213334333212122334432212122343432221123333433122113334333212122334432212122343432221123333433122122334333212122334432212122343432221123333433122122334333212122343432212122343432221213333433212122334333212122343432221122343432221213333433212122334333212122343432221122343432221213334333212122334342212122343432221123243432221213334333212122334432212122343432221123243433122113334333212122334432212122343432221123333433122113334333212122334432212122343432221123333433122122334333212122343432212122343432221123333433212122334333212122343432221122343432221213333433212122334333212122343432221122343432221213334333212122334342212122343432221123243432221213334333212122334432212122343432221123243432221213334333212122334432212122343432221123333433122113334333212122334432212122343432221123333433122122334333212122334432212122343432221123333433122122334333212122343432212122343432221213333433212122334333212122343432221122343432221213333433212122334333212122343432221123243432221213334333212122334342212122343432221123243432221213334333212122334432212122343432221123243433122113334333212122334432212122343432221123333433122122334333212122334432212122343432221123333433122122334333212122343432212122343432221123333433212122334333212122343432221122343432221213333433212122334333212122343432221122343432221213334333212122334342212122343432221123243432221213334333212122334432212122343432221123243433121213334333212122334432212122343432221123333433122113334333212122334432212122343432221123333433122122334333212122343432212122343432221123333433212122334333212122343432221122343432221213333433212122334333212122343432221122343432221213333433212122334333212122343432221123243432221213334333212122334432212122343432221123243432221213334333212122334432212122343432221123333433122113334333212122334432212122343432221123333433122122334333212122334432212122343432221123333433122122334333212122343432212122343432221213333433212122334333212122343432221122343432221213333433212122334333212122343432221122343432221213334333212122334342212122343432221123243432221213334333212122334432212122343432221123243433122113334333212122334432212122343432221123333433122122334333212122334432212122343432221123333433122122334333212122343432212122343432221123333433212122334333212122343432221122343432221213333433212122334333212122343432221122343432221213334333212122334342212122343432221123243432221213334333212122334432212122343432221123243432221213334333212122334432212122343432221123333433122113334333212122334432212122343432221123333433122122334333212122343432212122343432221123333433212122334333212122343432221122343432221213333433212122334333212122343432221122343432221213333433212122334333212122343432221123243432221213334333212122334342212122343432221123243432221213334333212122334432212122343432221123243433122113334333212122334432212122343432221123333433122122334333212122334432212122343432221123333433122122334333212122343432212122343432221123333433212122334333212122343432221122343432221213333433212122334333212122343432221122343432221213334333212122334342212122343432221122";

//RATE
final String RATE_SESSION_COUNT = "RATE_SESSION_COUNT";
final int INT_RATE_SESSION_COUNT = 5;
final String RATE_VIEW_TAB_COUNT = "RATE_VIEW_TAB_COUNT";
final int INT_RATE_VIEW_TAB_COUNT = 3;

//Calendar
final String CONFIG_CALENDAR_LIST_AD_INTERVAL =
    "CONFIG_CALENDARLIST_AD_INTERVAL";
final int CONFIG_CALENDAR_LIST_AD_INTERVAL_DEFAULT = 8;

//NATIVEADS RemoteConfig
final String CONFIG_NATIVE_ADS = "CONFIG_DISABLE_NATIVE_ADS";
final int CONFIG_NATIVE_ADS_DEFAULT = 0;

//Search Calendars
final String SEARCH_CALENDARS = "SEARCH_CALENDARS";
final bool SEARCH_CALENDARS_DEFAULT = false;

//-------------------------------------------------------
//------------------------TIMES OF NEPAL------------------
//REMOTE CONFIG DEFAULTS
final int INIT_TON_NEWS_URL_OPTIONS_VALUE = 1;

final bool AD_NEWS_BROWSER_VALUE = false;
final int ANDROID_BANNER_RECTANGULAR_ADS_SHOWING_OPTION_VALUE = 0;
final int ANDROID_INTERSTITIAL_ADS_SHOWING_OPTION_VALUE = 1;

final int IOS_BANNER_ADS_SHOWING_OPTION_VALUE = 0;
final int IOS_BANNER_RECTANGULAR_ADS_SHOWING_OPTION_VALUE = 0;
final int IOS_INTERSTITIAL_ADS_SHOWING_OPTION_VALUE = 0;

final int INTERSTITIAL_ADS_DISPLAY_ADS_COUNT = 3;
final int NEWS_NOTIFICATION_REMINDER_INTERVAL_VALUE = 15; //days
final int RASHIFAL_NOTIFICATION_REMINDER_INTERVAL_VALUE = 15; //days

final String NEWS_NOTIFICATION_REMINDER_INTERVAL =
    "CONFIG_NEWS_NOTIFICATION_REMINDER_INTERVAL";
final String RASHIFAL_NOTIFICATION_REMINDER_INTERVAL =
    "CONFIG_RASHIFAL_NOTIFICATION_REMINDER_INTERVAL";

final int REMOTE_CONFIG_FETCH_DURATION = 12;

final String FEED_DISTRIBUTION_RULE = "CONFIG_FEED_DISTRIBUTION";
final String FEED_CHUNKS = "CONFIG_FEEDS_CHUNKS";
final String BREIFING_CHUNKS = "CONFIG_BREIFING_CHUNKS";
final String BREFING_TYPE_PAGE_COUNT = "CONFIG_BRIEFING_PAGE_COUNT";
final String BRIEFING_TYPE_LIST_COUNT = "CONFIG_BRIEFING_LIST_COUNT";
final String BRIEFING_TYPE_HOME_NEWS_LIST_COUNT =
    "CONFIG_BRIEFING_HOME_NEWS_LIST_COUNT";
final String RECENT_NEWS_LIST_COUNT = "CONFIG_RECENT_NEWS_LIST_COUNT";
final String FEED_DESCRIPTION_VISIBILITY = "CONFIG_FEED_DESCRIPTION_VISIBILITY";
final String FEED_ANIMATED_DESCRIPTION_DURATION =
    "CONFIG_FEED_ANIMATED_DURATION";
final String FEED_OPEN_MODE_ANDROID = "CONFIG_FEED_OPEN_MODE_ANDROID";
final String FEED_OPEN_MODE_IOS = "CONFIG_FEED_OPEN_MODE_IOS";

final String FORCE_SOURCESELECTION_ANDROID =
    "config_feed_force_sourceselection_android";
final String FORCE_SOURCESELECTION_IOS =
    "config_feed_force_sourceselection_ios";
final String CONFIG_PRIORITY_WEIGHT_QTY =
    "config_feed_prority_weight_qty"; //not used in Np yet

final String CONFIG_TTS_ENABLE = "CONFIG_TTS_ENABLE";
final String INTERSTITIAL_ADS_DISPLAY = "CONFIG_INTERSTITIAL_ADS_DISPLAY";
final String INIT_TON_NEWS_URL_OPTIONS = "CONFIG_NEWS_URL_OPTION";
final String ADS_RESETTING_TIME = "CONFIG_ADS_RESETTING_TIME";
final String INTERSTITIAL_ADS_SHOWING__SERIES_CONDITION =
    "CONFIG_INTERSTITIAL_ADS_SHOWING_SERIES_CONDITION";

final String AD_NEWS_BROWSER = "AD_NEWS_BROWSER";
final String ANDROID_BANNER_RECTANGULAR_ADS_SHOWING_OPTION =
    "CONFIG_BANNER_RECTANGULAR_ADS_SHOWING_OPTION_ANDROID";
final String ANDROID_INTERSTITIAL_ADS_SHOWING_OPTION =
    "CONFIG_INTERSTITIAL_ADS_SHOWING_OPTION_ANDROID";

final String IOS_BANNER_ADS_SHOWING_OPTION =
    "CONFIG_BANNER_SMART_ADS_SHOWING_OPTION_IOS";
final String IOS_BANNER_RECTANGULAR_ADS_SHOWING_OPTION =
    "CONFIG_BANNER_RECTANGULAR_ADS_SHOWING_OPTION_IOS";
final String IOS_INTERSTITIAL_ADS_SHOWING_OPTION =
    "CONFIG_INTERSTITIAL_ADS_SHOWING_OPTION_IOS";

final String NEWS_WIDGET_REFRESH_TIME = "CONFIG_NEWS_WIDGET_REFRESH_TIME";
final int NEWS_WIDGET_REFRESH_TIME_DEFAULT = 15;

final int FEED_BREIFING_CHUNK_DEFAULT = 2;
final int FEED_CHUNKS_DEFAULT = 5;
final int FEED_BRIEFING_LIST_COUNT_DEFAULT = 6;
final int FEED_BRIEFING_HOME_NEWS_LIST_COUNT_DEFAULT = 5;
final int FEED_BRIEFING_PAGED_COUNT_DEFAULT = 10;
final int RECENT_NEWS_LIST_COUNT_DEFAULT = 5;
final int FEED_DESCRIPTION_VISIBILITY_DEFAULT = 1;
final int FEED_DESCRIPTION_ANIMATION_DURATION_DEFAULT = 1600;
final bool FORCE_SOURCESELECTION_ANDROID_DEF = true;
final bool FORCE_SOURCESELECTION_IOS_DEF = true;
final int CONFIG_PRIORITY_WEIGHT_QTY_DEFAULT = 2;
final int CONFIG_FORYOU_HEADER_DEFAULT = 0;
final int CONFIG_SESSION_INTERVAL_DEFAULT = 10;

final int INTERSTITIAL_ADS_SHOWING__SERIES_CONDITION_DEFAULT_VALUE = 1;
final int ADS_RESETTING_TIME_VALUE = 600;

//News Search Layout
final String BIG_LAYOUT_NEWS_SEARCH_VALUE = "BIG_LAYOUT_NEWS_SEARCH_VALUE";
final int BIG_LAYOUT_NEWS_SEARCH_DEFAULT_VALUE = 2;
final String SMALL_LAYOUT_NEWS_SEARCH_VALUE = "SMALL_LAYOUT_NEWS_SEARCH_VALUE";
final int SMALL_LAYOUT_NEWS_SEARCH_DEFAULT_VALUE = 3;

//BRIEFING TYPES {LIST,PAGED}
final String FEED_DISTRIBUTION_RULE_DEFAULTS =
    "[{\"override\":{\"weight\":50,\"scores\":{\"tops\":20,\"pltc\":20,\"sprt\":15,\"wrld\":15,\"busi\":5,\"entm\":5,\"hlth\":5,\"blog\":5,\"advs\":5,\"oths\":5}}},{\"base\":{\"weight\":25,\"scores\":{\"tops\":20,\"pltc\":20,\"sprt\":15,\"wrld\":15,\"busi\":5,\"entm\":5,\"hlth\":5,\"blog\":5,\"advs\":5,\"oths\":5}}},{\"user\":{\"weight\":25,\"scores\":{}}}]";

final bool CONFIG_TTS_ENABLE_DEFAULT = true;

//FOR BOTH VALUES 1= FORCE BROWSER 0= INAPP BROWSER
final int FEED_OPEN_MODE_ANDROID_DEF = 0;
final int FEED_OPEN_MODE_IOS_DEF = 0;

//FCM Token send interval
final String FCM_TOKEN_SEND_INTERVAL = "FCM_TOKEN_SEND_INTERVAL";
//default value set to 7 days in seconds to send fcm token to server for this interval
final int FCM_TOKEN_SEND_INTERVAL_DEFAULT = 604800;

//NEWS OPENING METHOD
const OPEN_URL_ON_WIFI = 0;
const ALWAYS_OPEN_URL = 1;
const SUMMARY_FIRST = 2;

//Interstitial ads Series CssConditionRule
const CONTINUOUS_SERIES = 0;
const EXPONENTIAL_SERIES = 1;

// Config to remove tooltip in app
final String TOOL_TIP_REMOVE_SESSION_COUNT = "TOOL_TIP_REMOVE_SESSION_COUNT";
final int TOOL_TIP_REMOVE_SESSION_COUNT_DEFAULT = 20;

// Configs for NATIVE ads
final String AD_HOME_AMESSAGE = "AD_HOME_AMESSAGE";
final bool AD_HOME_AMESSAGE_DEFAULT = false;
final String AD_HOME_EVENT = "AD_HOME_EVENT";
final bool AD_HOME_EVENT_DEFAULT = false;
final String AD_HOME_BLOG = "AD_HOME_BLOG";
final bool AD_HOME_BLOG_DEFAULT = false;
final String AD_HOME_NEWS = "AD_HOME_NEWS";
final bool AD_HOME_NEWS_DEFAULT = false;

final String AD_RASHIFAL = "AD_RASHIFAL";
final bool AD_RASHIFAL_DEFAULT = false;
final String AD_NEWS = "AD_NEWS";
final bool AD_NEWS_DEFAULT = false;
final String AD_NEWS_SUMMARY = "AD_NEWS_SUMMARY";
final bool AD_NEWS_SUMMARY_DEFAULT = false;
final String AD_CALENDAR = "AD_CALENDAR";
final bool AD_CALENDAR_DEFAULT = false;
final String AD_DATE_CONVERSION = "AD_DATE_CONVERSION";
final bool AD_DATE_CONVERSION_DEFAULT = false;
final String AD_FOREX = "AD_FOREX";
final bool AD_FOREX_DEFAULT = false;
final String AD_DAY_DETAIL = "AD_DAY_DETAIL";
final bool AD_DAY_DETAIL_DEFAULT = false;
final String AD_SUVASAIT = "AD_SUVASAIT";
final bool AD_SUVASAIT_DEFAULT = false;
final String AD_GH = "AD_GH";
final bool AD_GH_DEFAULT = false;
final String AD_BLOG = "AD_BLOG";
final bool AD_BLOG_DEFAULT = false;
final String AD_BLOG_DETAIL = "AD_BLOG_DETAIL";
final bool AD_BLOG_DETAIL_DEFAULT = false;

/// [AD_CALENDAR_TAB_INTERVAL] is the interval to show native ads in calendar
/// tab page
final String AD_CALENDAR_TAB_INTERVAL = "AD_CALENDAR_TAB_INTERVAL";
final int AD_CALENDAR_TAB_INTERVAL_DETAULT = 7;

/// [REWARD_AD_REWARD_INTERVAL] is the interval after user views rewarded ads
/// where user is not shown any ads. Its value is in minutes
final String REWARD_AD_REWARD_INTERVAL = "REWARD_AD_REWARD_INTERVAL";
final int REWARD_AD_REWARD_INTERVAL_DETAULT = 360;

// Banner ads remote configs
final String BANNER_AD_UNIT_CONVERSION = "BANNER_AD_UNIT_CONVERSION";
final bool BANNER_AD_UNIT_CONVERSION_DEFAULT = true;
final String BANNER_AD_CONVERSION = "BANNER_AD_CONVERSION";
final bool BANNER_AD_CONVERSION_DEFAULT = false;
final String BANNER_AD_FOREX = "BANNER_AD_FOREX";
final bool BANNER_AD_FOREX_DEFAULT = false;
final String BANNER_AD_SUVASAIT = "BANNER_AD_SUVASAIT";
final bool BANNER_AD_SUVASAIT_DEFAULT = false;
final String BANNER_AD_BLOG_DETAIL = "BANNER_AD_BLOG_DETAIL";
final bool BANNER_AD_BLOG_DETAIL_DEFAULT = false;
final String BANNER_AD_GH = "BANNER_AD_GH";
final bool BANNER_AD_GH_DEFAULT = false;
final String BANNER_AD_RASHIFAL = "BANNER_AD_RASHIFAL";
final bool BANNER_AD_RASHIFAL_DEFAULT = false;
final String BANNER_AD_BLOG = "BANNER_AD_BLOG";
final bool BANNER_AD_BLOG_DEFAULT = false;
final String BANNER_AD_MY_CALENDAR = "BANNER_AD_MY_CALENDAR";
final bool BANNER_AD_MY_CALENDAR_DEFAULT = false;
final String BANNER_AD_NEWS = "BANNER_AD_NEWS";
final bool BANNER_AD_NEWS_DEFAULT = false;
final String BANNER_AD_NEWS_SUMMARY = "BANNER_AD_NEWS_SUMMARY";
final bool BANNER_AD_NEWS_SUMMARY_DEFAULT = false;
final String BANNER_AD_CALENDAR = "BANNER_AD_CALENDAR";
final bool BANNER_AD_CALENDAR_DEFAULT = false;
final String BANNER_AD_DAY_DETAIL = "BANNER_AD_DAY_DETAIL";
final bool BANNER_AD_DAY_DETAIL_DEFAULT = false;
final String BANNER_AD_LIVE_TV = "BANNER_AD_LIVE_TV";
final bool BANNER_AD_LIVE_TV_DEFAULT = false;
final String BANNER_AD_BULLION = "BANNER_AD_BULLION";
final bool BANNER_AD_BULLION_DEFAULT = true;
final String BANNER_AD_BULLION_BOTTOM = "BANNER_AD_BULLION_BOTTOM";
final bool BANNER_AD_BULLION_BOTTOM_DEFAULT = false;
final String BANNER_AD_KUNDALI_LIST = "BANNER_AD_KUNDALI_LIST";
final bool BANNER_AD_KUNDALI_LIST_DEFAULT = true;
final String BANNER_AD_KUNDALI_PAGE = "BANNER_AD_KUNDALI_PAGE";
final bool BANNER_AD_KUNDALI_PAGE_DEFAULT = true;
final String BANNER_AD_CREATE_KUNDALI = "BANNER_AD_CREATE_KUNDALI";
final bool BANNER_AD_CREATE_KUNDALI_DEFAULT = true;
final String BANNER_AD_SHOWS_PAGE = "BANNER_AD_SHOWS_PAGE";
final bool BANNER_AD_SHOWS_PAGE_DEFAULT = true;
final String BANNER_AD_HOME = "BANNER_AD_HOME";
final bool BANNER_AD_HOME_DEFAULT = false;
final String BANNER_AD_WEATHER = "BANNER_AD_WEATHER";
final bool BANNER_AD_WEATHER_DEFAULT = true;

final String INTERSTITIAL_AD_LIVE_TV = "INTERSTITIAL_AD_LIVE_TV";
final bool INTERSTITIAL_AD_LIVE_TV_DEFAULT = true;
final String INTERSTITIAL_AD_KUNDALI = "INTERSTITIAL_AD_KUNDALI";
final bool INTERSTITIAL_AD_KUNDALI_DEFAULT = true;
final String INTERSTITIAL_AD_SHOWS_PAGE = "INTERSTITIAL_AD_SHOWS_PAGE";
final bool INTERSTITIAL_AD_SHOWS_PAGE_DEFAULT = true;
final String INTERSTITIAL_AD_WEATHER = "INTERSTITIAL_AD_WEATHER";
final bool INTERSTITIAL_AD_WEATHER_DEFAULT = false;

final String INTERSTITIAL_AD_LIVE_TV_SHOW_COUNT =
    "INTERSTITIAL_AD_LIVE_TV_SHOW_COUNT";
final int INTERSTITIAL_AD_LIVE_TV_SHOW_COUNT_DEFAUT = 5;

//NewsRefreshUI
final String CONFIG_NEWS_REFETCH_TIME = "CONFIG_NEWS_REFETCH_TIME";
final int CONFIG_NEWS_REFETCH_TIME_DEFAULT = 15;

final String INIT_NEWS_ADS_SEPARATION = "INIT_NEWS_ADS_SEPARATION";
final int INIT_NEWS_ADS_SEPARATION_DEFAULT = 5;

final String CONFIG_SHOW_SUBSCRIPTION = "CONFIG_SHOW_SUBSCRIPTION";
final bool CONFIG_SHOW_SUBSCRIPTION_DEFAULT = false;

final String CONFIG_SHOW_PARAMARSHA = "CONFIG_SHOW_PARAMARSHA";
final bool CONFIG_SHOW_PARAMARSHA_DEFAULT = false;

final String INIT_BROWSER_COOKIE_ENABLE_ANDROID =
    "INIT_BROWSER_COOKIE_ENABLE_ANDROID";
final bool INIT_BROWSER_COOKIE_ENABLE_ANDROID_DEFAULT = true;

final String INIT_BROWSER_COOKIE_ENABLE_IOS = "INIT_BROWSER_COOKIE_ENABLE_IOS";
final bool INIT_BROWSER_COOKIE_ENABLE_IOS_DEFAULT = true;

final String SERVICES_ENABLE = "SERVICES_ENABLE";
final bool SERVICES_ENABLE_DEFAULT_VALUE = false;

/// Fetch weather data if the difference between last fetch time and current
/// time is greater than this. NOTE: value is in minutes.
final String WEATHER_FETCH_INTERVAL = "WEATHER_FETCH_INTERVAL";
final int WEATHER_FETCH_INTERVAL_DEFAULT = 60;

/// Show user the weather data is old if the last fetch data exceeds this
/// interval. NOTE: value is in days.
final String WEATHER_INVALIDATE_INTERVAL = "WEATHER_INVALIDATE_INTERVAL";
final int WEATHER_INVALIDATE_INTERVAL_DEFAULT = 1;

//Timer to update News Impression for analytics UA
final String CONFIG_TIMER_NEWS_IMPRESSION_SEND =
    "CONFIG_TIMER_NEWS_IMPRESSION_SEND";
final int CONFIG_TIMER_NEWS_IMPRESSION_SEND_DEFAULT = 3;

//Config for GA-ID for our server
final String CONFIG_NEWS_GA_ID_FOR_SERVER = "CONFIG_NEWS_GA_ID_FOR_SERVER";
final String CONFIG_NEWS_GA_ID_FOR_SERVER_DEFAULT = "UA-7567254-6";

//Config to Send UA-DATA (PAGE and EVENT
final String CONFIG_NEWS_UA_DATA_FOR_PARTNER =
    "CONFIG_NEWS_UA_DATA_FOR_PARTNER";
final String CONFIG_NEWS_UA_DATA_FOR_PARTNER_DEFAULT =
    "{\"page\": \"Y\",\"event\": \"Y\"}";

final String REMOTE_CONFIG_ADS_PORTAL_JSON = "REMOTE_CONFIG_ADS_PORTAL_JSON";
final String REMOTE_CONFIG_ADS_PORTAL_JSON_DEFAULT =
    "{\"ad_portal_banner_blog\":0,\"ad_portal_banner_blog_detail\":1,\"ad_portal_banner_calendar\":1,\"ad_portal_banner_conversion\":1,\"ad_portal_banner_day_detail\":1,\"ad_portal_banner_my_calendar\":0,\"ad_portal_banner_forex\":2,\"ad_portal_banner_gh\":1,\"ad_portal_banner_news\":0,\"ad_portal_banner_news_summary\":0,\"ad_portal_banner_rashifal\":0,\"ad_portal_banner_suvasait\":0,\"ad_portal_banner_weather\":2,\"ad_portal_banner_home\":1,\"ad_portal_native_blog\":0,\"ad_portal_native_blog_detail\":0,\"ad_portal_native_calendar\":0,\"ad_portal_native_conversion\":0,\"ad_portal_native_day_details\":0,\"ad_portal_native_forex\":0,\"ad_portal_native_gh\":0,\"ad_portal_native_home_amessage\":0,\"ad_portal_native_home_blog\":0,\"ad_portal_native_home_news\":0,\"ad_portal_native_home_event\":0,\"ad_portal_native_news_list_search\":0,\"ad_portal_native_news_read_searched_news_view\":0,\"ad_portal_native_news_list_search_key_details\":0,\"ad_portal_native_news_list_category_pages\":0,\"ad_portal_native_news_list_for_you_tab\":1,\"ad_portal_native_news_list_top_read_tab\":2,\"ad_portal_native_rashifal\":2,\"ad_portal_native_sait\":0,\"ad_portal_native_news_read_news_view_pager_item\":0,\"ad_portal_interstitial_news_browser\":0,\"ad_portal_interstitial_weather\":0,\"ad_portal_interstitial\":2,\"ad_portal_banner_create_kundali\":2,\"ad_portal_banner_kundali_list\":1,\"ad_portal_interstitial_kundali\":2,\"ad_portal_banner_bullion\":1,\"ad_portal_banner_unit_conversion\":2,\"ad_portal_banner_shows\":0}";