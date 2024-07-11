import 'dart:convert';

class Reformers {
   Reformers({
    this.timegroup,
    required this.id,
    this.daygroup,
    required this.status,
    required this.name,
    this.userId, String? user_id,
  });

  factory Reformers.fromMap(Map<String, dynamic> map) {
    return Reformers(
      timegroup: map['timegroup'],
      id: map['id'].toInt(),
      daygroup: map['daygroup'],
      status: map['status'],
      name: map['name'],
      userId: map['user_id']?.toInt(),
    );
  }

  factory Reformers.fromJson(String source) => Reformers.fromMap(json.decode(source));

  final String? timegroup;

  final int id;

  final String? daygroup;

  late final bool status;

  late final String name;

  final int? userId;

  Reformers copyWith({
    String? timegroup,
    int? id,
    String? daygroup,
    bool? status,
    String? name,
    int? userId,
  }) {
    return Reformers(
      timegroup: timegroup ?? this.timegroup,
      id: id ?? this.id,
      daygroup: daygroup ?? this.daygroup,
      status: status ?? this.status,
      name: name ?? this.name,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timegroup': timegroup,
      'id': id,
      'daygroup': daygroup,
      'status': status,
      'name': name,
      'user_id': userId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reformers &&
        other.timegroup == timegroup &&
        other.id == id &&
        other.daygroup == daygroup &&
        other.status == status &&
        other.name == name &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return timegroup.hashCode ^ id.hashCode ^ daygroup.hashCode ^ status.hashCode ^ name.hashCode ^ userId.hashCode;
  }

  @override
  String toString() {
    return 'Reformers(timegroup: $timegroup, id: $id, daygroup: $daygroup, status: $status, name: $name, userId: $userId)';
  }
}
