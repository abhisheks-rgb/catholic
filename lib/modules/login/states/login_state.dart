// import 'dart:convert';
import 'package:butter/butter.dart';
// import 'package:flutter/services.dart';

import '../actions/login_action.dart';
import '../actions/navigate_to_action.dart';
import '../models/login_model.dart';

class LoginState extends BasePageState<LoginModel> {
  LoginState();

  LoginModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  LoginState.build(this.model, void Function(LoginModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LoginState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
      ]);

  @override
  LoginState fromStore() => LoginState.build(
          read<LoginModel>(
            LoginModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.navigateTo = (route) => dispatchAction(NavigateToAction(route: route));
        m.login = (email, password) =>
            dispatchAction(LoginAction(email: email, password: password));
      });
}
