import 'package:butter/butter.dart';

import 'pages/info_page.dart';
import 'states/info_state.dart';

class Info extends BaseModule {

  Info() : super(
    routeName: '/info',
    routes: {
      // This is the root route of the module ('/').
      '/': BasePageConnector<InfoState, InfoPage>(
        state: InfoState(),
        page: InfoPage(), 
        getPage: (vm) => InfoPage(model: vm.model),
      ), 
    },
  );
}
