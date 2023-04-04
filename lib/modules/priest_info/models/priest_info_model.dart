import 'package:butter/butter.dart';

class PriestInfoModel extends BaseUIModel<PriestInfoModel> {
  late void Function() loadData;
  String? error;
  bool loading;
  List<dynamic>? items;
  List<Object>? priests;
  String? priestName;

  PriestInfoModel({
    this.error,
    this.loading = false,
    this.items,
    this.priests,
    this.priestName,
  });

  late Future<List<Object>?> Function({String? name}) fetchPriests;
  late Function({String? priestName}) setPriestName;


  @override
  String get $key => '/priest_info';

  @override
  PriestInfoModel clone() => PriestInfoModel(
        error: error,
        loading: loading,
        items: items ?? [],
        priests: priests == null ? [] : List.unmodifiable(priests!),
        priestName: priestName,
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        items,
        loading,
        priests,
        priestName,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriestInfoModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading &&
          items == other.items &&
          priests == other.priests &&
          priestName == other.priestName;
}
