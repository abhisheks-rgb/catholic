import 'package:butter/butter.dart';

class EventsModel extends BaseUIModel<EventsModel> {
  //
  String? error;
  bool? loading;

  EventsModel({
    this.error,
    this.loading,
  });

  Future<void> Function(String route)? navigateTo;

  @override
  String get $key => '/events';

  @override
  EventsModel clone() => EventsModel(
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
      other is EventsModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading;
}
