import 'package:butter/butter.dart';

import 'pages/welcome_page.dart';
import 'states/welcome_state.dart';

class Welcome extends BaseModule {
  Welcome()
      : super(
          routeName: '/welcome',
          routes: {
            // This is the root route of the module ('/').
            '/': BasePageConnector<WelcomeState, WelcomePage>(
              state: WelcomeState(),
              page: WelcomePage(),
              getPage: (vm) => WelcomePage(model: vm.model),
            ),
          },
        );
}
