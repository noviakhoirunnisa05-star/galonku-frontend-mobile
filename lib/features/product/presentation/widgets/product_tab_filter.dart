
import 'package:flutter/material.dart';

class ProductTabFilter extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const ProductTabFilter({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static const Color blue = Color(0xFF0756C9);

  final List<String> tabs = const [
    'Semua Galon',
    'Isi Ulang (Tukar)',
    'Beli Galon Baru',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final active = selected == tab;

          return InkWell(
            onTap: () => onSelected(tab),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Text(
                    tab,
                    style: TextStyle(
                      fontSize: 9,
                      color: active ? blue : Colors.black87,
                      fontWeight: active
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  height: 2,
                  width: active ? 85 : 0,
                  color: blue,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
