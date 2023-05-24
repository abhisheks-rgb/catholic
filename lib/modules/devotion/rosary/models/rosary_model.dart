import 'package:butter/butter.dart';

class RosaryModel extends BaseUIModel<RosaryModel> {
  //
  String? error;
  bool? loading;
  double? titleFontSize = 20;
  double? contentFontSize = 16;

  RosaryModel({
    this.error,
    this.loading,
    this.titleFontSize,
    this.contentFontSize,
  });

  @override
  String get $key => '/rosary';

  @override
  RosaryModel clone() => RosaryModel(
        error: error,
        loading: loading,
        titleFontSize: titleFontSize,
        contentFontSize: contentFontSize,
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        loading,
        titleFontSize,
        contentFontSize,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RosaryModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading &&
          titleFontSize == other.titleFontSize &&
          contentFontSize == other.contentFontSize;
}
