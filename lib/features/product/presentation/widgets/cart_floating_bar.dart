
import 'package:flutter/material.dart';

class CartFloatingBar extends StatelessWidget {
  final int totalItems;
  final int totalPrice;
  final VoidCallback onTap;

  const CartFloatingBar({
    super.key,
    required this.totalItems,
    required this.totalPrice,
    required this.onTap,
  });

  static const Color blue = Color(0xFF0756C9);

  String formatPrice(int price) {
    final value = price.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < value.length; i++) {
      buffer.write(value[i]);
      final remaining = value.length - i - 1;

      if (remaining > 0 && remaining % 3 == 0) {
        buffer.write('.');
      }
    }

    return 'Rp $buffer';
  }

  @override
  Widget build(BuildContext context) {
    if (totalItems == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 3, 12, 5),
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 7,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$totalItems Galon Terpilih',
                  style: const TextStyle(fontSize: 8),
                ),
                Text(
                  formatPrice(totalPrice),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: blue,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'Lihat Keranjang',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
                CircleAvatar(
                  radius: 9,
                  backgroundColor: Colors.white,
                  child: Text(
                    '$totalItems',
                    style: const TextStyle(
                      fontSize: 8,
                      color: blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
