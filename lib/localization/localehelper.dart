// ignore_for_file: unnecessary_null_comparison

import 'package:easy_localization/easy_localization.dart';

class LocaleHelper {
  // NpScopedModel _model;

  // setScopedModel(NpScopedModel model) {
  //   this._model = model;
  // }

  static getlocaleString(keyword, context) {
    var result = tr(keyword);
    if (result == null || result == "null") return keyword;
    return result;
  }

  // static getArrayString(arrayKeyword, keyword, context) {
  //   var result = plural(arrayKeyword, keyword);
  //   return result ?? keyword;
  // }

  static String formatNumber(int number, locale) {
    try {
      NumberFormat format = NumberFormat("", locale);
      return format.format(number);
    } catch (e) {
      return number.toString();
    }
  }

  // static String getLocaleCode(context) {
  //   return EasyLocalization.of(context).locale.languageCode;
  // }

  // static String getValueFromBsDate(BsDate date, BuildContext context) {
  //   if (getLocaleCode(context) == "ne") {
  //     return date.getDayNp();
  //   } else {
  //     return date.getDay();
  //   }
  // }

//   void changeLocale(BuildContext context, String locale) async {
//     try {
//       EasyLocalization.of(context)?.setLocale(Locale(locale));
//       LocaleHelper()
//           .setScopedModel(_model); // Review: why create new LocalHelper
//       _model.setCurrentLocale(locale, true);
// //      SharedPreferences prefs = await SharedPreferences.getInstance();
// //      await prefs.setString(PREFERRED_LANGUAGE, locale);

//       Navigator.of(context).pop();
//     } catch (e) {
//       print(e);
//     }
//   }
}
