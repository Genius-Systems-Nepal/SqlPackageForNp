// ignore_for_file: constant_identifier_names, non_constant_identifier_names, prefer_const_declarations

const int DEF_TIMEOUT = 5000;
const int DEF_RECEIVETIMEOUT = 5000;

const String APP_THEME_LIGHT = "app_theme_light";
const String APP_THEME_DARK = "app_theme_dark";

const String APP_PACKAGE_NAME_ANDROID = "np.com.nepalipatro.debug";

enum HomeContentType { header, footer }
enum CalendarCreateType { create, edit }
enum EventEditType { SingleEvent, CurrentAndFuture, AllEvents }
enum ImageType { large, thumb }
enum NewsType {
  brief,
  pinned,
  recent,
  related,
}
//DATABASE TABLES
// final String DB_TABLE_DELETE_EVENTS = "DeleteEventsDB";
// final String DB_TABLE_DELETE_REMINDERS = "DeleteRemindersDB";
// final String DB_TABLE_BLOG = "Blogs";
// final String DB_TABLE_FOREX = "Forex";
// final String DB_TABLE_FOREX_DETAIL = "ForexDetail";
// final String DB_TABLE_RASHIFAL = "Rashifaldb";
// final String DB_TABLE_AMESSAGE = "AmessageDb";
// final String DB_CALENDAR = "CalendarDb";
// final String DB_CALENDAR_USER = "CalendarUserDb";
// final String DB_TABLE_EVENTS = "EventsDb";
// final String DB_TABLE_HOLIDAYS = "HolidaysDb";
// final String DB_TABLE_EVENTS_EXCEPTION = "EventsExcDb";
// final String DB_TABLE_CACHE = "cache";
// final String DB_TABLE_PANCHANGA = "PanchangaDb";
// final String DB_TABLE_REMINDERS = "RemindersDb";
final String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";

final String NOTIFICATION_TIME_ZONE = "listPrefNotificationTimeZone";
final String NOTIFICATION_TIME_ZONE_TITLE = "Notification Timezone";
//TimesOfNepal DATABASE TABLES
// final String DB_TABLE_SOURCES = "Sources";
// final String DB_TABLE_CATEGORIES = "Categories";
// final String DB_TABLE_FEEDS = "Feeds";
// final String DB_TABLE_RELATED_FEEDS = "RelatedFeeds";
// final String DB_TABLE_BOOKMARKS = "BookmarkedFeeds";
// final String DB_TABLE_BRIEF_FEEDS = "BriefFeeds";
// final String DB_TABLE_INFINITE_FEEDS = "InfiniteFeeds";

final String TIME_SEPARATOR_SYMBOL = "·";

final String SHARE_HASHTAG_CONTENT = "#NepaliPatro";

final bool DEBUG = false;

final String somethingWentWrong =
    "Something went wrong.Please try again later.";
final String networkProblemMessage =
    "There seems to be some problem while completing your task.\n Please try the following steps \n1. Check your Internet Connection. \n2. Try Again later.";

final String METHODCHANNEL_NEWS_TYPE_FEED = "FEED";
final String METHOD_NEWS_TYPE_FEED_EXTBROWSER = "FEED_EXT_BROWSER";
final String METHOD_CHANNEL_FCM_NEWS = "FCM_NEWS";
final String METHODCHANNEL_NEWS_TYPE_SEARCH = "SEARCH";
final String METHODCHANNEL_NEWS_TYPE_SEARCH_EXTBROWSER = "SEARCH_EXT_BROWSER";

enum ListType { Vertical, Horizontal }

enum loaderStatus {
  Loading,
  Complete,
  Error,
  Idle,
  BackgroundFetchError,
  NoData,
  FetchingNewData
}

enum NewsViewType {
  CustomizedLists,
  Topread,
  Default,
  Saved,
  Related,
  Search,
  Briefing,
  Pinned,
  RecentNews
}

