import 'dart:convert';

class Reformers {
  const Reformers({
    this.timegroup,
    this.userId,
    required this.id,
    required this.status,
    required this.name,
    this.daygroup,
  });

  factory Reformers.fromMap(Map<String, dynamic> map) {
    return Reformers(
      timegroup: map['timegroup'],
      userId: map['user_id']?.toInt(),
      id: map['id'].toInt(),
      status: map['status'],
      name: map['name'],
      daygroup: map['daygroup'],
    );
  }

  factory Reformers.fromJson(String source) => Reformers.fromMap(json.decode(source));

  final String? timegroup;

  final int? userId;

  final int id;

  final bool status;

  final String? name;

  final String? daygroup;

  Reformers copyWith({
    String? timegroup,
    int? userId,
    int? id,
    bool? status,
    String? name,
    String? daygroup,
  }) {
    return Reformers(
      timegroup: timegroup ?? this.timegroup,
      userId: userId ?? this.userId,
      id: id ?? this.id,
      status: status ?? this.status,
      name: name ?? this.name,
      daygroup: daygroup ?? this.daygroup,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timegroup': timegroup,
      'user_id': userId,
      'id': id,
      'status': status,
      'name': name,
      'daygroup': daygroup,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reformers &&
        other.timegroup == timegroup &&
        other.userId == userId &&
        other.id == id &&
        other.status == status &&
        other.name == name &&
        other.daygroup == daygroup;
  }

  @override
  int get hashCode {
    return timegroup.hashCode ^ userId.hashCode ^ id.hashCode ^ status.hashCode ^ name.hashCode ^ daygroup.hashCode;
  }

  @override
  String toString() {
    return 'Reformers(timegroup: $timegroup, userId: $userId, id: $id, status: $status, name: $name, daygroup: $daygroup)';
  }
}
