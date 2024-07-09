import 'dart:convert';

class Ders {
  const Ders({
    this.bittarih,
    this.grupid,
    this.hocaid,
    required this.dersid,
    this.saat,
    this.bastarih,
  });

  factory Ders.fromMap(Map<String, dynamic> map) {
    return Ders(
      bittarih: DateTime.tryParse(map['bittarih'] ?? ""),
      grupid: map['grupid']?.toInt(),
      hocaid: map['hocaid']?.toInt(),
      dersid: map['dersid'].toInt(),
      saat: map['saat'],
      bastarih: DateTime.tryParse(map['bastarih'] ?? ""),
    );
  }

  factory Ders.fromJson(String source) => Ders.fromMap(json.decode(source));

  final DateTime? bittarih;

  final int? grupid;

  final int? hocaid;

  final int dersid;

  final String? saat;

  final DateTime? bastarih;

  Ders copyWith({
    DateTime? bittarih,
    int? grupid,
    int? hocaid,
    int? dersid,
    String? saat,
    DateTime? bastarih,
  }) {
    return Ders(
      bittarih: bittarih ?? this.bittarih,
      grupid: grupid ?? this.grupid,
      hocaid: hocaid ?? this.hocaid,
      dersid: dersid ?? this.dersid,
      saat: saat ?? this.saat,
      bastarih: bastarih ?? this.bastarih,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bittarih': bittarih?.toIso8601String(),
      'grupid': grupid,
      'hocaid': hocaid,
      'dersid': dersid,
      'saat': saat,
      'bastarih': bastarih?.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ders &&
        other.bittarih == bittarih &&
        other.grupid == grupid &&
        other.hocaid == hocaid &&
        other.dersid == dersid &&
        other.saat == saat &&
        other.bastarih == bastarih;
  }

  @override
  int get hashCode {
    return bittarih.hashCode ^ grupid.hashCode ^ hocaid.hashCode ^ dersid.hashCode ^ saat.hashCode ^ bastarih.hashCode;
  }

  @override
  String toString() {
    return 'Ders(bittarih: $bittarih, grupid: $grupid, hocaid: $hocaid, dersid: $dersid, saat: $saat, bastarih: $bastarih)';
  }
}
