import 'package:butter/butter.dart';

class PrayModel extends BaseUIModel<PrayModel> {
  late void Function(String route) showPage;

  PrayModel();

  @override
  String get $key => '/pray';

  @override
  PrayModel clone() => PrayModel();
}
