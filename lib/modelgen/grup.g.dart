import 'dart:convert';

class Grup {
  const Grup({
    this.grupsaati,
    this.dersid,
    required this.grupid,
    this.grupismi,
  });

  factory Grup.fromMap(Map<String, dynamic> map) {
    return Grup(
      grupsaati: map['grupsaati'],
      dersid: map['dersid']?.toInt(),
      grupid: map['grupid'].toInt(),
      grupismi: map['grupismi'],
    );
  }

  factory Grup.fromJson(String source) => Grup.fromMap(json.decode(source));

  final String? grupsaati;

  final int? dersid;

  final int grupid;

  final String? grupismi;

  Grup copyWith({
    String? grupsaati,
    int? dersid,
    int? grupid,
    String? grupismi,
  }) {
    return Grup(
      grupsaati: grupsaati ?? this.grupsaati,
      dersid: dersid ?? this.dersid,
      grupid: grupid ?? this.grupid,
      grupismi: grupismi ?? this.grupismi,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'grupsaati': grupsaati,
      'dersid': dersid,
      'grupid': grupid,
      'grupismi': grupismi,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Grup &&
        other.grupsaati == grupsaati &&
        other.dersid == dersid &&
        other.grupid == grupid &&
        other.grupismi == grupismi;
  }

  @override
  int get hashCode {
    return grupsaati.hashCode ^ dersid.hashCode ^ grupid.hashCode ^ grupismi.hashCode;
  }

  @override
  String toString() {
    return 'Grup(grupsaati: $grupsaati, dersid: $dersid, grupid: $grupid, grupismi: $grupismi)';
  }
}
