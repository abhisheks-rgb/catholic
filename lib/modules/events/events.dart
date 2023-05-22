import 'package:butter/butter.dart';

import 'pages/events_page.dart';
import 'pages/events_list_page.dart';
import 'pages/event_details_page.dart';
import 'pages/event_register_page.dart';
import 'pages/my_event_page.dart';
import 'states/events_state.dart';
import 'states/events_list_state.dart';
import 'states/event_details_state.dart';
import 'states/event_register_state.dart';
import 'states/my_event_state.dart';

class Events extends BaseModule {
  Events()
      : super(
          routeName: '/events',
          routes: {
            // This is the root route of the module ('/').
            '/_/events': BasePageConnector<EventsState, EventsPage>(
              state: EventsState(),
              page: EventsPage(),
              getPage: (vm) => EventsPage(model: vm.model),
            ),
            '/_/events/list':
                BasePageConnector<EventsListState, EventsListPage>(
              state: EventsListState(),
              page: EventsListPage(),
              getPage: (vm) => EventsListPage(model: vm.model),
            ),
            '/_/events/myEvents': BasePageConnector<MyEventState, MyEventPage>(
              state: MyEventState(),
              page: MyEventPage(),
              getPage: (vm) => MyEventPage(model: vm.model),
            ),
            '/_/events/details':
                BasePageConnector<EventDetailsState, EventDetailsPage>(
              state: EventDetailsState(),
              page: EventDetailsPage(),
              getPage: (vm) => EventDetailsPage(model: vm.model),
            ),
            '/_/events/register':
                BasePageConnector<EventRegisterState, EventRegisterPage>(
              state: EventRegisterState(),
              page: EventRegisterPage(),
              getPage: (vm) => EventRegisterPage(model: vm.model),
            ),
          },
        );
}
