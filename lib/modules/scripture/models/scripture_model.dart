import 'package:butter/butter.dart';

class ScriptureModel extends BaseUIModel<ScriptureModel> {
  List<Object>? items;
  Map? isToday;
  //
  String? error;
  bool? loading;

  ScriptureModel({
    this.isToday,
    this.items,
    this.error,
    this.loading,
  });

  Future<void> Function(String authorname, String shortname,
      List<Object?> data)? viewHistory;
  Future<void> Function(Map<Object?, Object?>? scripture)? viewScriptureDetails;

  late Future<List<Object>?> Function({String? quantity}) fetchReflections;

  @override
  String get $key => '/scripture';

  @override
  ScriptureModel clone() => ScriptureModel(
        items: items ?? [],
        isToday: isToday,
        error: error,
        loading: loading,
      );

  @override
  int get hashCode => Object.hashAll([
        items,
        isToday,
        error,
        loading,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScriptureModel &&
          runtimeType == other.runtimeType &&
          isToday == other.isToday &&
          items == other.items &&
          error == other.error &&
          loading == other.loading;
}