//NewsReadMode
final String defaultNewsReadMode = "default";
final String summaryNewsReadMode = "summary";
final String fullNewsReadMode = "fullnews";

final String ANALYTICS_LABEL_NEWS = "News";
final String LABEL_SEARCH = "Search";
final String LABEL_CATEGORY = "Category";
final String LABEL_NOTIFICATION = "News Notification";
final String LABEL_SOURCE = "Source";
final String ANALYTICS_LABEL_CATEGORY = "Category Change";
final String ANALYTICS_LABEL_SOURCE = "Source Change";
final String LABEL_SEARCH_TAGS = "Search Tags";
final String LABEL_FCM_TOPIC = "FCM_TIMES_OF_NEPAL";

//TEST
final String TEST_ADMOB_APP_ID = "ca-app-pub-3940256099942544~3347511713";
final String TEST_BANNER_ADS_ID = "ca-app-pub-3940256099942544/6300978111";
final String TEST_INTERSTITIAL_ADS_ID =
    "ca-app-pub-3940256099942544/1033173712";

//ANALYTICS CONSTANTS
final String ANALYTICS_SCREEN_CATEGORYSELECTION = "Category Selection";
final String ANALYTICS_SCREEN_DASHBOARD = "Dashboard";
final String ANALYTICS_SCREEN_FORYOU = "For You";
final String ANALYTICS_SCREEN_HEADLINES = "Headlines";
final String ANALYTICS_SCREEN_NEWSSUMMARY = "News Summary";
final String ANALYTICS_SCREEN_BOOKMARKED = "Bookmarked News";
final String ANALYTICS_SCREEN_SEARCH = "NEWS SEARCH";
final String ANALYTICS_SCREEN_SETTINGS = "SETTINGS";
final String ANALYTICS_SCREEN_SOURCESELECTION = "Source Selection";
final String ANALYTICS_SCREEN_SPLASHSCREEN = "Splash Screen";

final String ANALYTICS_ACTION_CLICK = "Click";
final String ANALYTICS_ACTION_VIEW = "View";
final String ANALYTICS_ACTION_TTSPLAY = "Tts_Play";
final String ANALYTICS_ACTION_SHARE = "Share";
final String ANALYTICS_ACTION_CHANGE = "Change";
final String ANALYTICS_ACTION_NEWSBOOKMARKED = "Bookmarked";
final String ANALYTICS_ACTION_BOOKMARKREMOVED = "Bookmark_Removed";
final String ACTION_OPEN_FULLNEWS = "Full_News";
final String ACTION_THEME_CHANGE = "Theme_Change";
final String ACTION_LOCALE_CHANGE = "Locale_Change";
final String ACTION_NOTIFICATION_CLICK = "Notification_Click";

//PAGES
final String PAGE_TOP_READ = "topread_page";
final String PAGE_FOR_YOU = "for_you_page";
final String PAGE_BREIFING = "page_breifing";

final String FCM_NEWS_ENABLE = "FCM_NEWS_ENABLE";
final String FCM_NEWS_DISABLE = "FCM_NEWS_DISABLE";

//FCM constants
final String ALL_SUB_USERS = "ALL_SUB_USERS";
final String ALL_SUB_ANDROID = "ALL_SUB_ANDROID";
final String ALL_SUB_IOS = "ALL_SUB_IOS";

final String RASHIFAL_SUB = "RASHIFAL_SUB";
final String RASHIFAL_SUB_IOS = "RASHIFAL_SUB_IOS";
final String RASHIFAL_SUB_ANDROID = "RASHIFAL_SUB_ANDROID";

final String RASHIFAL_UNSUB = "RASHIFAL_UNSUB";
final String RASHIFAL_UNSUB_IOS = "RASHIFAL_UNSUB_IOS";
final String RASHIFAL_UNSUB_ANDROID = "RASHIFAL_UNSUB_ANDROID";

final String NEWS_SUB = "NEWS_SUB";
final String NEWS_SUB_ANDROID = "NEWS_SUB_ANDROID";
final String NEWS_SUB_IOS = "NEWS_SUB_IOS";

