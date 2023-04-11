import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../components/login_view.dart';
import '../models/login_model.dart';
import '../../../../utils/page_specs.dart';

class LoginPage extends BaseStatefulPageView {
  final LoginModel? model;

  LoginPage({Key? key, this.model}) : super();

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    await super.beforeLoad(context);

    if (model?.isLoggedIn == true) {
      await model?.navigateTo!('/_/welcome');
    }

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: false,
        title: '',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      LoginView(model!);
}
