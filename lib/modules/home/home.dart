import 'package:butter/butter.dart';

import 'pages/home_page.dart';
import 'states/home_state.dart';
import '../welcome/welcome.dart';
import '../info/info.dart';
import '../pray/pray.dart';
import '../schedules/schedules.dart';
import '../church_bulletin/church_bulletin.dart';
import '../church_info/church_info.dart';
import '../offertory/offertory.dart';
import '../scripture/scripture.dart';
import '../priest_info/priest_info.dart';
import '../mass_readings/mass_readings.dart';
import '../login/login.dart';
import '../profile/profile.dart';
import '../events/events.dart';
import '../notification/notification.dart';
import '../devotion/devotion.dart';
import '../confession/confession.dart';

class Home extends BaseModule {
  Home()
      : super(
          routeName: '/_',
          routes: {
            // This is the root route of the module ('/').
            '/': BasePageConnector<HomeState, HomePage>(
              state: HomeState(),
              page: HomePage(),
              getPage: (vm) => HomePage(model: vm.model),
            ),
          },
          modules: {
            '/_/info': Info(),
            '/_/pray': Pray(),
            '/_/welcome': Welcome(),
            '/_/schedules': Schedules(),
            '/_/church_bulletin': ChurchBulletin(),
            '/_/church_info': ChurchInfo(),
            '/_/offertory': Offertory(),
            '/_/scripture': Scripture(),
            '/_/priest_info': PriestInfo(),
            '/_/mass_readings': MassReadings(),
            '/_/login': Login(),
            '/_/profile': Profile(),
            '/_/events': Events(),
            '/_/notification': Notification(),
            '/_/devotion/main': Devotion(),
            '/_/confession': Confession(),
          },
        );
}
