// import 'dart:async';
// import 'dart:collection';
// import 'dart:convert';

// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/material.dart';
// import 'package:nepali_patro_sql_package/utils/prefsutils.dart';
// import 'package:nepali_patro_sql_package/utils/remoteconfigconstants.dart';
// import 'package:nepali_patro_sql_package/utils/timezone.dart';
// import 'package:nepali_patro_sql_package/utils/utils.dart';
// import 'package:nepalipatro/database/dbhelper.dart';
// import 'package:nepalipatro/models/calendarmodel.dart' as calendarModel;
// import 'package:nepalipatro/utils/ads/ad.dart';
// import 'package:nepalipatro/utils/constants.dart';
// import 'package:nepalipatro/utils/prefsutils.dart';
// import 'package:nepalipatro/utils/remoteconfigconstants.dart';
// import 'package:nepalipatro/utils/timezone.dart';
// import 'package:nepalipatro/utils/utils.dart';
// import 'package:oktoast/oktoast.dart';
// import 'package:scoped_model/scoped_model.dart';

// import 'calendareventsmodel.dart';
// import 'calendarlisteventmodel.dart';

// ignore_for_file: non_constant_identifier_names, unnecessary_getters_setters, unused_field, prefer_final_fields, curly_braces_in_flow_control_structures, unnecessary_null_comparison, library_prefixes

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:nepali_patro_sql_package/models/calendar_model.dart';
import 'package:nepali_patro_sql_package/models/calendarlisteventmodel.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'package:nepali_patro_sql_package/utils/constants.dart';
import 'package:nepali_patro_sql_package/utils/prefsutils.dart';
import 'package:nepali_patro_sql_package/utils/remoteconfigconstants.dart';
import 'package:nepali_patro_sql_package/utils/timezone.dart';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:nepali_patro_sql_package/models/calendar_model.dart'
    as calendarModel;
import 'package:scoped_model/scoped_model.dart';

abstract class IDateChangeNotifier {
  void onDateChanged();
}

class NpScopedModel extends Model {
  double content_scaling_factor = 1;

  int smartBannerAdsOption = 0;

  int newsNotificationReminderInterval = 15;
  int rashifalNotificationReminderInterval = 15;

  int newsUrlOption = 1;

  int powerValue = 1;

  int textanimationduration = 1600;
  int showFeedDescription = 1;

  bool forceOpenSource = true;
  int sourceWidgetMode = 0;
  int priorityweightqty = 2;
  String dayDetailToken = "";
  bool _showCalendarSearch = false;
  int fcmTokenSendInterval = FCM_TOKEN_SEND_INTERVAL_DEFAULT;

  /// This is the main variable to check for ad disable. If user is rewarded
  /// or the user has purchased subscription.
  bool _disableAds = false;

  bool get disableAds => _disableAds;
  DatabaseHelper databaseHelper = DatabaseHelper.privateConstructor();
  set disableAds(bool value) {
    PrefsUtils.putBoolean(PREFS_ADS_DISABLE, value);
    _disableAds = value;
    // notifyListeners();
    return;
  }

  bool showSubscription = false;

  bool showParamarsha = false;

  IDateChangeNotifier? _homePageDateChangeNotifier;
  IDateChangeNotifier? _calendarPageDateChangeNotifier;
  IDateChangeNotifier? _dayDetailPageDateChangeNotifier;

  IDateChangeNotifier get dayDetailPageDateChangeNotifier =>
      _dayDetailPageDateChangeNotifier!;

  set dayDetailPageDateChangeNotifier(IDateChangeNotifier value) {
    _dayDetailPageDateChangeNotifier = value;
  }

  IDateChangeNotifier get calendarPageDateChangeNotifier =>
      _calendarPageDateChangeNotifier!;

  set calendarPageDateChangeNotifier(IDateChangeNotifier value) {
    _calendarPageDateChangeNotifier = value;
  }

  IDateChangeNotifier get homePageDateChangeNotifier =>
      _homePageDateChangeNotifier!;

  set homePageDateChangeNotifier(IDateChangeNotifier value) {
    _homePageDateChangeNotifier = value;
  }

  bool get showCalendarSearch => _showCalendarSearch;

  set showCalendarSearch(bool value) {
    _showCalendarSearch = value;
  }

  String error_message = "Something went wrong";
  bool foryouBackgroundLoading = false;

  String APP_THEME = APP_THEME_LIGHT;
  String currentLocale = "ne";
  String userId = "";
  String authToken = "";
  String userDetails = "";
  int prefRashifal = 0, selectedRashifal = 0;
  int deviceVersionCode = 0;
  bool dailyRashifalNotifications = true;
  Map<String, dynamic> selectedRashifalMap = {};

