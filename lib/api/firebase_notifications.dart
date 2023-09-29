import 'package:butter/butter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotifications {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    try {
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        Butter.d('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        Butter.d('User granted provisional permission');
      } else {
        Butter.d('User declined or has not accepted permission');
      }
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
    }

    final token = await _firebaseMessaging.getToken();

    Butter.d('My token is $token');
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    _firebaseMessaging.getInitialMessage().then(_handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  Future<bool> hasUserDeclined() {
    return _firebaseMessaging.getNotificationSettings().then((settings) {
      return settings.authorizationStatus == AuthorizationStatus.denied;
    });
  }
}

void _handleMessage(RemoteMessage? message) {
  if (message == null) return;

  String? title = message.notification!.title;
  String? body = message.notification!.body;

  Butter.d('**************$title');
  Butter.d('**************$body');
  //   // navigatorKey.currentState?.pushNamed(NotificationPage.route,
  //   //     arguments: {'title': title, 'body': body});
  //   // navigatorKey.currentState?.pushNamed('/_/notification', arguments: 'notif');
  //   // NavigateAction.pushNamed('/_/notification');

  //   // FirebaseService._store.dispatch(NotifReceivedAction());
}
