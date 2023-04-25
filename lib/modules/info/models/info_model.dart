import 'package:butter/butter.dart';

class InfoModel extends BaseUIModel<InfoModel> {
  Map? qouteInfo;
  late void Function(String route) showPage;

  InfoModel({
    this.qouteInfo,
  });

  @override
  String get $key => '/info';

  @override
  InfoModel clone() => InfoModel(
        qouteInfo: qouteInfo,
      );

  @override
  int get hashCode => Object.hashAll([
        qouteInfo,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoModel &&
          runtimeType == other.runtimeType &&
          qouteInfo == other.qouteInfo;
}
