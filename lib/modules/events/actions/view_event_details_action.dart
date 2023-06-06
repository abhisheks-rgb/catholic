import 'dart:async';

import 'package:butter/butter.dart';

import './list_event_detail_action.dart';

class ViewEventDetailsAction extends BaseAction {
  final Map<dynamic, dynamic>? event;

  ViewEventDetailsAction(this.event);

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    await dispatchAction(ListEventDetailAction(eventId: event!['eventId']));

    pushNamed('/_/events/details');

    return null;
  }
}
