import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:nepali_patro_sql_package/utils/utils.dart';
import 'package:archive/archive.dart';

class APIResponseDecoder {
  static String? zipDecode(File tempFile) {
    try {
      Uint8List uint8list = tempFile.readAsBytesSync();
      ByteData audioByteData = ByteData.view(uint8list.buffer);
      return decode(audioByteData);
    } catch (e) {
      Utils.debugLog(e);
    }
    return null;
  }

  static String decode(ByteData audioByteData) {
    try {
      final bytes = audioByteData.buffer.asUint8List(
          audioByteData.offsetInBytes, audioByteData.lengthInBytes);
      bytes[0] = 0x1f;
      bytes[1] = 0x8b;
      bytes[2] = 0x08;
      bytes[3] = 0x00;
      bytes[4] = 0x00;
      bytes[5] = 0x00;
      bytes[6] = 0x00;
      bytes[7] = 0x00;
      final archive = GZipDecoder().decodeBytes(bytes);
      var stringFileData = utf8.decode(archive, allowMalformed: true);
      return stringFileData;
    } catch (e) {
      Utils.debugLog(e);
      return "";
    }
  }
}
