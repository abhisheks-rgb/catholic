import 'package:butter/butter.dart';

import 'pages/profile_page.dart';
import 'states/profile_state.dart';

class Profile extends BaseModule {

  Profile() : super(
    routeName: '/Profile',
    routes: {
      // This is the root route of the module ('/').
      '/': BasePageConnector<ProfileState, ProfilePage>(
        state: ProfileState(),
        page: ProfilePage(), 
        getPage: (vm) => ProfilePage(model: vm.model),
      ), 
    },
  );
}
