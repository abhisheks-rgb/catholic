import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../components/profile_view.dart';
import '../models/profile_model.dart';
import '../../../../utils/page_specs.dart';

class ProfilePage extends BaseStatefulPageView {
  final ProfileModel? model;

  ProfilePage({Key? key, this.model}) : super();

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    model?.loadData();

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: false,
        title: '',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      ProfileView(model!);
}
