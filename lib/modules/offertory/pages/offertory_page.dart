import 'dart:async';

import 'package:butter/butter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../components/offertory_view.dart';
import '../models/offertory_model.dart';
import '../../../../utils/page_specs.dart';

class OffertoryPage extends BaseStatefulPageView {
  final OffertoryModel? model;

  OffertoryPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    await FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'app_offertory');
    await FirebaseAnalytics.instance.logEvent(
      name: 'app_offertory_and_giving',
    );

    model!.loadData();
    model!.fetchOffertory();

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        title: 'Offertory & Giving',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      OffertoryView(model!);
}
