import 'package:butter/butter.dart';
import 'package:flutter/widgets.dart';

class HomeModel extends BaseUIModel<HomeModel> {
  String? error;
  bool initialized;
  bool loading;
  bool submitBookingLoading;
  String? title;
  Map<String, dynamic>? user;
  bool isFullScreen;
  int selectedIndex;
  DateTime? todayIsLastUpdate;

  bool isEventDetails;
  bool isEventRegister;
  Map<dynamic, dynamic>? selectedEventDetail;
  Map<dynamic, dynamic>? formObj;
  String? bookingFormView;
  String? bookingErrorMessage;

  late void Function(String route) showPage;
  void Function()? setPageFontSize;
  void Function(String route)? setShowInfo;

  late Future<void> Function(BuildContext context) initialize;
  late Future<void> Function() initializeTodayIs;
  Function({int? index})? setSelectedIndex;
  void Function({
    BuildContext? context,
    bool? replaceCurrent,
    String? route,
    String? selectedId,
    bool? allowSameId,
  })? selectMenuItem;

  void Function()? discardBooking;
  void Function()? setBookingFormView;
  late Future<void> Function()? closeSuccessPrompt;
  void Function()? gotoMyEvents;
  void Function()? redirectToLogin;
  void Function(Map<Object?, Object?>? event)? navigateToEventRegister;
  void Function(String parentEventId, String eventId)? setInterestEvent;
  late Future<void> Function()? submitFormEvent;
  late Future<void> Function()? cancelFormEvent;

  Future<void> Function(BaseAction action)? dispatch;
  T? Function<T extends BaseUIModel>(T m)? read;

  HomeModel({
    this.error,
    this.initialized = false,
    this.loading = false,
    this.title = '',
    this.user,
    this.isFullScreen = false,
    this.selectedIndex = 0,
    this.todayIsLastUpdate,
    this.isEventDetails = false,
    this.isEventRegister = false,
    this.selectedEventDetail,
    this.formObj,
    this.bookingFormView = 'bookingForm',
    this.submitBookingLoading = false,
    this.bookingErrorMessage,
  });

  @override
  String get $key => '/_';

  @override
  HomeModel clone() => HomeModel(
        error: error,
        initialized: initialized,
        loading: loading,
        title: title,
        user: user,
        isFullScreen: isFullScreen,
        selectedIndex: selectedIndex,
        todayIsLastUpdate: todayIsLastUpdate,
        isEventDetails: isEventDetails,
        isEventRegister: isEventRegister,
        selectedEventDetail: selectedEventDetail,
        formObj: formObj,
        bookingFormView: bookingFormView,
        submitBookingLoading: submitBookingLoading,
        bookingErrorMessage: bookingErrorMessage,
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        initialized,
        loading,
        title,
        user,
        isFullScreen,
        selectedIndex,
        todayIsLastUpdate,
        isEventDetails,
        isEventRegister,
        selectedEventDetail,
        formObj,
        bookingFormView,
        submitBookingLoading,
        bookingErrorMessage,
      ]);

  //
  // [initialized] and [selectedId] should not affect the model changes
  //
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          initialized == other.initialized &&
          loading == other.loading &&
          title == other.title &&
          user == other.user &&
          isFullScreen == other.isFullScreen &&
          selectedIndex == other.selectedIndex &&
          todayIsLastUpdate == other.todayIsLastUpdate &&
          isEventDetails == other.isEventDetails &&
          isEventRegister == other.isEventRegister &&
          selectedEventDetail == other.selectedEventDetail &&
          bookingFormView == other.bookingFormView &&
          submitBookingLoading == other.submitBookingLoading &&
          bookingErrorMessage == other.bookingErrorMessage;
}
