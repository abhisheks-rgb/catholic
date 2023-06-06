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
      final FirebaseAuth auth = FirebaseAuth.instance;

      var authenticatedUser = await auth.signInWithEmailAndPassword(
          email: email!.trim(), password: password!.trim());

      if (authenticatedUser.user!.emailVerified) {
        User? currentUser = auth.currentUser;
        if (currentUser != null) {
          await FirebaseFirestore.instance
              .doc('users/${currentUser.uid}')
              .get()
              .then((value) {
            user = value.data();
            isLoggedIn = true;

            if (user != null) {
              for (var e in items) {
                if (e['_id'] == int.parse(user!['parish'])) {
                  user!['churchName'] = e['name'];
                  user!['churchLink'] = e['link'];
                  user!['churchId'] = e['_id'] - 1;
                }
              }
            } else {
              error = 'incomplete';
              isLoggedIn = false;
            }
          }).onError((e, stacktrace) {
            Butter.e(e.toString());
            Butter.e(stacktrace.toString());
            error = 'verify';
            isLoggedIn = false;
          });
        }
      } else {
        error = 'verify';
        isLoggedIn = false;
      }
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
      switch (error) {
        case 'verify':
          await FirebaseAuth.instance.signOut();
          await dispatchModel<LoginModel>(LoginModel(), (m) {
            m.error =
                'To continue with the login process, please verify your account.';
            m.loading = false;
          });
          break;
        case 'incomplete':
          await FirebaseAuth.instance.signOut();
          await dispatchModel<LoginModel>(LoginModel(), (m) {
            m.error =
                'Your account is incomplete, please continue registration at https://mycatholic.sg/login';
            m.loading = false;
          });
          break;
        default:
          await dispatchModel<LoginModel>(LoginModel(), (m) {
            m.error = 'Incorrect email/password';
            m.loading = false;
          });
      }
    }

    return null;
  }
}
