import 'dart:convert';

class Ogrenci {
  const Ogrenci({
    this.derssaat,
    this.ucret,
    required this.ogrenciid,
    this.ogrencisoyad,
    this.ogrenciad,
    this.grupid,
  });

  factory Ogrenci.fromMap(Map<String, dynamic> map) {
    return Ogrenci(
      derssaat: map['derssaat']?.toInt(),
      ucret: map['ucret']?.toDouble(),
      ogrenciid: map['ogrenciid'].toInt(),
      ogrencisoyad: map['ogrencisoyad'],
      ogrenciad: map['ogrenciad'],
      grupid: map['grupid']?.toInt(),
    );
  }

  factory Ogrenci.fromJson(String source) => Ogrenci.fromMap(json.decode(source));

  final int? derssaat;

  final double? ucret;

  final int ogrenciid;

  final String? ogrencisoyad;

  final String? ogrenciad;

  final int? grupid;

  Ogrenci copyWith({
    int? derssaat,
    double? ucret,
    int? ogrenciid,
    String? ogrencisoyad,
    String? ogrenciad,
    int? grupid,
  }) {
    return Ogrenci(
      derssaat: derssaat ?? this.derssaat,
      ucret: ucret ?? this.ucret,
      ogrenciid: ogrenciid ?? this.ogrenciid,
      ogrencisoyad: ogrencisoyad ?? this.ogrencisoyad,
      ogrenciad: ogrenciad ?? this.ogrenciad,
      grupid: grupid ?? this.grupid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'derssaat': derssaat,
      'ucret': ucret,
      'ogrenciid': ogrenciid,
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
        other.ucret == ucret &&
        other.ogrenciid == ogrenciid &&
        other.ogrencisoyad == ogrencisoyad &&
        other.ogrenciad == ogrenciad &&
        other.grupid == grupid;
  }

  @override
  int get hashCode {
    return derssaat.hashCode ^
        ucret.hashCode ^
        ogrenciid.hashCode ^
        ogrencisoyad.hashCode ^
        ogrenciad.hashCode ^
        grupid.hashCode;
  }

  @override
  String toString() {
    return 'Ogrenci(derssaat: $derssaat, ucret: $ucret, ogrenciid: $ogrenciid, ogrencisoyad: $ogrencisoyad, ogrenciad: $ogrenciad, grupid: $grupid)';
  }
}
