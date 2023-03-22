import 'package:butter/butter.dart';

import 'pages/home_page.dart';
import 'states/home_state.dart';
import '../welcome/welcome.dart';
import '../schedules/schedules.dart';
import '../church_bulletin/church_bulletin.dart';
import '../church_info/church_info.dart';
import '../offertory/offertory.dart';

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
            '/_/welcome': Welcome(),
            '/_/schedules': Schedules(),
            '/_/church_bulletin': ChurchBulletin(),
            '/_/church_info': ChurchInfo(),
            '/_/offertory': Offertory(),
          },
        );
}