final String SHOWS_SUB_VON = "SHOWS_SUB_VON";

final String NEWS_UNSUB = "NEWS_UNSUB";
final String NEWS_UNSUB_ANDROID = "NEWS_UNSUB_ANDROID";
final String NEWS_UNSUB_IOS = "NEWS_UNSUB_IOS";

// load day image title // options
final String LOAD_DAY_IMAGE = "Load day images";
final String LOAD_DAY_IMAGE_OPTION_WIFI = "wifi";
final String LOAD_DAY_IMAGE_OPTION_ALWAYS = "always";
final String LOAD_DAY_IMAGE_OPTION_NEVER = "never";

final String CALENDAR_SCROLL_BEHAVIOUR = "Calendar tab scroll behaviour";
final String CALENDAR_SCROLL_DEFAULT = "default";
final String CALENDAR_SCROLL_ALL = "scroll_all";
final String CALENDAR_SCROLL_STICKY = "scroll_sticky";

const FCM_ATTRIBUTE_DATA = "data";
const FCM_ATTRIBUTE_DATA_ID = "id";
const FCM_ATTRIBUTE_DATA_TITLE = "title";
const FCM_ATTRIBUTE_DATA_MESSAGE = "message";
const FCM_ATTRIBUTE_DATA_ACTION = "action";
const FCM_ATTRIBUTE_DATA_ACTION_IN_APP = "in-app";
const FCM_ATTRIBUTE_DATA_ACTION_DIRECT = "direct";
const FCM_ATTRIBUTE_DATA_TYPE = "type";
const FCM_ATTRIBUTE_DATA_LINK = "link";
const FCM_ATTRIBUTE_DATA_LINK_NEWS = "news";
const FCM_ATTRIBUTE_DATA_LINK_CALENDAR = "calendar";
const FCM_ATTRIBUTE_DATA_LINK_DAY_DETAILS = "day_details";
const FCM_ATTRIBUTE_DATA_LINK_MY_EVENTS = "my_events";
const FCM_ATTRIBUTE_DATA_LINK_CONVERSION = "conversion";
const FCM_ATTRIBUTE_DATA_LINK_RASHIFAL = "rashifal";
const FCM_ATTRIBUTE_DATA_LINK_FOREX = "forex";
const FCM_ATTRIBUTE_DATA_LINK_LIVE_TV = "live_tv";
const FCM_ATTRIBUTE_DATA_LINK_SHOWS = "shows";
const FCM_ATTRIBUTE_DATA_LINK_BULLION = "bullion";
const FCM_ATTRIBUTE_DATA_LINK_KUNDALI = "kundali";
const FCM_ATTRIBUTE_DATA_LINK_WEATHER = "weather";
const FCM_ATTRIBUTE_DATA_LINK_RADIO = "radio";
const FCM_ATTRIBUTE_DATA_LINK_SAIT = "suvasait";
const FCM_ATTRIBUTE_DATA_LINK_LS = "loadshedding";
const FCM_ATTRIBUTE_DATA_LINK_ADDONS = "addons";
const FCM_ATTRIBUTE_DATA_LINK_BLOG = "blog";
const FCM_ATTRIBUTE_DATA_LINK_SUBSCRIPTION = "subscription";
const FCM_ATTRIBUTE_DATA_TYPE_MODULE = "module";
const FCM_ATTRIBUTE_DATA_TYPE_OPEN = "open";
const FCM_ATTRIBUTE_DATA_OPTIONS = "options";
const FCM_ATTRIBUTE_DATA_LINK_MARKETPLACE = "marketplace";

const FCM_ATTRIBUTE_DATA_TYPE_MARKET = "market";
const FCM_ATTRIBUTE_DATA_TYPE_URL = "url";
const FCM_ATTRIBUTE_DATA_TYPE_MAIL = "mail";
const FCM_ATTRIBUTE_DATA_TYPE_YOUTUBE = "youtube";
const FCM_ATTRIBUTE_DATA_TYPE_PHONE = "phone";
const FCM_ATTRIBUTE_DATA_TYPE_APP = "app";

