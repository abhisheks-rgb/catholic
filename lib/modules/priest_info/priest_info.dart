import 'package:butter/butter.dart';

import 'pages/priest_info_page.dart';
import 'states/priest_info_state.dart';

class PriestInfo extends BaseModule {

  PriestInfo() : super(
    routeName: '/priest_info',
    routes: {
      // This is the root route of the module ('/').
      '/': BasePageConnector<PriestInfoState, PriestInfoPage>(
        state: PriestInfoState(),
        page: PriestInfoPage(), 
        getPage: (vm) => PriestInfoPage(model: vm.model),
      ), 
    },
  );
}
