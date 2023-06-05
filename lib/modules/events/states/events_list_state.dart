import 'package:butter/butter.dart';

import '../actions/view_event_details_action.dart';
import '../actions/list_events_action.dart';
import '../actions/list_interested_events_action.dart';
import '../models/events_list_model.dart';
import '../../home/models/home_model.dart';

class EventsListState extends BasePageState<EventsListModel> {
  EventsListState();

  EventsListModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  EventsListState.build(this.model, void Function(EventsListModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is EventsListState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
      ]);

  @override
  EventsListState fromStore() => EventsListState.build(
          read<EventsListModel>(
            EventsListModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.loadEvents = () async {
          await dispatchAction(ListEventsAction());
        };
        m.loadInterestedEvents = () async {
          Map<String, dynamic>? user;
          dispatchModel<HomeModel>(HomeModel(), (m) {
            user = m.user;
          });

          await dispatchAction(
              ListInterestedEventsAction(userId: user!['userid']));
        };
        m.viewEventDetails =
            (event) => dispatchAction(ViewEventDetailsAction(event!));
        m.showPage = (route) async {
          pushNamed(route);
        };
        m.checkIsLoggedIn = () async {
          Map<String, dynamic>? user;

          dispatchModel<HomeModel>(HomeModel(), (m) {
            user = m.user;
          });

          await dispatchModel<EventsListModel>(EventsListModel(), (m) {
            m.isLoggedIn = user == null ? false : true;
          });
        };
      });
}
