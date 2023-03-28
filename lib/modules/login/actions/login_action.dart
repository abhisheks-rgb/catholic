import 'dart:async';

import 'package:butter/butter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/login_model.dart';
import '../../home/models/home_model.dart';

class LoginAction extends BaseAction {
  final String? email;
  final String? password;

  LoginAction({
    this.email,
    this.password,
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

    User? user;
    bool? isLoggedIn = false;

    try {
      await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!.trim(), password: password!.trim());

      user = FirebaseAuth.instance.currentUser;
      isLoggedIn = true;
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
      error = e.toString();
      isLoggedIn = false;
    }

    await dispatchModel<HomeModel>(HomeModel(), (m) {
      m.user = user;
    });

    await Future.delayed(const Duration(seconds: 1), () async {
      if (isLoggedIn == true) {
        await Future.delayed(const Duration(seconds: 1), () async {
          await dispatchModel<LoginModel>(LoginModel(), (m) {
            m.error = error;
            m.loading = false;
            m.isLoggedIn = true;
          });
        });

        pushNamed('/_/welcome');
      } else {
        await Future.delayed(const Duration(seconds: 1), () async {
          await dispatchModel<LoginModel>(LoginModel(), (m) {
            m.error = error;
            m.loading = false;
          });
        });
      }
    });

    return null;
  }
}
