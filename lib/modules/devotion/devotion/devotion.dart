import 'package:butter/butter.dart';

import 'pages/devotion_page.dart';
import 'states/devotion_state.dart';

class Devotion extends BaseModule {
  Devotion()
      : super(
          routeName: '/main',
          routes: {
            // This is the root route of the module ('/').
            '/': BasePageConnector<DevotionState, DevotionPage>(
              state: DevotionState(),
              page: DevotionPage(),
              getPage: (vm) => DevotionPage(model: vm.model),
            ),
          },
        );
}
