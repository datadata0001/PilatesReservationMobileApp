import 'dart:convert';

class Users {
  const Users({
    required this.email,
    required this.userId,
    this.classHours,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.fee,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      email: map['email'],
      userId: map['user_id'].toInt(),
      classHours: map['class_hours']?.toInt(),
      firstName: map['first_name'],
      lastName: map['last_name'],
      phone: map['phone'],
      fee: map['fee']?.toDouble(),
    );
  }

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  final String email;

  final int userId;

  final int? classHours;

  final String firstName;

  final String lastName;

  final String phone;

  final double? fee;

  Users copyWith({
    String? email,
    int? userId,
    int? classHours,
    String? firstName,
    String? lastName,
    String? phone,
    double? fee,
  }) {
    return Users(
      email: email ?? this.email,
      userId: userId ?? this.userId,
      classHours: classHours ?? this.classHours,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      fee: fee ?? this.fee,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'user_id': userId,
      'class_hours': classHours,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'fee': fee,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Users &&
        other.email == email &&
        other.userId == userId &&
        other.classHours == classHours &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phone == phone &&
        other.fee == fee;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        userId.hashCode ^
        classHours.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        phone.hashCode ^
        fee.hashCode;
  }

  @override
  String toString() {
    return 'Users(email: $email, userId: $userId, classHours: $classHours, firstName: $firstName, lastName: $lastName, phone: $phone, fee: $fee)';
  }
}
