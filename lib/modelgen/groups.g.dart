import 'dart:convert';

class Groups {
  const Groups({
    required this.time,
    required this.day,
    required this.id,
  });

  factory Groups.fromMap(Map<String, dynamic> map) {
    return Groups(
      time: map['time'],
      day: map['day'],
      id: map['id'].toInt(),
    );
  }

  factory Groups.fromJson(String source) => Groups.fromMap(json.decode(source));

  final String time;

  final String day;

  final int id;

  Groups copyWith({
    String? time,
    String? day,
    int? id,
  }) {
    return Groups(
      time: time ?? this.time,
      day: day ?? this.day,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'day': day,
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Groups && other.time == time && other.day == day && other.id == id;
  }

  @override
  int get hashCode {
    return time.hashCode ^ day.hashCode ^ id.hashCode;
  }

  @override
  String toString() {
    return 'Groups(time: $time, day: $day, id: $id)';
  }
}
