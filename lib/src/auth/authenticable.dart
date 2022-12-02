mixin Authenticable {
  int get id;

  String? get name;

  String? get email;

  String? get phone;

  DateTime? get verificationAt;

  Type get type => Authenticable;
}
