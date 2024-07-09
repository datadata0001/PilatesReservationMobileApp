import 'dart:convert';

class Reformersthursday {
  const Reformersthursday({
    this.daygroup,
    this.timegroup,
    required this.id,
    required this.status,
    this.ogrenciId,
    required this.name,
  });

  factory Reformersthursday.fromMap(Map<String, dynamic> map) {
    return Reformersthursday(
      daygroup: map['daygroup'],
      timegroup: map['timegroup'],
      id: map['id'].toInt(),
      status: map['status'],
      ogrenciId: map['ogrenci_id']?.toInt(),
      name: map['name'],
    );
  }

  factory Reformersthursday.fromJson(String source) => Reformersthursday.fromMap(json.decode(source));

  final String? daygroup;

  final String? timegroup;

  final int id;

  final bool status;

  final int? ogrenciId;

  final String name;

  Reformersthursday copyWith({
    String? daygroup,
    String? timegroup,
    int? id,
    bool? status,
    int? ogrenciId,
    String? name,
  }) {
    return Reformersthursday(
      daygroup: daygroup ?? this.daygroup,
      timegroup: timegroup ?? this.timegroup,
      id: id ?? this.id,
      status: status ?? this.status,
      ogrenciId: ogrenciId ?? this.ogrenciId,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'daygroup': daygroup,
      'timegroup': timegroup,
      'id': id,
      'status': status,
      'ogrenci_id': ogrenciId,
      'name': name,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reformersthursday &&
        other.daygroup == daygroup &&
        other.timegroup == timegroup &&
        other.id == id &&
        other.status == status &&
        other.ogrenciId == ogrenciId &&
        other.name == name;
  }

  @override
  int get hashCode {
    return daygroup.hashCode ^ timegroup.hashCode ^ id.hashCode ^ status.hashCode ^ ogrenciId.hashCode ^ name.hashCode;
  }

  @override
  String toString() {
    return 'Reformersthursday(daygroup: $daygroup, timegroup: $timegroup, id: $id, status: $status, ogrenciId: $ogrenciId, name: $name)';
  }
}
