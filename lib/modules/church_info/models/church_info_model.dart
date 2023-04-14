import 'package:butter/butter.dart';

class ChurchInfoModel extends BaseUIModel<ChurchInfoModel> {
  late void Function(String route, String? name, String? churchLink) showPage;
  late void Function() loadData;
  List<dynamic>? items;
  //
  String? error;
  bool? loading;
  List<Object>? churchInfos;
  int? churchId;
  String? churchName;

  ChurchInfoModel({
    this.items,
    this.error,
    this.loading,
    this.churchInfos,
    this.churchId,
    this.churchName,
  });

  late Future<List<Object>?> Function({int? orgId}) fetchChurchInfo;
  late Function({int? churchId}) setChurchId;

  @override
  String get $key => '/church_info';

  @override
  ChurchInfoModel clone() => ChurchInfoModel(
        items: items ?? [],
        error: error,
        loading: loading,
        churchInfos: churchInfos == null ? [] : List.unmodifiable(churchInfos!),
        churchId: churchId,
        churchName: churchName,
      );

  @override
  int get hashCode => Object.hashAll([
        items,
        error,
        loading,
        churchInfos,
        churchId,
        churchName,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChurchInfoModel &&
          runtimeType == other.runtimeType &&
          items == other.items &&
          error == other.error &&
          loading == other.loading &&
          churchInfos == other.churchInfos &&
          churchId == other.churchId &&
          churchName == other.churchName;
}
