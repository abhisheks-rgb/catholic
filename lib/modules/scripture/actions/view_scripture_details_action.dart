import 'dart:async';

import 'package:butter/butter.dart';

import '../models/scripture_details_model.dart';
import '../models/scripture_history_model.dart';
import '../models/scripture_model.dart';

class ViewScriptureDetailsAction extends BaseAction {
  final Map<Object?, Object?>? scripture;

  ViewScriptureDetailsAction(this.scripture);

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

    await dispatchModel<ScriptureDetailsModel>(ScriptureDetailsModel(), (m) {
      m.error = error;
      m.loading = true;
    });
    
    await Future.delayed(const Duration(seconds: 1), () async {
      pushNamed('/_/scripture/details');

      await Future.delayed(const Duration(seconds: 1), () async {
        await dispatchModel<ScriptureModel>(ScriptureModel(), (m) {
          m.error = error;
          m.loading = false;
        });
      });

      await Future.delayed(const Duration(seconds: 1), () async {
        await dispatchModel<ScriptureHistoryModel>(ScriptureHistoryModel(), (m) {
          m.error = error;
          m.loading = false;
        });
      });
    });

    await Future.delayed(const Duration(seconds: 2), () async {
      await dispatchModel<ScriptureDetailsModel>(
          ScriptureDetailsModel(), (m) {
        m.error = error;
        m.loading = false;
        m.item = scripture;
      });
    });

    return null;
  }
}
