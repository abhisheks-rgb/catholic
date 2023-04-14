import 'dart:async';
import 'dart:convert';

import 'package:butter/butter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../config/app_config.dart';
import 'select_menu_item_action.dart';
import '../models/home_model.dart';

class InitializeAction extends BaseAction {
  final BuildContext context;
  final Map<String, dynamic>? params;

  InitializeAction({
    required this.context,
    this.params,
  });

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
      // ignore: use_build_context_synchronously
      await dispatchAction(SelectMenuItemAction(
        allowSameId: false,
        context: context,
        replaceCurrent: true,
        route: AppConfig.initRoute,
      ));

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
                user!['churchId'] = e['_id'];
                user!['churchName'] = e['name'];
              }
            }

            Butter.d('InitializeAction::reduce::is_logged_in');
          }).onError((error, stackTrace) {
            Butter.e(error.toString());
            Butter.e(stackTrace.toString());
            error = error.toString();
          });
        } else {
          Butter.d('InitializeAction::reduce::not_logged_in');
        }
      } else {
        Butter.d('InitializeAction::reduce::not_logged_in');
      }
    } catch (e) {
      Butter.e(e.toString());
      throw 'Unable to load resources properly!';
    }

    Butter.d('InitializeAction::reduce::done');
    return write<HomeModel>(HomeModel(), (m) {
      m.error = error;
      m.loading = false;
      m.initialized = true;
      m.user = user;
    });
  }
}