const OPEN_MODULE_SOURCE = "OPEN_MODULE_SOURCE";
const OPEN_MODULE_SOURCE_WIDGET_1x1 = "OPEN_MODULE_SOURCE_WIDGET_1x1";
const OPEN_MODULE_SOURCE_WIDGET_1x4 = "OPEN_MODULE_SOURCE_WIDGET_1x4";
const OPEN_MODULE_SOURCE_WIDGET_2x4 = "OPEN_MODULE_SOURCE_WIDGET_2x4";
const OPEN_MODULE_SOURCE_CALENDAR_WIDGET = "OPEN_MODULE_SOURCE_WIDGET_2x4";
const OPEN_MODULE_SOURCE_NOTIFICATION = "OPEN_MODULE_SOURCE_NOTIFICATION";
const OPEN_MODULE_SOURCE_NOTIFICATION_STICKY =
    "OPEN_MODULE_SOURCE_NOTIFICATION";
const OPEN_MODULE_SOURCE_FCM = "OPEN_MODULE_SOURCE_FCM";

List<String> rashifal_array = [
  "मेष - Aries",
  "बृष - Taurus",
  "मिथुन - Gemini",
  "कर्कट - Cancer",
  "सिंह - Leo",
  "कन्या - Virgo",
  "तुला - Libra",
  "बृश्चिक - Scorpio",
  "धनु - Sagittarius",
  "मकर - Capricorn",
  "कुम्भ - Aquarius",
  "मीन - Pisces"
];

List<String> calendarType_array = ["AD", "BS", "NS"];

List<String> rashifalLists = [
  "aries",
  "taurus",
  "gemini",
  "cancer",
  "leo",
  "virgo",
  "libra",
  "scorpio",
  "sagittarius",
  "capricorn",
  "aquarius",
  "pisces"
];
List<String> rashifalLists_np = [
  "मेष",
  "वृष",
  "मिथुन",
  "कर्कट",
  "सिंह",
  "कन्या",
  "तुला",
  "वृश्चिक",
  "धनु",
  "मकर",
  "कुम्भ",
  "मीन"
];
List<String> rashifalLists_en = [
  "Mesh",
  "Vrishabha",
  "Mithun",
  "Kark",
  "Singh",
  "Kanya",
  "Tula",
  "Vrishchik",
  "Dhanu",
  "Makar",
  "Kumbh",
  "Meen"
];
List<String> rashifalSignLetter_en = [
  "चु, चे, चो, ला, लि, लु, ले, लो, अ",
  "इ, उ, ए, ओ, वा, वि, वु, वे, वो",
  "का, कि, कु, घ, ङ, छ, के, को, हा",
  "हि, हु, हे, हो, डा, डि, डु, डे, डो",
  "मा, मि, मु, मे, मो, टा, टि, टु, टे",
  "टो, पा, पि, पु, ष, ण, ठ, पे, पो",
  "रा, रि, रु, रे, रो, ता, ति, तु, ते",
  "तो, ना, नि, नु, ने, नो, या, यि, यु",
  "ये, यो, भा, भि, भु, धा, फा, ढा, भे",
  "भो,जा,जि,जु,जे,जो,ख,खि,खु,खे,खो,गा,गि",
  "गु, गे, गो, सा, सि, सु, से, सो, दा",
  "दि, दु, थ, झ, ञ, दे, दो, चा, चि"
];
List<String> rashifalSignLetters = [
  "चु, चे, चो, ला, लि, लु, ले, लो, अ",
  "इ, उ, ए, ओ, वा, वि, वु, वे, वो",
  "का, कि, कु, घ, ङ, छ, के, को, हा",
  "हि, हु, हे, हो, डा, डि, डु, डे, डो",
  "मा, मि, मु, मे, मो, टा, टि, टु, टे",
  "टो, पा, पि, पु, ष, ण, ठ, पे, पो",
  "रा, रि, रु, रे, रो, ता, ति, तु, ते",
  "तो, ना, नि, नु, ने, नो, या, यि, यु",
  "ये, यो, भा, भि, भु, धा, फा, ढा, भे",
  "भो,जा,जि,जु,जे,जो,ख,खि,खु,खे,खो,गा,गि",
  "गु, गे, गो, सा, सि, सु, से, सो, दा",
  "दि, दु, थ, झ, ञ, दे, दो, चा, चि"
];
List<String> week_array_long = [
  "sunday",
  "monday",
  "tuesday",
  "wednesday",
  "thursday",
  "friday"
];
List<String> week_array_short = [
  "week_sun",
  "week_mon",
  "week_tue",
  "week_wed",
  "week_thu",
  "week_fri",
  "week_sat"
];
List<String> array_week = ["SU", "MO", "TU", "WE", "TH", "FR", "SA"];
List<String> week_array = [
  "week_su",
  "week_mo",
  "week_tu",
  "week_we",
  "week_th",
  "week_fr",
  "week_sa"
];
List<String> month_array_en = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];
List<String> month_arry_en_short = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];
List<String> month_arary_ne = [
  "baisakh",
  "jestha",
  "ashar",
  "shrawan",
  "bhadra",
  "ashoj",
  "kartik",
  "mangsir",
  "poush",
  "magh",
  "falgun",
  "chaitra"
];

