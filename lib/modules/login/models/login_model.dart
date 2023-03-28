import 'package:butter/butter.dart';

class LoginModel extends BaseUIModel<LoginModel> {
  late void Function(String email, String password) login;
  //
  String? error;
  bool? loading;
  bool isLoggedIn;

  LoginModel({
    this.error,
    this.loading,
    this.isLoggedIn = false,
  });

  Future<void> Function(String route)? navigateTo;

  @override
  String get $key => '/login';

  @override
  LoginModel clone() => LoginModel(
    error: error,
    loading: loading,
    isLoggedIn : isLoggedIn,
  );

  @override
  int get hashCode => Object.hashAll([
    error,
    loading,
    isLoggedIn,
    
  ]);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is LoginModel &&
        runtimeType == other.runtimeType &&
        error == other.error &&
        loading == other.loading &&
        isLoggedIn == other.isLoggedIn;
}
