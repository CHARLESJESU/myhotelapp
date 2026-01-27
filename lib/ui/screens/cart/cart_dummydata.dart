/// Dummy data for Cart screen
class CartDummyData {
  static const List<Map<String, dynamic>> initialCartItemKeys = [
    {'title_key': 'margherita_pizza', 'price': 12.99, 'qty': 2},
    {'title_key': 'classic_burger', 'price': 8.50, 'qty': 1},
    {'title_key': 'caesar_salad', 'price': 7.00, 'qty': 1},
  ];

  static const double deliveryFee = 5.0;
  static const double taxes = 3.32;
}

/// Add the missing translation keys to the JSON files
/*
  "classic_burger": "Classic Burger",
  "caesar_salad": "Caesar Salad"
*/
