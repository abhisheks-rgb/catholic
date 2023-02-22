import 'package:butter/butter.dart';

import 'pages/schedules_page.dart';
import 'states/schedules_state.dart';

class Schedules extends BaseModule {

  Schedules() : super(
    routeName: '/schedules',
    routes: {
      // This is the root route of the module ('/').
      '/': BasePageConnector<SchedulesState, SchedulesPage>(
        state: SchedulesState(),
        page: SchedulesPage(), 
        getPage: (vm) => SchedulesPage(model: vm.model),
      ), 
    },
  );
}
