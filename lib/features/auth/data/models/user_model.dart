import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.id, super.email, super.name});

  factory UserModel.fromSupabase(Map<String, dynamic> user) {
    return UserModel(
      id: user['id'] as String,
      email: user['email'] as String?,
      name: user['user_metadata']?['name'] as String?,
    );
  }
}
