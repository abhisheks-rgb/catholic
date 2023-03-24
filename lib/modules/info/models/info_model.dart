import 'package:butter/butter.dart';

class InfoModel extends BaseUIModel<InfoModel> {
  late void Function(String route) showPage;
  InfoModel();

  @override
  String get $key => '/info';

  @override
  InfoModel clone() => InfoModel();
}
