import 'dart:async';

import 'package:butter/butter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../../../../utils/page_specs.dart';
import '../components/discover_view.dart';
import '../models/discover_model.dart';

class DiscoverPage extends BaseStatefulPageView {
  final DiscoverModel? model;

  DiscoverPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    // Firebase Analytics
    await FirebaseAnalytics.instance.setCurrentScreen(screenName: 'discover');

    model!.fetchSeries();

    return true;
  }

  @override
  get specs => PageSpecs.build(
    (context, {dispatch, read}) => PageSpecs(
      hasAppBar: true,
      title: 'Discover',
      leadingLogo: false,
      showNotification: false,
      showProfile: false,
      showInfo: false,
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.abc))],
    ),
  );

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      DiscoverView(model!);
}
