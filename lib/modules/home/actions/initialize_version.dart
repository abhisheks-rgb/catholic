import 'dart:async';
import 'dart:convert';
import 'package:butter/butter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:new_version_plus/new_version_plus.dart';

import '../../welcome/models/welcome_model.dart';

class InitializeVersion extends BaseAction {
  InitializeVersion();

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('InitializeVersion::reduce');
    final newVersionPlus = NewVersionPlus(
        androidId: 'com.CSG.CatholicSG',
        iOSId: 'com.CSG.CatholicSG',
        iOSAppStoreCountry: 'SG',
        androidPlayStoreCountry: 'SG');
    final status = await newVersionPlus.getVersionStatus();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('version')
        .doc('app')
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      final data = documentSnapshot.data() as Map<String, dynamic>;

      Butter.d('InitializeVersion::reduce::done');
      final dbVersion = {'ios': data['ios'], 'android': data['android']};

      final response = await rootBundle.loadString('assets/version.json');
      final config = await json.decode(response);
      Butter.d(config['ios']);
      Butter.d(config['android']);

      final appVersion = {'ios': config['ios'], 'android': config['android']};

      await dispatchModel<WelcomeModel>(WelcomeModel(), (m) {
        m.appVersion = appVersion;
        m.dbVersion = dbVersion;
        m.versionPlus = status;
      });
    });

    return null;
  }
}
