import 'package:butter/butter.dart';

class OffertoryModel extends BaseUIModel<OffertoryModel> {
  late void Function() loadData;
  List<dynamic>? items;
  //
  String? error;
  bool? loading;
  List<Object>? offertories;

  OffertoryModel({
    this.items,
    this.error,
    this.loading,
    this.offertories,
  });

  late Future<List<Object>?> Function({int? charityId}) fetchOffertory;
  Future<void> Function(int? churchId, String route)? navigateTo;

  @override
  String get $key => '/offertory';

  @override
  OffertoryModel clone() => OffertoryModel(
    items: items ?? [],
    error: error,
    loading: loading,
    offertories: offertories == null ? [] : List.unmodifiable(offertories!),
  );

  @override
  int get hashCode => Object.hashAll([
    items,
    error,
    loading,
    offertories,
  ]);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is OffertoryModel &&
        runtimeType == other.runtimeType &&
        items == other.items &&
        error == other.error &&
        loading == other.loading &&
        offertories == other.offertories;
}
