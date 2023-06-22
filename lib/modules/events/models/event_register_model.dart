import 'package:butter/butter.dart';

class EventRegisterModel extends BaseUIModel<EventRegisterModel> {
  Map<dynamic, dynamic>? item;
  String? bookingFormView;
  //
  String? error;
  bool? loading;
  Map<dynamic, dynamic>? formObj;
  Map? formErrorObj;

  late Future<void> Function(Map? formErrorObj)? setFormErrorObj;
  late Function({bool? isEventRegister}) setIsEventRegister;
  late Function(Map<dynamic, dynamic> formObj) setFormObj;
  void Function()? resetBookingForm;

  EventRegisterModel({
    this.error,
    this.loading,
    this.item,
    this.formObj,
    this.formErrorObj,
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
        formErrorObj: formErrorObj,
        bookingFormView: bookingFormView,
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        loading,
        item,
        formObj,
        formErrorObj,
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
          formErrorObj == other.formErrorObj &&
          bookingFormView == other.bookingFormView;
}
