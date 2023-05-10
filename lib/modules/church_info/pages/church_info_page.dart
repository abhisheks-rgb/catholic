import 'dart:async';

import 'package:butter/butter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../components/church_info_view.dart';
import '../models/church_info_model.dart';

import '../../../../utils/page_specs.dart';

class ChurchInfoPage extends BaseStatefulPageView {
  final ChurchInfoModel? model;

  ChurchInfoPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    await FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'app_church_info');

    model!.loadData();
    model!.fetchChurchInfo();
    model!.fetchPriestList();

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        title: 'Church Info',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      ChurchInfoView(model!);
}
