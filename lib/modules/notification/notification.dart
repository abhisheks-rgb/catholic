import 'package:butter/butter.dart';

import 'pages/notification_page.dart';
import 'states/notification_state.dart';

class Notification extends BaseModule {
  Notification()
      : super(
          routeName: '/notification',
          routes: {
            // This is the root route of the module ('/').
            '/': BasePageConnector<NotificationState, NotificationPage>(
              state: NotificationState(),
              page: NotificationPage(),
              getPage: (vm) => NotificationPage(model: vm.model),
            ),
          },
        );
}
