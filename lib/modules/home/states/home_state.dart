import 'package:butter/butter.dart';

import '../actions/initialize_action.dart';
import '../actions/select_menu_item_action.dart';
import '../models/home_model.dart';
import '../../mass_readings/models/mass_readings_model.dart';
import '../../scripture/models/scripture_details_model.dart';

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
        m.dispatch = (action) => dispatchAction(action);
        m.read = <T extends BaseUIModel>(T o) {
          return read(o);
        };
        m.initialize =
            (context) => dispatchAction(InitializeAction(context: context));
        m.setSelectedIndex = ({index}) {
          dispatchModel<HomeModel>(HomeModel(), (m) {
            m.selectedIndex = index!;
          });
        };
        m.setPageFontSize = () {
          double defaultTitleFontSize = 20.0;
          double defaultContentFontSize = 17;
          double titlefontsize;
          double contentfontsize;

          if (m.titleFontSize == defaultTitleFontSize) {
            titlefontsize = defaultTitleFontSize * 1.2;
            contentfontsize = defaultContentFontSize * 1.2;
          } else if (m.titleFontSize == defaultTitleFontSize * 1.2) {
            titlefontsize = defaultTitleFontSize * 1.4;
            contentfontsize = defaultContentFontSize * 1.4;
          } else if (m.titleFontSize == defaultTitleFontSize * 1.4) {
            titlefontsize = defaultTitleFontSize * 0.8;
            contentfontsize = defaultContentFontSize * 0.8;
          } else {
            titlefontsize = defaultTitleFontSize;
            contentfontsize = defaultContentFontSize;
          }

          dispatchModel<MassReadingsModel>(MassReadingsModel(), (m) {
            m.titleFontSize = titlefontsize;
            m.contentFontSize = contentfontsize;
          });

          dispatchModel<ScriptureDetailsModel>(ScriptureDetailsModel(), (m) {
            m.titleFontSize = titlefontsize;
            m.contentFontSize = contentfontsize;
          });

          dispatchModel<HomeModel>(HomeModel(), (m) {
            m.titleFontSize = titlefontsize;
            m.contentFontSize = contentfontsize;
          });
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
      });
}
