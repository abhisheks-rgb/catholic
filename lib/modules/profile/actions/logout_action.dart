import 'dart:async';

import 'package:butter/butter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/profile_model.dart';
import '../../home/models/home_model.dart';
import '../../login/models/login_model.dart';

class LogoutAction extends BaseAction {
  LogoutAction();

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    String? error;
    await dispatchModel<ProfileModel>(ProfileModel(), (m) {
      m.error = error;
      m.loading = true;
    });

    User? user;

    await dispatchModel<HomeModel>(HomeModel(), (m) {
      m.user = user;
    });

    await dispatchModel<LoginModel>(LoginModel(), (m) {
      m.isLoggedIn = false;
    });

    await Future.delayed(const Duration(seconds: 2), () async {
      pushNamed('/_/login');
      
      await Future.delayed(const Duration(seconds: 1), () async {
        await dispatchModel<ProfileModel>(ProfileModel(), (m) {
          m.error = error;
          m.loading = false;
          m.user = user;
        });
      });
    });

    return null;
  }
}