import 'package:butter/butter.dart';

import 'pages/pray_page.dart';
import 'states/pray_state.dart';

class Pray extends BaseModule {

  Pray() : super(
    routeName: '/pray',
    routes: {
      // This is the root route of the module ('/').
      '/': BasePageConnector<PrayState, PrayPage>(
        state: PrayState(),
        page: PrayPage(), 
        getPage: (vm) => PrayPage(model: vm.model),
      ), 
    },
  );
}
