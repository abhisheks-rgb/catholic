import 'package:butter/butter.dart';

class PriestInfoModel extends BaseUIModel<PriestInfoModel> {
  late void Function() loadData;
  bool loading;
  List<dynamic>? items;

  PriestInfoModel({
    this.loading = false,
    this.items,
  });

  @override
  String get $key => '/priest_info';

  @override
  PriestInfoModel clone() => PriestInfoModel(
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
      other is PriestInfoModel &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          items == other.items;
}
