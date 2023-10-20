import 'package:butter/butter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trcas_catholic/main.dart';
import 'package:trcas_catholic/service/package_info_service.dart';

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
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    //save token here
    if (FirebaseAuth.instance.currentUser != null) {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      //subscribe to topic here
      //get user
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);
      final userDocSnapshot = await userDoc.get();
      final userParish = userDocSnapshot.data()?['parish'];
      final channel = userDocSnapshot.data()?['channel'];
      Butter.d('Channel: $channel');
      if (channel == null) {
        await _firebaseMessaging.subscribeToTopic(userParish.toString());
      } else {
        //check if channel is the same as the user's parish, if not, unsub and sub to the new parish
        if (channel != userParish.toString()) {
          await _firebaseMessaging.unsubscribeFromTopic(channel);
        }
        await _firebaseMessaging.subscribeToTopic(userParish.toString());
      }
      //also let's store the version of the app this user is using
      final packageDetails = await PackageInfoService.getPackageDetails();
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'tokens': FieldValue.arrayUnion([token]),
        'appversion': packageDetails.version,
        'channel': userParish.toString()
      });
    }
  }

  Future<bool> hasUserDeclined() {
    return _firebaseMessaging.getNotificationSettings().then((settings) {
      return settings.authorizationStatus == AuthorizationStatus.denied;
    });
  }
}

/*
When using Flutter version 3.3.0 or higher, 
the message handler must be annotated with @pragma('vm:entry-point') right above the function declaration 
(otherwise it may be removed during tree shaking for release mode).
See: https://firebase.google.com/docs/cloud-messaging/flutter/receive
*/
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  Butter.d('Handling a background message ${message.messageId}');
}

void _handleMessage(RemoteMessage? message) {
  if (message == null) return;

  String? title = message.notification!.title;
  String? body = message.notification!.body;

  Butter.d('**************$title');
  Butter.d('**************$body');
  navigatorKey.currentState
      ?.pushNamed('/_/notification', arguments: 'notification');
  // NavigateAction.pushNamed('/_/notification', arguments: {});
  //   // navigatorKey.currentState?.pushNamed(NotificationPage.route,
  //   //     arguments: {'title': title, 'body': body});
  //   // navigatorKey.currentState?.pushNamed('/_/notification', arguments: 'notif');
  //   // NavigateAction.pushNamed('/_/notification');

  //   // FirebaseService._store.dispatch(NotifReceivedAction());
}
