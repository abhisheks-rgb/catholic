import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../components/event_details_view.dart';
import '../models/event_details_model.dart';
import '../../../../utils/page_specs.dart';

class EventDetailsPage extends BaseStatefulPageView {
  final EventDetailsModel? model;

  EventDetailsPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    await FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'app_event_details');

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        title: 'Event Details',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      EventDetailsView(model!);
}
