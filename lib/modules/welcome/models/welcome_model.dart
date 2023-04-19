import 'package:butter/butter.dart';

class WelcomeModel extends BaseUIModel<WelcomeModel> {
  Map<String, dynamic>? user;
  late void Function(String route) showPage;

  WelcomeModel({
    this.user,
  });

  @override
  String get $key => '/welcome';

  @override
  WelcomeModel clone() => WelcomeModel(
        user: user,
      );

  @override
  int get hashCode => Object.hashAll([
        user,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WelcomeModel &&
          runtimeType == other.runtimeType &&
          user == other.user;
}
