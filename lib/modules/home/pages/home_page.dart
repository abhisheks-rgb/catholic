import 'dart:async';

import 'package:butter/butter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:trcas_catholic/api/firebase_notifications.dart';

import '../../../app/app.dart';
import '../../../app/splash_screen.dart';
import '../../../config/app_config.dart';
import '../../../utils/asset_path.dart';
import '../../../utils/page_specs.dart';
import '../../confession/components/confession_view.dart' as confession;
import '../../devotion/divine_mercy_prayer/components/divine_mercy_prayer_view.dart'
    as divine;
import '../../devotion/rosary/components/rosary_view.dart' as rosary;
import '../components/events_footer.dart';
import '../components/navbar.dart';
import '../models/home_model.dart';

String? mToken = ' ';
// late final ValueNotifier<Object>? objectNotifier;
final objectNotifier = ValueNotifier<Object>({});

class HomePage extends BaseStatefulPageView {
  final HomeModel? model;

  // ignore: use_key_in_widget_constructors
  HomePage({Key? key, this.model}) : super();

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    model!.initializeVersion();
    model!.initializeObjects();
    if (!model!.initialized) {
      await model!.initialize(context);
    }

    final currentTime = DateTime.now();
    if (model!.todayIsLastUpdate?.year != currentTime.year ||
        model!.todayIsLastUpdate?.month != currentTime.month ||
        model!.todayIsLastUpdate?.day != currentTime.day) {
      await model!.initializeTodayIs();
    }

    model!.initializeNotification();
    model!.loadHomeData();
    model!.fetchContinueListening();
    model!.fetchFeaturedSeries();
    // EasyDebounce.debounce('debounce-rosary', const Duration(seconds: 1), () {
    //   requestPermission();
    //   getToken();
    //   initInfo();
    // });
    try {
      await FirebaseNotifications().initNotifications(objectNotifier);
    } catch (e) {
      Butter.e(e);
    }
    // FirebaseMessaging messaging = FirebaseMessaging.instance;

    // NotificationSettings settings = await messaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );

    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   Butter.d('User granted permission');
    // } else if (settings.authorizationStatus ==
    //     AuthorizationStatus.provisional) {
    //   Butter.d('User granted provisional permission');
    // } else {
    //   Butter.d('User declined or has not accepted permission');
    // }

    // final token = await FirebaseMessaging.instance.getToken();

    // Butter.d('My token is $token');
    // saveToken(token!);

    // await FirebaseMessaging.instance
    //     .setForegroundNotificationPresentationOptions(
    //         alert: true, badge: true, sound: true);

    // FirebaseMessaging.instance.getInitialMessage().then(_handleMessage);

    // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    // FirebaseMessaging.onMessage.listen(_handleMessage);
    return true;
  }

  //   void _handleMessage(RemoteMessage? message) {
  //     if (message == null) return;

  //     String? title = message.notification!.title;
  //     String? body = message.notification!.body;

  //     Butter.d('**************$title');
  //     Butter.d('**************$body');
  // //   // navigatorKey.currentState?.pushNamed(NotificationPage.route,
  // //   //     arguments: {'title': title, 'body': body});
  // //   // navigatorKey.currentState?.pushNamed('/_/notification', arguments: 'notif');
  // //   // NavigateAction.pushNamed('/_/notification');

  // //   // FirebaseService._store.dispatch(NotifReceivedAction());
  //   }

  initInfo() {
    var androidInitialize = const AndroidInitializationSettings(
      '@mipmap/mycatholicsg_white.png',
    );
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );

    FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse payload) async {
        try {
          if (payload.toString().isNotEmpty) {}
        } catch (e) {
          Butter.d(e);
        }
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      Butter.d('.....onMessage.....');
      Butter.d(
        'onMessage: ${message.notification?.title}/${message.notification?.body}',
      );

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
      specs =
          baseSpecs?.builder!(
            context,
            dispatch: model!.dispatch,
            read: model!.read,
          ) ??
          PageSpecs();
    }

    if (model!.title != null) {
      specs.title = model!.title;
    }

    final currentRoute = ModalRoute.of(context)?.settings.name;
    final showContinueListening = currentRoute == '/_/welcome';

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
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
                            model!.setSelectedIndex!(index: 0);
                          },
                          child: SizedBox(
                            width: 36,
                            height: 36,
                            child: Image.asset(assetPath('icon-small.png')),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Color.fromRGBO(4, 26, 82, 1),
                            size: 24,
                          ),
                          onPressed: () async {
                            if (ModalRoute.of(context)!.settings.name ==
                                    '/_/events/register' &&
                                model?.bookingFormView == 'bookingFormReview' &&
                                model
                                    ?.selectedEventDetail?['eventFormContent']
                                    .isNotEmpty) {
                              model?.discardBooking!();
                            } else {
                              final result = await Navigator.of(
                                context,
                              ).maybePop();
                              if (!result && context.mounted) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(
                                  context,
                                ).popAndPushNamed('/_/welcome');
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
                            onPressed: () {
                              switch (ModalRoute.of(context)!.settings.name!) {
                                case '/_/confession':
                                  confession.ConfessionViewState.showInfo(
                                    context,
                                    model!.titleFontSize,
                                    model!.contentFontSize,
                                  );
                                  break;
                                case '/_/devotion/rosary':
                                  rosary.RosaryViewState.showInfo(
                                    context,
                                    model!.titleFontSize,
                                    model!.contentFontSize,
                                  );
                                  break;
                                case '/_/devotion/divine_mercy_prayer':
                                  divine.DivineMercyPrayerViewState.showInfo(
                                    context,
                                    model!.titleFontSize,
                                    model!.contentFontSize,
                                  );
                                  break;
                                default:
                              }
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
          body: showContinueListening
              ? _buildBodyWithContinueListening(module)
              : Container(child: module),
          bottomNavigationBar: SizedBox(
            height: model!.isFullScreen ? 0 : 82,
            child: model!.isFullScreen
                ? Container(width: MediaQuery.of(context).size.width)
                : ModalRoute.of(context)!.settings.name ==
                          '/_/events/details' ||
                      ModalRoute.of(context)!.settings.name ==
                          '/_/events/register'
                ? EventDetailsFooter(model: model)
                : Navbar(model: model),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyWithContinueListening(Widget? module) {
    return CustomScrollView(
      slivers: [
        // Continue Listening Section
        if (model!.continueListening != null &&
            model!.continueListening!.isNotEmpty) ...[
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Text(
                'Continue Listening',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 220, child: _buildContinueListeningList()),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],

        // Original module content
        SliverFillRemaining(hasScrollBody: false, child: module ?? Container()),
      ],
    );
  }

  Widget _buildContinueListeningList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: model!.continueWatchingVideos.length,
      itemBuilder: (context, index) {
        final video = model!.continueWatchingVideos[index];
        return _buildContinueCard(video);
      },
    );
  }

  Widget _buildContinueCard(dynamic video) {
    final progress = video['progress'] as int;

    return Container(
      width: 320,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => model!.resumeVideo(video['videoId']),
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail with progress
              Stack(
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF6B5B8C), Color(0xFF9B7B9E)],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.play_circle_filled,
                        size: 56,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),

                  // Progress bar
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress / 100,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFD4A574),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Time badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${video['position'] ~/ 60}:${(video['position'] % 60).toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video['title'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      video['seriesTitle'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
