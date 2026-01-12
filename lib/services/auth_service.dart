import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'database_service.dart';
import 'user_model.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  
  final RxBool _isLoggedIn = false.obs;
  final Rx<User?> _currentUser = Rx<User?>(null);

  bool get isLoggedIn => _isLoggedIn.value;
  User? get currentUser => _currentUser.value;
  int get userId => _currentUser.value?.userId ?? 0;
  String get userName => _currentUser.value?.userName ?? '';
  String get userEmail => _currentUser.value?.userEmail ?? '';

  Future<void> loginWithUserData(User user) async {
    final db = await DatabaseService.database;
    await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    _currentUser.value = user;
    _isLoggedIn.value = true;
  }

  Future<void> logout() async {
    final db = await DatabaseService.database;
    await db.delete('users');
    _currentUser.value = null;
    _isLoggedIn.value = false;
  }

  Future<User?> getStoredUser() async {
    final db = await DatabaseService.database;
    final users = await db.query('users', limit: 1);
    
    if (users.isNotEmpty) {
      final user = User.fromJson(users.first);
      _currentUser.value = user;
      _isLoggedIn.value = true;
      return user;
    }
    return null;
  }
}
