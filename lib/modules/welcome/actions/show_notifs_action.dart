import 'dart:async';

import 'package:butter/butter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trcas_catholic/modules/welcome/models/welcome_model.dart';

import 'show_page_action.dart';

class ShowNotifsAction extends BaseAction {
  ShowNotifsAction();

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('ShowNotifsAction::reduce');
    String notifId = '';
    await dispatchModel<WelcomeModel>(WelcomeModel(), (m) {
      notifId = m.notifId;
    });
    Butter.d('ShowNotifsAction::reduce::notifId:: $notifId');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('announcementId', notifId);

    await dispatchAction(ShowPageAction('/_/notification'));

    return null;
  }
}
