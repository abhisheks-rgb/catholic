import 'dart:async';

import 'package:butter/butter.dart';

import '../models/welcome_model.dart';

class NotifReceivedAction extends BaseAction {
  final Object? notificationObject;
  final bool hasNotif;
  NotifReceivedAction(this.notificationObject, this.hasNotif);

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('NotifReceivedAction::reduce');
    // WelcomeModel model = read<WelcomeModel>(WelcomeModel());
    // Butter.d('WelcomeModel: ${model.notificationObject}');
    // Butter.d('WelcomeModel: ${model.hasNotif}');

    // //make sure we don't overlap notifications
    // //1. if model.notificationObject is null, then we can write
    // if (model.notificationObject == null) {
    //   Butter.d('*******Empty model.notificationObject*******');
    //   return write<WelcomeModel>(WelcomeModel(), (m) {
    //     m.hasNotif = hasNotif;
    //     //put object here
    //     m.notificationObject = notificationObject;
    //     //show dialog indicator
    //     m.dialogCount = 1;
    //   });
    // }
    // //2. if model.notificationObject is not null, and notificationObject is null, then we set m.notificationObject to null
    // if (model.notificationObject != null && notificationObject == null) {
    //   Butter.d(
    //       '******* model.notificationObject != null && notificationObject == null *******');
    //   return write<WelcomeModel>(WelcomeModel(), (m) {
    //     m.hasNotif = hasNotif;
    //     //put object here
    //     m.notificationObject = null;
    //     //show dialog indicator
    //     m.dialogCount = 0;
    //   });
    // }
    // return null;
    return write<WelcomeModel>(WelcomeModel(), (m) {
      m.hasNotif = hasNotif;
      //put object here
      m.notificationObject = notificationObject;
      //show dialog indicator
    });
  }
}
