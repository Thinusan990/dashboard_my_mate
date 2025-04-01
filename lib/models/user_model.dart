enum UserRole { admin, manager, superAdmin }

class UserModel {
  final String uid;
  final String email;
  final String fullName;
  final UserRole role;

  UserModel({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    String roleStr = data['role'] ?? 'manager';
    UserRole role;

    switch (roleStr.toLowerCase()) {
      case 'admin':
        role = UserRole.admin;
        break;
      case 'superadmin':
        role = UserRole.superAdmin;
        break;
      case 'manager':
      default:
        role = UserRole.manager;
    }

    return UserModel(
      uid: data['uid'],
      email: data['email'],
      fullName: data['fullName'],
      role: role,
    );
  }
}
