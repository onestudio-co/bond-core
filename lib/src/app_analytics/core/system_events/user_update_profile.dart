mixin UserUpdateProfile {
  int? get id;

  String? get name;

  String? get mobile;

  String? get email;

  String? get dob;

  String? get gender;

  String? get country;

  String? get city;

  int? get age;

  Map<String, dynamic> get customAttributes => {};
}
