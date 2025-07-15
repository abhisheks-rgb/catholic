import 'dart:async';

import 'package:butter/butter.dart';

import '../models/scripture_history_model.dart';

class ViewScriptureHistoryAction extends BaseAction {
  final String authorname;
  final String shortname;
  final List<Object?> data;

  ViewScriptureHistoryAction(this.authorname, this.shortname, this.data);

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    String? error;

    await dispatchModel<ScriptureHistoryModel>(ScriptureHistoryModel(), (m) {
      m.error = error;
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

    await dispatchModel<ScriptureHistoryModel>(ScriptureHistoryModel(), (m) {
      m.error = error;
      m.items = records;
      m.authorName = authorname;
      m.shortName = shortname;
    });

    pushNamed('/_/scripture/history');

    return null;
  }
}
