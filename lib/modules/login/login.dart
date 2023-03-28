import 'package:butter/butter.dart';

import 'pages/login_page.dart';
import 'states/login_state.dart';

class Login extends BaseModule {

  Login() : super(
    routeName: '/login',
    routes: {
      // This is the root route of the module ('/').
      '/': BasePageConnector<LoginState, LoginPage>(
        state: LoginState(),
        page: LoginPage(), 
        getPage: (vm) => LoginPage(model: vm.model),
      ), 
    },
  );
}
