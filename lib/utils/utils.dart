import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:nepali_patro_sql_package/models/calendareventsmodel.dart';
import 'package:nepali_patro_sql_package/models/eventdescriptionmodel.dart';
import 'package:nepali_patro_sql_package/utils/constants.dart';
import 'package:nepali_patro_sql_package/utils/stringConstants.dart';
import 'package:encrypt/encrypt.dart' as prefix0;
import 'package:encrypt/encrypt.dart';

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
      print(e);
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
}
