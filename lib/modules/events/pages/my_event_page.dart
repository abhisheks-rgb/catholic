import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../components/my_events_view.dart';
import '../models/my_event_model.dart';
import '../../../../utils/page_specs.dart';

class MyEventPage extends BaseStatefulPageView {
  final MyEventModel? model;

  MyEventPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    await FirebaseAnalytics.instance.setCurrentScreen(screenName: 'app_events');

    model?.checkIsLoggedIn();
    model!.loadEvents();
    model?.loadBookings();

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        showProfile: true,
        leadingLogo: true,
        title: 'My Events',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      MyEventsView(model!);
}
