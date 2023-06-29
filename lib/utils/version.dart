import 'package:butter/butter.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io' show Platform;

class AppVersion {
  // late String version;
  late Map<dynamic, dynamic> version;

  Future<AppVersion> init() async {
    final data = await AppVersionRuntimeOptions().read();
    version = {
      'ios': data['ios'].toString(),
      'android': data['android'].toString()
    };

    Butter.d('Version: $version');

    return this;
  }

  Map<dynamic, dynamic> get appVersion {
    return version;
  }

  bool isVersionMatch(Map<dynamic, dynamic> dbVersion) {
    bool isMatch = false;
    if (Platform.isIOS) {
      //do ios
      if (dbVersion['ios'] == version['ios']) {
        isMatch = true;
      }
    } else {
      //do android
      if (dbVersion['android'] == version['android']) {
        isMatch = true;
      }
    }
    return isMatch;
  }
}

class AppVersionRuntimeOptions {
  factory AppVersionRuntimeOptions() {
    return _instance;
  }

  AppVersionRuntimeOptions._internal();

  static final AppVersionRuntimeOptions _instance =
      AppVersionRuntimeOptions._internal();

  Future<dynamic> read() async {
    final raw = await rootBundle.loadString('assets/version.json');
    return await json.decode(raw);
  }
}