List<String> tithi_array_en = [
  "Pratipada",
  "Dwitia",
  "Tritiya",
  "Chaturthi",
  "Panchami",
  "Sasthi",
  "Saptami",
  "Astami",
  "Nawami",
  "Dashami",
  "Ekadashi",
  "Dwadashi",
  "Trayodashi",
  "Chaturdashi",
  "Purnima",
  "Aunsi"
];

List<String> tithi_array_ne = [
  "प्रतिपदा",
  "द्वितीया",
  "तृतीया",
  "चतुर्थी",
  "पञ्चमी",
  "षष्ठी",
  "सप्तमी",
  "अष्टमी",
  "नवमी",
  "दशमी",
  "एकादशी",
  "द्वादशी",
  "त्रयोदशी",
  "चतुर्दशी",
  "पूर्णिमा",
  "औंसी"
];

List<String> ns_month_ne = [
  "कछलाथ्व",
  "कछलागा",
  "थिंलाथ्व",
  "थिंलागा",
  "पोहेलाथ्व",
  "पोहेलागा",
  "सिल्लाथ्व",
  "सिल्लागा",
  "चिल्लाथ्व",
  "चिल्लागा",
  "चौलाथ्व",
  "चौलागा",
  "बछलाथ्व",
  "बछलागा",
  "तछलाथ्व",
  "तछलागा",
  "दिल्लाथ्व",
  "दिल्लागा",
  "गुँलाथ्व",
  "गुँलागा",
  "ञलाथ्व",
  "ञलगा",
  "कौलाथ्व",
  "कौलागा"
];

List<String> ns_month_en = [
  "कछलाथ्व",
  "कछलागा",
  "थिंलाथ्व",
  "थिंलागा",
  "पोहेलाथ्व",
  "पोहेलागा",
  "सिल्लाथ्व",
  "सिल्लागा",
  "चिल्लाथ्व",
  "चिल्लागा",
  "चौलाथ्व",
  "चौलागा",
  "बछलाथ्व",
  "बछलागा",
  "तछलाथ्व",
  "तछलागा",
  "दिल्लाथ्व",
  "दिल्लागा",
  "गुँलाथ्व",
  "गुँलागा",
  "ञलाथ्व",
  "ञलगा",
  "कौलाथ्व",
  "कौलागा"
];

