import 'dart:async';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../../scripture/models/scripture_history_model.dart';

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

    await dispatchModel<ScriptureHistoryModel>(ScriptureHistoryModel(), (m) {
      m.error = error;
    });

    List<Object> records = [];
    String authorname = '';

    try {
      final instance = await FirebaseFunctions.instanceFor(region: 'asia-east2')
          .httpsCallable('reflection')
          .call(
        {
          'type': quantity ?? 'archbishopReflection_scripture_reflection',
        },
      );

      var result = instance.data['results']['items'];

      records = result['data'].map<Object>((e) {
        return e as Object;
      }).toList();
      authorname = 'Cardinal ${result['authorname']}';
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
      error = 'Unexpected error';
    }

    await dispatchModel<ScriptureHistoryModel>(ScriptureHistoryModel(), (m) {
      m.loading = false;
      m.error = error;
      m.items = records;
      m.authorName = authorname;
    });

    return null;
  }
}
