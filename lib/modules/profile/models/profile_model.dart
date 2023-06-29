import 'package:butter/butter.dart';

class ProfileModel extends BaseUIModel<ProfileModel> {
  //
  String? error;
  bool? loading;
  Map<String, dynamic>? user;
  Map<dynamic, dynamic>? appVersion;
  Map<dynamic, dynamic>? dbVersion;

  ProfileModel(
      {this.error, this.loading, this.user, this.appVersion, this.dbVersion});

  // Future<void> Function(String route)? navigateTo;
  Future<void> Function()? logout;

  @override
  String get $key => '/profile';

  @override
  ProfileModel clone() => ProfileModel(
      error: error,
      loading: loading,
      user: user,
      appVersion: appVersion,
      dbVersion: dbVersion);

  @override
  int get hashCode =>
      Object.hashAll([error, loading, user, appVersion, dbVersion]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading &&
          user == other.user &&
          appVersion == other.appVersion &&
          dbVersion == other.dbVersion;
}
