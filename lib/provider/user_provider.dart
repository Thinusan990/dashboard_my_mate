

import 'package:dashboard_my_mate/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user){
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  bool hasPermission(String permission) {
    if (_user == null) return false;

    switch (_user!.role) {
      case UserRole.superAdmin:
        return true; // Full access
      case UserRole.admin:
      // Define admin permissions
        return ['add', 'changeType', 'view'].contains(permission);
      case UserRole.manager:
      // Define manager permissions
        return ['view'].contains(permission);
      default:
        return false;
    }
  }
}