
import 'package:flutter/material.dart';

class ProductSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onFilterTap;

  const ProductSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      margin: const EdgeInsets.fromLTRB(12, 5, 12, 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE9EBF2)),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 10),
        decoration: InputDecoration(
          hintText: 'Cari Aqua, Le Minerale, Cleo, Club...',
          hintStyle: const TextStyle(
            fontSize: 9,
            color: Colors.grey,
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 17,
            color: Colors.grey,
          ),
          suffixIcon: IconButton(
            onPressed: onFilterTap,
            icon: const Icon(
              Icons.tune,
              size: 16,
              color: Colors.grey,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 9),
        ),
      ),
    );
  }
}
