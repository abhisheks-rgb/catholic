import 'package:butter/butter.dart';

import 'devotion/devotion.dart' as d;
import 'divine_mercy_prayer/divine_mercy_prayer.dart' as dmp;
import 'rosary/rosary.dart' as r;

class Devotion extends BaseModule {
  Devotion()
      : super(
          routeName: '/devotion',
          routes: {
            // This is the root route of the module ('/').
            '/_/devotion/main': d.Devotion(),
            '/_/devotion/rosary': r.Rosary(),
            '/_/devotion/divine_mercy_prayer': dmp.DivineMercyPrayer(),
          },
        );
}
