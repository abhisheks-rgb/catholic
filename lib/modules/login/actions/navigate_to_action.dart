import 'dart:async';

import 'package:butter/butter.dart';

import '../models/login_model.dart';

class NavigateToAction extends BaseAction {
  final int? churchId;
  final String? route;

  NavigateToAction({
    this.churchId,
    this.route,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    String? error;
    await dispatchModel<LoginModel>(LoginModel(), (m) {
      m.error = error;
      m.loading = true;
    });

    try {
      pushNamed(route!);
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
      error = 'Unexpected error';
    }

    return write<LoginModel>(LoginModel(), (m) {
      m.error = error;
      m.loading = false;
    });
  }
}