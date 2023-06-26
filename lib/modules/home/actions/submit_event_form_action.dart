import 'dart:async';

import 'dart:convert';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../models/home_model.dart';
import '../../events/models/event_details_model.dart';

class SubmitEventFormAction extends BaseAction {
  final List formResponse;
  final String eventId;

  SubmitEventFormAction({
    required this.formResponse,
    required this.eventId,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('SubmitEventFormAction::reduce');
    final m = read<HomeModel>(HomeModel());
    await dispatchModel<HomeModel>(HomeModel(), (m) {
      m.submitBookingLoading = true;
    });

    final result = await FirebaseFunctions.instanceFor(region: 'asia-east2')
        .httpsCallable('events')
        .call({
      'type': 'setBooking',
      'arg': {
        'eventId': eventId,
        'formResponse': json.encode(formResponse),
      },
    });

    if (result.data['status'] == 0) {
      Map<dynamic, dynamic>? event = m.selectedEventDetail;

      event!['hasBooked'] = true;

      dispatchModel<EventDetailsModel>(EventDetailsModel(), (m) {
        m.item = event;
        m.loading = false;
      });

      dispatchModel<HomeModel>(HomeModel(), (m) {
        m.submitBookingLoading = false;
        m.selectedEventDetail = event;
      });
    } else {
      Map<dynamic, dynamic>? event = m.selectedEventDetail;

      dispatchModel<EventDetailsModel>(EventDetailsModel(), (m) {
        m.item = event;
        m.loading = false;
      });
      dispatchModel<HomeModel>(HomeModel(), (m) {
        m.submitBookingLoading = false;
        m.bookingErrorMessage = result.data['message'].toString();
        m.selectedEventDetail = event;
      });
    }

    return null;
  }
}
