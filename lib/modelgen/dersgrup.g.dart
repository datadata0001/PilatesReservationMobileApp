import 'dart:convert';

class Dersgrup {
  const Dersgrup({
    required this.dersgrupid,
    this.dersid,
    this.grupid,
  });

  factory Dersgrup.fromMap(Map<String, dynamic> map) {
    return Dersgrup(
      dersgrupid: map['dersgrupid'].toInt(),
      dersid: map['dersid']?.toInt(),
      grupid: map['grupid']?.toInt(),
    );
  }

  factory Dersgrup.fromJson(String source) => Dersgrup.fromMap(json.decode(source));

  final int dersgrupid;

  final int? dersid;

  final int? grupid;

  Dersgrup copyWith({
    int? dersgrupid,
    int? dersid,
    int? grupid,
  }) {
    return Dersgrup(
      dersgrupid: dersgrupid ?? this.dersgrupid,
      dersid: dersid ?? this.dersid,
      grupid: grupid ?? this.grupid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dersgrupid': dersgrupid,
      'dersid': dersid,
      'grupid': grupid,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Dersgrup && other.dersgrupid == dersgrupid && other.dersid == dersid && other.grupid == grupid;
  }

  @override
  int get hashCode {
    return dersgrupid.hashCode ^ dersid.hashCode ^ grupid.hashCode;
  }

  @override
  String toString() {
    return 'Dersgrup(dersgrupid: $dersgrupid, dersid: $dersid, grupid: $grupid)';
  }
}
