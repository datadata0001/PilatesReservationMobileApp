import 'dart:convert';

class Hoca {
  const Hoca({
    this.ad,
    required this.hocaid,
    this.soyad,
  });

  factory Hoca.fromMap(Map<String, dynamic> map) {
    return Hoca(
      ad: map['ad'],
      hocaid: map['hocaid'].toInt(),
      soyad: map['soyad'],
    );
  }

  factory Hoca.fromJson(String source) => Hoca.fromMap(json.decode(source));

  final String? ad;

  final int hocaid;

  final String? soyad;

  Hoca copyWith({
    String? ad,
    int? hocaid,
    String? soyad,
  }) {
    return Hoca(
      ad: ad ?? this.ad,
      hocaid: hocaid ?? this.hocaid,
      soyad: soyad ?? this.soyad,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ad': ad,
      'hocaid': hocaid,
      'soyad': soyad,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hoca && other.ad == ad && other.hocaid == hocaid && other.soyad == soyad;
  }

  @override
  int get hashCode {
    return ad.hashCode ^ hocaid.hashCode ^ soyad.hashCode;
  }

  @override
  String toString() {
    return 'Hoca(ad: $ad, hocaid: $hocaid, soyad: $soyad)';
  }
}
