import 'dart:convert';

class Ders {
  const Ders({
    this.saat,
    this.bastarih,
    this.bittarih,
    this.grupid,
    this.hocaid,
    required this.dersid,
  });

  factory Ders.fromMap(Map<String, dynamic> map) {
    return Ders(
      saat: map['saat'],
      bastarih: DateTime.tryParse(map['bastarih'] ?? ""),
      bittarih: DateTime.tryParse(map['bittarih'] ?? ""),
      grupid: map['grupid']?.toInt(),
      hocaid: map['hocaid']?.toInt(),
      dersid: map['dersid'].toInt(),
    );
  }

  factory Ders.fromJson(String source) => Ders.fromMap(json.decode(source));

  final String? saat;

  final DateTime? bastarih;

  final DateTime? bittarih;

  final int? grupid;

  final int? hocaid;

  final int dersid;

  Ders copyWith({
    String? saat,
    DateTime? bastarih,
    DateTime? bittarih,
    int? grupid,
    int? hocaid,
    int? dersid,
  }) {
    return Ders(
      saat: saat ?? this.saat,
      bastarih: bastarih ?? this.bastarih,
      bittarih: bittarih ?? this.bittarih,
      grupid: grupid ?? this.grupid,
      hocaid: hocaid ?? this.hocaid,
      dersid: dersid ?? this.dersid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'saat': saat,
      'bastarih': bastarih?.toIso8601String(),
      'bittarih': bittarih?.toIso8601String(),
      'grupid': grupid,
      'hocaid': hocaid,
      'dersid': dersid,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ders &&
        other.saat == saat &&
        other.bastarih == bastarih &&
        other.bittarih == bittarih &&
        other.grupid == grupid &&
        other.hocaid == hocaid &&
        other.dersid == dersid;
  }

  @override
  int get hashCode {
    return saat.hashCode ^ bastarih.hashCode ^ bittarih.hashCode ^ grupid.hashCode ^ hocaid.hashCode ^ dersid.hashCode;
  }

  @override
  String toString() {
    return 'Ders(saat: $saat, bastarih: $bastarih, bittarih: $bittarih, grupid: $grupid, hocaid: $hocaid, dersid: $dersid)';
  }
}
