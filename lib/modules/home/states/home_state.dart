import 'package:butter/butter.dart';
import 'package:intl/intl.dart';

import '../actions/initialize_action.dart';
import '../actions/initialize_todayis.dart';
import '../actions/select_menu_item_action.dart';
import '../actions/set_font_size_action.dart';
import '../actions/set_interest_action.dart';
import '../actions/submit_event_form_action.dart';
import '../actions/cancel_book_action.dart';
import '../models/home_model.dart';
import '../../confession/models/confession_model.dart';
import '../../devotion/rosary/models/rosary_model.dart';
import '../../devotion/divine_mercy_prayer/models/divine_mercy_prayer_model.dart';
import '../../events/models/event_register_model.dart';
import '../../events/models/event_details_model.dart';
import '../../profile/models/profile_model.dart';

class HomeState extends BasePageState<HomeModel> {
  HomeState();

  HomeModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  HomeState.build(this.model, void Function(HomeModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is HomeState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
      ]);

  @override
  HomeState fromStore() => HomeState.build(
          read<HomeModel>(
            HomeModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.showPage = (route) async {
          String newRoute = route;
          Map<String, dynamic>? user;

          dispatchModel<HomeModel>(HomeModel(), (m) {
            user = m.user;
          });

          switch (route) {
            case '/_/profile':
              if (user == null) {
                newRoute = '/_/login';
              } else {
                await dispatchModel<ProfileModel>(ProfileModel(), (m) {
                  m.user = user;
                });
              }
              break;
            default:
          }

          pushNamed(newRoute);
        };
        m.initialize =
            (context) => dispatchAction(InitializeAction(context: context));
        m.initializeTodayIs = () => dispatchAction(InitializeTodayIs());
        m.setSelectedIndex = ({index}) {
          dispatchModel<HomeModel>(HomeModel(), (m) {
            m.selectedIndex = index!;
          });
        };
        m.setPageFontSize = () {
          dispatchAction(SetFontSizeAction());
        };
        m.discardBooking = () async {
          dispatchModel<HomeModel>(HomeModel(), (m) {
            m.bookingFormView = 'bookingForm';
            m.formObj = {};
          });

          return dispatchModel<EventRegisterModel>(EventRegisterModel(), (m) {
            m.bookingFormView = 'bookingForm';
            m.formErrorObj = {};
            m.formObj = {};
          });
        };
        m.setBookingFormView = () {
          final m = read<EventRegisterModel>(EventRegisterModel());
          final h = read<HomeModel>(HomeModel());

          String bookingView = 'bookingForm';

          Map errorObj = {};
          m.item!['eventFormContent'].forEach((e) {
            if (h.formObj == null && e['required'] == true) {
              errorObj[e['field_name']] = '${e['label']} is required.';
            } else if (e['required'] == true &&
                (h.formObj![e['field_name']] == null ||
                    h.formObj![e['field_name']] == '')) {
              errorObj[e['field_name']] = '${e['label']} is required.';
            } else if (e['required'] == true &&
                e['element'] == 'Checkboxes' &&
                h.formObj![e['field_name']].length == 0) {
              errorObj[e['field_name']] = '${e['label']} is required.';
            }
          });

          if (errorObj.isEmpty) {
            bookingView = 'bookingFormReview';
          }

          dispatchModel<EventRegisterModel>(EventRegisterModel(), (m) {
            m.bookingFormView = bookingView;
            m.formErrorObj = errorObj;
            m.loading = false;
          });
          dispatchModel<HomeModel>(HomeModel(), (m) {
            m.bookingFormView = bookingView;
          });
        };
        m.cancelFormEvent = () async {
          final m = read<EventDetailsModel>(EventDetailsModel());
          dispatchAction(
              CancelBookAction(eventId: m.item!['eventId'].toString()));
        };
        m.submitFormEvent = () async {
          final m = read<EventRegisterModel>(EventRegisterModel());

          List formResponse = [];
          m.formObj?.forEach((key, value) {
            formResponse.add({
              'fieldId': key,
              'value': value.runtimeType == DateTime
                  ? DateFormat('d MMM y').format(value)
                  : value,
              'label': m.item!['eventFormContent'].firstWhere((option) {
                return option['field_name'] == key;
              })['label'],
            });
          });

          dispatchAction(SubmitEventFormAction(
            eventId: m.item!['eventId'],
            formResponse: formResponse,
          ));
        };
        m.closeSuccessPrompt = () async {
          pushNamed('/_/events/list');

          dispatchModel<EventRegisterModel>(EventRegisterModel(), (m) {
            m.bookingFormView = 'bookingForm';
            m.formObj = {};
          });

          await dispatchModel<HomeModel>(HomeModel(), (m) {
            m.isEventRegister = false;
            m.selectedEventDetail = {};
            m.bookingErrorMessage = '';
            m.bookingFormView = 'bookingForm';
            m.loading = false;
          });
        };
        m.redirectToLogin = () {
          dispatchModel<HomeModel>(HomeModel(), (m) {
            m.isEventRegister = false;
            // m.isEventDetails = false;
            m.loading = false;
          });
          pushNamed('/_/login');
        };
        m.gotoMyEvents = () async {
          dispatchModel<EventRegisterModel>(EventRegisterModel(), (m) {
            m.bookingFormView = 'bookingForm';
            m.formObj = {};
          });

          await dispatchModel<HomeModel>(HomeModel(), (m) {
            m.selectedEventDetail = {};
            m.bookingFormView = 'bookingForm';
            m.loading = false;
          });

          pushNamed('/_/events/myEvents');
        };
        m.setShowInfo = (String route) {
          bool showInfo = false;

          switch (route) {
            case '/_/devotion/rosary':
              dispatchModel<RosaryModel>(RosaryModel(), (m) {
                showInfo = m.showInfo == true;
              });

              if (!showInfo) {
                dispatchModel<RosaryModel>(RosaryModel(), (m) {
                  m.showInfo = true;
                });
              }
              break;
            case '/_/confession':
              dispatchModel<ConfessionModel>(ConfessionModel(), (m) {
                showInfo = m.showInfo == true;
              });

              if (!showInfo) {
                dispatchModel<ConfessionModel>(ConfessionModel(), (m) {
                  m.showInfo = true;
                });
              }
              break;
            case '/_/devotion/divine_mercy_prayer':
              dispatchModel<DivineMercyPrayerModel>(DivineMercyPrayerModel(),
                  (m) {
                showInfo = m.showInfo == true;
              });

              if (!showInfo) {
                dispatchModel<DivineMercyPrayerModel>(DivineMercyPrayerModel(),
                    (m) {
                  m.showInfo = true;
                });
              }
              break;
            default:
          }
        };
        m.selectMenuItem = ({
          allowSameId = true,
          context,
          replaceCurrent = true,
          route,
          selectedId,
        }) =>
            dispatchAction(SelectMenuItemAction(
              allowSameId: allowSameId,
              context: context,
              replaceCurrent: replaceCurrent,
              route: route,
              selectedId: selectedId,
            ));
        m.navigateToEventRegister = (event) {
          dispatchModel<EventRegisterModel>(EventRegisterModel(), (m) {
            m.item = event;
          });
          pushNamed('/_/events/register');

          dispatchModel<HomeModel>(HomeModel(), (m) {
            m.isEventRegister = true;
          });
        };
        m.setInterestEvent = (parentEventId, eventId) => dispatchAction(
            SetInterestAction(eventId: eventId, parentEventId: parentEventId));
      });
}
