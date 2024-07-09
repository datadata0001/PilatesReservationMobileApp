import 'dart:convert';

class Hoca {
  const Hoca({
    this.soyad,
    required this.hocaid,
    this.ad,
  });

  factory Hoca.fromMap(Map<String, dynamic> map) {
    return Hoca(
      soyad: map['soyad'],
      hocaid: map['hocaid'].toInt(),
      ad: map['ad'],
    );
  }

  factory Hoca.fromJson(String source) => Hoca.fromMap(json.decode(source));

  final String? soyad;

  final int hocaid;

  final String? ad;

  Hoca copyWith({
    String? soyad,
    int? hocaid,
    String? ad,
  }) {
    return Hoca(
      soyad: soyad ?? this.soyad,
      hocaid: hocaid ?? this.hocaid,
      ad: ad ?? this.ad,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'soyad': soyad,
      'hocaid': hocaid,
      'ad': ad,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hoca && other.soyad == soyad && other.hocaid == hocaid && other.ad == ad;
  }

  @override
  int get hashCode {
    return soyad.hashCode ^ hocaid.hashCode ^ ad.hashCode;
  }

  @override
  String toString() {
    return 'Hoca(soyad: $soyad, hocaid: $hocaid, ad: $ad)';
  }
}
