import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../confirm_order_dialog/confirm_order_dialog_ui.dart';
import '../track_order/track_order_ui.dart';
import 'cart_dummydata.dart';
import 'widget/cart_widget.dart';

class CartScreen extends StatefulWidget {
  final bool isDark;
  const CartScreen({super.key, this.isDark = true});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> items = List.from(CartDummyData.initialCartItems);

  final double deliveryFee = CartDummyData.deliveryFee;
  final double taxes = CartDummyData.taxes;

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
                  return CartItemCard(
                    title: item['title'],
                    price: item['price'],
                    qty: item['qty'],
                    cardBg: cardBg,
                    primaryText: primaryText,
                    secondaryText: secondaryText,
                    onIncrement: () => _changeQty(i, 1),
                    onDecrement: () => _changeQty(i, -1),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            SummaryRow(
              label: 'Subtotal',
              value: '\$${subtotal.toStringAsFixed(2)}',
              primaryText: primaryText,
              secondaryText: secondaryText,
            ),
            const SizedBox(height: 8),
            SummaryRow(
              label: 'Delivery Fee',
              value: '\$${deliveryFee.toStringAsFixed(2)}',
              primaryText: primaryText,
              secondaryText: secondaryText,
            ),
            const SizedBox(height: 8),
            SummaryRow(
              label: 'Taxes',
              value: '\$${taxes.toStringAsFixed(2)}',
              primaryText: primaryText,
              secondaryText: secondaryText,
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
}
