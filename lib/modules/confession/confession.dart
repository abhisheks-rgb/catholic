import 'package:butter/butter.dart';

import 'pages/confession_page.dart';
import 'states/confession_state.dart';

class Confession extends BaseModule {
  Confession()
      : super(
          routeName: '/Confession',
          routes: {
            // This is the root route of the module ('/').
            '/': BasePageConnector<ConfessionState, ConfessionPage>(
              state: ConfessionState(),
              page: ConfessionPage(),
              getPage: (vm) => ConfessionPage(model: vm.model),
            ),
          },
        );
}
