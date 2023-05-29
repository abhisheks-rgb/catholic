import 'dart:async';

import 'package:butter/butter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../components/confession_view.dart';
import '../models/confession_model.dart';
import '../../../../utils/page_specs.dart';

class ConfessionPage extends BaseStatefulPageView {
  final ConfessionModel? model;

  ConfessionPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    await FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'app_confession');

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        showProfile: false,
        leadingLogo: false,
        showFontSetting: true,
        title: 'Confession',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      ConfessionView(model!);
}
