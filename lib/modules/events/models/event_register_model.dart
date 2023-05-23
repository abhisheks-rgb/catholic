import 'package:butter/butter.dart';

class EventRegisterModel extends BaseUIModel<EventRegisterModel> {
  Map<dynamic, dynamic>? item;
  //
  String? error;
  bool? loading;

  EventRegisterModel({
    this.error,
    this.loading,
    this.item,
  });

  late Function({bool? isEventRegister}) setIsEventRegister;

  @override
  String get $key => '/event_register';

  @override
  EventRegisterModel clone() => EventRegisterModel(
        error: error,
        loading: loading,
        item: item,
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        loading,
        item,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventRegisterModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading &&
          item == other.item;
}
