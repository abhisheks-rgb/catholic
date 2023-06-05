import 'dart:async';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../models/my_event_model.dart';

import '../models/events_list_model.dart';

class ListInterestedEventsAction extends BaseAction {
  final String userId;
  ListInterestedEventsAction({
    required this.userId,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('ListInterestedEventsAction::reduce');

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
        'type': 'getInterested',
        'arg': userId,
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
      m.events = records;
    });

    await dispatchModel<EventsListModel>(EventsListModel(), (m) {
      m.error = error;
      m.loading = false;
      m.interestedEvents = records;
    });

    return null;
  }
}
