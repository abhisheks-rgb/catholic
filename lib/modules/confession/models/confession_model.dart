import 'package:butter/butter.dart';

class ConfessionModel extends BaseUIModel<ConfessionModel> {
  //
  String? error;
  bool? loading;
  double? titleFontSize = 20;
  double? contentFontSize = 16;
  bool? showInfo;

  void Function()? setShowInfo;

  ConfessionModel({
    this.error,
    this.loading,
    this.titleFontSize,
    this.contentFontSize,
    this.showInfo = false,
  });

  @override
  String get $key => '/confession';

  @override
  ConfessionModel clone() => ConfessionModel(
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
      other is ConfessionModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading &&
          titleFontSize == other.titleFontSize &&
          contentFontSize == other.contentFontSize &&
          showInfo == other.showInfo;
}
