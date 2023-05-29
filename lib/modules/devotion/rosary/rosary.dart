import 'package:butter/butter.dart';

import 'pages/rosary_page.dart';
import 'states/rosary_state.dart';

class Rosary extends BaseModule {
  Rosary()
      : super(
          routeName: '/rosary',
          routes: {
            // This is the root route of the module ('/').
            '/': BasePageConnector<RosaryState, RosaryPage>(
              state: RosaryState(),
              page: RosaryPage(),
              getPage: (vm) => RosaryPage(model: vm.model),
            ),
          },
        );
}
