import 'package:butter/butter.dart';

import 'pages/events_page.dart';
import 'states/events_state.dart';

class Events extends BaseModule {
  Events()
      : super(
          routeName: '/events',
          routes: {
            // This is the root route of the module ('/').
            '/': BasePageConnector<EventsState, EventsPage>(
              state: EventsState(),
              page: EventsPage(),
              getPage: (vm) => EventsPage(model: vm.model),
            ),
          },
        );
}
