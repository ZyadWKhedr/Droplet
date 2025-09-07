import '../../domain/entities/user_entity.dart';

class ProfileModel extends UserEntity {
  const ProfileModel({required super.id, super.email, super.name});

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as String,
      email: map['email'] as String?,
      name: map['username'] as String?,
    );
  }
}
