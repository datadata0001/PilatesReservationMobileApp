import 'dart:convert';

class Ogrenci {
  const Ogrenci({
    this.derssaat,
    required this.ogrenciid,
    this.ucret,
    this.ogrencisoyad,
    this.ogrenciad,
    this.grupid,
  });

  factory Ogrenci.fromMap(Map<String, dynamic> map) {
    return Ogrenci(
      derssaat: map['derssaat']?.toInt(),
      ogrenciid: map['ogrenciid'].toInt(),
      ucret: map['ucret']?.toDouble(),
      ogrencisoyad: map['ogrencisoyad'],
      ogrenciad: map['ogrenciad'],
      grupid: map['grupid']?.toInt(),
    );
  }

  factory Ogrenci.fromJson(String source) => Ogrenci.fromMap(json.decode(source));

  final int? derssaat;

  final int ogrenciid;

  final double? ucret;

  final String? ogrencisoyad;

  final String? ogrenciad;

  final int? grupid;

  Ogrenci copyWith({
    int? derssaat,
    int? ogrenciid,
    double? ucret,
    String? ogrencisoyad,
    String? ogrenciad,
    int? grupid,
  }) {
    return Ogrenci(
      derssaat: derssaat ?? this.derssaat,
      ogrenciid: ogrenciid ?? this.ogrenciid,
      ucret: ucret ?? this.ucret,
      ogrencisoyad: ogrencisoyad ?? this.ogrencisoyad,
      ogrenciad: ogrenciad ?? this.ogrenciad,
      grupid: grupid ?? this.grupid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'derssaat': derssaat,
      'ogrenciid': ogrenciid,
      'ucret': ucret,
      'ogrencisoyad': ogrencisoyad,
      'ogrenciad': ogrenciad,
      'grupid': grupid,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ogrenci &&
        other.derssaat == derssaat &&
        other.ogrenciid == ogrenciid &&
        other.ucret == ucret &&
        other.ogrencisoyad == ogrencisoyad &&
        other.ogrenciad == ogrenciad &&
        other.grupid == grupid;
  }

  @override
  int get hashCode {
    return derssaat.hashCode ^
        ogrenciid.hashCode ^
        ucret.hashCode ^
        ogrencisoyad.hashCode ^
        ogrenciad.hashCode ^
        grupid.hashCode;
  }

  @override
  String toString() {
    return 'Ogrenci(derssaat: $derssaat, ogrenciid: $ogrenciid, ucret: $ucret, ogrencisoyad: $ogrencisoyad, ogrenciad: $ogrenciad, grupid: $grupid)';
  }
}
