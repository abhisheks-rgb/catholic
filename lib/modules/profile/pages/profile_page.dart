import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../components/profile_view.dart';
import '../models/profile_model.dart';


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
  Widget build(BuildContext context, {bool loading = false}) => ProfileView(model!);
}
