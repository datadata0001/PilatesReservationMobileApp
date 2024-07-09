import 'dart:convert';

class Reformers {
   Reformers({
    this.daygroup,
    required this.id,
    this.status,
    this.ogrenciId,
    this.timegroup,
    this.name,
    this.groupId,
  });

  factory Reformers.fromMap(Map<String, dynamic> map) {
    return Reformers(
      daygroup: map['daygroup'],
      id: map['id'].toInt(),
      status: map['status'],
      ogrenciId: map['ogrenci_id']?.toInt(),
      timegroup: map['timegroup'],
      name: map['name'],
      groupId: map['group_id']?.toInt(),
    );
  }

  factory Reformers.fromJson(String source) => Reformers.fromMap(json.decode(source));

  final String? daygroup;

  final int id;

  late  bool? status;

  late  int? ogrenciId;

  final String? timegroup;

  final String? name;

  final int? groupId;

  Reformers copyWith({
    String? daygroup,
    int? id,
    bool? status,
    int? ogrenciId,
    String? timegroup,
    String? name,
    int? groupId,
  }) {
    return Reformers(
      daygroup: daygroup ?? this.daygroup,
      id: id ?? this.id,
      status: status ?? this.status,
      ogrenciId: ogrenciId ?? this.ogrenciId,
      timegroup: timegroup ?? this.timegroup,
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'daygroup': daygroup,
      'id': id,
      'status': status,
      'ogrenci_id': ogrenciId,
      'timegroup': timegroup,
      'name': name,
      'group_id': groupId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reformers &&
        other.daygroup == daygroup &&
        other.id == id &&
        other.status == status &&
        other.ogrenciId == ogrenciId &&
        other.timegroup == timegroup &&
        other.name == name &&
        other.groupId == groupId;
  }

  @override
  int get hashCode {
    return daygroup.hashCode ^
        id.hashCode ^
        status.hashCode ^
        ogrenciId.hashCode ^
        timegroup.hashCode ^
        name.hashCode ^
        groupId.hashCode;
  }

  @override
  String toString() {
    return 'Reformers(daygroup: $daygroup, id: $id, status: $status, ogrenciId: $ogrenciId, timegroup: $timegroup, name: $name, groupId: $groupId)';
  }
}
