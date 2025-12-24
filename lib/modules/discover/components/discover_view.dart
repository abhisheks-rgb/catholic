import 'package:flutter/material.dart';
import '../models/discover_model.dart';

class DiscoverView extends StatelessWidget {
  final DiscoverModel model;

  const DiscoverView(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Loading state
    if (model.loading == true && (model.series == null || model.series!.isEmpty)) {
      return const Center(child: CircularProgressIndicator());
    }

    // Error state
    if (model.error != null && (model.series == null || model.series!.isEmpty)) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(model.error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => model.fetchSeries!(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        // Search Bar
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _buildSearchBar(context),
          ),
        ),

        // Categories Section
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        // Categories Grid
        _buildCategoriesGrid(context),

        // All Series Section
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
            child: Text(
              'All Series',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        // Series List
        _buildSeriesList(context),

        // Bottom padding
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: (query) => model.updateSearchQuery(query),
        decoration: const InputDecoration(
          hintText: 'Prayers, Categories, Bible and More',
          hintStyle: TextStyle(fontSize: 13),
          prefixIcon: Icon(Icons.search, size: 22),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid(BuildContext context) {
    final categories = [
      {'title': 'All', 'color': 0xFF6B5B8C},
      {'title': 'Advent', 'color': 0xFF6B5B8C},
      {'title': 'Bible Study', 'color': 0xFFC9A66B},
      {'title': 'Prayer', 'color': 0xFF5B9A9D},
      {'title': 'Rosaries', 'color': 0xFF8B6F5C},
      {'title': 'Sleep', 'color': 0xFF4A6FA5},
      {'title': 'Saints', 'color': 0xFF9B7B9E},
    ];

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.5,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final category = categories[index];
            return _buildCategoryCard(
              context,
              category['title'] as String,
              Color(category['color'] as int),
            );
          },
          childCount: categories.length,
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, Color color) {
    final isSelected = model.selectedCategory == title;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(isSelected ? 1.0 : 0.8),
            color,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => model.selectCategory(title),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  _getCategoryIcon(title),
                  color: Colors.white,
                  size: 28,
                ),
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Advent':
        return Icons.star_rounded;
      case 'Bible Study':
        return Icons.menu_book_rounded;
      case 'Prayer':
        return Icons.wb_sunny_rounded;
      case 'Rosaries':
        return Icons.spa_rounded;
      case 'Sleep':
        return Icons.nightlight_round;
      case 'Saints':
        return Icons.church_rounded;
      default:
        return Icons.category;
    }
  }

  Widget _buildSeriesList(BuildContext context) {
    final filteredSeries = model.filteredSeries;

    if (filteredSeries.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Text('No series found'),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final series = filteredSeries[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildSeriesListItem(context, series),
            );
          },
          childCount: filteredSeries.length,
        ),
      ),
    );
  }

  Widget _buildSeriesListItem(BuildContext context, dynamic series) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to series detail
            model.showPage('/_/series/${series['id']}');
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Thumbnail
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        series['title'] as String,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        series['description'] as String,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 12,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${series['episodeCount']} episodes',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 11,
                            ),
                      ),
                    ],
                  ),
                ),

                // Favorite button
                IconButton(
                  onPressed: () {
                    model.toggleFavourite(series['id'] as String);
                  },
                  icon: Icon(
                    series['isFavourite'] == true
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: series['isFavourite'] == true
                        ? Colors.red
                        : Colors.grey,
                    size: 22,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}