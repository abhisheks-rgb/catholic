import 'package:butter/butter.dart';
import '../models/discover_model.dart';
import '../actions/discover_actions.dart';
class DiscoverState extends BasePageState<DiscoverModel> {
  DiscoverState();

  DiscoverModel? model;

  DiscoverState.build(this.model, void Function(DiscoverModel m) f)
      : super.build(model!, f);

  @override
  DiscoverState fromStore() => DiscoverState.build(
        read<DiscoverModel>(DiscoverModel()),
        (m) {
          m.fetchSeries = () {
            dispatchAction(FetchSeriesAction());
          };

          m.updateSearchQuery = (query) {
            dispatchAction(UpdateSearchQueryAction(query: query));
          };

          m.selectCategory = (category) {
            dispatchAction(SelectCategoryAction(category: category));
          };

          m.toggleFavourite = (id) {
            dispatchAction(ToggleFavouriteAction(seriesId: id));
          };

          m.showPage = (route) {
            dispatchAction(NavigateToPageAction(route: route));
          };
        },
      );
}
