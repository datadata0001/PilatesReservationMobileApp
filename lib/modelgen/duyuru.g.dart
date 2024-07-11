import 'dart:convert';

class Duyuru {
  const Duyuru({
    this.createdAt,
    this.content,
    this.id,
    this.title,
  });

  factory Duyuru.fromMap(Map<String, dynamic> map) {
    return Duyuru(
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
      content: map['content'],
      id: map['id'].toInt(),
      title: map['title'],
    );
  }

  factory Duyuru.fromJson(String source) => Duyuru.fromMap(json.decode(source));

  final DateTime? createdAt;

  final String? content;

  final int? id;

  final String? title;

  Duyuru copyWith({
    DateTime? createdAt,
    String? content,
    int? id,
    String? title,
  }) {
    return Duyuru(
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt?.toIso8601String(),
      'content': content,
      'id': id,
      'title': title,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Duyuru &&
        other.createdAt == createdAt &&
        other.content == content &&
        other.id == id &&
        other.title == title;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^ content.hashCode ^ id.hashCode ^ title.hashCode;
  }

  @override
  String toString() {
    return 'Duyuru(createdAt: $createdAt, content: $content, id: $id, title: $title)';
  }
}
