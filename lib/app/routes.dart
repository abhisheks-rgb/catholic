import 'package:butter/butter.dart';

import '../modules/home/home.dart';
import '../modules/welcome/welcome.dart';
import '../modules/schedules/schedules.dart';
import '../modules/church_bulletin/church_bulletin.dart';
import '../modules/church_info/church_info.dart';
import '../modules/offertory/offertory.dart';

class Routes extends BaseRoutes {
  Routes()
      : super(
          modules: [
            Home(),
            Welcome(),
            Schedules(),
            ChurchBulletin(),
            ChurchInfo(),
            Offertory(),
          ],
        );
}
