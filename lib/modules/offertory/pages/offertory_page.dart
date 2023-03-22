import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../components/offertory_view.dart';
import '../models/offertory_model.dart';

// import '../../../utils/asset_path.dart';

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
  Widget build(BuildContext context, {bool loading = false}) => OffertoryView(model!);
}
