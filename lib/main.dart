import 'package:butter/butter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:trcas_catholic/api/firebase_notifications.dart';
import 'package:trcas_catholic/modules/welcome/actions/notif_received_action.dart';
import 'package:trcas_catholic/service/firebase_service.dart';
import 'app/app.dart';
import 'app/persistor.dart' as p;
import 'firebase_options.dart';
// import 'service/firebase_service.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final firebaseOptions = await DefaultFirebaseOptions().init();
  await Firebase.initializeApp(
    options: firebaseOptions.currentPlatform,
  );

  final persistor = p.Persistor('mycatholicsg');
  AppState? initialState = await persistor.readState();
  if (initialState == null) {
    initialState = AppState(data: <String, dynamic>{});
    await persistor.saveInitialState(initialState);
  }

  final store = Store<AppState>(
    initialState: initialState,
    persistor: persistor,
  );
  NavigateAction.setNavigatorKey(navigatorKey);

  await FirebaseNotifications().initNotifications(store);
  // store.dispatch(NotifReceivedAction());
  // await FirebaseService.initialize(store);
  // // Push Notification
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     Butter.d('User granted permission');
  //   } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  //     Butter.d('User granted provisional permission');
  //   } else {
  //     Butter.d('User declined or has not accepted permission');
  //   }

  // final token = await FirebaseMessaging.instance.getToken();

  // Butter.d('***********My token is $token');
  //   // saveToken(token!);

  //   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //       alert: true, badge: true, sound: true);

  //   FirebaseMessaging.instance.getInitialMessage().then(_handleMessage);

  //   FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  //   // FirebaseMessaging.onMessage.listen(_handleMessage);

  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Firebase crashlytics
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  run(store, navigatorKey);
}

// void _handleMessage(RemoteMessage? message) {
//   if (message == null) return;

//   String? title = message.notification!.title;
//   String? body = message.notification!.body;

//   Butter.d('**************$title');
//   Butter.d('**************$body');
//   // navigatorKey.currentState?.pushNamed(NotificationPage.route,
//   //     arguments: {'title': title, 'body': body});
//   // navigatorKey.currentState?.pushNamed('/_/notification', arguments: 'notif');
//   // NavigateAction.pushNamed('/_/notification');

//   // FirebaseService._store.dispatch(NotifReceivedAction());
// }

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();

//   Butter.d('Handling a background message ${message.messageId}');
//   // final navigatorKey = GlobalKey<NavigatorState>();
//   // navigatorKey.currentState
//   //     ?.pushNamed('/_/notification', arguments: 'notification');
//   // NavigateAction.pushNamed('/_/notification', arguments: {});
// }

void run(Store<AppState> store, GlobalKey<NavigatorState> navigatorKey) =>
    runApp(StoreProvider<AppState>(
      store: store,
      child: App(navigatorKey: navigatorKey),
    ));
