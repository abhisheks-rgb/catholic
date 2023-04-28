import 'dart:async';
import 'dart:convert';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../models/mass_readings_model.dart';

class ListMassReadingAction extends BaseAction {
  final String? massReadingDate;

  ListMassReadingAction({
    this.massReadingDate,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    String? error;
    await dispatchModel<MassReadingsModel>(MassReadingsModel(), (m) {
      m.error = error;
      m.loading = true;
    });

    Map<String, dynamic> record = {};
    List<Object> records2 = [];
    List<String> keyList = [];

    try {
      final instance = await FirebaseFunctions.instanceFor(region: 'asia-east2')
          .httpsCallable('massreading')
          .call(
        {
          'input': massReadingDate,
        },
      );

      record = json.decode(instance.data['results']['items']);

      print('sffasdfas $record');

      record.forEach((key, value) {
        print('$key $value');
        if (key != 'number' && key != 'date' && key != 'day') {
          records2.add({key: value});
          keyList.add(key);
        }
      });
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
      error = 'Unexpected error';
    }

    await Future.delayed(const Duration(seconds: 1), () async {
      await dispatchModel<MassReadingsModel>(MassReadingsModel(), (m) {
        m.error = error;
        m.loading = false;
        m.massReadingItem = record;
        m.massReadingList = records2;
        m.massReadingTypeList = keyList;
      });
    });

    return null;
  }
}
