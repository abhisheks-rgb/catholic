import 'dart:async';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../models/church_info_model.dart';

class ListChurchInfoAction extends BaseAction {
  final int? orgId;

  ListChurchInfoAction({
    this.orgId,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    String? error;
    int? churchId;
    await dispatchModel<ChurchInfoModel>(ChurchInfoModel(), (m) {
      m.error = error;
      m.loading = true;
      m.churchInfos = [];
      churchId = m.churchId != null ? m.churchId! + 1 : null;
    });

    List<Object> records = [];

    try {
      final instance = await FirebaseFunctions.instanceFor(region: 'asia-east2')
          .httpsCallable('org')
          .call(
        {
          'input': orgId != null
              ? '$orgId'
              : churchId != null && churchId! > 0
                  ? '$churchId'
                  : '2',
        },
      );

      List<Object?> result = instance.data['results']['items'];

      records = result.map((e) {
        return e as Object;
      }).toList();
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
      error = 'Unexpected error';
    }

    await Future.delayed(const Duration(seconds: 1), () async {
      await dispatchModel<ChurchInfoModel>(ChurchInfoModel(), (m) {
        m.error = error;
        m.loading = false;
        m.churchInfos = records;
      });
    });

    return null;
  }
}
