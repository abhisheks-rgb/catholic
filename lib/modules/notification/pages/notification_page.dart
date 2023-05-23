import 'dart:async';

import 'package:butter/butter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../components/notification_view.dart';
import '../models/notification_model.dart';
import '../../../../utils/page_specs.dart';

class NotificationPage extends BaseStatefulPageView {
  final NotificationModel? model;

  NotificationPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    await FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'app_notification');

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: false,
        title: '',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      NotificationView(model!);
}
