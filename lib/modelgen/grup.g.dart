import 'dart:convert';

class Grup {
  const Grup({
    this.grupsaati,
    this.grupismi,
    required this.grupid,
    this.dersid,
  });

  factory Grup.fromMap(Map<String, dynamic> map) {
    return Grup(
      grupsaati: map['grupsaati'],
      grupismi: map['grupismi'],
      grupid: map['grupid'].toInt(),
      dersid: map['dersid']?.toInt(),
    );
  }

  factory Grup.fromJson(String source) => Grup.fromMap(json.decode(source));

  final String? grupsaati;

  final String? grupismi;

  final int grupid;

  final int? dersid;

  Grup copyWith({
    String? grupsaati,
    String? grupismi,
    int? grupid,
    int? dersid,
  }) {
    return Grup(
      grupsaati: grupsaati ?? this.grupsaati,
      grupismi: grupismi ?? this.grupismi,
      grupid: grupid ?? this.grupid,
      dersid: dersid ?? this.dersid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'grupsaati': grupsaati,
      'grupismi': grupismi,
      'grupid': grupid,
      'dersid': dersid,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Grup &&
        other.grupsaati == grupsaati &&
        other.grupismi == grupismi &&
        other.grupid == grupid &&
        other.dersid == dersid;
  }

  @override
  int get hashCode {
    return grupsaati.hashCode ^ grupismi.hashCode ^ grupid.hashCode ^ dersid.hashCode;
  }

  @override
  String toString() {
    return 'Grup(grupsaati: $grupsaati, grupismi: $grupismi, grupid: $grupid, dersid: $dersid)';
  }
}
