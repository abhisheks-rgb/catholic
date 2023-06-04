import 'dart:async';

import 'package:butter/butter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../components/scripture_history_view.dart';
import '../models/scripture_history_model.dart';
import '../../../../utils/page_specs.dart';

class ScriptureHistoryPage extends BaseStatefulPageView {
  final ScriptureHistoryModel? model;

  ScriptureHistoryPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    await FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'app_scripture_history');

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        title: 'Scripture Reflections',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      ScriptureHistoryView(model!);
}
