import 'package:butter/butter.dart';

class ChurchBulletinModel extends BaseUIModel<ChurchBulletinModel> {
  late void Function() loadData;
  bool loading;
  List<dynamic>? items;

  ChurchBulletinModel({
    this.loading = false,
    this.items,
  });

  @override
  String get $key => '/church_bulletin';

  @override
  ChurchBulletinModel clone() => ChurchBulletinModel(
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
      other is ChurchBulletinModel &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          items == other.items;
}
