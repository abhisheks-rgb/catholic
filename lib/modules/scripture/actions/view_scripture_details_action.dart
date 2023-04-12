import 'dart:async';

import 'package:butter/butter.dart';

import '../models/scripture_details_model.dart';

class ViewScriptureDetailsAction extends BaseAction {
  final Map<Object?, Object?>? scripture;

  ViewScriptureDetailsAction(this.scripture);

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    String? error;

    await dispatchModel<ScriptureDetailsModel>(ScriptureDetailsModel(), (m) {
      m.error = error;
      m.item = scripture;
    });

    pushNamed('/_/scripture/details');

    return null;
  }
}
