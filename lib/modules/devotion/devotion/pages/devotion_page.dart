import 'dart:async';

import 'package:butter/butter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../components/devotion_view.dart';
import '../models/devotion_model.dart';
import '../../../../utils/page_specs.dart';

class DevotionPage extends BaseStatefulPageView {
  final DevotionModel? model;

  DevotionPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    await FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'app_devotion');

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        showProfile: false,
        leadingLogo: false,
        title: 'Devotions',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      DevotionView(model: model);
}
