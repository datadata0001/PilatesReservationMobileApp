import 'dart:convert';

class Duyuru {
  const Duyuru({
    this.content,
    this.isAudioArticle,
    this.createdAt,
    this.title,
    required this.id,
  });

  factory Duyuru.fromMap(Map<String, dynamic> map) {
    return Duyuru(
      content: map['content'],
      isAudioArticle: map['is_audio_article'],
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
      title: map['title'],
      id: map['id'].toInt(),
    );
  }

  factory Duyuru.fromJson(String source) => Duyuru.fromMap(json.decode(source));

  final String? content;

  final bool? isAudioArticle;

  final DateTime? createdAt;

  final String? title;

  final int? id;

  Duyuru copyWith({
    String? content,
    bool? isAudioArticle,
    DateTime? createdAt,
    String? title,
    int? id,
  }) {
    return Duyuru(
      content: content ?? this.content,
      isAudioArticle: isAudioArticle ?? this.isAudioArticle,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'is_audio_article': isAudioArticle,
      'created_at': createdAt?.toIso8601String(),
      'title': title,
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Duyuru &&
        other.content == content &&
        other.isAudioArticle == isAudioArticle &&
        other.createdAt == createdAt &&
        other.title == title &&
        other.id == id;
  }

  @override
  int get hashCode {
    return content.hashCode ^ isAudioArticle.hashCode ^ createdAt.hashCode ^ title.hashCode ^ id.hashCode;
  }

  @override
  String toString() {
    return 'Duyuru(content: $content, isAudioArticle: $isAudioArticle, createdAt: $createdAt, title: $title, id: $id)';
  }
}
