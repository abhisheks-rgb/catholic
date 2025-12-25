import 'package:butter/butter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trcas_catholic/modules/home/models/home_model.dart';

/// Toggle this to false when Firebase is ready
const bool useMockHomeData = true;

/// Thumbnail URLs (public CDN)
const adventThumbnail =
    'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800&q=80';
const bibleThumbnail =
    'https://images.unsplash.com/photo-1504052434569-70ad5836ab65?w=800&q=80';
const prayerThumbnail =
    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=800&q=80';
const churchThumbnail =
    'https://images.unsplash.com/photo-1505852679233-d9fd70aff56d?w=800&q=80';

/// ------------------------------------------------------------
/// Load initial home state
/// ------------------------------------------------------------
class LoadHomeDataAction extends BaseAction {
  @override
  Future<AppState?> reduce() async {
    return write<HomeModel>(HomeModel(), (m) {
      m.continueListening ??= [];
      m.featuredSeries ??= [];
    });
  }
}

/// ------------------------------------------------------------
/// Continue Listening
/// ------------------------------------------------------------
class FetchContinueListeningAction extends BaseAction {
  @override
  Future<AppState?> reduce() async {
    try {
      if (useMockHomeData) {
        final mockVideos = [
          {
            'id': 'v1',
            'videoId': 'video_101',
            'seriesId': 'series_1',
            'title': 'Day 1: Hope Is Born',
            'seriesTitle': 'Advent: Thrill of Hope',
            'thumbnailUrl': adventThumbnail,
            'duration': 900, // 15 min
            'position': 300, // 5 min
            'progress': 33,
            'lastPlayedAt': DateTime.now().subtract(const Duration(hours: 2)),
          },
          {
            'id': 'v2',
            'videoId': 'video_102',
            'seriesId': 'series_2',
            'title': 'Genesis – Creation',
            'seriesTitle': 'Bible in a Year',
            'thumbnailUrl': bibleThumbnail,
            'duration': 1200, // 20 min
            'position': 600, // 10 min
            'progress': 50,
            'lastPlayedAt': DateTime.now().subtract(const Duration(days: 1)),
          },
        ];

        await dispatchModel<HomeModel>(HomeModel(), (m) {
          m.continueListening = mockVideos;
        });
      }

      // 🔽 Firebase logic (enable later)
      final userId = 'current_user_id';

      final snapshot = await FirebaseFirestore.instance
          .collection('user_progress')
          .doc(userId)
          .collection('videos')
          .where('progress', isGreaterThan: 0)
          .where('progress', isLessThan: 95)
          .orderBy('lastPlayedAt', descending: true)
          .limit(10)
          .get();

      final videos = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'videoId': data['videoId'],
          'seriesId': data['seriesId'],
          'title': data['title'],
          'seriesTitle': data['seriesTitle'],
          'thumbnailUrl': data['thumbnailUrl'],
          'duration': data['duration'],
          'position': data['position'],
          'progress':
              ((data['position'] as int) / (data['duration'] as int) * 100)
                  .toInt(),
          'lastPlayedAt': (data['lastPlayedAt'] as Timestamp).toDate(),
        };
      }).toList();

      return write<HomeModel>(HomeModel(), (m) {
        m.continueListening = videos;
      });
    } catch (e) {
      Butter.e('Error fetching continue listening: $e');
      return null;
    }
  }
}

/// ------------------------------------------------------------
/// Featured Series
/// ------------------------------------------------------------
class FetchFeaturedSeriesAction extends BaseAction {
  @override
  Future<AppState?> reduce() async {
    try {
      final mockSeries = [
        {
          'id': 'series_1',
          'title': 'Advent: Thrill of Hope',
          'description': 'Prepare your heart this Advent season',
          'category': 'Advent',
          'thumbnailUrl': churchThumbnail,
          'episodeCount': 24,
          'featured': true,
        },
        {
          'id': 'series_2',
          'title': 'Bible in a Year',
          'description': 'Journey through Scripture',
          'category': 'Bible Study',
          'thumbnailUrl': bibleThumbnail,
          'episodeCount': 365,
          'featured': true,
        },
      ];

      return write<HomeModel>(HomeModel(), (m) {
        m.featuredSeries = mockSeries;
      });
    } catch (e) {
      Butter.e('Error fetching featured series: $e');
      return null;
    }
  }
}

/// ------------------------------------------------------------
/// Update Video Progress
/// ------------------------------------------------------------
class UpdateVideoProgressAction extends BaseAction {
  final String videoId;
  final int position;
  final int duration;

  UpdateVideoProgressAction({
    required this.videoId,
    required this.position,
    required this.duration,
  });

  @override
  Future<AppState?> reduce() async {
    try {
      final progress = (position / duration * 100).toInt();

      if (!useMockHomeData) {
        final userId = 'current_user_id';

        await FirebaseFirestore.instance
            .collection('user_progress')
            .doc(userId)
            .collection('videos')
            .doc(videoId)
            .set({
              'videoId': videoId,
              'position': position,
              'duration': duration,
              'progress': progress,
              'lastPlayedAt': FieldValue.serverTimestamp(),
            }, SetOptions(merge: true));
      }

      return write<HomeModel>(HomeModel(), (m) {
        final index =
            m.continueListening?.indexWhere((v) => v['videoId'] == videoId) ??
            -1;

        if (index != -1) {
          final updated = List<Map<String, dynamic>>.from(m.continueListening!);

          updated[index] = {
            ...updated[index],
            'position': position,
            'progress': progress,
            'lastPlayedAt': DateTime.now(),
          };

          m.continueListening = updated;
        }
      });
    } catch (e) {
      Butter.e('Error updating progress: $e');
      return null;
    }
  }
}

/// ------------------------------------------------------------
/// Resume Video
/// ------------------------------------------------------------
class ResumeVideoAction extends BaseAction {
  final String videoId;

  ResumeVideoAction({required this.videoId});

  @override
  Future<AppState?> reduce() async {
    pushNamed('/_/player/$videoId', arguments: {'resume': true});
    return null;
  }
}

/// ------------------------------------------------------------
/// Navigate to Series
/// ------------------------------------------------------------
class NavigateToSeriesAction extends BaseAction {
  final String seriesId;

  NavigateToSeriesAction({required this.seriesId});

  @override
  Future<AppState?> reduce() async {
    pushNamed('/_/series/$seriesId');
    return null;
  }
}
