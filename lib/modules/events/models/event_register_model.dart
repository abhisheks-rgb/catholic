import 'package:butter/butter.dart';

class EventRegisterModel extends BaseUIModel<EventRegisterModel> {
  //
  String? error;
  bool? loading;

  EventRegisterModel({
    this.error,
    this.loading,
  });

  late Function({bool? isEventRegister}) setIsEventRegister;

  @override
  String get $key => '/event_register';

  @override
  EventRegisterModel clone() => EventRegisterModel(
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
      other is EventRegisterModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading;
}
