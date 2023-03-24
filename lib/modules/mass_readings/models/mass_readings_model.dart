import 'package:butter/butter.dart';

class MassReadingsModel extends BaseUIModel<MassReadingsModel> {
  late void Function(String massReadingDate) loadMassReading;
  //
  String? error;
  bool? loading;
  Map? massReadingItem;
  List<Object>? massReadingList;
  List<String>? massReadingTypeList;

  MassReadingsModel({
    this.error,
    this.loading,
    this.massReadingItem,
    this.massReadingList,
    this.massReadingTypeList,
  });

  @override
  String get $key => '/mass_readings';

  @override
  MassReadingsModel clone() => MassReadingsModel(
        error: error,
        loading: loading,
        massReadingItem: massReadingItem ?? {},
        massReadingList: massReadingList ?? [],
        massReadingTypeList: massReadingTypeList ?? [],
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        loading,
        massReadingItem,
        massReadingList,
        massReadingTypeList,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MassReadingsModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading &&
          massReadingItem == other.massReadingItem &&
          massReadingList == other.massReadingList &&
          massReadingTypeList == other.massReadingTypeList;
}
