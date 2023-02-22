import 'package:butter/butter.dart';

class SchedulesModel extends BaseUIModel<SchedulesModel> {
  SchedulesModel();

  @override
  String get $key => '/schedules';

  @override
  SchedulesModel clone() => SchedulesModel();
}
