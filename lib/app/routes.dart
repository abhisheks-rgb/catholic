import 'package:butter/butter.dart';
import 'package:trcas_catholic/modules/discover/discover.dart';

import '../modules/church_bulletin/church_bulletin.dart';
import '../modules/church_info/church_info.dart';
import '../modules/home/home.dart';
import '../modules/info/info.dart';
import '../modules/login/login.dart';
import '../modules/mass_readings/mass_readings.dart';
import '../modules/offertory/offertory.dart';
import '../modules/pray/pray.dart';
import '../modules/priest_info/priest_info.dart';
import '../modules/profile/profile.dart';
import '../modules/schedules/schedules.dart';
import '../modules/scripture/scripture.dart';
import '../modules/welcome/welcome.dart';

class Routes extends BaseRoutes {
  Routes()
    : super(
        modules: [
          Home(),
          Info(),
          Pray(),
          Welcome(),
          Schedules(),
          ChurchBulletin(),
          ChurchInfo(),
          Offertory(),
          Scripture(),
          PriestInfo(),
          MassReadings(),
          Login(),
          Profile(),
          Discover(),
        ],
      );
}
