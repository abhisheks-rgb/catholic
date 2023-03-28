// import 'dart:convert';
import 'package:butter/butter.dart';
// import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../actions/logout_action.dart';
import '../models/profile_model.dart';
import '../../home/models/home_model.dart';

class ProfileState extends BasePageState<ProfileModel> {
  ProfileState();

  ProfileModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  ProfileState.build(this.model, void Function(ProfileModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ProfileState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
      ]);

  @override
  ProfileState fromStore() => ProfileState.build(
          read<ProfileModel>(
            ProfileModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.loadData = () async {
          User? user;
          dispatchModel<ProfileModel>(ProfileModel(), (m) {
            m.loading = true;
          });
          dispatchModel<HomeModel>(HomeModel(), (m) {
            user = m.user;
          });
          await Future.delayed(const Duration(seconds: 1), () async {
            dispatchModel<ProfileModel>(ProfileModel(), (m) {
              m.loading = false;
              m.user = user;
            });
          });
        };
        m.logout = () => dispatchAction(LogoutAction());
      });
}
