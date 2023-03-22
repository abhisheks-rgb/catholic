import 'package:butter/butter.dart';

class ScriptureHistoryModel extends BaseUIModel<ScriptureHistoryModel> {
  List<Object>? items;
  String? authorName;
  //
  String? error;
  bool? loading;

  ScriptureHistoryModel({
    this.items,
    this.authorName,
    this.error,
    this.loading,
  });

  Future<void> Function(Map<Object?, Object?>? scripture)? viewScriptureDetails;

  @override
  String get $key => '/scripture_history';

  @override
  ScriptureHistoryModel clone() => ScriptureHistoryModel(
    items: items ?? [],
    authorName: authorName,
    error: error,
    loading: loading,
  );

  @override
  int get hashCode => Object.hashAll([
    items,
    authorName,
    error,
    loading,
  ]);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is ScriptureHistoryModel &&
        runtimeType == other.runtimeType &&
        items == other.items &&
        authorName == other.authorName &&
        error == other.error &&
        loading == other.loading;
}
