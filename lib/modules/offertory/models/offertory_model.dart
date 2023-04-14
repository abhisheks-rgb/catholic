import 'package:butter/butter.dart';

class OffertoryModel extends BaseUIModel<OffertoryModel> {
  late void Function() loadData;
  List<dynamic>? items;
  //
  String? error;
  bool? loading;
  List<Object>? offertories;
  String? churchName;

  OffertoryModel({
    this.items,
    this.error,
    this.loading,
    this.offertories,
    this.churchName,
  });

  late Future<List<Object>?> Function({int? charityId}) fetchOffertory;
  Future<void> Function(int? churchId, String route, String churchName)?
      navigateTo;
  late Function({String? churchName}) setChurchName;

  @override
  String get $key => '/offertory';

  @override
  OffertoryModel clone() => OffertoryModel(
        items: items ?? [],
        error: error,
        loading: loading,
        offertories: offertories == null ? [] : List.unmodifiable(offertories!),
        churchName: churchName,
      );

  @override
  int get hashCode => Object.hashAll([
        items,
        error,
        loading,
        offertories,
        churchName,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OffertoryModel &&
          runtimeType == other.runtimeType &&
          items == other.items &&
          error == other.error &&
          loading == other.loading &&
          offertories == other.offertories &&
          churchName == other.churchName;
}
