import 'package:butter/butter.dart';

import 'pages/notification_page.dart';
import 'pages/notification_details_page.dart';
import 'states/notification_state.dart';
import 'states/notification_details_state.dart';

class Notification extends BaseModule {
  Notification()
      : super(
          routeName: '/notification',
          routes: {
            // This is the root route of the module ('/').
            '/_/notification':
                BasePageConnector<NotificationState, NotificationPage>(
              state: NotificationState(),
              page: NotificationPage(),
              getPage: (vm) => NotificationPage(model: vm.model),
            ),
            '/_/notification/details': BasePageConnector<
                NotificationDetailsState, NotificationDetailsPage>(
              state: NotificationDetailsState(),
              page: NotificationDetailsPage(),
              getPage: (vm) => NotificationDetailsPage(model: vm.model),
            ),
          },
        );
}
