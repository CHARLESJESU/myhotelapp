import 'package:get/get.dart';
import 'database_service.dart';
import 'user_model.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final RxBool _isLoggedIn = false.obs;
  final RxInt _userId = 0.obs;
  final RxString _userName = ''.obs;
  final RxString _userEmail = ''.obs;
  final RxString _token = ''.obs;

  bool get isLoggedIn => _isLoggedIn.value;
  int get userId => _userId.value;
  String get userName => _userName.value;
  String get userEmail => _userEmail.value;
  String get token => _token.value;

  Future<void> login(int userId, String userName, String userEmail, String token) async {
    _isLoggedIn.value = true;
    _userId.value = userId;
    _userName.value = userName;
    _userEmail.value = userEmail;
    _token.value = token;
  }

  Future<void> loginWithUserData(User user, String token) async {
    // Store user data in SQLite database
    await DatabaseService.instance.insertOrUpdateUser(user.toMap());

    // Update authentication state
    _isLoggedIn.value = true;
    _userId.value = user.userId;
    _userName.value = user.userName;
    _userEmail.value = user.userEmail;
    _token.value = token;
  }

  Future<void> logout() async {
    // Clear user data from database
    final db = await DatabaseService.instance.database;
    await db.delete('users'); // Clear all users since we only have one logged in at a time

    // Clear authentication state
    _isLoggedIn.value = false;
    _userId.value = 0;
    _userName.value = '';
    _userEmail.value = '';
    _token.value = '';
  }

  // Get stored user from database
  Future<User?> getStoredUser() async {
    // Query the database for any stored user
    final db = await DatabaseService.instance.database;
    final List<Map<String, dynamic>> users = await db.query('users');

    if (users.isNotEmpty) {
      // Return the first user (assuming only one user is logged in at a time)
      final user = User.fromJson(users.first);

      // Update authentication state to reflect the stored user
      _isLoggedIn.value = true;
      _userId.value = user.userId;
      _userName.value = user.userName;
      _userEmail.value = user.userEmail;

      return user;
    }
    return null;
  }

  // Store the last visited screen
  Future<void> setLastVisitedScreen(String? screenName) async {
    // Get the current user data
    final userData = await DatabaseService.instance.getUserById(_userId.value);
    if (userData != null) {
      // Update the user object with the new last visited screen
      final user = User.fromJson(userData);
      final updatedUser = User(
        userId: user.userId,
        userName: user.userName,
        userEmail: user.userEmail,
        phoneNumber: user.phoneNumber,
        userPassword: user.userPassword,
        address: user.address,
        isAddressProvided: user.isAddressProvided,
        isRestaurantOwner: user.isRestaurantOwner,
        lastVisitedScreen: screenName?.isEmpty == true ? null : screenName,
      );

      // Save the updated user back to the database
      await DatabaseService.instance.insertOrUpdateUser(updatedUser.toMap());
    }
  }

  // Get the last visited screen
  Future<String?> getLastVisitedScreen() async {
    if (_userId.value != 0) {
      final userData = await DatabaseService.instance.getUserById(_userId.value);
      if (userData != null) {
        final user = User.fromJson(userData);
        return user.lastVisitedScreen;
      }
    }
    return null;
  }
}