List<String> chandrama_ne = [
  "कार्तिक शुक्लपक्ष",
  "मार्ग कृष्णपक्ष",
  "मार्ग शुक्लपक्ष",
  "पौष कृष्णपक्ष",
  "पौष शुक्लपक्ष",
  "माघ कृष्णपक्ष",
  "माघ शुक्लपक्ष",
  "फाल्गुण कृष्णपक्ष",
  "फाल्गुण शुक्लपक्ष",
  "चैत्र कृष्णपक्ष",
  "चैत्र शुक्लपक्ष",
  "वैशाख कृष्णपक्ष",
  "वैशाख शुक्लपक्ष",
  "ज्येष्ठ कृष्णपक्ष",
  "ज्येष्ठ शुक्लपक्ष",
  "आषाढ कृष्णपक्ष",
  "आषाढ शुक्लपक्ष",
  "श्रावण कृष्णपक्ष",
  "श्रावण शुक्लपक्ष",
  "भाद्र कृष्णपक्ष",
  "भाद्र शुक्लपक्ष",
  "आश्विन कृष्णपक्ष",
  "आश्विन शुक्लपक्ष",
  "कार्तिक कृष्णपक्ष"
];

List<String> chandrama_en = [
  "Kartik Shuklapaksha",
  "Marga Krishnapaksha",
  "Marga Shuklapaksha",
  "Poush Krishnapaksha",
  "Poush Shuklapaksha",
  "Magh Krishnapaksha",
  "Magh Shuklapaksha",
  "Falgun Krishnapaksha",
  "Falgun Shuklapaksha",
  "Chaitra Krishnapaksha",
  "Chaitra Shuklapaksha",
  "Baishakh Krishnapaksha",
  "Baishakh Shuklapaksha",
  "Jestha Krishnapaksha",
  "Jestha Shuklapaksha",
  "Ashadh Krishnapaksha",
  "Ashadh Shuklapaksha",
  "Shrawan Krishnapaksha",
  "Shrawan Shuklapaksha",
  "Bhadra Krishnapaksha",
  "Bhadra Shuklapaksha",
  "Aswin Krishnapaksha",
  "Aswin Shuklapaksha",
  "Kartik Krishnapaksha",
];

List<String> newari_month = [
  'कछलाथ्व',
  'कछलागा',
  'थिंलाथ्व',
  'थिंलागा',
  'पोहेलाथ्व',
  'पोहेलागा',
  'सिल्लाथ्व',
  'सिल्लागा',
  'चिल्लाथ्व',
  'चिल्लागा',
  'चौलाथ्व',
  'चौलागा',
  'बछलाथ्व',
  'बछलागा',
  'तछलाथ्व',
  'तछलागा',
  'दिल्लाथ्व',
  'दिल्लागा',
  'गुँलाथ्व',
  'गुँलागा',
  'ञलाथ्व',
  'ञलगा',
  'कौलाथ्व',
  'कौलागा'
];

List<String> rashifal_tabs = ["daily", "weekly", "monthly", "yearly"];

enum DATE_TYPE { AD, BS, NS }
enum AD_TYPE { AD_FACEBOOK, AD_GOOGLE }

String BUNDLE_CALENDAR = "bundle_calendar";

