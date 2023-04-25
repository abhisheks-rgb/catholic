import 'dart:async';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../models/home_model.dart';
import '../../pray/models/pray_model.dart';
import '../../scripture/models/scripture_model.dart';
import '../../info/models/info_model.dart';

class InitializeQoutes extends BaseAction {
  InitializeQoutes();

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('InitializeQoutes::reduce');

    final todayIsResult =
        await FirebaseFunctions.instanceFor(region: 'asia-east2')
            .httpsCallable('todayis')
            .call({});

    final qouteResult =
        await FirebaseFunctions.instanceFor(region: 'asia-east2')
            .httpsCallable('quote')
            .call({});

    final infoQoute =
        qouteResult.data['results']['items'].firstWhere((element) {
      return element['type'] == 'info';
    });

    Butter.d('InitializeQoutes::reduce::done');

    await dispatchModel<PrayModel>(PrayModel(), (m) {
      m.isToday = todayIsResult.data['results']['items'][0];
    });

    await dispatchModel<ScriptureModel>(ScriptureModel(), (m) {
      m.isToday = todayIsResult.data['results']['items'][0];
    });

    await dispatchModel<InfoModel>(InfoModel(), (m) {
      m.qouteInfo = infoQoute;
    });

    return write<HomeModel>(HomeModel(), (m) {
      m.loading = false;
      m.initialized = true;
    });
  }
}
