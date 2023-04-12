import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../components/priest_info_view.dart';
import '../models/priest_info_model.dart';
import '../../../../utils/page_specs.dart';

// import '../../../utils/asset_path.dart';

class PriestInfoPage extends BaseStatefulPageView {
  final PriestInfoModel? model;

  PriestInfoPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    model!.loadData();
    model!.fetchPriests();

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        title: 'Priest Info',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      PriestInfoView(model!);
}
