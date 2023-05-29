import 'dart:async';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../models/my_event_model.dart';

class ListBookingsAction extends BaseAction {
  ListBookingsAction();

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('ListBookingsAction::reduce');

    String? error;
    await dispatchModel<MyEventModel>(MyEventModel(), (m) {
      m.error = error;
      m.loading = true;
    });

    List<Object> records = [];

    try {
      final instance = await FirebaseFunctions.instanceFor(region: 'asia-east2')
          .httpsCallable('events')
          .call({
        'type': 'getBookings',
      });

      List result = instance.data['results']['items'];

      records = result.map((e) {
        return e as Object;
      }).toList();
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
      error = 'Unexpected error';
    }

    await dispatchModel<MyEventModel>(MyEventModel(), (m) {
      m.error = error;
      m.loading = false;
      m.bookings = records;
    });

    return null;
  }
}
