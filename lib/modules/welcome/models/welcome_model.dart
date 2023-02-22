import 'package:butter/butter.dart';

class WelcomeModel extends BaseUIModel<WelcomeModel> {
  late void Function(String route) showPage;

  WelcomeModel();

  @override
  String get $key => '/welcome';

  @override
  WelcomeModel clone() => WelcomeModel();
}
