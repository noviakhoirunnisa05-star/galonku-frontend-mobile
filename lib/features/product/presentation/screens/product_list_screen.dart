
import 'package:flutter/material.dart';
import '../widgets/product_card.dart';

// ======================================================
// MODEL PRODUK
// ======================================================

class _Product {
  final String id;
  final String name;
  final String description;
  final String brand;
  final String category;
  final String image;
  final String rating;
  final String unit;
  final int price;
  final int? originalPrice;

  const _Product({
    required this.id,
    required this.name,
    required this.description,
    required this.brand,
    required this.category,
    required this.image,
    required this.rating,
    required this.unit,
    required this.price,
    this.originalPrice,
  });
}

// ======================================================
// PRODUCT LIST SCREEN
// ======================================================

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() =>
      _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  static const Color primaryBlue = Color(0xFF0756C9);
  static const Color cyan = Color(0xFF35C9E8);
  static const Color pageBackground = Color(0xFFF5F6FC);

  final TextEditingController searchController =
      TextEditingController();

  String selectedBrand = 'Semua';
  String selectedCategory = 'Semua Galon';

  int selectedBottomIndex = 1;

  final Map<String, int> quantities = {};

  // ======================================================
  // DATA PRODUK
  // ======================================================

  final List<_Product> products = const [
    _Product(
      id: 'aqua',
      name: 'Aqua Galon Isi Ulang 19L',
      description: 'Tukar galon kosong dengan galon resmi.',
      brand: 'Aqua',
      category: 'Isi Ulang (Tukar)',
      image: 'assets/images/aqua_19l.png',
      rating: '4.9 (1.2k)',
      unit: 'Galon Baru Setiap Beli',
      price: 20000,
      originalPrice: 22000,
    ),

    _Product(
      id: 'le_minerale',
      name: 'Le Minerale 15L',
      description: 'Galon baru dan higienis sekali pakai.',
      brand: 'Le Minerale',
      category: 'Galon Baru',
      image: 'assets/images/le_minerale_15l.png',
      rating: '4.9 (890)',
      unit: 'Galon Baru Setiap Beli',
      price: 22000,
    ),

    _Product(
      id: 'cleo',
      name: 'Cleo Pure Water Galon 19L',
      description: 'Air murni bebas mineral anorganik.',
      brand: 'Cleo',
      category: 'Isi Ulang (Tukar)',
      image: 'assets/images/cleo_galon_19l.png',
      rating: '4.9 (470)',
      unit: 'Isi Ulang & Baru',
      price: 19000,
    ),

    _Product(
      id: 'vit',
      name: 'Vit 19L',
      description: 'Pilihan hemat dan terpercaya.',
      brand: 'Vit',
      category: 'Isi Ulang (Tukar)',
      image: 'assets/images/vit_19l.png',
      rating: '4.8 (520)',
      unit: 'Refill Galon Resmi',
      price: 16000,
    ),

    _Product(
      id: 'amidis',
      name: 'Amidis 19L',
      description: 'Air demineralisasi murni pilihan.',
      brand: 'Amidis',
      category: 'Galon Baru',
      image: 'assets/images/amidis_19l.png',
      rating: '4.9 (310)',
      unit: 'Bebas Mineral Berat',
      price: 24000,
    ),
  ];

  // ======================================================
  // TOTAL JUMLAH PRODUK
  // ======================================================

  int get totalItems {
    return quantities.values.fold(
      0,
      (total, quantity) => total + quantity,
    );
  }

  // ======================================================
  // TOTAL HARGA KERANJANG
  // ======================================================

  int get totalPrice {
    int total = 0;

    for (final product in products) {
      total +=
          product.price * (quantities[product.id] ?? 0);
    }

    return total;
  }

  // ======================================================
  // FORMAT HARGA
  // ======================================================

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

  // ======================================================
  // FILTER PRODUK
  // ======================================================

  List<_Product> get filteredProducts {
    final keyword =
        searchController.text.toLowerCase().trim();

    return products.where((product) {
      final brandMatch = selectedBrand == 'Semua' ||
          product.brand == selectedBrand;

      final categoryMatch =
          selectedCategory == 'Semua Galon' ||
              product.category == selectedCategory;

      final searchMatch =
          product.name.toLowerCase().contains(keyword) ||
              product.brand.toLowerCase().contains(keyword);

      return brandMatch && categoryMatch && searchMatch;
    }).toList();
  }

  // ======================================================
  // UPDATE QUANTITY
  // ======================================================

  void updateQuantity(String id, int change) {
    setState(() {
      final current = quantities[id] ?? 0;
      final next = current + change;

      if (next <= 0) {
        quantities.remove(id);
      } else {
        quantities[id] = next;
      }
    });
  }

  // ======================================================
  // SNACKBAR
  // ======================================================

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ======================================================
  // HEADER GALONKU
  // ======================================================

  Widget buildHeader() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.water_drop,
                color: primaryBlue,
                size: 23,
              ),
              const SizedBox(width: 6),
              const Text(
                'GalonKu',
                style: TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const Spacer(),
              const Text(
                'Rosi',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF172337),
                ),
              ),
              const SizedBox(width: 8),

              // FOTO PROFIL ROSI
              ClipOval(
                child: Image.asset(
                  'assets/images/profile.png',
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint(
                      'Gagal memuat foto Rosi: $error',
                    );

                    return Container(
                      width: 36,
                      height: 36,
                      color: const Color(0xFFE7EEFF),
                      child: const Icon(
                        Icons.person,
                        color: primaryBlue,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ALAMAT PENGIRIMAN
          InkWell(
            onTap: () {
              showMessage('Ubah alamat pengiriman.');
            },
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: primaryBlue,
                  size: 17,
                ),
                const SizedBox(width: 6),
                const Expanded(
                  child: Text(
                    'Kirim ke: Kost Sakura, Kamar 204',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF172337),
                    ),
                  ),
                ),
                const Text(
                  'Ubah',
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================
  // SEARCH BAR
  // ======================================================

  Widget buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(13, 5, 13, 10),
      child: Container(
        height: 43,
        padding: const EdgeInsets.symmetric(horizontal: 11),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE5E9F1),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              size: 20,
              color: Colors.grey,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  hintText:
                      'Cari Aqua, Le Minerale, Cleo, Club...',
                  hintStyle: TextStyle(fontSize: 11),
                  border: InputBorder.none,
                  isDense: true,
                ),
                style: const TextStyle(fontSize: 12),
              ),
            ),
            if (searchController.text.isNotEmpty)
              InkWell(
                onTap: () {
                  searchController.clear();
                  setState(() {});
                },
                child: const Icon(
                  Icons.close,
                  size: 18,
                ),
              ),
            const SizedBox(width: 6),
            const Icon(
              Icons.tune,
              size: 19,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  // ======================================================
  // FILTER MEREK
  // ======================================================

  Widget buildBrandFilter() {
    const brands = [
      'Semua',
      'Aqua',
      'Vit',
      'Cleo',
      'Le Minerale',
      'Amidis',
    ];

    return Container(
      color: Colors.white,
      height: 52,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: brands.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: 7),
        itemBuilder: (context, index) {
          final brand = brands[index];
          final selected = selectedBrand == brand;

          return Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: () {
                setState(() {
                  selectedBrand = brand;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? primaryBlue
                      : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: selected
                        ? primaryBlue
                        : const Color(0xFFE7EAF0),
                  ),
                ),
                child: Text(
                  brand,
                  style: TextStyle(
                    fontSize: 10,
                    color: selected
                        ? Colors.white
                        : Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ======================================================
  // FILTER KATEGORI
  // ======================================================

  Widget buildCategoryFilter() {
    const categories = [
      'Semua Galon',
      'Isi Ulang (Tukar)',
      'Galon Baru',
    ];

    return Container(
      height: 43,
      color: Colors.white,
      child: Row(
        children: categories.map((category) {
          final selected = selectedCategory == category;

          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 2,
                        ),
                        child: Text(
                          category,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9,
                            color: selected
                                ? primaryBlue
                                : const Color(0xFF657084),
                            fontWeight: selected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 55,
                    color: selected
                        ? primaryBlue
                        : Colors.transparent,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ======================================================
  // BANNER HIGIENIS
  // ======================================================

  Widget buildHygieneBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 7),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F5FC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: Color(0xFFB8EDFA),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified_user_outlined,
              color: Color(0xFF0086A6),
              size: 22,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jaminan Higienis & Tersegel',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Semua galon dicuci steril & tutup segel ganda resmi.',
                  style: TextStyle(fontSize: 9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================
  // KARTU PRODUK
  // MENGGUNAKAN PRODUCT CARD DARI WIDGETS
  // ======================================================

  Widget buildProductCard(_Product product) {
    final quantity = quantities[product.id] ?? 0;

    return ProductCard(
      product: product,
      quantity: quantity,
      onQuantityChanged: (change) {
        updateQuantity(product.id, change);
      },
    );
  }

  // ======================================================
  // RINGKASAN KERANJANG
  // ======================================================

  Widget buildCartBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      size: 14,
                      color: primaryBlue,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$totalItems Galon Terpilih',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                Text(
                  formatPrice(totalPrice),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 38,
            child: ElevatedButton(
              onPressed: showCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  const Text(
                    'Lihat Keranjang',
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(width: 7),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: Text(
                      '$totalItems',
                      style: const TextStyle(
                        color: primaryBlue,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================
  // KERANJANG BELANJA
  // ======================================================

  void showCart() {
    if (totalItems == 0) {
      showMessage(
        'Silakan pilih produk terlebih dahulu.',
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            final selectedProducts = products.where(
              (product) =>
                  (quantities[product.id] ?? 0) > 0,
            ).toList();

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Keranjang Belanja',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      ...selectedProducts.map((product) {
                        final quantity =
                            quantities[product.id] ?? 0;

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Image.asset(
                            product.image,
                            width: 42,
                            height: 50,
                            fit: BoxFit.contain,
                            errorBuilder:
                                (context, error, stackTrace) {
                              return const Icon(
                                Icons.broken_image_outlined,
                                color: Colors.red,
                              );
                            },
                          ),
                          title: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            formatPrice(product.price),
                            style: const TextStyle(
                              color: primaryBlue,
                              fontSize: 10,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  updateQuantity(
                                    product.id,
                                    -1,
                                  );
                                  modalSetState(() {});
                                },
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  size: 19,
                                ),
                              ),
                              Text(
                                '$quantity',
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  updateQuantity(
                                    product.id,
                                    1,
                                  );
                                  modalSetState(() {});
                                },
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: primaryBlue,
                                  size: 19,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      const Divider(),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Belanja',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            formatPrice(totalPrice),
                            style: const TextStyle(
                              color: primaryBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: totalItems == 0
                              ? null
                              : () {
                                  Navigator.pop(sheetContext);
                                  showMessage(
                                    'Produk berhasil dipilih.',
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(13),
                          ),
                          child: const Text('Lanjutkan'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ======================================================
  // BOTTOM NAVIGATION
  // ======================================================

  Widget buildBottomNavigation() {
    const labels = [
      'Beranda',
      'Produk',
      'Riwayat',
      'Profil',
    ];

    const icons = [
      Icons.home_outlined,
      Icons.storefront_outlined,
      Icons.receipt_long_outlined,
      Icons.person_outline,
    ];

    return Container(
      height: 55,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE6E9F0),
          ),
        ),
      ),
      child: Row(
        children: List.generate(4, (index) {
          final active = selectedBottomIndex == index;

          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedBottomIndex = index;
                });

                if (index != 1) {
                  showMessage(
                    '${labels[index]} dipilih.',
                  );
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icons[index],
                    size: 19,
                    color: active
                        ? primaryBlue
                        : Colors.black54,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    labels[index],
                    style: TextStyle(
                      fontSize: 9,
                      color: active
                          ? primaryBlue
                          : Colors.black54,
                      fontWeight: active
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // ======================================================
  // DISPOSE
  // ======================================================

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ======================================================
  // MAIN BUILD
  // ======================================================

  @override
  Widget build(BuildContext context) {
    final visibleProducts = filteredProducts;

    return Scaffold(
      backgroundColor: pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(),

            buildSearchBar(),

            buildBrandFilter(),

            buildCategoryFilter(),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  buildHygieneBanner(),

                  if (visibleProducts.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(35),
                      child: Center(
                        child: Text(
                          'Produk tidak ditemukan',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  else
                    ...visibleProducts.map(
                      (product) => buildProductCard(product),
                    ),

                  const SizedBox(height: 12),
                ],
              ),
            ),

            buildCartBar(),

            buildBottomNavigation(),
          ],
        ),
      ),
    );
  }
}
