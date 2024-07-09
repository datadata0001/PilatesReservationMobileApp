import 'dart:convert';

class Reformerstuesday {
  const Reformerstuesday({
    required this.name,
    this.daygroup,
    this.timegroup,
    this.ogrenciId,
    required this.status,
    required this.id,
  });

  factory Reformerstuesday.fromMap(Map<String, dynamic> map) {
    return Reformerstuesday(
      name: map['name'],
      daygroup: map['daygroup'],
      timegroup: map['timegroup'],
      ogrenciId: map['ogrenci_id']?.toInt(),
      status: map['status'],
      id: map['id'].toInt(),
    );
  }

  factory Reformerstuesday.fromJson(String source) => Reformerstuesday.fromMap(json.decode(source));

  final String name;

  final String? daygroup;

  final String? timegroup;

  final int? ogrenciId;

  final bool status;

  final int id;

  Reformerstuesday copyWith({
    String? name,
    String? daygroup,
    String? timegroup,
    int? ogrenciId,
    bool? status,
    int? id,
  }) {
    return Reformerstuesday(
      name: name ?? this.name,
      daygroup: daygroup ?? this.daygroup,
      timegroup: timegroup ?? this.timegroup,
      ogrenciId: ogrenciId ?? this.ogrenciId,
      status: status ?? this.status,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'daygroup': daygroup,
      'timegroup': timegroup,
      'ogrenci_id': ogrenciId,
      'status': status,
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reformerstuesday &&
        other.name == name &&
        other.daygroup == daygroup &&
        other.timegroup == timegroup &&
        other.ogrenciId == ogrenciId &&
        other.status == status &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^ daygroup.hashCode ^ timegroup.hashCode ^ ogrenciId.hashCode ^ status.hashCode ^ id.hashCode;
  }

  @override
  String toString() {
    return 'Reformerstuesday(name: $name, daygroup: $daygroup, timegroup: $timegroup, ogrenciId: $ogrenciId, status: $status, id: $id)';
  }
}
