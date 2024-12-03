class UserModel {
  final String uid;
  final String email;
  final String role;  // Роль пользователя (например, админ, работник)

  UserModel({required this.uid, required this.email, required this.role});
}