const tempresponse =
    "{\"calendar\":[{\"calendar_id\":\"432654724e\",\"name\":\"synced calendar\",\"priority\":3,\"color\":\"#AC6E46\",\"status\":1,\"updated_at\":\"2019-09-11 14:23:49\"},{\"calendar_id\":\"4326547245\",\"name\":\"new calendar\",\"priority\":3,\"color\":\"#AC6E46\",\"status\":1,\"updated_at\":\"2019-09-11 14:23:49\"}],\"deleted_calendar\":[{\"calendar_id\":\"432654724e\",\"name\":\"synced calendar\",\"priority\":3,\"color\":\"#AC6E46\",\"status\":1,\"updated_at\":\"2019-09-11 14:23:49\"},{\"calendar_id\":\"4326547245\",\"name\":\"new calendar\",\"priority\":3,\"color\":\"#AC6E46\",\"status\":1,\"updated_at\":\"2019-09-11 14:23:49\"},{\"calendar_id\":\"432654724e\",\"name\":\"synced calendar\",\"priority\":3,\"color\":\"#AC6E46\",\"status\":1,\"updated_at\":\"2019-09-11 14:23:49\"},{\"calendar_id\":\"4326547245\",\"name\":\"new calendar\",\"priority\":3,\"color\":\"#AC6E46\",\"status\":1,\"updated_at\":\"2019-09-11 14:23:49\"}],\"events\":[{\"id\":\"e02ad770-cea0-11e9-e46a-a39175b153c4\",\"parent_event_id\":\"\",\"title\":\"test\",\"description\":\"\",\"start_date\":\"2019-09-12T06:00:00.000\",\"end_date\":\"2019-09-12T06:00:00.000\",\"is_full_day_event\":0,\"recurring_end_date\":null,\"is_recurring\":0,\"created_by\":\"\",\"has_reminder\":0,\"location\":\"\",\"guests\":null,\"rsvp\":null,\"note\":\"\",\"event_permission\":null,\"visibility\":\"\",\"privacy\":\"\",\"status\":1,\"duration\":1,\"gh\":1,\"rrule\":\"\",\"deleted_at\":null,\"created_at\":\"2019-09-12T11:18:39.809346\",\"updated_at\":\"2019-09-12T11:18:39.809346\",\"calendar_id\":\"5d5f86f153784\",\"based_on\":\"BS\",\"rsvp_stats\":null,\"formatted_rrule\":null,\"rsstart\":null,\"origid\":-1}],\"exceptions\":[{\"id\":1,\"exception_date\":\"2019-09-12T00:00:00.000\",\"event_id\":\"2b3fa630-cea0-11e9-a753-f3bc1fd52ce8\",\"created_date\":\"2019-09-12T11:15:43.722565\",\"updated_date\":\"2019-09-12T11:16:21.275802\",\"calendar_id\":\"5d63aa62ac5cd\"}]}";

const String NAVIGATION_HOME = "home";
const int NAVIGATION_HOME_ID = 0001;
const String NAVIGATION_CALENDAR = "calendar";
const int NAVIGATION_CALENDAR_ID = 0002;
const String NAVIGATION_NEWS = "news";
const int NAVIGATION_NEWS_ID = 0003;
const String NAVIGATION_RASHIFAL = "rashifal";
const int NAVIGATION_RASHIFAL_ID = 0004;
const String NAVIGATION_MORE = "more";
const int NAVIGATION_MORE_ID = 0005;
const String NAVIGATION_MYEVENTS = "events";
const String NAVIGATION_MYCALENDAR = "my_calendars";
const String NAVIGATION_DATECONVERSION = "conversion";
const String NAVIGATION_FOREX = "forex";
const String NAVIGATION_SHUVASAIT = "subhasait";
const String NAVIGATION_BLOG = "blog";
const int NAVIGATION_BLOG_ID = 00011;
const String NAVIGATION_GOVERNMENT_HOLIDAY = "governmentholiday";
const String NAVIGATION_SETTINGS = "settings";
const String NAVIGATION_CHECKUPDATE = "checkupdate";
const String NAVIGATION_ABOUTUS = "aboutus";
const String NAVIGATION_MORE_APPS = "other_apps";
const String NAVIGATION_FEEDBACK = "feedback";
const String NAVIGATION_CONNECTWITHUS = "connectwithus";
const String NAVIGATION_VERISONHISTORY = "version_history";
const String NAVIGATION_PRIVACY = "privacy";
const String NAVIGATION_FAQ = "faq";
const String NAVIGATION_TAG = "navigation_tag_id";
const String NAVIGATION_SUBSCRIPTION = "subscriptions";
const String NAVIGATION_TERMS_OF_SERVICE = "termsofservice";
const String NAVIGATION_ADDONS = "addon";
const String NAVIGATION_PANCHANGA_V2 = "navigation_panchangav2";
const String NAVIGATION_CONSULTATION = "navigation_consultation";
const String NAVIGATION_LIVE_TV = "live_tv";
const String NAVIGATION_BULLION = "bullion";
const String NAVIGATION_FM_RADIO = "fm_radio";
const String NAVIGATION_KUNDALI = "kundali";
const String NAVIGATION_UNIT_CONVERSION = "unit_conversion";
const String NAVIGATION_PARAMARSHA = "paramarsha";
const String NAVIGATION_SHOWS = "shows";
const String NAVIGATION_RADIO = "radio";
const String NAVIGATION_WEATHER = "weather";
const String NAVIGATION_STOCK = "stock";
const String NAVIGATION_MARKET_PLACE = "marketplace";

