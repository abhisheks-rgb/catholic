import 'dart:async';

import 'package:butter/butter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../components/notification_details_view.dart';
import '../models/notification_details_model.dart';
import '../../../../utils/page_specs.dart';

class NotificationDetailsPage extends BaseStatefulPageView {
  final NotificationDetailsModel? model;

  NotificationDetailsPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    await FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'app_notification_details');

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        title: 'Notification',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      NotificationDetailsView(model!);
}
