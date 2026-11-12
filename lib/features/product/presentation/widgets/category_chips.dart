
import 'package:flutter/material.dart';

class CategoryChips extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const CategoryChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static const Color blue = Color(0xFF0756C9);

  final List<String> categories = const [
    'Semua',
    'Aqua',
    'Vit',
    'Cleo',
    'Le Minerale',
    'Amidis',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 7),
        itemBuilder: (context, index) {
          final item = categories[index];
          final active = selected == item;

          return InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => onSelected(item),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              decoration: BoxDecoration(
                color: active ? blue : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: active ? blue : const Color(0xFFE9EBF2),
                ),
              ),
              child: Row(
                children: [
                  if (index == 0)
                    const Icon(
                      Icons.grid_view,
                      size: 11,
                    ),
                  if (index == 0) const SizedBox(width: 4),
                  Text(
                    item,
                    style: TextStyle(
                      fontSize: 9,
                      color: active ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
