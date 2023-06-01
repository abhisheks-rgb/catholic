import 'dart:async';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../models/my_event_model.dart';

import '../models/event_details_model.dart';
import '../../home/models/home_model.dart';

class ListEventDetailAction extends BaseAction {
  final String eventId;
  ListEventDetailAction({
    required this.eventId,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('ListEventDetailAction::reduce');

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
        'type': 'getEventDetails',
        'arg': {
          'eventId': eventId,
        },
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
      // m.bookings = records;
    });

    await dispatchModel<EventDetailsModel>(EventDetailsModel(), (m) {
      m.error = error;
      m.item = records[0] as Map<Object?, Object?>?;
    });

    await dispatchModel<HomeModel>(HomeModel(), (m) {
      m.isEventDetails = true;
      m.selectedEventDetail = records[0] as Map<Object?, Object?>?;
      ;
    });

    return null;
  }
}
