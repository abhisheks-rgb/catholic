import 'package:butter/butter.dart';

class DiscoverModel extends BaseUIModel<DiscoverModel> {
  // State properties
  List<dynamic>? series;
  String? searchQuery;
  String? selectedCategory;
  bool? loading;
  String? error;
  bool? initialized;

  // Late functions (assigned in state connector)
  late void Function(String route) showPage;
  late void Function() fetchSeries;
  late Function(String query) updateSearchQuery;
  late Function(String seriesId) toggleFavourite;
  late Function(String? category) selectCategory;

  DiscoverModel({
    this.series,
    this.searchQuery,
    this.selectedCategory,
    this.loading,
    this.error,
  });

  // Computed properties
  List<dynamic> get filteredSeries {
    if (series == null || series!.isEmpty) return [];
    
    var filtered = series!;

    // Filter by category
    if (selectedCategory != null && selectedCategory != 'All') {
      filtered = filtered
          .where((s) => s['category'] == selectedCategory)
          .toList();
    }

    // Filter by search
    if (searchQuery != null && searchQuery!.isNotEmpty) {
      final query = searchQuery!.toLowerCase();
      filtered = filtered
          .where((s) =>
              (s['title'] as String).toLowerCase().contains(query) ||
              (s['description'] as String).toLowerCase().contains(query))
          .toList();
    }

    return filtered;
  }

  List<dynamic> get favouriteSeries {
    if (series == null) return [];
    return series!.where((s) => s['isFavourite'] == true).toList();
  }

  // Required for Butter
  @override
  String get $key => '/discover';

  @override
  DiscoverModel clone() => DiscoverModel(
        series: series == null ? [] : List.unmodifiable(series!),
        searchQuery: searchQuery,
        selectedCategory: selectedCategory,
        loading: loading,
        error: error,
      );

  @override
  int get hashCode => Object.hashAll([
        series,
        searchQuery,
        selectedCategory,
        loading,
        error,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscoverModel &&
          runtimeType == other.runtimeType &&
          series == other.series &&
          searchQuery == other.searchQuery &&
          selectedCategory == other.selectedCategory &&
          loading == other.loading &&
          error == other.error;
}
