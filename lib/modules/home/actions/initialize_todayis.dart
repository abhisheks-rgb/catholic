import 'dart:async';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../models/home_model.dart';
import '../../pray/models/pray_model.dart';
import '../../scripture/models/scripture_model.dart';

class InitializeTodayIs extends BaseAction {
  InitializeTodayIs();

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('InitializeTodayIs::reduce');

    final todayIsResult =
        await FirebaseFunctions.instanceFor(region: 'asia-east2')
            .httpsCallable('todayis')
            .call({});

    Butter.d('InitializeTodayIs::reduce::done');

    await dispatchModel<PrayModel>(PrayModel(), (m) {
      m.isToday = todayIsResult.data['results']['items'][0];
    });

    await dispatchModel<ScriptureModel>(ScriptureModel(), (m) {
      m.isToday = todayIsResult.data['results']['items'][0];
    });

    DateTime latestUpdate = DateTime.now();

    return write<HomeModel>(HomeModel(), (m) {
      m.loading = false;
      m.todayIsLastUpdate = latestUpdate;
    });
  }
}