  bool calendarNotifications = true;
  bool stickyNotifications = true;
  bool prefetchHoroscope = true;
  bool showEvents = true;
  bool autoUpdate = true;
  bool isValidVoucher = false;
  Map<String, dynamic> _extraBundle = HashMap();
  String selectedLoadDayImage = LOAD_DAY_IMAGE_OPTION_ALWAYS;
  ConnectivityResult? connectivityResult;
  int nativeAds = 1;

  int _noOfHomeListOfEvents = 4;

  /// [_timer] periodically checks if a day has passed to refresh pages in app
  Timer? _timer;

  /// Periodically checks if a day has passed comparing [Timezone().curDateTimeByZone("NPT")] with
  /// [_prevDate]
  startTimer() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        /// condition to check if a day has passed between previous DateTime
        /// and Timezone().curDateTimeByZone("NPT")
        if ((_prevDate!.day - Timezone().curDateTimeByZone("NPT").day).abs() !=
            0) {
          _prevDate = Timezone().curDateTimeByZone("NPT");
          _homePageDateChangeNotifier?.onDateChanged();
          _calendarPageDateChangeNotifier?.onDateChanged();
          _dayDetailPageDateChangeNotifier?.onDateChanged();
        }
      });
    }
  }

  dateDiffChecker() {
    if ((_prevDate!.day - Timezone().curDateTimeByZone("NPT").day).abs() != 0) {
      _prevDate = Timezone().curDateTimeByZone("NPT");
      _homePageDateChangeNotifier?.onDateChanged();
      _calendarPageDateChangeNotifier?.onDateChanged();
      _dayDetailPageDateChangeNotifier?.onDateChanged();
    }
  }

  cancelTimer() {
    _timer?.cancel();
  }

  /// [_timerRewardAd] sets timer after which ad is disabled and after timer is
  /// completed enable ad
  Timer? _timerRewardAd;

  startTimerForRewardedAd({int remainingInterval = 0}) {
    if (_timerRewardAd == null || !_timerRewardAd!.isActive) {
      _timerRewardAd = Timer.periodic(
          Duration(minutes: rewardedAdRewardInterval - remainingInterval),
          (timer) {
        /// timer for rewarded ad to enable ads again
        Utils.debugLog("Reward ad timer end");
        isUserAwarded = false;
        _timerRewardAd?.cancel();
        showToast("Premium time ended",
            duration: const Duration(seconds: 2),
            position: ToastPosition.bottom,
            backgroundColor: Colors.red);
        PrefsUtils.putString(PREFS_REWARDED_AD_AWARDED_TIME, "");
      });
    }
  }

  rewardAdChecker(int remainingInterval) {
    if (remainingInterval > rewardedAdRewardInterval) {
      isUserAwarded = false;
      _timerRewardAd?.cancel();
      PrefsUtils.putString(PREFS_REWARDED_AD_AWARDED_TIME, "");
    }
  }

  /// [_prevDate] is used to check if a day is completed and the app needs to
  /// refresh its content set it during the first launch only
  DateTime? _prevDate;

  DateTime get prevDate => _prevDate!;

  set prevDate(DateTime value) {
    _prevDate = value;
  }

  /// [_isUserAwarded] is used to check if user has viewed rewarded ad and
  /// disable or enable ads accordingly
  bool _isUserAwarded = false;

  bool get isUserAwarded => _isUserAwarded;

  set isUserAwarded(bool value) {
    _isUserAwarded = value;
    disableAds = value;
  }

  int _rewardedAdRewardInterval = REWARD_AD_REWARD_INTERVAL_DETAULT;

  int get rewardedAdRewardInterval => _rewardedAdRewardInterval;

  set rewardedAdRewardInterval(int value) {
    _rewardedAdRewardInterval = value;
  }

  int get noOfHomeListOfEvents => _noOfHomeListOfEvents;

  set noOfHomeListOfEvents(int value) {
    _noOfHomeListOfEvents = value;
  }

  /// [_adCalendarTabInterval] holds the interval data from remote config to
  /// get the interval to show ads in calendar tab page
  int _adCalendarTabInterval = 7;

  int get adCalendarTabInterval => _adCalendarTabInterval;

  set adCalendarTabInterval(int value) {
    _adCalendarTabInterval = value;
  }

  //ads Related
  // NewsAds adsHelper;

  setVoucherStatus(bool voucherStatus, {bool notify = false}) {
    isValidVoucher = voucherStatus;
    disableAds = voucherStatus;
    if (notify) notifyListeners();
  }

  get getConnectivityResult => connectivityResult;

  setConnectivityResult(ConnectivityResult result) {
    connectivityResult = result;
  }

  get getSelectedLoadDayImage => selectedLoadDayImage;

  setSelectedLoadDayImage(String value) {
    selectedLoadDayImage = value;
  }

  get getExtraBundle => _extraBundle;

  setExtraBundle(key, value) {
    _extraBundle[key] = value;
  }

  Map eventIntents = {};

  String notificationTime = "";
  List<CalendarListEventModel> homeEventsLists = [];
  List<Event> homeListOfEvents = [];
  bool hasEventLimit = true;
  List<Event>? _eventsTodayLists;
  List<calendarModel.Calendar> _calendarLists = [];
  String _calendarData = "";
  Map<String, dynamic> _calendarMap = {};

  static NpScopedModel of(BuildContext context) =>
      ScopedModel.of<NpScopedModel>(context);

  setTheme(theme, notify) {
    APP_THEME = theme;
    if (notify) notifyListeners();
  }

  setCurrentLocale(locale, notify) {
    currentLocale = locale;
    if (notify) notifyListeners();
  }

  setUserDetails(String userData, notify) {
    userDetails = userData;
    if (notify) notifyListeners();
  }

  getUserDetail() {
    return userDetails;
  }

  setPrefRashifal(index, notify) {
    prefRashifal = index;
    if (notify) notifyListeners();
  }

  setSelectedRashifal(int selectedRashifal, bool notify) {
    this.selectedRashifal = selectedRashifal;
    if (notify) notifyListeners();
  }

  setRashifalDailyNotification(bool checked, bool notify) {
    dailyRashifalNotifications = checked;
    if (notify) notifyListeners();
  }

  setEventIntent(intentMap, notify) {
    if (intentMap is Map) eventIntents = intentMap;
    if (notify) notifyListeners();
  }

  clearEventIntents() {
    eventIntents.clear();
  }

  setSelectedRashifalDetail(details, ntf, key) {
    selectedRashifalMap[key] = details;
    if (ntf) notifyListeners();
  }

  clearSelectedRashifalMap() {
    selectedRashifalMap.clear();
  }

  changeHasEventLimit(value, {bool notify = true}) {
    if (value == null)
      hasEventLimit = !hasEventLimit;
    else
      hasEventLimit = value;
    // if (notify) notifyListeners();
  }

  getHasEventLimit() => hasEventLimit;

  clearCalendars() {
    _calendarLists.clear();
  }

  setCalendars(List<calendarModel.Calendar> calendars, bool notify) async {
    if (calendars.isEmpty) {
      _calendarLists = await databaseHelper.getAllSortedCalendars();
    } else {
      _calendarLists = calendars;
    }
    if (notify) notifyListeners();
  }

  Calendar? getCalendarById(String id) {
    try {
      List<calendarModel.Calendar> calendarLists = _calendarLists
          .where((calendarModel.Calendar c) => c.calendar_id == id)
          .toList();
      if (calendarLists != null && calendarLists.isNotEmpty) {
        return calendarLists[0];
      }
    } catch (e) {
      Utils.debugLog(e);
    }
    return null;
  }

  getCalendarByCalendarId(String id) {
    try {
      List<calendarModel.Calendar> calendarLists = _calendarLists
          .where((calendarModel.Calendar c) => c.calendar_id == id)
          .toList();
      if (calendarLists != null && calendarLists.isNotEmpty) {
        return calendarLists[0];
      }
    } catch (e) {
      Utils.debugLog(e);
    }
    return null;
  }

  List<calendarModel.Calendar> getCalendars() => _calendarLists;

  getModifiableCalendars() {
    try {
      List<calendarModel.Calendar> calendarLists = _calendarLists
          .where((calendarModel.Calendar c) => c.isModifiable == 1)
          .toList();
      if (calendarLists != null && calendarLists.isNotEmpty) {
        return calendarLists;
      }
    } catch (e) {
      Utils.debugLog(e);
    }
    return null;
  }

  getUserCalendars() {
    try {
      List<calendarModel.Calendar> calendarLists = _calendarLists
          .where((calendarModel.Calendar c) =>
              c.createdBy == userId && c.status != 2)
          .toList();
      if (calendarLists != null && calendarLists.isNotEmpty) {
        return calendarLists;
      }
    } catch (e) {
      Utils.debugLog(e);
    }
    return null;
  }

  setCalendarData(String calendarData, bool notify) {
    try {
      _calendarData = calendarData;
      if (_calendarData.isNotEmpty) {
        var dataMap = jsonDecode(_calendarData)["data"];
        _calendarMap = dataMap["events"];
      }

      if (notify) notifyListeners();
    } catch (e) {
      Utils.debugLog(e);
    }
  }

  getCalendarData() {
    return _calendarMap;
  }
}

//   //--------------------------------TimesOfNepal------------------------------------//

//   setRashifalNotificationReminderInterval(
//       int rashifalNotificationReminderInterval,
//       [bool notify = true]) {
//     this.rashifalNotificationReminderInterval =
//         rashifalNotificationReminderInterval;
//     if (notify) notifyListeners();
//   }

//   setSmartBannerAdsShowingOption(int option, [bool notify = true]) {
//     this.smartBannerAdsOption = option;
//     if (notify) notifyListeners();
//   }

//   getSmartBannerAdsShowingOption() {
//     return smartBannerAdsOption;
//   }
// }
