import 'dart:async';

import 'package:butter/butter.dart';

import '../models/welcome_model.dart';
import 'show_page_action.dart';

class ShowNotifsAction extends BaseAction {
  ShowNotifsAction();

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('ShowNotifsAction::reduce');

    await dispatchModel<WelcomeModel>(
        WelcomeModel(), (m) => m.hasNotif = false);

    await dispatchAction(ShowPageAction('/_/notification'));

    return null;
  }
}
