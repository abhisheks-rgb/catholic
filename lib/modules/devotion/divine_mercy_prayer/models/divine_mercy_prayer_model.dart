import 'package:butter/butter.dart';

class DivineMercyPrayerModel extends BaseUIModel<DivineMercyPrayerModel> {
  //
  String? error;
  bool? loading;
  double? titleFontSize = 20;
  double? contentFontSize = 16;
  bool? showInfo = false;

  void Function()? setShowInfo;

  DivineMercyPrayerModel({
    this.error,
    this.loading,
    this.titleFontSize,
    this.contentFontSize,
    this.showInfo,
  });

  @override
  String get $key => '/divine_mercy_prayer';

  @override
  DivineMercyPrayerModel clone() => DivineMercyPrayerModel(
        error: error,
        loading: loading,
        titleFontSize: titleFontSize,
        contentFontSize: contentFontSize,
        showInfo: showInfo,
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        loading,
        titleFontSize,
        contentFontSize,
        showInfo,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DivineMercyPrayerModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading &&
          titleFontSize == other.titleFontSize &&
          contentFontSize == other.contentFontSize &&
          showInfo == other.showInfo;
}
