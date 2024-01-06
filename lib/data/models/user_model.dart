import 'package:house_of_genuises/data/providers/casheProvider/cashe_provider.dart';

class User {
  final int? id;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? password;
  final int? isBlocked;
  final String? image;
  final String? type;
  final String? location;

  User(
      {this.id,
      this.fullName,
      this.email,
      this.phone,
      this.isBlocked,
      this.type,
      this.password,
      this.image,
      this.location});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      isBlocked: json['is_blocked'],
      type: json['type'],
    );
  }
  Map<String, dynamic> loginUserToJson() {
    return {
      "phone": phone,
      "password": password,
      "device_id": CacheProvider().getDeviceId()
    };
  }

  Map<String, dynamic> registerUserToJson() {
    return {
      "full_name": fullName,
      "phone": phone,
      "password": password,
      "device_id": CacheProvider().getDeviceId(),
      "email": "hamzafz888@gmail.com"
    };
  }
}
