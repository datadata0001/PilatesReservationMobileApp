import 'dart:convert';

class Dersgrup {
  const Dersgrup({
    required this.dersgrupid,
    this.grupid,
    this.dersid,
  });

  factory Dersgrup.fromMap(Map<String, dynamic> map) {
    return Dersgrup(
      dersgrupid: map['dersgrupid'].toInt(),
      grupid: map['grupid']?.toInt(),
      dersid: map['dersid']?.toInt(),
    );
  }

  factory Dersgrup.fromJson(String source) => Dersgrup.fromMap(json.decode(source));

  final int dersgrupid;

  final int? grupid;

  final int? dersid;

  Dersgrup copyWith({
    int? dersgrupid,
    int? grupid,
    int? dersid,
  }) {
    return Dersgrup(
      dersgrupid: dersgrupid ?? this.dersgrupid,
      grupid: grupid ?? this.grupid,
      dersid: dersid ?? this.dersid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dersgrupid': dersgrupid,
      'grupid': grupid,
      'dersid': dersid,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Dersgrup && other.dersgrupid == dersgrupid && other.grupid == grupid && other.dersid == dersid;
  }

  @override
  int get hashCode {
    return dersgrupid.hashCode ^ grupid.hashCode ^ dersid.hashCode;
  }

  @override
  String toString() {
    return 'Dersgrup(dersgrupid: $dersgrupid, grupid: $grupid, dersid: $dersid)';
  }
}
