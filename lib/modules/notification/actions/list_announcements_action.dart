import 'dart:async';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:trcas_catholic/api/firebase_notifications.dart';

import '../models/notification_model.dart';
import '../../home/models/home_model.dart';

class ListAnnouncementsAction extends BaseAction {
  final int? orgId;

  ListAnnouncementsAction({
    this.orgId,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    String? error;
    int? churchId;
    Map<String, dynamic>? user;
    await dispatchModel<NotificationModel>(NotificationModel(), (m) {
      m.error = error;
      m.loading = true;
    });

    await dispatchModel<HomeModel>(HomeModel(), (m) {
      user = m.user;
    });

    if (user != null) {
      churchId = user!['churchId'] + 1;
    }

    List<Object> records = [];

    var call = {};

    if (orgId != null) {
      call = {
        'org': '$orgId',
      };
    } else if (churchId != null && churchId > 0) {
      call = {
        'org': '$churchId',
      };
    }

    try {
      final instance = await FirebaseFunctions.instanceFor(region: 'asia-east2')
          .httpsCallable('announcements')
          .call(call);

      List<Object?> result = instance.data['results']['items'];

      records = result.map((e) {
        return e as Object;
      }).toList();
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
      error = 'Unexpected error';
    }
    //check if user has declined notification
    bool showNotifications = await FirebaseNotifications().hasUserDeclined();
    await dispatchModel<NotificationModel>(NotificationModel(), (m) {
      m.error = error;
      m.loading = false;
      m.items = records;
      m.showNotification = showNotifications;
    });

    return null;
  }
}
