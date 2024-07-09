import 'dart:convert';

class Reformersmonday {
  const Reformersmonday({
    required this.id,
    required this.name,
    this.timegroup,
    this.daygroup,
    this.ogrenciId,
    required this.status,
  });

  factory Reformersmonday.fromMap(Map<String, dynamic> map) {
    return Reformersmonday(
      id: map['id'].toInt(),
      name: map['name'],
      timegroup: map['timegroup'],
      daygroup: map['daygroup'],
      ogrenciId: map['ogrenci_id']?.toInt(),
      status: map['status'],
    );
  }

  factory Reformersmonday.fromJson(String source) => Reformersmonday.fromMap(json.decode(source));

  final int id;

  final String name;

  final String? timegroup;

  final String? daygroup;

  final int? ogrenciId;

  final bool status;

  Reformersmonday copyWith({
    int? id,
    String? name,
    String? timegroup,
    String? daygroup,
    int? ogrenciId,
    bool? status,
  }) {
    return Reformersmonday(
      id: id ?? this.id,
      name: name ?? this.name,
      timegroup: timegroup ?? this.timegroup,
      daygroup: daygroup ?? this.daygroup,
      ogrenciId: ogrenciId ?? this.ogrenciId,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'timegroup': timegroup,
      'daygroup': daygroup,
      'ogrenci_id': ogrenciId,
      'status': status,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reformersmonday &&
        other.id == id &&
        other.name == name &&
        other.timegroup == timegroup &&
        other.daygroup == daygroup &&
        other.ogrenciId == ogrenciId &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ timegroup.hashCode ^ daygroup.hashCode ^ ogrenciId.hashCode ^ status.hashCode;
  }

  @override
  String toString() {
    return 'Reformersmonday(id: $id, name: $name, timegroup: $timegroup, daygroup: $daygroup, ogrenciId: $ogrenciId, status: $status)';
  }
}
