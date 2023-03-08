import 'package:butter/butter.dart';

class SchedulesModel extends BaseUIModel<SchedulesModel> {
  late void Function() loadData;
  bool loading;
  List<dynamic>? items;

  SchedulesModel({
    this.loading = false,
    this.items,
  });

  @override
  String get $key => '/schedules';

  @override
  SchedulesModel clone() => SchedulesModel(
        loading: loading,
        items: items ?? [],
      );

  @override
  int get hashCode => Object.hashAll([
        items,
        loading,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchedulesModel &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          items == other.items;
}
