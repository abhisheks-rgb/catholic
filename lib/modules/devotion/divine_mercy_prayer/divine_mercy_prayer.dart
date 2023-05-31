import 'package:butter/butter.dart';

import 'pages/divine_mercy_prayer_page.dart';
import 'states/divine_mercy_prayer_state.dart';

class DivineMercyPrayer extends BaseModule {
  DivineMercyPrayer()
      : super(
          routeName: '/divine_mercy_prayer',
          routes: {
            // This is the root route of the module ('/').
            '/': BasePageConnector<DivineMercyPrayerState,
                DivineMercyPrayerPage>(
              state: DivineMercyPrayerState(),
              page: DivineMercyPrayerPage(),
              getPage: (vm) => DivineMercyPrayerPage(model: vm.model),
            ),
          },
        );
}
