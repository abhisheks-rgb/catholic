import 'dart:async';

import 'package:butter/butter.dart';

import '../models/offertory_model.dart';
import '../../church_info/models/church_info_model.dart';

class NavigateToAction extends BaseAction {
  final int? churchId;
  final String? route;
  final String? churchName;

  NavigateToAction({
    this.churchId,
    this.route,
    this.churchName,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    String? error;
    await dispatchModel<OffertoryModel>(OffertoryModel(), (m) {
      m.error = error;
      m.loading = true;
    });

    try {
      await dispatchModel<ChurchInfoModel>(ChurchInfoModel(), (m) {
        m.churchId = churchId;
        m.churchName = churchName;
      });

      // pushNamed(route!);
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
      error = 'Unexpected error';
    }

    return write<OffertoryModel>(OffertoryModel(), (m) {
      m.error = error;
      m.loading = false;
    });
  }
}
