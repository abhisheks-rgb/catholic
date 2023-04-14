import 'package:butter/butter.dart';

class SchedulesModel extends BaseUIModel<SchedulesModel> {
  late void Function(String route, int? orgId, String? churchName) showPage;
  late void Function() loadData;
  bool loading;
  List<dynamic>? items;
  String? churchName;

  SchedulesModel({
    this.loading = false,
    this.items,
    this.churchName,
  });

  late Function({String? churchName}) setChurchName;

  @override
  String get $key => '/schedules';

  @override
  SchedulesModel clone() => SchedulesModel(
        loading: loading,
        items: items ?? [],
        churchName: churchName,
      );

  @override
  int get hashCode => Object.hashAll([
        items,
        loading,
        churchName,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchedulesModel &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          items == other.items &&
          churchName == other.churchName;
}
