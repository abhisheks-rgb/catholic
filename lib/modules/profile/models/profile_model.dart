import 'package:butter/butter.dart';

class ProfileModel extends BaseUIModel<ProfileModel> {
  late void Function() loadData;
  List<dynamic>? items;
  //
  String? error;
  bool? loading;
  Map<String, dynamic>? user;

  ProfileModel({
    this.items,
    this.error,
    this.loading,
    this.user,
  });

  // Future<void> Function(String route)? navigateTo;
  Future<void> Function()? logout;

  @override
  String get $key => '/profile';

  @override
  ProfileModel clone() => ProfileModel(
        items: items ?? [],
        error: error,
        loading: loading,
        user: user,
      );

  @override
  int get hashCode => Object.hashAll([
        items,
        error,
        loading,
        user,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileModel &&
          runtimeType == other.runtimeType &&
          items == other.items &&
          error == other.error &&
          loading == other.loading &&
          user == other.user;
}
