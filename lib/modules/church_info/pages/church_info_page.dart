import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../components/church_info_view.dart';
import '../models/church_info_model.dart';

import '../../../../utils/page_specs.dart';

class ChurchInfoPage extends BaseStatefulPageView {
  final ChurchInfoModel? model;

  ChurchInfoPage({Key? key, this.model}) : super();

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    model!.loadData();
    model!.fetchChurchInfo();

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        title: "Church Info",
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      ChurchInfoView(model!);
}
