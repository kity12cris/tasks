class UserEntity {
  final String name;
  final String email;

  UserEntity({
    required this.name,
    required this.email
});

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
  };

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    name: json["name"],
    email: json["email"],
  );

}