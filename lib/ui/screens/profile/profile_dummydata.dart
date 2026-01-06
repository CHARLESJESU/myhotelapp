/// Dummy data for Profile screen
class ProfileDummyData {
  static const String userName = 'Jane Doe';
  static const String userEmail = 'jane.doe@email.com';

  static const List<Map<String, dynamic>> accountItems = [
    {'label': 'Personal Information', 'icon': 'person'},
    {'label': 'My Addresses', 'icon': 'place'},
    {'label': 'Payment Methods', 'icon': 'credit_card'},
    {'label': 'Order History', 'icon': 'receipt_long'},
  ];

  static const List<Map<String, dynamic>> supportItems = [
    {'label': 'Help & Support', 'icon': 'help_outline'},
    {'label': 'About', 'icon': 'info_outline'},
  ];
}
