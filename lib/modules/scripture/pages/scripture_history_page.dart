import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../components/scripture_history_view.dart';
import '../models/scripture_history_model.dart';

class ScriptureHistoryPage extends BaseStatefulPageView {
  final ScriptureHistoryModel? model;

  ScriptureHistoryPage({Key? key, this.model}) : super();

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    return true;
  }

  @override
  Widget build(BuildContext context, {bool loading = false}) => ScriptureHistoryView(model!);
}
