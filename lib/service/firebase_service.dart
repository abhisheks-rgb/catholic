import 'package:butter/butter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:trcas_catholic/modules/welcome/actions/notif_received_action.dart';

class FirebaseService {
  static late final Store<AppState> _store;

  static Future<void> initialize(Store<AppState> store) async {
    FirebaseService._store = store;

    // Push Notification
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
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

    final token = await FirebaseMessaging.instance.getToken();

    Butter.d('My token is $token');
    // saveToken(token!);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    final msg = await FirebaseMessaging.instance.getInitialMessage();
    FirebaseService._handleMessage(msg);

    FirebaseMessaging.onMessageOpenedApp.listen(FirebaseService._handleMessage);
    FirebaseMessaging.onMessage.listen(FirebaseService._handleMessage);

    FirebaseMessaging.onBackgroundMessage(
        FirebaseService._firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();

    Butter.d('Handling a background message ${message.messageId}');
    // final navigatorKey = GlobalKey<NavigatorState>();
    // navigatorKey.currentState
    //     ?.pushNamed('/_/notification', arguments: 'notification');
    // NavigateAction.pushNamed('/_/notification', arguments: {});
  }

  static void _handleMessage(RemoteMessage? message) {
    if (message == null) return;

    String? title = message.notification!.title;
    String? body = message.notification!.body;

    Butter.d('**************$title');
    Butter.d('**************$body');
    // navigatorKey.currentState?.pushNamed(NotificationPage.route,
    //     arguments: {'title': title, 'body': body});
    // navigatorKey.currentState?.pushNamed('/_/notification', arguments: 'notif');
    // NavigateAction.pushNamed('/_/notification');

    FirebaseService._store.dispatch(NotifReceivedAction(null, true));
  }
}
