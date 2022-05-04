// ignore_for_file: non_constant_identifier_names, prefer_const_declarations

final String FOREX_URI = "${NP_BASE_URL}forex/getv4/";
final String BLOG_URI = "${NP_BASE_URL}blog/mappedblogs/";
final String BLOG_COMMENT_URL =
    "https://nepalipatro.com.np/blog/?json=respond.submit_comment";
final String API_SEND_FCM_TOKEN = "${NP_BASE_URL}gcm/register";
final String FAQ_URL = "${NP_BASE_URL}faq/android";
final String PRIVACY_URL = "${NP_DEV_URL}policies/privacy";
final String TERMS_OF_SERVICE_URL = "${NP_DEV_URL}policies/tos";
final String HOLIDAYS_API = "${NP_V2_BASEURL}holidays/sync";

final String NP_DEV_URL = "https://api.nepalipatro.com.np/";
//final String NP_DEV_URL="https://backend-calendar.dev.geniussystems.com.np/";

final String SUVASAITS_API = "https://nepalipatro.com.np/sait/getv4";
final String NP_BASE_URL = "https://nepalipatro.com.np/";
final String panchangBaseUrl = "https://nepalipatro.com.np/sait/getv4";
//final String NP_BASE_URL = "https://api.nepalipatro.com.np/";
// final String NP_V2_DEV_BASEURL =
//     "https://backend-calendar.dev.geniussystems.com.np/";
// final String NP_V2_BASEURL = "https://backend-calendar.dev.geniussystems.com.np/";
// final String NP_V2_BASEURL =
//     "https://backend-calendar.dev.geniussystems.com.np/";
final String NP_V2_BASEURL = "https://api.nepalipatro.com.np/";
// final String NP_V2_BASEURL = "https://backend-calendar.dev.geniussystems.com.np/";
final String CHECK_VERSION_API = "${NP_V2_BASEURL}checkVersions";
final String REGSITER_FCM = "${NP_V2_BASEURL}userfcm";
final String RASHIFAL_URI = "${NP_BASE_URL}rashifal/getv5/type/";
final String AMESSAGE_URI = "${NP_V2_BASEURL}amessage/getv2";
final String CALENDAR_URI = "${NP_V2_BASEURL}calendars";
final String SYNC_CALENDAR_PRIORITY_API = "${NP_V2_BASEURL}calendar-priority";
//final String SYNC_CALENDAR_API = "${NP_V2_BASEURL}calendars/sync?version=v2";
//final String SYNC_CALENDAR_API = "${NP_V2_BASEURL}calendars/sync/v3";
final String SYNC_CALENDAR_API = "${NP_V2_BASEURL}calendars/sync/v4";
//final String SYNC_CALENDAR_API = "${NP_V2_BASEURL}calendars/sync";
//final String USER_SYNC_CALENDAR_API = "${NP_V2_BASEURL}users/calendars/sync";
final String USER_SYNC_CALENDAR_API =
    "${NP_V2_BASEURL}users/calendars/sync?version=v2";
final String PANCHANGA_API = "$NP_BASE_URL/panchanga/getv443dd/";
final String ALMANAC_API = "${NP_V2_BASEURL}fetch/panchanga/format/html/";
final String LOGIN_API = "${NP_V2_BASEURL}users/login";
final String SIGNUP_API = "${NP_V2_BASEURL}users";
final String LOCAL_CALENDARS_LISTS_API = "${NP_V2_BASEURL}public-calendars";
final String SUBSCRIBE_TO_CALENDARS =
    "${NP_V2_BASEURL}public-calendars/subscribe";
final String LOGIN_FORGOT_API = "${NP_V2_BASEURL}forgot-password";
final String SOCIALLOGIN_API_FB = "${NP_V2_BASEURL}users/facebook/login";
final String SOCIALLOGIN_API_GOOGLE = "${NP_V2_BASEURL}users/google/login";
final String SOCIALLOGIN_API_APPLE = "${NP_V2_BASEURL}users/apple/login";

String ERP_CODE_API({String? user_id}) => "${NP_V2_BASEURL}users/$user_id/erp";

final String POST_FEEDBACK_URL = "${NP_V2_BASEURL}feedback";
final String REFRESH_TOKEN = "${NP_V2_BASEURL}users/refresh-token";
final String CRUD_USER_SYNC_WEB = "${NP_V2_BASEURL}sync-webfcms";
final String TITHI_MAP = "${NP_V2_BASEURL}generate-mapping";

final String SUBSCRIPTION_URL =
    "https://nepalipatro.com.np/subscription?token=";
final String PARAMARSHA_URL = "https://nepalipatro.com.np/paramarsha/1?token=";

