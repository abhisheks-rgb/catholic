import 'dart:async';

import 'package:butter/butter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../components/divine_mercy_prayer_view.dart';
import '../models/divine_mercy_prayer_model.dart';
import '../../../../utils/page_specs.dart';

class DivineMercyPrayerPage extends BaseStatefulPageView {
  final DivineMercyPrayerModel? model;

  DivineMercyPrayerPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    await FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'app_divine_mercy_prayer');
    await FirebaseAnalytics.instance.logEvent(
      name: 'app_divine_mercy_prayer',
    );

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        showProfile: false,
        leadingLogo: false,
        showFontSetting: true,
        showInfo: true,
        title: 'Divine Mercy Prayer',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      DivineMercyPrayerView(model!);
}
