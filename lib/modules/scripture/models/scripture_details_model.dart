import 'package:butter/butter.dart';

class ScriptureDetailsModel extends BaseUIModel<ScriptureDetailsModel> {
  Map<Object?, Object?>? item;
  //
  String? error;
  bool? loading;

  ScriptureDetailsModel({
    this.item,
    this.error,
    this.loading,
  });

  @override
  String get $key => '/scripture_details';

  @override
  ScriptureDetailsModel clone() => ScriptureDetailsModel(
    item: item ?? {},
    error: error,
    loading: loading,
  );

  @override
  int get hashCode => Object.hashAll([
    item,
    error,
    loading,
  ]);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is ScriptureDetailsModel &&
        runtimeType == other.runtimeType &&
        item == other.item &&
        error == other.error &&
        loading == other.loading;
}
