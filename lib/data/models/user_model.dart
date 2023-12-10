class UserModel {
  String? name;
  String? phone;
  String? password;
  String? deviceInfo;

  UserModel({this.name, this.password, this.phone});

  Map<String, dynamic> loginUserToJson() {
    return {"phone": phone, "password": password};
  }

  Map<String, dynamic> registerUserToJson() {
    return {
      "phone": phone,
      "password": password,
      "name": name,
      "confirm_password": password
    };
  }
}
