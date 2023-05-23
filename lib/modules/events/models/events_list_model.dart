import 'package:butter/butter.dart';

class EventsListModel extends BaseUIModel<EventsListModel> {
  bool isLoggedIn;
  late void Function(String route) showPage;
  late void Function() checkIsLoggedIn;
  //
  String? error;
  bool? loading;
  List<Object>? events;
  late void Function() loadEvents;

  EventsListModel({
    this.error,
    this.loading,
    this.isLoggedIn = false,
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
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        loading,
        isLoggedIn,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventsListModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading &&
          isLoggedIn == other.isLoggedIn;
}
