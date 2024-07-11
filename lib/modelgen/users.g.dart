import 'dart:convert';

class Users {
  const Users({
    required this.phone,
    required this.userId,
    this.fee,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.classHours,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      phone: map['phone'],
      userId: map['user_id'].toInt(),
      fee: map['fee']?.toDouble(),
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      classHours: map['class_hours']?.toInt(),
    );
  }

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  final String phone;

  final int userId;

  final double? fee;

  final String email;

  final String firstName;

  final String lastName;

  final int? classHours;

  Users copyWith({
    String? phone,
    int? userId,
    double? fee,
    String? email,
    String? firstName,
    String? lastName,
    int? classHours,
  }) {
    return Users(
      phone: phone ?? this.phone,
      userId: userId ?? this.userId,
      fee: fee ?? this.fee,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      classHours: classHours ?? this.classHours,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'user_id': userId,
      'fee': fee,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'class_hours': classHours,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Users &&
        other.phone == phone &&
        other.userId == userId &&
        other.fee == fee &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.classHours == classHours;
  }

  @override
  int get hashCode {
    return phone.hashCode ^
        userId.hashCode ^
        fee.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        classHours.hashCode;
  }

  @override
  String toString() {
    return 'Users(phone: $phone, userId: $userId, fee: $fee, email: $email, firstName: $firstName, lastName: $lastName, classHours: $classHours)';
  }
}
