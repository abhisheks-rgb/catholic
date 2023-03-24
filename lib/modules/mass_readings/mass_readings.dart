import 'package:butter/butter.dart';

import 'pages/mass_readings_page.dart';
import 'states/mass_readings_state.dart';

class MassReadings extends BaseModule {

  MassReadings() : super(
    routeName: '/mass_readings',
    routes: {
      // This is the root route of the module ('/').
      '/': BasePageConnector<MassReadingsState, MassReadingsPage>(
        state: MassReadingsState(),
        page: MassReadingsPage(), 
        getPage: (vm) => MassReadingsPage(model: vm.model),
      ), 
    },
  );
}
