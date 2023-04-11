import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../components/offertory_view.dart';
import '../models/offertory_model.dart';
import '../../../../utils/page_specs.dart';

class OffertoryPage extends BaseStatefulPageView {
  final OffertoryModel? model;

  OffertoryPage({Key? key, this.model}) : super();

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

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
