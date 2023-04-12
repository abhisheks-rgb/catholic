import 'dart:async';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../models/scripture_model.dart';

class ListReflectionAction extends BaseAction {
  final String? quantity;

  ListReflectionAction({
    this.quantity,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    String? error;
    await dispatchModel<ScriptureModel>(ScriptureModel(), (m) {
      m.error = error;
      m.loading = true;
    });

    List<Object> records = [];

    try {
      final instance = await FirebaseFunctions.instanceFor(region: 'asia-east2')
          .httpsCallable('reflection')
          .call(
        {
          'type': quantity ?? 'all',
        },
      );

      List<Object?> result = instance.data['results']['items'];

      records = result.map((e) {
        return e as Object;
      }).toList();
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
      error = 'Unexpected error';
    }

    await dispatchModel<ScriptureModel>(ScriptureModel(), (m) {
      m.error = error;
      m.loading = false;
      m.items = records;
    });

    return null;
  }
}
