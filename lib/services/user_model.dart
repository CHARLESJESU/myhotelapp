class User {
  final int userId;
  final String userName;
  final String userEmail;
  final String? phoneNumber;
  final String? userPassword;
  final String? address;
  final bool isAddressProvided;
  final bool isRestaurantOwner;
  final String? lastVisitedScreen;

  User({
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.phoneNumber,
    this.userPassword,
    this.address,
    required this.isAddressProvided,
    required this.isRestaurantOwner,
    this.lastVisitedScreen,
  });

  // Convert from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userid'] ?? 0,
      userName: json['username'] ?? '',
      userEmail: json['useremail'] ?? '',
      phoneNumber: json['phoneNumber'],
      userPassword: json['userpassword'],
      address: json['address'],
      isAddressProvided: json['isaddressprvided'] == 1,
      isRestaurantOwner: json['isrestaurentowner'] == 1,
      lastVisitedScreen: json['last_visited_screen'],
    );
  }

  // Convert to Map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'userid': userId,
      'username': userName,
      'useremail': userEmail,
      'phoneNumber': phoneNumber,
      'userpassword': userPassword,
      'address': address,
      'isaddressprvided': isAddressProvided ? 1 : 0,
      'isrestaurentowner': isRestaurantOwner ? 1 : 0,
      'last_visited_screen': lastVisitedScreen,
    };
  }

  @override
  String toString() {
    return 'User(userId: $userId, userName: $userName, userEmail: $userEmail, phoneNumber: $phoneNumber)';
  }
}