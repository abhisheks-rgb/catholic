part of '../continue_listening_section.dart';

class _ContinueCard extends StatelessWidget {
  final dynamic video;
  final VoidCallback onTap;

  const _ContinueCard({required this.video, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final progress = video['progress'] as int;

    return Container(
      width: 320,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _thumbnail(progress),
              const SizedBox(height: 12),
              _title(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _thumbnail(int progress) {
    return Stack(
      children: [
        Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF6B5B8C), Color(0xFF9B7B9E)],
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.play_circle_filled,
              size: 56,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: LinearProgressIndicator(
            value: progress / 100,
            minHeight: 4,
            backgroundColor: Colors.black26,
            color: const Color(0xFFD4A574),
          ),
        ),
      ],
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video['title'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            video['seriesTitle'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