// API to post voucher code
final String POST_VOUCHER_API = "${NP_V2_BASEURL}verify-vouchers";
// API to fetch url for webview in payment
final String INITIATE_PAYEMNT_URL = "${NP_V2_BASEURL}initiatepayments";
// API to generate voucher
final String GENERATE_VOUCHER = "${NP_V2_BASEURL}vouchers";
// API to get product list for subscription
final String GET_PRODUCT_LIST_API = "${NP_V2_BASEURL}gerp/products";
// API to send email to user when user subscribes
final String PAYMENT_COMPLETEION_MAIL = "${NP_V2_BASEURL}payment/mail";

final String SERVICES_API = "${NP_V2_BASEURL}services";

final String VERIFY_EMAIL_API = "${NP_V2_BASEURL}verify-testusers";

//##--------------------------------------------Times of Nepal------------------------------##

//API URLS

final String BASEURL_V5 = "https://timesofnepal.com.np/newsv5/";
final String API_CUSTOM_FEED_COUNT = "${BASEURL_V5}t.php";

final String API_SOURCES = "${BASEURL_V5}sources.php"; // ?a=sdf thiyo
final String API_WEATHER = "${BASEURL_V5}weather.php?";

//------------------ForYouPage maa use huni---------------
//final String API_BREIFING = "${BASEURL_V3}feeds_brief.php";   //pinned news halnu ahgi
final String API_BREIFING =
    "${BASEURL_V5}feeds_brief.php"; //after pinned news added
final String API_NEWS_FETCH =
    "${BASEURL_V5}infinite_feeds.php"; //NewsFetchForYouService
//----------------------------------------------------------------------------------------//

//---------------------HeadLines page maa use huni-----------------------------//
final String API_TOP_READ = "${BASEURL_V5}feeds_top.php"; //TopReadWebService
final String API_NEWS_FETCHV2 =
    "${BASEURL_V5}infinite_feeds_category.php"; //NewsFetchByCategoryService  ----by appending required parameters other two URLs are created
//--------------------------------------------------------------------------------------------------//

//--------------------------BackgroundFetch maa Use huni URL--------------------------//
final String API_FEEDS_V2 =
    "${BASEURL_V5}feeds.php"; //NewsFetchBackgroundManager ----other NewsFetchForYouService n NewsBriefingService also used
//-------------------------------------------------------------------------------------//

final String API_CHIPS = "${BASEURL_V5}tags.php";
final String API_SEARCH_API = "${BASEURL_V5}search.php?text=";
final String API_MORE_PRODUCTS =
    "https://nepali-keyboard-b62c1.firebaseio.com/";

//final String API_SEND_FCM_TOKEN = "https://timesofnepal.com.np/fcm/register";

final String PRIVACY_POLICY_URL = "https://timesofnepal.com.np/privacy-policy";
final String POP_UP_DAY_DETAIL = "https://nepalipatro.com.np/events/api/";
final String NEWS_SOURCES_LIST_URL = "https://nepalipatro.com.np/news-sources";

//##--------------------------------------------Times of Nepal------------------------------##

/*final String SUVASAITS_API="https://nepalipatro.com.np/sait/getv4";
  final String NP_BASE_URL="https://nepalipatro.com.np/";
  final String NP_V2_BASEURL="https://backend-calendar.dev.geniussystems.com.np/";
  final String RASHIFAL_URI="${NP_BASE_URL}rashifal/getv5/type/";
  final String AMESSAGE_URI="${NP_BASE_URL}amessage/getv2";
  final String CALENDAR_URI="${NP_V2_BASEURL}calendars";
  final String SYNC_CALENDAR_PRIORITY_API="${NP_V2_BASEURL}calendar-priority";
  final String SYNC_CALENDAR_API="${NP_V2_BASEURL}calendars/sync";
  final String PANCHANGA_API="${NP_BASE_URL}/panchanga/getv443dd/";
  final String LOGIN_API = "${NP_V2_BASEURL}users/login";
  final String SIGNUP_API = "${NP_V2_BASEURL}users";
  final String LOCAL_CALENDARS_LISTS_API="${NP_V2_BASEURL}public-calendars";
  final String SUBSCRIBE_TO_CALENDARS="${NP_V2_BASEURL}public-calendars/subscribe";
  final String LOGIN_FORGOT_API = "${NP_V2_BASEURL}forgot-password";
  final String SOCIALLOGIN_API_FB = "${NP_V2_BASEURL}users/facebook/login";
  final String SOCIALLOGIN_API_GOOGLE = "${NP_V2_BASEURL}users/google/login";*/
final String CHECKUPDATE_API = "${NP_V2_BASEURL}apps/versioncheck";
final String CHECKUPDATE_API_IOS = "https://nepalipatro.com.np/apps/ios/act/vc";
final String UPDATE_USERSTATS_ANDROID =
    "https://nepalipatro.com.np/apps/android/stats/ok";
final String MULTIPLE_BLOG_FETCH_BY_IDS = "${NP_BASE_URL}blog/mappedblogs/id/";

final String WEATHER_BASE_URL = "https://weather.nepalipatro.com.np/";

final String WEATHER_PROVINCE_API = "${WEATHER_BASE_URL}provinces";
