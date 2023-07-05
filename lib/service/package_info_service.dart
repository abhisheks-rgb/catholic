import 'package:butter/butter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  static Future<PackageInfo> getPackageDetails() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    Butter.d('$appName $packageName $version $buildNumber');
    return packageInfo;
  }
}
