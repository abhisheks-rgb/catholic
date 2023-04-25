import 'package:butter/butter.dart';

class ScriptureDetailsModel extends BaseUIModel<ScriptureDetailsModel> {
  Map<Object?, Object?>? item;

  double? titleFontSize = 20;
  double? contentFontSize = 17;
  //
  String? error;
  bool? loading;

  ScriptureDetailsModel({
    this.item,
    this.error,
    this.loading,
    this.titleFontSize,
    this.contentFontSize,
  });

  @override
  String get $key => '/scripture_details';

  @override
  ScriptureDetailsModel clone() => ScriptureDetailsModel(
        item: item ?? {},
        error: error,
        loading: loading,
        titleFontSize: titleFontSize,
        contentFontSize: contentFontSize,
      );

  @override
  int get hashCode => Object.hashAll([
        item,
        error,
        loading,
        titleFontSize,
        contentFontSize,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScriptureDetailsModel &&
          runtimeType == other.runtimeType &&
          item == other.item &&
          error == other.error &&
          loading == other.loading &&
          titleFontSize == other.titleFontSize &&
          contentFontSize == other.contentFontSize;
}
