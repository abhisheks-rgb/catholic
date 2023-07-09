import 'package:butter/butter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileModel extends BaseUIModel<ProfileModel> {
  //
  String? error;
  bool? loading;
  Map<String, dynamic>? user;
  PackageInfo? packageDetails;

  ProfileModel({this.error, this.loading, this.user, this.packageDetails});

  // Future<void> Function(String route)? navigateTo;
  Future<void> Function()? logout;

  @override
  String get $key => '/profile';

  @override
  ProfileModel clone() => ProfileModel(
      error: error,
      loading: loading,
      user: user,
      packageDetails: packageDetails);

  @override
  int get hashCode => Object.hashAll([error, loading, user, packageDetails]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading &&
          user == other.user &&
          packageDetails == other.packageDetails;
}
