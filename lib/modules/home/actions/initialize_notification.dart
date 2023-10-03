import 'dart:async';
import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home/models/home_model.dart';
import '../../welcome/models/welcome_model.dart';

class InitializeNotification extends BaseAction {
  InitializeNotification();

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    int? churchId;
    int? orgId;
    bool hasNotif = false;
    String notifId = 'default';
    Map<String, dynamic>? user;
    Butter.d('InitializeNotification::reduce');

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
    Butter.d('ChurchId: $churchId');
    try {
      final instance = await FirebaseFunctions.instanceFor(region: 'asia-east2')
          .httpsCallable('announcements')
          .call(call);

      List<Object?> result = instance.data['results']['items'];

      records = result.map((e) {
        return e as Object;
      }).toList();

      // Get the first element of the records list
      Object? firstRecord = records.first;
      Butter.d('First Record: $firstRecord');

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final storedId = prefs.getString('announcementId');
      Butter.d('Stored Id: $storedId');
      final first = (firstRecord as Map<Object?, Object?>)['id'].toString();
      Butter.d('First Id: $first');
      if (storedId != null) {
        if (first == storedId) {
          hasNotif = false;
          notifId = storedId;
        } else {
          hasNotif = true;
          notifId = first.toString();
        }
      } else {
        hasNotif = true;
        notifId = first.toString();
      }
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('announcementId', 'default');
    }

    Butter.d('InitializeNotification::reduce::done');

    await dispatchModel<WelcomeModel>(WelcomeModel(), (m) {
      m.hasNotif = hasNotif;
      m.notifId = notifId;
    });

    return null;
  }
}
