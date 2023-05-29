import 'dart:async';

import 'package:butter/butter.dart';

import '../models/event_details_model.dart';
import '../../home/models/home_model.dart';

class ViewEventDetailsAction extends BaseAction {
  final Map<dynamic, dynamic>? event;

  ViewEventDetailsAction(this.event);

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    String? error;
    await dispatchModel<EventDetailsModel>(EventDetailsModel(), (m) {
      m.error = error;
      m.item = event;
    });

    await dispatchModel<HomeModel>(HomeModel(), (m) {
      m.isEventDetails = true;
      m.selectedEventDetail = event;
    });

    pushNamed('/_/events/details');

    return null;
  }
}
