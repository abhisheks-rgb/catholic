import 'package:butter/butter.dart';

class EventRegisterModel extends BaseUIModel<EventRegisterModel> {
  Map<dynamic, dynamic>? item;
  String? bookingFormView;
  //
  String? error;
  bool? loading;
  Map? formObj;
  late Function({bool? isEventRegister}) setIsEventRegister;
  late Future<void> Function(Map formObj) setFormObj;

  EventRegisterModel({
    this.error,
    this.loading,
    this.item,
    this.formObj,
    this.bookingFormView = 'bookingForm',
  });

  @override
  String get $key => '/event_register';

  @override
  EventRegisterModel clone() => EventRegisterModel(
        error: error,
        loading: loading,
        item: item,
        formObj: formObj,
        bookingFormView: bookingFormView,
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        loading,
        item,
        formObj,
        bookingFormView,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventRegisterModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading &&
          item == other.item &&
          formObj == other.formObj &&
          bookingFormView == other.bookingFormView;
}
