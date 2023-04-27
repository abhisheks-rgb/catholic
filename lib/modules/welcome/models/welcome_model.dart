import 'package:butter/butter.dart';

class WelcomeModel extends BaseUIModel<WelcomeModel> {
  bool loading;
  Map<String, dynamic>? user;
  late void Function(String route) showPage;
  late Future<void> Function() initializeQoute;
  late Future<void> Function() initializeUser;

  WelcomeModel({
    this.loading = false,
    this.user,
  });

  @override
  String get $key => '/welcome';

  @override
  WelcomeModel clone() => WelcomeModel(
        loading: loading,
        user: user,
      );

  @override
  int get hashCode => Object.hashAll([
        loading,
        user,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WelcomeModel &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          user == other.user;
}
