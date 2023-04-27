import 'dart:async';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../models/welcome_model.dart';
import '../../info/models/info_model.dart';

class InitializeQoutes extends BaseAction {
  InitializeQoutes();

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('InitializeQoutes::reduce');

    final qouteResult =
        await FirebaseFunctions.instanceFor(region: 'asia-east2')
            .httpsCallable('quote')
            .call({});

    final infoQoute =
        qouteResult.data['results']['items'].firstWhere((element) {
      return element['type'] == 'info';
    });

    Butter.d('InitializeQoutes::reduce::done');

    await dispatchModel<InfoModel>(InfoModel(), (m) {
      m.qouteInfo = infoQoute;
    });

    return write<WelcomeModel>(WelcomeModel(), (m) {
      m.loading = false;
    });
  }
}
