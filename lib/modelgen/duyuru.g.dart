import 'dart:convert';

class Duyuru {
  const Duyuru({
    required this.id,
    this.createdAt,
    this.content,
    this.title,
    this.isAudioArticle,
  });

  factory Duyuru.fromMap(Map<String, dynamic> map) {
    return Duyuru(
      id: map['id'].toInt(),
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
      content: map['content'],
      title: map['title'],
      isAudioArticle: map['is_audio_article'],
    );
  }

  factory Duyuru.fromJson(String source) => Duyuru.fromMap(json.decode(source));

  final int? id;

  final DateTime? createdAt;

  final String? content;

  final String? title;

  final bool? isAudioArticle;

  Duyuru copyWith({
    int? id,
    DateTime? createdAt,
    String? content,
    String? title,
    bool? isAudioArticle,
  }) {
    return Duyuru(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      title: title ?? this.title,
      isAudioArticle: isAudioArticle ?? this.isAudioArticle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'content': content,
      'title': title,
      'is_audio_article': isAudioArticle,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Duyuru &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.content == content &&
        other.title == title &&
        other.isAudioArticle == isAudioArticle;
  }

  @override
  int get hashCode {
    return id.hashCode ^ createdAt.hashCode ^ content.hashCode ^ title.hashCode ^ isAudioArticle.hashCode;
  }

  @override
  String toString() {
    return 'Duyuru(id: $id, createdAt: $createdAt, content: $content, title: $title, isAudioArticle: $isAudioArticle)';
  }
}
