import 'package:tasks/domain/entities/user.dart';

class TaskEntity {
  final String title;
  final String description;
  final bool state;
  final UserEntity user;

  TaskEntity({
    required this.title,
    required this.description,
    required this.state,
    required this.user
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "state": state,
    "user": user
  };

  factory TaskEntity.fromJson(Map<String, dynamic> json) => TaskEntity(
    title: json["title"],
    description: json["description"],
    state: json["state"],
    user: UserEntity.fromJson(json["user"]),
  );

}