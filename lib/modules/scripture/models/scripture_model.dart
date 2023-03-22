import 'package:butter/butter.dart';

class ScriptureModel extends BaseUIModel<ScriptureModel> {
  List<Object>? items;
  //
  String? error;
  bool? loading;

  ScriptureModel({
    this.items,
    this.error,
    this.loading,
  });

  Future<void> Function(int? id)? viewHistory;
  Future<void> Function(Map<Object?, Object?>? scripture)? viewScriptureDetails;

  late Future<List<Object>?> Function({String? quantity}) fetchReflections;

  @override
  String get $key => '/scripture';

  @override
  ScriptureModel clone() => ScriptureModel(
    items: items ?? [],
    error: error,
    loading: loading,
  );

  @override
  int get hashCode => Object.hashAll([
    items,
    error,
    loading,
  ]);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is ScriptureModel &&
        runtimeType == other.runtimeType &&
        items == other.items &&
        error == other.error &&
        loading == other.loading;
}
