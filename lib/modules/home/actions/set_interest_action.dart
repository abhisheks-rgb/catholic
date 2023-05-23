import 'dart:async';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../models/home_model.dart';

class SetInterestAction extends BaseAction {
  final String parentEventId;
  final String eventId;

  SetInterestAction({
    required this.parentEventId,
    required this.eventId,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('SetInterestAction::reduce');
    final m = read<HomeModel>(HomeModel());
    await dispatchModel<HomeModel>(HomeModel(), (m) {
      m.loading = true;
    });

    final result = await FirebaseFunctions.instanceFor(region: 'asia-east2')
        .httpsCallable('events')
        .call({
      'type': 'setInterest',
      'arg': {
        'eventId': eventId,
        'parentEventId': parentEventId,
      }
    });

    if (result.data['status'] == 0) {
      final event = m.selectedEventDetail;

      event!['hasLiked'] = true;
      event['interested'] = ++event['interested'];

      dispatchModel<HomeModel>(HomeModel(), (m) {
        m.selectedEventDetail = event;
        m.loading = false;
      });
    }

    return null;
  }
}
