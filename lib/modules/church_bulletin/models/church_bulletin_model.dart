import 'package:butter/butter.dart';

class ChurchBulletinModel extends BaseUIModel<ChurchBulletinModel> {
  late void Function() loadData;
  bool loading;
  List<dynamic>? items;
  String? churchName;

  ChurchBulletinModel({
    this.loading = false,
    this.items,
    this.churchName,
  });

  late Function({String? churchName}) setChurchName;
  late Function({bool? isFullScreen}) setIsFullScreen;

  @override
  String get $key => '/church_bulletin';

  @override
  ChurchBulletinModel clone() => ChurchBulletinModel(
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
      other is ChurchBulletinModel &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          items == other.items &&
          churchName == other.churchName;
}
