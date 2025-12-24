import 'package:butter/butter.dart';
import 'pages/discover_page.dart';
import 'states/discover_state.dart';

class Discover extends BaseModule {
  Discover()
      : super(
          routeName: '/_/discover',
          routes: {
            '/': BasePageConnector<DiscoverState, DiscoverPage>(
              state: DiscoverState(),
              page: DiscoverPage(),
              getPage: (vm) => DiscoverPage(model: vm.model),
            ),
          },
        );
}