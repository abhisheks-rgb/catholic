import 'dart:async';
import 'package:butter/butter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:new_version_plus/new_version_plus.dart';

import '../../welcome/models/welcome_model.dart';

class InitializeObjects extends BaseAction {
  InitializeObjects();

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('InitializeObjects::reduce');

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('objects')
        .doc('app')
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      final data = documentSnapshot.data() as Map<String, dynamic>;

      Butter.d('InitializeObjects::reduce::done');
      final dbOjects = {'objects': data};

      Butter.d(dbOjects);

      await dispatchModel<WelcomeModel>(WelcomeModel(), (m) {
        m.dbOjects = dbOjects;
      });
    });

    return null;
  }
}
