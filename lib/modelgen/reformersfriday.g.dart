import 'dart:convert';

class Reformersfriday {
  const Reformersfriday({
    this.daygroup,
    required this.id,
    required this.status,
    this.ogrenciId,
    this.timegroup,
    required this.name,
  });

  factory Reformersfriday.fromMap(Map<String, dynamic> map) {
    return Reformersfriday(
      daygroup: map['daygroup'],
      id: map['id'].toInt(),
      status: map['status'],
      ogrenciId: map['ogrenci_id']?.toInt(),
      timegroup: map['timegroup'],
      name: map['name'],
    );
  }

  factory Reformersfriday.fromJson(String source) => Reformersfriday.fromMap(json.decode(source));

  final String? daygroup;

  final int id;

  final bool status;

  final int? ogrenciId;

  final String? timegroup;

  final String name;

  Reformersfriday copyWith({
    String? daygroup,
    int? id,
    bool? status,
    int? ogrenciId,
    String? timegroup,
    String? name,
  }) {
    return Reformersfriday(
      daygroup: daygroup ?? this.daygroup,
      id: id ?? this.id,
      status: status ?? this.status,
      ogrenciId: ogrenciId ?? this.ogrenciId,
      timegroup: timegroup ?? this.timegroup,
      name: name ?? this.name,
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
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reformersfriday &&
        other.daygroup == daygroup &&
        other.id == id &&
        other.status == status &&
        other.ogrenciId == ogrenciId &&
        other.timegroup == timegroup &&
        other.name == name;
  }

  @override
  int get hashCode {
    return daygroup.hashCode ^ id.hashCode ^ status.hashCode ^ ogrenciId.hashCode ^ timegroup.hashCode ^ name.hashCode;
  }

  @override
  String toString() {
    return 'Reformersfriday(daygroup: $daygroup, id: $id, status: $status, ogrenciId: $ogrenciId, timegroup: $timegroup, name: $name)';
  }
}
