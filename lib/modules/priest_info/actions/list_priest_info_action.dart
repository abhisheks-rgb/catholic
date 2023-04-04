import 'dart:async';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../models/priest_info_model.dart';

class ListPriestInfoAction extends BaseAction {
  final String? name;

  ListPriestInfoAction({
    this.name,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    String? error;
    await dispatchModel<PriestInfoModel>(
        PriestInfoModel(), (m) {
      m.error = error;
      m.loading = true;
    });

    List<Object> records = [];
    
    try {
      final instance = await FirebaseFunctions
        .instanceFor(region: 'asia-east2')
        .httpsCallable('priest')
        .call(
        {
          "type": 'all',
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

    await Future.delayed(const Duration(seconds: 1), () async {
      await dispatchModel<PriestInfoModel>(
          PriestInfoModel(), (m) {
        m.error = error;
        m.loading = false;
        m.priests = records;
      });
    });

    return null;
  }
}
