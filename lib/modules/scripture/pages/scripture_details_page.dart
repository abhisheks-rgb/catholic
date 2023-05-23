import 'dart:async';

import 'package:butter/butter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../components/scripture_details_view.dart';
import '../models/scripture_details_model.dart';
import '../../../../utils/page_specs.dart';

class ScriptureDetailsPage extends BaseStatefulPageView {
  final ScriptureDetailsModel? model;

  ScriptureDetailsPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    await FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'app_scripture_details');

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        showFontSetting: true,
        title: 'Scripture Reflection',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      ScriptureDetailsView(model!);
}
