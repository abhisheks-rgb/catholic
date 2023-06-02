import 'package:butter/butter.dart';

class MyEventModel extends BaseUIModel<MyEventModel> {
  bool isLoggedIn;
  late void Function(String route) showPage;
  late void Function() checkIsLoggedIn;
  //
  String? error;
  bool? loading;
  List<Object>? events;
  List<Object>? bookings;
  List<Object>? interestedEvents;
  late void Function() loadEvents;
  late void Function() loadBookings;

  MyEventModel({
    this.error,
    this.loading,
    this.isLoggedIn = false,
    this.bookings,
    this.events,
  });

  Future<void> Function(String route)? navigateTo;
  Future<void> Function(Map<Object?, Object?>? event)? viewEventDetails;

  @override
  String get $key => '/my_event';

  @override
  MyEventModel clone() => MyEventModel(
        error: error,
        loading: loading,
        isLoggedIn: isLoggedIn,
        bookings: bookings,
        events: events,
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        loading,
        isLoggedIn,
        events,
        bookings,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyEventModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading &&
          isLoggedIn == other.isLoggedIn &&
          events == other.events &&
          bookings == other.bookings;
}
