import 'package:flutter/services.dart';
import 'dart:convert';

class AppConfig {
  static const title = 'My Catholic SG';
  static const shortTitle = 'Catholic SG';
  static const initRoute = '/_/welcome';

  // Web url
  // static const webUrl = getWebUrl();
  // prod web url
  // static const webUrl = 'https://mycatholic.sg';

  late String webShareUrl;

  Future<AppConfig> init() async {
    final data = await AppConfigRuntimeOptions().read();

    webShareUrl = data['webUrl'].toString();

    return this;
  }

  String get webUrl {
    return webShareUrl;
  }
}

class AppConfigRuntimeOptions {
  factory AppConfigRuntimeOptions() {
    return _instance;
  }

  AppConfigRuntimeOptions._internal();

  static final AppConfigRuntimeOptions _instance =
      AppConfigRuntimeOptions._internal();

  Future<dynamic> read() async {
    final raw = await rootBundle.loadString('assets/share_config.json');
    return await json.decode(raw);
  }
}
