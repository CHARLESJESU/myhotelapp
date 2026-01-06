/// Data model for Order Item
class OrderItem {
  final String name;
  final String time;
  final List<String> items;
  final String address;
  final String phone;
  final double price;
  final String status;

  OrderItem({
    required this.name,
    required this.time,
    required this.items,
    required this.address,
    required this.phone,
    required this.price,
    required this.status,
  });
}

/// Dummy data for Admin Order Management screen
class AdminOrderManagementDummyData {
  static final List<OrderItem> sampleOrders = [
    OrderItem(
      name: 'John Doe',
      time: '12:30 PM, Oct 26',
      items: ['2x Classic Burger', '1x Fries'],
      address: '123 Main St, Anytown, USA',
      phone: '(123) 456-7890',
      price: 25.50,
      status: 'New',
    ),
    OrderItem(
      name: 'Jane Smith',
      time: '12:25 PM, Oct 26',
      items: ['1x Pepperoni Pizza'],
      address: '456 Oak Ave, Anytown, USA',
      phone: '(987) 654-3210',
      price: 18.00,
      status: 'Preparing',
    ),
    OrderItem(
      name: 'Sam Wilson',
      time: '12:15 PM, Oct 26',
      items: ['3x Tacos', '1x Guacamole'],
      address: '789 Pine Ln, Anytown, USA',
      phone: '(555) 123-4567',
      price: 22.75,
      status: 'Delivered',
    ),
  ];
}
