import 'dart:async';

import 'package:butter/butter.dart';

import '../models/scripture_history_model.dart';
import '../models/scripture_model.dart';

class ViewScriptureHistoryAction extends BaseAction {
  final String authorname;
  final List<Object?> data;

  ViewScriptureHistoryAction(
    this.authorname,
    this.data
  );

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    String? error;
    await dispatchModel<ScriptureModel>(ScriptureModel(), (m) {
      m.error = error;
      m.loading = true;
    });

    await dispatchModel<ScriptureHistoryModel>(ScriptureHistoryModel(), (m) {
      m.error = error;
      m.loading = true;
    });

    List<Object> records = [];
    
    try {
      records = data.map((e) {
        return e as Object;
      }).toList();
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
      error = 'Unexpected error';
    }

    await Future.delayed(const Duration(seconds: 1), () async {
      pushNamed('/_/scripture/history');

      await Future.delayed(const Duration(seconds: 1), () async {
        await dispatchModel<ScriptureModel>(ScriptureModel(), (m) {
          m.error = error;
          m.loading = false;
        });
      });
    });

    await Future.delayed(const Duration(seconds: 2), () async {
      await dispatchModel<ScriptureHistoryModel>(
          ScriptureHistoryModel(), (m) {
        m.error = error;
        m.loading = false;
        m.items = records;
        m.authorName = authorname;
      });
    });

    return null;
  }
}
