import 'dart:convert';

class Reformerswednesday {
  const Reformerswednesday({
    required this.status,
    this.timegroup,
    required this.name,
    this.daygroup,
    required this.id,
    this.ogrenciId,
  });

  factory Reformerswednesday.fromMap(Map<String, dynamic> map) {
    return Reformerswednesday(
      status: map['status'],
      timegroup: map['timegroup'],
      name: map['name'],
      daygroup: map['daygroup'],
      id: map['id'].toInt(),
      ogrenciId: map['ogrenci_id']?.toInt(),
    );
  }

  factory Reformerswednesday.fromJson(String source) => Reformerswednesday.fromMap(json.decode(source));

  final bool status;

  final String? timegroup;

  final String name;

  final String? daygroup;

  final int id;

  final int? ogrenciId;

  Reformerswednesday copyWith({
    bool? status,
    String? timegroup,
    String? name,
    String? daygroup,
    int? id,
    int? ogrenciId,
  }) {
    return Reformerswednesday(
      status: status ?? this.status,
      timegroup: timegroup ?? this.timegroup,
      name: name ?? this.name,
      daygroup: daygroup ?? this.daygroup,
      id: id ?? this.id,
      ogrenciId: ogrenciId ?? this.ogrenciId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'timegroup': timegroup,
      'name': name,
      'daygroup': daygroup,
      'id': id,
      'ogrenci_id': ogrenciId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reformerswednesday &&
        other.status == status &&
        other.timegroup == timegroup &&
        other.name == name &&
        other.daygroup == daygroup &&
        other.id == id &&
        other.ogrenciId == ogrenciId;
  }

  @override
  int get hashCode {
    return status.hashCode ^ timegroup.hashCode ^ name.hashCode ^ daygroup.hashCode ^ id.hashCode ^ ogrenciId.hashCode;
  }

  @override
  String toString() {
    return 'Reformerswednesday(status: $status, timegroup: $timegroup, name: $name, daygroup: $daygroup, id: $id, ogrenciId: $ogrenciId)';
  }
}
