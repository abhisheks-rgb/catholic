import 'dart:async';

import 'package:butter/butter.dart';

import '../models/church_info_model.dart';

class SetChurchIdAction extends BaseAction {
  final int? churchId;

  SetChurchIdAction({
    this.churchId,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    String? error;
    await dispatchModel<ChurchInfoModel>(
        ChurchInfoModel(), (m) {
      m.error = error;
      m.loading = true;
    });

    await dispatchModel<ChurchInfoModel>(
        ChurchInfoModel(), (m) {
      m.error = error;
      m.loading = false;
      m.churchId = churchId;
    });

    return null;
  }
}
