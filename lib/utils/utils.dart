// ignore_for_file: curly_braces_in_flow_control_structures, unnecessary_string_escapes, unused_local_variable, deprecated_member_use, invalid_use_of_protected_member, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nepali_patro_sql_package/localization/localehelper.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart';
import 'package:nepali_patro_sql_package/models/eventdescriptionmodel.dart';
import 'package:nepali_patro_sql_package/models/npscopemodel.dart';
import 'package:nepali_patro_sql_package/utils/apiconstants.dart';
import 'package:nepali_patro_sql_package/utils/constants.dart';
import 'package:nepali_patro_sql_package/utils/prefsutils.dart';
import 'package:nepali_patro_sql_package/utils/stringConstants.dart';
import 'package:encrypt/encrypt.dart' as prefix0;
import 'package:encrypt/encrypt.dart';
import 'package:oktoast/oktoast.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  static void debugLog(message) {
    if (!kReleaseMode) {
      print("np.com.nepalipatro: $message");
    }
  }

  static getEventsDescriptionOnly(Event event) {
    EventDescriptionModel? eventDescriptionModel;
    try {
      RegExp regExp = RegExp("\{.*\}");
      var result = Utils.decryptData(event.description);
      if (regExp.hasMatch(result!)) {
        eventDescriptionModel = eventDescriptionModelFromJson(result);
      }
      eventDescriptionModel = eventDescriptionModelEncrypteFromJson(result);
      return eventDescriptionModel;
    } catch (e) {
      Utils.debugLog(e);
    }
    return eventDescriptionModel;
  }

  static String? decryptData(String? encData) {
    try {
//      var encData = encryptedData.replaceAll(new RegExp("[^A-Za-z0-9+/=]"), "");
      var b64 = utf8.decode(base64.decode(encData.toString()));
      var json = jsonDecode(b64);
      var iv = json['iv'];
      var data = json['value'];
      List<int> byteData = [];
      byteData.addAll(StringConstants.byteArray);
      byteData.addAll(byteArray2);
      var k = utf8.decode(byteData);
      final encrypter =
          Encrypter(AES(prefix0.Key.fromBase64(k), mode: AESMode.cbc));
      final decrypted = encrypter.decrypt64(data, iv: IV.fromBase64(iv));
      return decrypted;
    } catch (e) {
      return encData;
    }
  }

  static encrypt(String result) {
    try {
      List<int> byteData = [];
      byteData.addAll(StringConstants.byteArray);
      byteData.addAll(byteArray2);
      var k = utf8.decode(byteData);
      final key = prefix0.Key.fromBase64(k);
      var ivStr = ivString;
      final iv = IV.fromBase64(ivStr);
      final encrypter =
          Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
      final encrypted = encrypter.encrypt(result, iv: iv);
      var jsonMap = {"value": encrypted.base64, "iv": ivStr};
      var rB64 = jsonEncode(jsonMap);
      var rBase64Decoded = utf8.encode(rB64);
      var rEncryptedData = base64.encode(rBase64Decoded);
      return rEncryptedData;
    } catch (e) {
      return result;
    }
  }

  static decodeData(k, v, data) {
    //SUVHASAIT [0]
    //BLOG[]
    String decrypted = "";
    String trimmedString = "";
    try {
      var reversed = data
          .split('')
          .reversed
          .join('')
          .replaceAll(RegExp("[^A-Za-z0-9+/=]"), "");
      final key = prefix0.Key.fromUtf8(k);
      final iv = IV.fromUtf8(v);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: null));
      decrypted = encrypter.decrypt16(reversed, iv: iv).toString();
      trimmedString = decrypted.replaceAll(RegExp("[^A-Za-z0-9+/=]"), "");
      var decoded = utf8.decode(base64.decode(trimmedString));
      return decoded;
    } catch (e) {
      try {
        var decoded = utf8.decode(base64.decode(decrypted));
        return decoded;
      } catch (e) {
        Utils.debugLog(e);
      }
    }
  }

  static decodeDataWithoutIV(k, encryptedData) {
    //var encrypter=Encrypter(AES())
//    encryptedData = encryptedData.replaceAll(new RegExp("[^A-Za-z0-9+/=]"), "");
    var b64 = utf8.decode(base64.decode(encryptedData.toString()));
    var json = jsonDecode(b64);

    var iv = json['iv'];
    var data = json['value'];

    final encrypter =
        Encrypter(AES(prefix0.Key.fromBase64(k), mode: AESMode.cbc));
    final decrypted = encrypter.decrypt64(data, iv: IV.fromBase64(iv));
    return jsonDecode(decrypted);
  }

  static String pad(int n, {String locale = "en"}) {
    if (n <= 9) if (locale == "en")
      return "0" + n.toString();
    else
      return "${LocaleHelper.formatNumber(0, locale)}${LocaleHelper.formatNumber(n, locale)}";
    else if (locale == "en")
      return n.toString();
    else
      return LocaleHelper.formatNumber(n, locale);
  }

  static Future<String> getUrl(appendInfo, url) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (appendInfo) {
      var appVersionName = packageInfo.version;
      var appVersionCode = packageInfo.buildNumber;
      var extraInfo = "?vn=" + appVersionName + "&vc=" + appVersionCode;
      Utils.debugLog("EXTRAINFO-->$extraInfo");
      return url + extraInfo;
    } else {
      return url;
    }
  }

  static Future<String> readFile(filename) async {
    String text = "";
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$filename.txt');
      text = await file.readAsString();
//      text = Utils.decodeDataWithoutIV("9E4mk3Woz7tN8Ic9LRZYG5ipy7971B62egK199a0d+c=", text);
    } catch (e) {
      Utils.debugLog(e);
      // Print("Couldn't read file");
    }
    return text;
  }

  static decrypt(String encryptedData) {
    try {
//      encryptedData = encryptedData.replaceAll(new RegExp("[^A-Za-z0-9+/=]"), "");
      var b64 = utf8.decode(base64.decode(encryptedData.toString()));
      var json = jsonDecode(b64);

      var iv = json['iv'];
      var data = json['value'];
      List<int> byteData = [];
      byteData.addAll(StringConstants.byteArray);
      byteData.addAll(byteArray2);
      var k = utf8.decode(byteData);
      final encrypter =
          Encrypter(AES(prefix0.Key.fromBase64(k), mode: AESMode.cbc));
      final decrypted = encrypter.decrypt64(data, iv: IV.fromBase64(iv));
      return jsonDecode(decrypted);
    } catch (e) {
      return encryptedData;
    }
  }

  static Future<bool> isUserAuthorized() async {
    var token = await PrefsUtils.getString(PREF_AUTH_TOKEN, "abcdedf");
    return token.isEmpty ? false : true;
  }

  static userCrudSyncToWeb() async {
    var token = await PrefsUtils.getString(PREF_AUTH_TOKEN, "");
    if (token.isNotEmpty) {
      Dio dio = Dio();
      try {
        var userCrudSyncWeb = await dio.get(CRUD_USER_SYNC_WEB,
            options: Options(headers: {"Authorization": "Bearer $token"}));
        if (userCrudSyncWeb.statusCode == 200) {
          Utils.debugLog("successfully send to web");
        }
      } on DioError catch (de) {
        Utils.debugLog(de);
      } catch (e) {
        Utils.debugLog(e);
      }
      return true;
    }
    return true;
  }

  static Future<Dio> getApiClient(BuildContext context, {String? token}) async {
    NpScopedModel _npSopedModel = NpScopedModel.of(context);
    Dio _dio = Dio();
    _dio.options = BaseOptions(
        connectTimeout: DEF_TIMEOUT, receiveTimeout: DEF_RECEIVETIMEOUT);
//    token = await storage.read(key: USER_TOKEN);
    token = await PrefsUtils.getString(PREF_AUTH_TOKEN, "");
    _dio.interceptors.clear();
    // Todo confirm this change ie: removed token part from interceptor from onRequest
    if (token.isNotEmpty) {
      _dio.options.headers = {"Authorization": "Bearer $token"};
    }
    _dio.interceptors
        .add(InterceptorsWrapper(onError: (DioError error, handler) async {
      // Do something with response error
      Utils.debugLog("error " + error.toString());
      if (_npSopedModel.authToken != "") {
        if (error.response != null && error.response?.statusCode == 401) {
          _dio.lock();
          try {
            var userId = await PrefsUtils.getString(PREF_USER_ID, "");
            var refToken =
                await PrefsUtils.getString(PREF_REFRESH_AUTH_TOKEN, "");
            var authToken = await PrefsUtils.getString(PREF_AUTH_TOKEN, "");
            var data = {"username": userId, "refresh_token": refToken};
            Dio tokenDio = Dio();
            var refreshToken = await tokenDio.post(REFRESH_TOKEN, data: data);

            if (refreshToken.statusCode == 200) {
              // _dio.unlock();
              QueuedInterceptor();
              var authsToken = refreshToken.data["access_token"];
              var refToken = refreshToken.data["refresh_token"];
              await PrefsUtils.putString(PREF_AUTH_TOKEN, authsToken);
              await PrefsUtils.putString(PREF_REFRESH_AUTH_TOKEN, refToken);
              _npSopedModel.authToken = authsToken;
              RequestOptions requestOptions = error.response!.requestOptions;
              Options options = Options();
              options.headers?.addAll({'requiresToken': true});
              options.headers!["Authorization"] = "Bearer " + authsToken;

              // return _dio.request(requestOptions.path,
              //     options: options, data: requestOptions.data);
              dynamic path = _dio.request(requestOptions.path,
                  options: options, data: requestOptions.data);
              return path;
            }
          } on DioError catch (dioEror) {
            Utils.debugLog(dioEror);
            if (dioEror.response != null &&
                dioEror.response?.statusCode == 401) {
              showToast("Token Expire Please Login Again.",
                  backgroundColor: Colors.red,
                  position: ToastPosition.bottom,
                  duration: const Duration(seconds: 2));
              await PrefsUtils.putString(PREF_USER_DETAILS, "");
              await PrefsUtils.putString(PREF_USER_ID, "");
              await PrefsUtils.putString(PREF_AUTH_TOKEN, "");
              _npSopedModel.authToken = "";
              _npSopedModel.userId = "";
              _npSopedModel.notifyListeners();
              return dioEror.error;
            }
          } catch (dioError) {
            Utils.debugLog(dioError);
            return;
          }
          return;
        }
      } else {
        return;
      }
    }));
    /*   _dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      // Do something before request is sent
      token = await PrefsUtils.getString(PREF_AUTH_TOKEN, "");
      token != "" ? options.headers["Authorization"] = "Bearer " + token : null;
      return options;
    }, onResponse: (Response response, handler) {
      // Do something with response data
      return response; // continue
    }, onError: (DioError error, handler) async {
      // Do something with response error
      Utils.debugLog("error " + error.toString());
      if (_npSopedModel.authToken != "") {
        if (error.response != null && error.response?.statusCode == 401) {
          _dio.lock();
          */ /* _dio.interceptors.requestLock.lock();
    _dio.interceptors.responseLock.lock();*/ /*

          try {
            var userId = await PrefsUtils.getString(PREF_USER_ID, "");
            var refToken =
                await PrefsUtils.getString(PREF_REFRESH_AUTH_TOKEN, "");
            var authToken = await PrefsUtils.getString(PREF_AUTH_TOKEN, "");
            var data = {"username": userId, "refresh_token": refToken};
            Dio tokenDio = new Dio();
            var refreshToken = await tokenDio.post(REFRESH_TOKEN, data: data);

            if (refreshToken.statusCode == 200) {
              _dio.unlock();
              var authsToken = refreshToken.data["access_token"];
              var refToken = refreshToken.data["refresh_token"];
              await PrefsUtils.putString(PREF_AUTH_TOKEN, authsToken);
              await PrefsUtils.putString(PREF_REFRESH_AUTH_TOKEN, refToken);
              _npSopedModel.authToken = authToken;
              RequestOptions requestOptions = error.response.requestOptions;
              Options options = Options();
              options.headers.addAll({'requiresToken': true});
              options.headers["Authorization"] = "Bearer " + authsToken;
              // _dio.options = options;
              */ /*_dio.interceptors.requestLock.unlock();
        _dio.interceptors.responseLock.unlock();*/ /*

              // Print("refresh 200     ${options.path}");
              // Print("refresh 200     ${options.headers}");
              return _dio.request(requestOptions.path,
                  options: options, data: requestOptions.data);
//      Dio newDio = new Dio();
//      var requestDio = await newDio.
//      return error;
            }
          } on DioError catch (dioEror) {
            Utils.debugLog(dioEror);
            if (dioEror.response != null &&
                dioEror.response.statusCode == 401) {
              showToast("Token Expire Please Login Again.",
                  backgroundColor: Colors.red,
                  position: ToastPosition.bottom,
                  duration: Duration(seconds: 2));
              await PrefsUtils.putString(PREF_USER_DETAILS, "");
              await PrefsUtils.putString(PREF_USER_ID, "");
              await PrefsUtils.putString(PREF_AUTH_TOKEN, "");
              _npSopedModel.authToken = "";
              _npSopedModel.userId = "";
              _npSopedModel.notifyListeners();
              return dioEror;
            }
          } catch (dioError) {
            Utils.debugLog(dioError);
            return dioError;
          }
          return error;
        }
      } else {
        return error;
      }
    }));*/
    return _dio;
  }
}
