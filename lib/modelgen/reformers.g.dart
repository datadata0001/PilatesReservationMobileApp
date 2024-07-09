import 'dart:convert';

class Reformers {
  const Reformers({
    this.daygroup,
    required this.status,
    this.ogrenciId,
    this.timegroup,
    required this.name,
    required this.id,
  });

  factory Reformers.fromMap(Map<String, dynamic> map) {
    return Reformers(
      daygroup: map['daygroup'],
      status: map['status'],
      ogrenciId: map['ogrenci_id']?.toInt(),
      timegroup: map['timegroup'],
      name: map['name'],
      id: map['id'].toInt(),
    );
  }

  factory Reformers.fromJson(String source) => Reformers.fromMap(json.decode(source));

  final String? daygroup;

  final bool status;

  final int? ogrenciId;

  final String? timegroup;

  final String name;

  final int id;

  Reformers copyWith({
    String? daygroup,
    bool? status,
    int? ogrenciId,
    String? timegroup,
    String? name,
    int? id,
  }) {
    return Reformers(
      daygroup: daygroup ?? this.daygroup,
      status: status ?? this.status,
      ogrenciId: ogrenciId ?? this.ogrenciId,
      timegroup: timegroup ?? this.timegroup,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'daygroup': daygroup,
      'status': status,
      'ogrenci_id': ogrenciId,
      'timegroup': timegroup,
      'name': name,
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reformers &&
        other.daygroup == daygroup &&
        other.status == status &&
        other.ogrenciId == ogrenciId &&
        other.timegroup == timegroup &&
        other.name == name &&
        other.id == id;
  }

  @override
  int get hashCode {
    return daygroup.hashCode ^ status.hashCode ^ ogrenciId.hashCode ^ timegroup.hashCode ^ name.hashCode ^ id.hashCode;
  }

  @override
  String toString() {
    return 'Reformers(daygroup: $daygroup, status: $status, ogrenciId: $ogrenciId, timegroup: $timegroup, name: $name, id: $id)';
  }
}