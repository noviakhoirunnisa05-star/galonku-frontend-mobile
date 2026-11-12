
import 'package:flutter/material.dart';

class QuantityStepper extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onChanged,
  });

  static const Color blue = Color(0xFF0756C9);
  static const Color cyan = Color(0xFF42CBE8);

  @override
  Widget build(BuildContext context) {
    if (quantity == 0) {
      return SizedBox(
        height: 29,
        child: ElevatedButton.icon(
          onPressed: () => onChanged(1),
          icon: const Icon(Icons.add, size: 13),
          label: const Text(
            'Tambah',
            style: TextStyle(fontSize: 9),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: cyan,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
          ),
        ),
      );
    }

    return Container(
      height: 29,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E8F0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => onChanged(-1),
            child: const SizedBox(
              width: 27,
              child: Icon(Icons.remove, size: 14),
            ),
          ),
          Text(
            '$quantity',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () => onChanged(1),
            child: const SizedBox(
              width: 27,
              child: Icon(
                Icons.add,
                size: 14,
                color: blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
