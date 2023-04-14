import 'dart:async';

import 'package:butter/butter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

    Map<String, dynamic>? user;
    bool? isLoggedIn = false;

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email!.trim(), password: password!.trim())
          .then((value) async {
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          await FirebaseFirestore.instance
              .doc('users/${currentUser.uid}')
              .get()
              .then((value) {
            user = value.data();
            isLoggedIn = true;
          }).onError((error, stackTrace) {
            Butter.e(error.toString());
            Butter.e(stackTrace.toString());
            error = error.toString();
            isLoggedIn = false;
          });
        }
      }).onError((error, stackTrace) {
        Butter.e(error.toString());
        Butter.e(stackTrace.toString());
        error = error.toString();
        isLoggedIn = false;
      });
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
      error = e.toString();
      isLoggedIn = false;
    }

    if (isLoggedIn == true) {
      await dispatchModel<HomeModel>(HomeModel(), (m) {
        m.user = user;
      });

      await dispatchModel<LoginModel>(LoginModel(), (m) {
        m.error = error;
        m.loading = false;
        m.isLoggedIn = isLoggedIn!;
      });

      pushNamed('/_/welcome');
    } else {
      await dispatchModel<LoginModel>(LoginModel(), (m) {
        m.error = 'Incorrect email/password';
        m.loading = false;
      });
    }

    return null;
  }
}
