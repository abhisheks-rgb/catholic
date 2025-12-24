class Series {
  final String id;
  final String title;
  final String description;
  final String category;
  final int episodeCount;
  final bool isFavourite;
  final String? thumbnailUrl;

  Series({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.episodeCount,
    this.isFavourite = false,
    this.thumbnailUrl,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      episodeCount: json['episodeCount'] ?? 0,
      isFavourite: json['isFavourite'] ?? false,
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'episodeCount': episodeCount,
      'isFavourite': isFavourite,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  Series copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    int? episodeCount,
    bool? isFavourite,
    String? thumbnailUrl,
  }) {
    return Series(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      episodeCount: episodeCount ?? this.episodeCount,
      isFavourite: isFavourite ?? this.isFavourite,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }
}
