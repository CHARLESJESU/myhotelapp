import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'confirm_order_dialog.dart';
import 'track_order_screen.dart';

class CartScreen extends StatefulWidget {
  final bool isDark;
  const CartScreen({super.key, this.isDark = true});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> items = [
    {'title': 'Margherita Pizza', 'price': 12.99, 'qty': 2},
    {'title': 'Classic Burger', 'price': 8.50, 'qty': 1},
    {'title': 'Caesar Salad', 'price': 7.00, 'qty': 1},
  ];

  final double deliveryFee = 5.0;
  final double taxes = 3.32;

  void _changeQty(int index, int delta) {
    setState(() {
      final q = items[index]['qty'] as int;
      final newQ = (q + delta).clamp(0, 99);
      items[index]['qty'] = newQ;
    });
  }

  double get subtotal =>
      items.fold(0.0, (s, item) => s + item['price'] * item['qty']);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark
        ? AppColors.screenBackground
        : AppColors.lightScreenBackground;
    final primaryText = isDark
        ? AppColors.primaryText
        : AppColors.lightPrimaryText;
    final secondaryText = isDark
        ? AppColors.secondaryText
        : AppColors.lightSecondaryText;
    final cardBg = isDark ? AppColors.cardDark : AppColors.lightCard;
    final buttonBg = isDark ? AppColors.buttonBg : AppColors.lightButtonBg;
    final buttonText = isDark
        ? AppColors.buttonText
        : AppColors.lightButtonText;

    final total = subtotal + deliveryFee + taxes;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'My Cart',
          style: TextStyle(color: primaryText, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline, color: primaryText),
            onPressed: () {
              setState(() => items.clear());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final item = items[i];
                  return Container(
                    height: 84,
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            color: AppColors.uploadPlaceholder,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: TextStyle(
                                  color: primaryText,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '\$${(item['price'] as double).toStringAsFixed(2)}',
                                style: TextStyle(color: secondaryText),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            _qtyButton('-', () => _changeQty(i, -1)),
                            const SizedBox(width: 8),
                            Text(
                              '${item['qty']}',
                              style: TextStyle(color: primaryText),
                            ),
                            const SizedBox(width: 8),
                            _qtyButton('+', () => _changeQty(i, 1)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            _summaryRow(
              'Subtotal',
              '\$${subtotal.toStringAsFixed(2)}',
              primaryText,
              secondaryText,
            ),
            const SizedBox(height: 8),
            _summaryRow(
              'Delivery Fee',
              '\$${deliveryFee.toStringAsFixed(2)}',
              primaryText,
              secondaryText,
            ),
            const SizedBox(height: 8),
            _summaryRow(
              'Taxes',
              '\$${taxes.toStringAsFixed(2)}',
              primaryText,
              secondaryText,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total', style: TextStyle(color: secondaryText)),
                        Text(
                          '\$${total.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonBg,
                        foregroundColor: buttonText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (_) => ConfirmOrderDialog(
                            items: items,
                            deliveryFee: deliveryFee,
                            taxes: taxes,
                          ),
                        );

                        if (confirmed == true) {
                          // simple UI-only confirmation: clear cart then open tracking page
                          setState(() => items.clear());
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => TrackOrderScreen(),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Place Order',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _qtyButton(String label, VoidCallback onTap) => Container(
    width: 36,
    height: 36,
    decoration: BoxDecoration(
      color: AppColors.cardDark,
      shape: BoxShape.circle,
    ),
    child: IconButton(
      padding: EdgeInsets.zero,
      icon: Text(
        label,
        style: const TextStyle(
          color: AppColors.buttonText,
          fontWeight: FontWeight.w700,
        ),
      ),
      onPressed: onTap,
    ),
  );

  Widget _summaryRow(
    String label,
    String value,
    Color primaryText,
    Color secondaryText,
  ) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
    child: Row(
      children: [
        Text(label, style: TextStyle(color: secondaryText)),
        const Spacer(),
        Text(
          value,
          style: TextStyle(color: primaryText, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}
