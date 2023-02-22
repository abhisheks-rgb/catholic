import 'package:butter/butter.dart';

import '../modules/home/home.dart';
import '../modules/welcome/welcome.dart';
import '../modules/schedules/schedules.dart';

class Routes extends BaseRoutes {
  Routes()
      : super(
          modules: [
            // TODO: Define all top-level modules here
            // ModuleName(), // First defined module gets the root route ('/')

            Home(),
            Welcome(),
            Schedules(),
          ],
        );
}
