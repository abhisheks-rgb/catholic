import 'package:butter/butter.dart';

import '../actions/initialize_action.dart';
import '../actions/initialize_todayis.dart';
import '../actions/select_menu_item_action.dart';
import '../actions/set_font_size_action.dart';
import '../actions/set_interest_action.dart';
import '../models/home_model.dart';
import '../../events/models/event_register_model.dart';

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
        // m.dispatch = (action) => dispatchAction(action);
        // m.read = <T extends BaseUIModel>(T o) {
        //   return read(o);
        // };
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
          dispatchModel<HomeModel>(HomeModel(), (m) {
            m.isEventRegister = true;
          });

          dispatchModel<EventRegisterModel>(EventRegisterModel(), (m) {
            m.item = event;
          });
          pushNamed('/_/events/register');
        };
        m.setInterestEvent = (parentEventId, eventId) => dispatchAction(
            SetInterestAction(eventId: eventId, parentEventId: parentEventId));
      });
}
