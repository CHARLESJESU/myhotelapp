import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive_helper.dart';
import '../../router/routing.dart';
import '../confirm_order_dialog/confirm_order_dialog_ui.dart';
import 'cart_dummydata.dart';
import 'widget/cart_widget.dart';

/// Full CartScreen with Scaffold and AppBar (for direct navigation)
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    // Get responsive values
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.025,
      16,
      20,
    );

    return Scaffold(
      backgroundColor: colors.screenBackground,
      appBar: AppBar(
        backgroundColor: colors.screenBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.primaryText),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'My Cart',
          style: TextStyle(
            color: colors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: titleFontSize,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: CartContent()),
    );
  }
}

/// Cart content widget (for use inside BottomRoutingScreen)
class CartContent extends StatefulWidget {
  const CartContent({super.key});

  @override
  State<CartContent> createState() => _CartContentState();
}

class _CartContentState extends State<CartContent> {
  List<Map<String, dynamic>> _items = List.from(CartDummyData.initialCartItems);
  final double _deliveryFee = CartDummyData.deliveryFee;
  final double _taxes = CartDummyData.taxes;

  void _changeQty(int index, int delta) {
    setState(() {
      final q = _items[index]['qty'] as int;
      final newQ = (q + delta).clamp(0, 99);
      _items[index]['qty'] = newQ;
    });
  }

  double get _subtotal =>
      _items.fold(0.0, (s, item) => s + item['price'] * item['qty']);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final total = _subtotal + _deliveryFee + _taxes;

    // Get responsive values
    final padding = ResponsiveHelper.getResponsivePaddingLTRB(
      context,
      leftPercentage: 0.04,
      topPercentage: 0.01,
      rightPercentage: 0.04,
      bottomPercentage: 0.02,
    );

    final smallSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.01,
      8,
      12,
    );
    final mediumSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.015,
      12,
      16,
    );
    final largeSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.02,
      16,
      24,
    );
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.03,
      20,
      28,
    );
    final totalFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.025,
      18,
      24,
    );
    final buttonHeight = ResponsiveHelper.getResponsiveButtonHeight(
      context,
      0.06,
      48,
      60,
    );

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          padding.left,
          padding.top,
          padding.right,
          padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title for bottom nav version
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Cart',
                  style: TextStyle(
                    color: colors.primaryText,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, color: colors.primaryText),
                  onPressed: () => setState(() => _items.clear()),
                ),
              ],
            ),
            SizedBox(height: mediumSpacing),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _items.length,
              separatorBuilder: (_, __) => SizedBox(height: mediumSpacing),
              itemBuilder: (context, i) {
                final item = _items[i];
                return CartItemCard(
                  title: item['title'],
                  price: item['price'],
                  qty: item['qty'],
                  cardBg: colors.card,
                  primaryText: colors.primaryText,
                  secondaryText: colors.secondaryText,
                  onIncrement: () => _changeQty(i, 1),
                  onDecrement: () => _changeQty(i, -1),
                );
              },
            ),
            SizedBox(height: mediumSpacing),
            SummaryRow(
              label: 'Subtotal',
              value: '\$${_subtotal.toStringAsFixed(2)}',
              primaryText: colors.primaryText,
              secondaryText: colors.secondaryText,
            ),
            SizedBox(height: smallSpacing),
            SummaryRow(
              label: 'Delivery Fee',
              value: '\$${_deliveryFee.toStringAsFixed(2)}',
              primaryText: colors.primaryText,
              secondaryText: colors.secondaryText,
            ),
            SizedBox(height: smallSpacing),
            SummaryRow(
              label: 'Taxes',
              value: '\$${_taxes.toStringAsFixed(2)}',
              primaryText: colors.primaryText,
              secondaryText: colors.secondaryText,
            ),
            SizedBox(height: largeSpacing),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  0.01,
                  6,
                  12,
                ),
                vertical: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  0.01,
                  8,
                  12,
                ),
              ),
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(color: colors.secondaryText),
                        ),
                        Text(
                          '\$${total.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: colors.primaryText,
                            fontSize: totalFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: buttonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.buttonBg,
                        foregroundColor: colors.buttonText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        final confirmed = await Get.dialog<bool>(
                          ConfirmOrderDialog(
                            items: _items,
                            deliveryFee: _deliveryFee,
                            taxes: _taxes,
                          ),
                        );

                        if (confirmed == true) {
                          setState(() => _items.clear());
                          Get.toNamed(AppRoutes.trackOrder);
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
