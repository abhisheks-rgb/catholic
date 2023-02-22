import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/widgets.dart';

import '../../../config/app_config.dart';
import 'select_menu_item_action.dart';
import '../models/home_model.dart';

class InitializeAction extends BaseAction {
  final BuildContext context;
  final Map<String, dynamic>? params;

  InitializeAction({
    required this.context,
    this.params,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('InitializeAction::reduce');

    String? error;
    await dispatchModel<HomeModel>(HomeModel(), (m) {
      m.error = error;
      m.loading = true;
    });

    try {
      // ignore: use_build_context_synchronously
      await dispatchAction(SelectMenuItemAction(
        allowSameId: false,
        context: context,
        replaceCurrent: true,
        route: AppConfig.initRoute,
      ));
    } catch (e) {
      Butter.e(e.toString());
      throw 'Unable to load resources properly!';
    }

    Butter.d('InitializeAction::reduce::done');
    return write<HomeModel>(HomeModel(), (m) {
      m.error = error;
      m.loading = false;
      m.initialized = true;
    });
  }
}
