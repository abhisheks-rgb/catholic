import 'dart:async';

import 'package:butter/butter.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../app/app.dart';
import '../../../app/splash_screen.dart';
import '../../../config/app_config.dart';
import '../../../utils/page_specs.dart';
import '../../../utils/asset_path.dart';

import '../models/home_model.dart';
import '../components/events_footer.dart';
import '../components/navbar.dart';

String? mToken = ' ';

class HomePage extends BaseStatefulPageView {
  final HomeModel? model;

  // ignore: use_key_in_widget_constructors
  HomePage({Key? key, this.model}) : super();

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    if (!model!.initialized) {
      await model!.initialize(context);
    }

    final currentTime = DateTime.now();
    if (model!.todayIsLastUpdate?.year != currentTime.year ||
        model!.todayIsLastUpdate?.month != currentTime.month ||
        model!.todayIsLastUpdate?.day != currentTime.day) {
      await model!.initializeTodayIs();
    }

    EasyDebounce.debounce('debounce-rosary', const Duration(milliseconds: 100),
        () {
      requestPermission();
      getToken();
      initInfo();
    });

    return true;
  }

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );

    FlutterLocalNotificationsPlugin().initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse payload) async {
      try {
        if (payload.toString().isNotEmpty) {}
      } catch (e) {
        Butter.d(e);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      Butter.d('.....onMessage.....');
      Butter.d(
          'onMessage: ${message.notification?.title}/${message.notification?.body}');

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );

      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        'trcas',
        'trcas',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
      );

      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidNotificationDetails,
      );

      await FlutterLocalNotificationsPlugin().show(
        0,
        message.notification?.title,
        message.notification?.body,
        platformChannelSpecifics,
        payload: message.data['body'],
      );
    });
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      mToken = token;
      Butter.d('My token is $token');
      // saveToken(token!);
    });
  }

  // void saveToken(String token) async {
  //   await FirebaseFirestore.instance.collection('UserTokens').doc('User1').set({
  //     'token': token,
  //   });
  // }

  void requestPermission() async {
    try {
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
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
    }
  }

  /// Called while waiting for the result of [beforeLoad]
  ///
  /// Returns the [Widget] to render on the page
  @override
  Widget buildLoading(BuildContext context) => build(context);

  @override
  Widget build(BuildContext context, {bool loading = false}) {
    if (!model!.initialized) {
      return const SplashScreen();
    }

    var module = App.getChild(context, model!);
    module ??= App.getChild(context, model!, '/');

    PageSpecs? baseSpecs = module?.page?.specs as PageSpecs?;
    var specs = baseSpecs ?? PageSpecs();

    if (baseSpecs?.builder != null) {
      specs = baseSpecs?.builder!(
            context,
            dispatch: model!.dispatch,
            read: model!.read,
          ) ??
          PageSpecs();
    }

    if (model!.title != null) {
      specs.title = model!.title;
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SafeArea(
        child: Scaffold(
          appBar: specs.hasAppBar! && !model!.isFullScreen
              ? AppBar(
                  elevation: 1.2,
                  centerTitle: true,
                  leading: specs.leadingLogo!
                      ? RawMaterialButton(
                          constraints: const BoxConstraints(),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed('/_/welcome');
                          },
                          child: SizedBox(
                            width: 36,
                            height: 36,
                            child: Image.asset(
                              assetPath('icon-small.png'),
                            ),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Color.fromRGBO(4, 26, 82, 1),
                            size: 24,
                          ),
                          onPressed: () async {
                            final result =
                                await Navigator.of(context).maybePop();
                            if (!result && context.mounted) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context)
                                  .popAndPushNamed('/_/welcome');
                            } else {
                              if (ModalRoute.of(context)!.settings.name ==
                                  '/_/events/details') {
                                Navigator.of(context)
                                    .popAndPushNamed('/_/events/list');
                              }
                            }
                          },
                        ),
                  title: Text(specs.title ?? AppConfig.title),
                  actions: [
                    specs.showNotification!
                        ? RawMaterialButton(
                            constraints: const BoxConstraints(),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              model?.showPage('/_/notification');
                            },
                            child: Container(
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(
                                    Octicons.bell_fill,
                                    color: Color.fromRGBO(4, 26, 82, 0.2),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    specs.showProfile!
                        ? RawMaterialButton(
                            constraints: const BoxConstraints(),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              model?.showPage('/_/profile');
                            },
                            child: Container(
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    assetPath('user-active-solid.png'),
                                    color: const Color.fromRGBO(4, 26, 82, 0.2),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    specs.showFontSetting!
                        ? RawMaterialButton(
                            constraints: const BoxConstraints(),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () async {
                              model?.setPageFontSize!();
                            },
                            child: Container(
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    assetPath('font-size.png'),
                                    color: const Color.fromRGBO(4, 26, 82, 1),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    specs.showInfo!
                        ? RawMaterialButton(
                            constraints: const BoxConstraints(),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () async {
                              model?.setShowInfo!(
                                  ModalRoute.of(context)!.settings.name!);
                            },
                            child: Container(
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    assetPath('info.png'),
                                    color: const Color.fromRGBO(4, 26, 82, 1),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    // ...?specs.actions,
                  ],
                )
              : PreferredSize(
                  preferredSize: const Size(0.0, 0.0),
                  child: Container(),
                ),
          body: Container(child: module),
          bottomNavigationBar: SizedBox(
            height: model!.isFullScreen ? 0 : 82,
            child: model!.isFullScreen
                ? Container(
                    width: MediaQuery.of(context).size.width,
                  )
                : ModalRoute.of(context)!.settings.name ==
                            '/_/events/details' ||
                        ModalRoute.of(context)!.settings.name ==
                            '/_/events/register'
                    ? EventDetailsFooter(
                        model: model,
                      )
                    : Navbar(
                        model: model,
                      ),
          ),
        ),
      ),
    );
  }
}
