import 'package:butter/butter.dart';

class EventsModel extends BaseUIModel<EventsModel> {
  bool isLoggedIn;
  late void Function(String route) showPage;
  late void Function() checkIsLoggedIn;
  //
  String? error;
  bool? loading;

  EventsModel({
    this.error,
    this.loading,
    this.isLoggedIn = false,
  });

  Future<void> Function(String route)? navigateTo;
  Future<void> Function(Map<Object?, Object?>? event)? viewEventDetails;

  @override
  String get $key => '/events';

  @override
  EventsModel clone() => EventsModel(
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
      other is EventsModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading &&
          isLoggedIn == other.isLoggedIn;
}
