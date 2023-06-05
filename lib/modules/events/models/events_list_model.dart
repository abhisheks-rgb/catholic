import 'package:butter/butter.dart';

class EventsListModel extends BaseUIModel<EventsListModel> {
  bool isLoggedIn;
  late void Function(String route) showPage;
  late void Function() checkIsLoggedIn;
  //
  String? error;
  bool? loading;
  List<Object>? events;
  List<Object>? interestedEvents;
  late void Function() loadEvents;
  late void Function() loadInterestedEvents;

  EventsListModel({
    this.error,
    this.loading,
    this.isLoggedIn = false,
    this.events,
    this.interestedEvents,
  });

  Future<void> Function(String route)? navigateTo;
  Future<void> Function(Map<Object?, Object?>? event)? viewEventDetails;

  @override
  String get $key => '/events_list';

  @override
  EventsListModel clone() => EventsListModel(
        error: error,
        loading: loading,
        isLoggedIn: isLoggedIn,
        events: events,
        interestedEvents: interestedEvents,
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        loading,
        isLoggedIn,
        events,
        interestedEvents,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventsListModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading &&
          isLoggedIn == other.isLoggedIn &&
          events == other.events &&
          interestedEvents == other.interestedEvents;
}