const String EVENT_REPETITION_AD_MONTH = "AD";
const String EVENT_REPETITION_AD_YEAR = "AD";
const String EVENT_REPTITION_BS_MONTH = "BS";
const String EVENT_REPTITION_BS_YEARLY = "BS";
const String EVENT_REPTITION_NS_MONTH = "NS";
const String EVENT_REPTITION_NS_YEARLY = "NS";
const String EVENT_REPETITION_CUSTOM = "repetition_custom";
const String EVENT_REPETITION_CREATE_CUSTOM = "repetition_custom_button";
const int DAY_START_HOUR = 00;

// calendar tab date selection
const String CAL_TAB_JUMP_DATE = "cal_tab_jump_date";
const String CAL_TAB_CREATE_EVENT = "cal_tab_create_event";

const String DEFAULT_IMAGE_URL =
    "https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";

const TAG_EVENT_REMINDER_TIME = "event_reminder_time";
const defUserId = "default_user";
const defToken = "";

const String PUBLIC_KEY_JWT =
    "MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAnmWD6ONWM50y/BaxPkCQgzvGbNby6lID/Fu601KEMwidonpd9ZYMaubJQW1DEUNWwJ99qJlyL4lI/fd4Kjv8PzEjtXMlXCn/i1H+571R6t4uB+K7uGJDxaaZF664/epXUhQUxzf5ACzhgSp7+1Y9vOuLcHGdb3nVm7cgitJc2SQiU1Ykuyva6EkovsggdlnSlkIiedktxsXg8fy7ryyY6RY9MEviXyQoA6G+WdWcs63XP++vO4Vdq3ex0UenB6kCPonIoy2Ys64vAnEwGc/nIeAjGielGFqj7RaGj7JzQ9cDzjQr1y6F7FYI+yneGppD4bHIuLbEc/eoLFCDBoAV6edP8lm5n/QNWkCi+tu/nykXGE2djhWGzeCyeLeQYYc/QmXVL9wyDEteinTVNNbgzJPobgQkNyh/pbF3s/LsVos7K7zgpYUsUohhKg3Ch7FvqemQ5Ubk9eDONn1c/ij+RaFz1O9/FZLcIPcKvciT81qBBnbCZONrf9oj3Fv63hwn/6g7mvxsU5tIFW+t6nyMmFByULTODsWL8by9lH3d0cEqxHW72TnbqQJJU5ljd9SzCTlUOWo9xqvz80dZYBJ2RcvLGR/ICLBE+RizpCRAsTWO/3LFyiuWywUoeZ8ly78LCRlJajGfegL+uZjJFuSfjz2UXLo65wx/smRqG4pjJ3cCAwEAAQ==";

const List<int> byteArray2 = [
  105,
  112,
  121,
  55,
  57,
  55,
  49,
  66,
  54,
  50,
  101,
  103,
  75,
  49,
  57,
  57,
  97,
  48,
  100,
  43,
  99,
  61
];
const ivString = "6qDiBm1LiWGvRPmau8cuUw==";
const shippedCaldbVersion = 20220227000051;
const shippedTithiVersion = 20220223000001;
// final ValueNotifier<bool> IS_PORTRAIT = ValueNotifier<bool>(true);

// PendingDynamicLinkData dynamicLinkData;
