import 'package:flutter/services.dart';
import 'channelconstants.dart';

class ChannelPluginHelper {
  static const channel = MethodChannel(DEFAULT_CHANNEL_NP);

  static Future<dynamic> invalidateUserEventsAlarm() async {
    return channel
        .invokeMethod(CHANNEL_METHOD_REINIT_EVENTS_ALARM, ["", "", ""]);
  }

  static loadWebView(String url) {
    channel.invokeMethod(CHANNEL_METHOD_OPEN_URL, ["", "", url]);
  }

  static void calltest() {
    channel.invokeMethod(CHANNEL_METHOD_TEST, ["", "", ""]);
  }

  static void clearAppData() {
    channel.invokeMethod(CHANNEL_CLEAR_DATA, ["", "", ""]);
  }
}
