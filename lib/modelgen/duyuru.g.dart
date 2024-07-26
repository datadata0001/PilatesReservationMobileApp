import 'dart:convert';

class Duyuru {
  const Duyuru({
    required this.id,
    this.title,
    this.content,
    this.createdAt,
  });

  factory Duyuru.fromMap(Map<String, dynamic> map) {
    return Duyuru(
      id: map['id'].toInt(),
      title: map['title'],
      content: map['content'],
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
    );
  }

  factory Duyuru.fromJson(String source) => Duyuru.fromMap(json.decode(source));

  final int? id;

  final String? title;

  final String? content;

  final DateTime? createdAt;

  Duyuru copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
  }) {
    return Duyuru(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Duyuru &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ content.hashCode ^ createdAt.hashCode;
  }

  @override
  String toString() {
    return 'Duyuru(id: $id, title: $title, content: $content, createdAt: $createdAt)';
  }
}
