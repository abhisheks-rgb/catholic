import 'dart:async';
import 'dart:convert';

import 'package:butter/butter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/login_model.dart';
import '../../home/models/home_model.dart';
import '../../welcome/models/welcome_model.dart';

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

    final String response =
        await rootBundle.loadString('assets/data/parish.json');
    final data = await json.decode(response);
    final items = data['parishes'];

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

            for (var e in items) {
              if (e['_id'] == int.parse(user!['parish'])) {
                user!['churchId'] = e['_id'] - 1;
                user!['churchName'] = e['name'];
                user!['churchLink'] = e['link'];
              }
            }
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

      await dispatchModel<WelcomeModel>(WelcomeModel(), (m) {
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
