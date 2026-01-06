/// Dummy data for Home screen
class HomeDummyData {
  static const List<String> categories = [
    'Pizza',
    'Sushi',
    'Burgers',
    'Desserts',
    'Drinks',
  ];

  static const String greeting = 'Good morning, Alex!';
  static const String deliveryLocation = 'Delivering to Home';

  static const Map<String, dynamic> promoData = {
    'title': '50% OFF Your First Order',
    'subtitle': 'Valid for new users only',
  };

  static const Map<String, dynamic> featuredDish = {
    'name': 'Spicy Pizza',
    'restaurant': 'Pizzeria Roma',
    'price': 14.99,
  };

  static const Map<String, dynamic> restaurantData = {
    'name': 'The Gourmet Kitchen',
    'cuisine': 'Italian • \$\$',
    'rating': 4.8,
    'deliveryTime': '25-35 min',
  };
}
