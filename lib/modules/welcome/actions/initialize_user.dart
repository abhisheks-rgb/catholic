import 'dart:async';
import 'dart:convert';

import 'package:butter/butter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/welcome_model.dart';
import '../../home/models/home_model.dart';

class InitializeUser extends BaseAction {
  InitializeUser();

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('InitializeAction::reduce');

    String? error;
    Map<String, dynamic>? user;
    await dispatchModel<HomeModel>(HomeModel(), (m) {
      m.error = error;
      m.loading = true;
      user = m.user;
    });

    final String response =
        await rootBundle.loadString('assets/data/parish.json');
    final data = await json.decode(response);
    final items = data['parishes'];

    try {
      if (user == null) {
        User? currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null) {
          await FirebaseFirestore.instance
              .doc('users/${currentUser.uid}')
              .get()
              .then((value) {
            user = value.data();

            for (var e in items) {
              if (e['_id'] == int.parse(user!['parish'])) {
                user!['churchId'] = e['_id'] - 1;
                user!['churchName'] = e['name'];
                user!['churchLink'] = e['link'];
              }
            }

            Butter.d('InitializeAction::reduce::is_logged_in');
          }).onError((error, stackTrace) {
            Butter.e(error.toString());
            Butter.e(stackTrace.toString());
            error = error.toString();
          });
        } else {
          Butter.d('InitializeUser::reduce::not_logged_in');
        }
      } else {
        Butter.d('InitializeUser::reduce::not_logged_in');
      }
    } catch (e) {
      Butter.e(e.toString());
      throw 'Unable to load resources properly!';
    }

    Butter.d('InitializeUser::reduce::done');

    await dispatchModel<HomeModel>(HomeModel(), (m) {
      m.user = user;
      m.error = error;
    });

    return write<WelcomeModel>(WelcomeModel(), (m) {
      m.loading = false;
      m.user = user;
    });
  }
}
