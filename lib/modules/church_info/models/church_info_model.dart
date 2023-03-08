import 'package:butter/butter.dart';

class ChurchInfoModel extends BaseUIModel<ChurchInfoModel> {
  late void Function(String route) showPage;

  ChurchInfoModel();

  @override
  String get $key => '/church_info';

  @override
  ChurchInfoModel clone() => ChurchInfoModel();
}
