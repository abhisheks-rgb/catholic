import 'package:butter/butter.dart';

import 'pages/church_bulletin_page.dart';
import 'states/church_bulletin_state.dart';

class ChurchBulletin extends BaseModule {
  ChurchBulletin()
      : super(
          routeName: '/church_bulletin',
          routes: {
            // This is the root route of the module ('/').
            '/': BasePageConnector<ChurchBulletinState, ChurchBulletinPage>(
              state: ChurchBulletinState(),
              page: ChurchBulletinPage(),
              getPage: (vm) => ChurchBulletinPage(model: vm.model),
            ),
          },
        );
}
