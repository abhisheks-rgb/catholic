import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../components/events_view.dart';
import '../models/events_model.dart';
import '../../../../utils/page_specs.dart';

class EventsPage extends BaseStatefulPageView {
  final EventsModel? model;

  EventsPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);
    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        showProfile: true,
        leadingLogo: true,
        title: 'Events',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      EventsView(model!);
}
