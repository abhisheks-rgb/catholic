import 'package:butter/butter.dart';
import '../models/discover_model.dart';
import '../actions/discover_actions.dart';

class DiscoverState extends BasePageState<DiscoverModel> {
  DiscoverState();

  DiscoverModel? model;

  DiscoverState.build(this.model, void Function(DiscoverModel m) f)
    : super.build(model!, f);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DiscoverState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([runtimeType, model]);

  @override
  DiscoverState fromStore() =>
      DiscoverState.build(read<DiscoverModel>(DiscoverModel()), (m) {
        m.fetchSeries = () async {
          await dispatchAction(FetchSeriesAction());
        };

        m.updateSearchQuery = (query) async {
          await dispatchAction(UpdateSearchQueryAction(query: query));
        };

        m.selectCategory = (category) async {
          await dispatchAction(SelectCategoryAction(category: category));
        };

        m.toggleFavourite = (id) async {
          await dispatchAction(ToggleFavouriteAction(seriesId: id));
        };

        m.showPage = (route) async {
          await dispatchAction(NavigateToPageAction(route: route));
        };
      });
}
