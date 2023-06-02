import 'dart:async';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../models/home_model.dart';
import '../../events/models/event_details_model.dart';

class CancelBookAction extends BaseAction {
  final String eventId;

  CancelBookAction({
    required this.eventId,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('SubmitEventFormAction::reduce');
    final m = read<HomeModel>(HomeModel());
    await dispatchModel<HomeModel>(HomeModel(), (m) {
      m.loading = true;
    });

    final result = await FirebaseFunctions.instanceFor(region: 'asia-east2')
        .httpsCallable('events')
        .call({
      'type': 'cancelBooking',
      'arg': {
        'eventId': eventId,
      },
    });

    if (result.data['status'] == 0) {
      Map<dynamic, dynamic>? event = m.selectedEventDetail;

      event!['hasBooked'] = false;

      dispatchModel<HomeModel>(HomeModel(), (m) {
        m.loading = false;
        m.selectedEventDetail = event;
      });

      dispatchModel<EventDetailsModel>(EventDetailsModel(), (m) {
        m.item = event;
        m.loading = false;
      });
    }

    return null;
  }
}
