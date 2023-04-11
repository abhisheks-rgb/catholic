import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../components/scripture_view.dart';
import '../models/scripture_model.dart';
import '../../../../utils/page_specs.dart';

class ScripturePage extends BaseStatefulPageView {
  final ScriptureModel? model;

  ScripturePage({Key? key, this.model}) : super();

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    model!.fetchReflections();

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        title: 'Scripture Reflections',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      ScriptureView(model!);
}
