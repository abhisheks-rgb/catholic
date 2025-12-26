import 'package:flutter/material.dart';

part 'widgets/continue_card.dart';

class ContinueListeningSection {
  static List<Widget> slivers({
    required List<dynamic> items,
    required void Function(dynamic video) onItemTap,
    VoidCallback? onViewAll,
    required ValueNotifier<bool> isExpandedNotifier,
  }) {
    if (items.isEmpty) {
      return [];
    }

    return [
      _stickyHeader(onViewAll, isExpandedNotifier, items.length),
      ValueListenableBuilder<bool>(
        valueListenable: isExpandedNotifier,
        builder: (context, isExpanded, child) {
          if (!isExpanded) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
          return _list(items, onItemTap);
        },
      ),
      ValueListenableBuilder<bool>(
        valueListenable: isExpandedNotifier,
        builder: (context, isExpanded, child) {
          return SliverToBoxAdapter(
            child: SizedBox(height: isExpanded ? 24 : 0),
          );
        },
      ),
    ];
  }

  static SliverPersistentHeader _stickyHeader(
    VoidCallback? onViewAll,
    ValueNotifier<bool> isExpandedNotifier,
    int itemCount,
  ) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _ContinueListeningHeaderDelegate(
        onViewAll: onViewAll,
        isExpandedNotifier: isExpandedNotifier,
        itemCount: itemCount,
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
              key: ValueKey(items[index]['videoId']),
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

class _ContinueListeningHeaderDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback? onViewAll;
  final ValueNotifier<bool> isExpandedNotifier;
  final int itemCount;

  _ContinueListeningHeaderDelegate({
    this.onViewAll,
    required this.isExpandedNotifier,
    required this.itemCount,
  });

  @override
  double get minExtent => 70.0;

  @override
  double get maxExtent => 70.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ValueListenableBuilder<bool>(
      valueListenable: isExpandedNotifier,
      builder: (context, isExpanded, child) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Text(
                      'Continue Listening',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF041A51),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDF1FD),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$itemCount',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF041A51),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onViewAll != null)
                    TextButton(
                      onPressed: onViewAll,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        minimumSize: const Size(0, 36),
                      ),
                      child: const Text(
                        'View all',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  IconButton(
                    icon: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: const Color(0xFF041A51),
                    ),
                    onPressed: () {
                      isExpandedNotifier.value = !isExpandedNotifier.value;
                    },
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool shouldRebuild(covariant _ContinueListeningHeaderDelegate oldDelegate) {
    return oldDelegate.itemCount != itemCount ||
        oldDelegate.onViewAll != onViewAll;
  }
}
