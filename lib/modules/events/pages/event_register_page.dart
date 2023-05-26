import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../components/event_register_view.dart';
import '../models/event_register_model.dart';
import '../../../../utils/page_specs.dart';

class EventRegisterPage extends BaseStatefulPageView {
  final EventRegisterModel? model;

  EventRegisterPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    await FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'app_event_register');

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        title: 'Booking Form',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      EventRegisterView(model!);
}
