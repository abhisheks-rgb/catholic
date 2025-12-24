import 'package:butter/butter.dart';
import '../models/discover_model.dart';

// Fetch series from API/Firebase
class FetchSeriesAction extends BaseAction {
  @override
  Future<AppState?> reduce() async {
    await dispatchModel<DiscoverModel>(DiscoverModel(), (m) {
      m.loading = true;
      m.error = null;
    });

    String? error;
    List<Map<String, Object>> series = [];

    try {
      // await Future.delayed(const Duration(milliseconds: 500));

      final mockSeries = [
        {
          'id': '1',
          'title': 'Advent',
          'description':
              'Prepare your heart for Christmas with daily reflections',
          'category': 'Advent',
          'episodeCount': 24,
          'isFavourite': false,
        },
        {
          'id': '2',
          'title': 'Bible in a Year',
          'description': 'Journey through the entire Bible in 365 days',
          'category': 'Bible Study',
          'episodeCount': 365,
          'isFavourite': false,
        },
        {
          'id': '3',
          'title': 'Daily Prayers',
          'description': 'Essential prayers for your daily spiritual practice',
          'category': 'Prayer',
          'episodeCount': 30,
          'isFavourite': false,
        },
        {
          'id': '4',
          'title': 'The Holy Rosary',
          'description': 'Guided Rosary prayers for meditation',
          'category': 'Rosaries',
          'episodeCount': 20,
          'isFavourite': true,
        },
        {
          'id': '5',
          'title': 'Sleep with Scripture',
          'description': 'Peaceful prayers and music for restful sleep',
          'category': 'Sleep',
          'episodeCount': 15,
          'isFavourite': false,
        },
      ];

      // await dispatchModel<DiscoverModel>(DiscoverModel(), (m) {
      //   m.series = mockSeries;
      //   m.loading = false;
      // });
      series = List<Map<String, Object>>.from(mockSeries);
    } catch (e, st) {
      Butter.e(e.toString());
      Butter.e(st.toString());

      // await dispatchModel<DiscoverModel>(DiscoverModel(), (m) {
      //   m.loading = false;
      //   m.error = 'Failed to load series';
      // });
      error = 'Failed to load series';
    }
    await Future.delayed(const Duration(seconds: 1), () async {
      await dispatchModel<DiscoverModel>(DiscoverModel(), (m) {
        m.error = error;
        m.series = series;
        m.loading = false;
      });
    });
    return null;
  }
}

// Update search query
class UpdateSearchQueryAction extends BaseAction {
  final String query;

  UpdateSearchQueryAction({required this.query});

  @override
  Future<AppState?> reduce() async {
    return write<DiscoverModel>(DiscoverModel(), (m) {
      m.searchQuery = query;
    });
  }
}

// Toggle favourite
class ToggleFavouriteAction extends BaseAction {
  final String seriesId;

  ToggleFavouriteAction({required this.seriesId});

  @override
  Future<AppState?> reduce() async {
    return write<DiscoverModel>(DiscoverModel(), (m) {
      if (m.series != null) {
        final index = m.series!.indexWhere((s) => s['id'] == seriesId);
        if (index != -1) {
          final updatedSeries = List.from(m.series!);
          updatedSeries[index] = {
            ...updatedSeries[index],
            'isFavourite':
                !(updatedSeries[index]['isFavourite'] as bool? ?? false),
          };
          m.series = updatedSeries;
        }
      }
    });
  }
}

// Select category
class SelectCategoryAction extends BaseAction {
  final String? category;

  SelectCategoryAction({required this.category});

  @override
  Future<AppState?> reduce() async {
    return write<DiscoverModel>(DiscoverModel(), (m) {
      m.selectedCategory = category;
    });
  }
}

// Navigate to page
class NavigateToPageAction extends BaseAction {
  final String route;

  NavigateToPageAction({required this.route});

  @override
  Future<AppState?> reduce() async {
    pushNamed(route);
    return null;
  }
}
