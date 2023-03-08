import 'package:butter/butter.dart';

import 'pages/church_info_page.dart';
import 'states/church_info_state.dart';

class ChurchInfo extends BaseModule {

  ChurchInfo() : super(
    routeName: '/church_info',
    routes: {
      // This is the root route of the module ('/').
      '/': BasePageConnector<ChurchInfoState, ChurchInfoPage>(
        state: ChurchInfoState(),
        page: ChurchInfoPage(), 
        getPage: (vm) => ChurchInfoPage(model: vm.model),
      ), 
    },
  );
}
