import 'package:butter/butter.dart';

import 'pages/offertory_page.dart';
import 'states/offertory_state.dart';

class Offertory extends BaseModule {

  Offertory() : super(
    routeName: '/offertory',
    routes: {
      // This is the root route of the module ('/').
      '/': BasePageConnector<OffertoryState, OffertoryPage>(
        state: OffertoryState(),
        page: OffertoryPage(), 
        getPage: (vm) => OffertoryPage(model: vm.model),
      ), 
    },
  );
}
