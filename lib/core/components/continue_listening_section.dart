import 'package:flutter/material.dart';

part 'widgets/continue_card.dart';

class ContinueListeningSection {
  static List<Widget> slivers({
    required List<dynamic> items,
    required void Function(dynamic video) onItemTap,
    VoidCallback? onViewAll,
  }) {
    if (items.isEmpty) {
      return [];
    }

    return [
      _header(onViewAll),
      _list(items, onItemTap),
      const SliverToBoxAdapter(child: SizedBox(height: 24)),
    ];
  }

  static SliverToBoxAdapter _header(VoidCallback? onViewAll) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Continue Listening',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            if (onViewAll != null)
              TextButton(onPressed: onViewAll, child: const Text('View all')),
          ],
        ),
      ),
    );
  }

  static SliverToBoxAdapter _list(
    List<dynamic> items,
    void Function(dynamic video) onItemTap,
  ) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return KeyedSubtree(
              key: ValueKey(items[index]['videoId']), // unique key
              child: _ContinueCard(
                video: items[index],
                onTap: () => onItemTap(items[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
