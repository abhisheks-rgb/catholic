import 'package:butter/butter.dart';

class EventsListModel extends BaseUIModel<EventsListModel> {
  //
  String? error;
  bool? loading;
  List<Object>? events;
  late void Function() loadEvents;

  EventsListModel({
    this.error,
    this.loading,
  });

  Future<void> Function(String route)? navigateTo;
  Future<void> Function(Map<Object?, Object?>? event)? viewEventDetails;

  @override
  String get $key => '/events_list';

  @override
  EventsListModel clone() => EventsListModel(
        error: error,
        loading: loading,
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        loading,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventsListModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading;
}
