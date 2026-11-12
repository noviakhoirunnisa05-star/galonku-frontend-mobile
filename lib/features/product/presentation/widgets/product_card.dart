
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final dynamic product;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const ProductCard({
    super.key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
  });

  static const Color primaryBlue = Color(0xFF0756C9);
  static const Color cyan = Color(0xFF35C9E8);
  static const Color backgroundColor = Color(0xFFF0F4FC);
  static const Color textColor = Color(0xFF172337);

  // FORMAT HARGA
  String formatPrice(dynamic price) {
    final int value = (price as num).toInt();
    final String number = value.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < number.length; i++) {
      buffer.write(number[i]);

      final remaining = number.length - i - 1;

      if (remaining > 0 && remaining % 3 == 0) {
        buffer.write('.');
      }
    }

    return 'Rp $buffer';
  }

  // GAMBAR PRODUK
  Widget buildProductImage() {
    final String imagePath = product.image.toString();

    return Container(
      width: 76,
      height: 91,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          width: 76,
          height: 91,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            debugPrint('GAMBAR PRODUK GAGAL DIMUAT');
            debugPrint('Produk: ${product.name}');
            debugPrint('Path: $imagePath');
            debugPrint('Error: $error');

            return const Center(
              child: Icon(
                Icons.broken_image_outlined,
                color: Colors.red,
                size: 28,
              ),
            );
          },
        ),
      ),
    );
  }

  // TOMBOL TAMBAH DAN KURANG
  Widget buildQuantityControl() {
    if (quantity <= 0) {
      return SizedBox(
        height: 32,
        child: ElevatedButton.icon(
          onPressed: () => onQuantityChanged(1),
          icon: const Icon(
            Icons.add,
            size: 14,
          ),
          label: const Text(
            'Tambah',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: cyan,
            foregroundColor: const Color(0xFF073B69),
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
          ),
        ),
      );
    }

    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE2E7F2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => onQuantityChanged(-1),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.remove,
                size: 14,
                color: primaryBlue,
              ),
            ),
          ),
          Text(
            '$quantity',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          InkWell(
            onTap: () => onQuantityChanged(1),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.add,
                size: 14,
                color: primaryBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // INFORMASI PRODUK
  Widget buildProductInformation() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // NAMA DAN RATING
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  product.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              const Icon(
                Icons.star,
                size: 12,
                color: Colors.orange,
              ),
              Flexible(
                child: Text(
                  product.rating.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 8,
                    color: Color(0xFF596273),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // DESKRIPSI
          Text(
            product.description.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 9,
              color: Color(0xFF8992A3),
            ),
          ),

          const SizedBox(height: 5),

          // HARGA SEBELUM PROMO
          if (product.originalPrice != null)
            Text(
              formatPrice(product.originalPrice),
              style: const TextStyle(
                fontSize: 8,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),

          // HARGA DAN QUANTITY
          Row(
            children: [
              Expanded(
                child: Text(
                  formatPrice(product.price),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
              ),
              buildQuantityControl(),
            ],
          ),

          const SizedBox(height: 3),

          // KETERANGAN PRODUK
          Text(
            product.unit.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 8,
              color: Color(0xFF16834C),
            ),
          ),
        ],
      ),
    );
  }

  // TAMPILAN KARTU PRODUK
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildProductImage(),
          const SizedBox(width: 10),
          buildProductInformation(),
        ],
      ),
    );
  }
}
