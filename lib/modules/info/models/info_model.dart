import 'package:butter/butter.dart';

class InfoModel extends BaseUIModel<InfoModel> {
  Map? qouteInfo;
  bool isLoggedIn;
  late void Function(String route) showPage;
  late void Function() checkIsLoggedIn;

  InfoModel({
    this.qouteInfo,
    this.isLoggedIn = false,
  });

  @override
  String get $key => '/info';

  @override
  InfoModel clone() => InfoModel(
        qouteInfo: qouteInfo,
        isLoggedIn: isLoggedIn,
      );

  @override
  int get hashCode => Object.hashAll([
        qouteInfo,
        isLoggedIn,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoModel &&
          runtimeType == other.runtimeType &&
          qouteInfo == other.qouteInfo &&
          isLoggedIn == other.isLoggedIn;
}
