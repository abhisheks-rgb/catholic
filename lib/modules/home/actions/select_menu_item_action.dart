import 'package:butter/butter.dart';
import 'package:flutter/widgets.dart';

import '../models/home_model.dart';

class SelectMenuItemAction extends BaseAction {
  final BuildContext? context;
  final bool? replaceCurrent;
  final String? route;
  final bool? allowSameId;
  final String? selectedId;

  SelectMenuItemAction({
    this.context,
    this.replaceCurrent = true,
    this.route,
    this.selectedId,
    this.allowSameId = true,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    // Prevent reselection of the same item

    if (replaceCurrent!) {
      final r = BaseNavigator.getRouteName(context!) ?? '';
      final frags = r.split('?');
      var args = r.contains('?') ? '?${frags[1]}' : '?';
      if (args == '?') {
        args = '';
      }

      if (route != frags[0]) {
        args = '';
      }

      pushNamedAndRemoveAll('$route$args');
    } else {
      pushNamed(route!);
    }

    return write<HomeModel>(HomeModel(), (m) {
      m.initialized = true;
      m.title = null;
    });
  }
}
