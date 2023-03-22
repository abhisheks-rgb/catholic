import 'package:butter/butter.dart';

import 'pages/scripture_page.dart';
import 'pages/scripture_details_page.dart';
import 'pages/scripture_history_page.dart';
import 'states/scripture_state.dart';
import 'states/scripture_details_state.dart';
import 'states/scripture_history_state.dart';

class Scripture extends BaseModule {

  Scripture() : super(
    routeName: '/scripture',
    routes: {
      // This is the root route of the module ('/').
      '/_/scripture': BasePageConnector<ScriptureState, ScripturePage>(
        state: ScriptureState(),
        page: ScripturePage(), 
        getPage: (vm) => ScripturePage(model: vm.model),
      ),
      '/_/scripture/history': BasePageConnector<ScriptureHistoryState, ScriptureHistoryPage>(
        state: ScriptureHistoryState(),
        page: ScriptureHistoryPage(),
        getPage: (vm) => ScriptureHistoryPage(model: vm.model),
      ),
      '/_/scripture/details': BasePageConnector<ScriptureDetailsState, ScriptureDetailsPage>(
        state: ScriptureDetailsState(),
        page: ScriptureDetailsPage(),
        getPage: (vm) => ScriptureDetailsPage(model: vm.model),
      ),
    },
  );
}
