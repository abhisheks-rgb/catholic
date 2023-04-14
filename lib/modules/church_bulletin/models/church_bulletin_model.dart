import 'package:butter/butter.dart';

class ChurchBulletinModel extends BaseUIModel<ChurchBulletinModel> {
  late void Function() loadData;
  bool loading;
  List<dynamic>? items;
  String? churchName;
  String? churchLink;

  ChurchBulletinModel({
    this.loading = false,
    this.items,
    this.churchName,
    this.churchLink,
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
        churchLink: churchLink,
      );

  @override
  int get hashCode => Object.hashAll([
        items,
        loading,
        churchName,
        churchLink,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChurchBulletinModel &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          items == other.items &&
          churchName == other.churchName &&
          churchLink == other.churchLink;
}
