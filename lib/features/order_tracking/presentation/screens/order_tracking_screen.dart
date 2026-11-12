
import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() =>
      _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  static const Color blue = Color(0xFF0756C9);
  static const Color dark = Color(0xFF172337);
  static const Color background = Color(0xFFF8F9FE);
  static const Color cyan = Color(0xFF42D4EF);

  // ASSET GAMBAR
  static const String aquaImage = 'assets/images/aqua_19l.png';
  static const String profileImage = 'assets/images/profile.png';

  int selectedMenu = 0;
  double zoom = 1.0;

  void showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // WIDGET GAMBAR
  Widget assetImage(
    String path, {
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(
      path,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('GAGAL MEMUAT GAMBAR: $path');
        debugPrint('ERROR: $error');

        return Container(
          color: const Color(0xFFF0F2F7),
          alignment: Alignment.center,
          child: const Icon(
            Icons.broken_image_outlined,
            color: Colors.redAccent,
            size: 25,
          ),
        );
      },
    );
  }

  // HEADER
  Widget buildHeader() {
    return Container(
      height: 43,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          const Icon(
            Icons.water_drop,
            color: blue,
            size: 19,
          ),
          const SizedBox(width: 6),
          const Text(
            'GalonKu',
            style: TextStyle(
              color: blue,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Text(
            'Rosi',
            style: TextStyle(fontSize: 9, color: dark),
          ),
          const SizedBox(width: 6),
          ClipOval(
            child: SizedBox(
              width: 25,
              height: 25,
              child: assetImage(
                profileImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // JUDUL TRACKING
  Widget buildTitle() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 9),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                showMessage('Tidak ada halaman sebelumnya.');
              }
            },
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Color(0xFFF1F3F9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 16,
                color: dark,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Tracking Pesanan',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: dark,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.circle,
                      color: Color(0xFF19B66E),
                      size: 7,
                    ),
                    SizedBox(width: 3),
                    Text(
                      'Live',
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xFF19A86A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3),
                Text(
                  'Order #GK-8821 • Refill Cepat',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: showHelp,
            child: Container(
              width: 27,
              height: 27,
              decoration: const BoxDecoration(
                color: Color(0xFFEAF3FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.headset_mic_outlined,
                size: 15,
                color: blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // PETA
  Widget buildMap() {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: MapPainter(zoom: zoom),
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: mapBadge(
                Icons.circle,
                blue,
                'Perkiraan Tiba: 12 Menit',
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: InkWell(
                onTap: () {
                  showMessage('Pengiriman diperkirakan tepat waktu.');
                },
                child: mapBadge(
                  Icons.verified_user,
                  const Color(0xFF168C59),
                  'Tepat Waktu',
                ),
              ),
            ),

            // PENANDA KURIR, BUKAN FOTO
            const Positioned(
              left: 75,
              top: 44,
              child: Icon(
                Icons.navigation,
                color: blue,
                size: 27,
              ),
            ),
            const Positioned(
              left: 173,
              top: 38,
              child: Icon(
                Icons.location_on,
                color: Color(0xFFC62828),
                size: 25,
              ),
            ),
            const Positioned(
              left: 58,
              top: 80,
              child: Text(
                'Taman Kota',
                style: TextStyle(
                  fontSize: 6,
                  color: Color(0xFF168C59),
                ),
              ),
            ),
            const Positioned(
              right: 35,
              bottom: 54,
              child: Text(
                'Jl. Kenanga Baru',
                style: TextStyle(
                  fontSize: 6,
                  color: Colors.grey,
                ),
              ),
            ),

            // ALAMAT DI PETA
            Positioned(
              left: 8,
              bottom: 8,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x15000000),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color(0xFFC62828),
                      size: 11,
                    ),
                    SizedBox(width: 3),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kost Sakura, Kamar 204',
                          style: TextStyle(
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                            color: dark,
                          ),
                        ),
                        Text(
                          'Jl. Melati No. 12, Sumbersari',
                          style: TextStyle(
                            fontSize: 6,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // TOMBOL ZOOM
            Positioned(
              right: 7,
              bottom: 8,
              child: Column(
                children: [
                  mapControl(Icons.add, () {
                    setState(() {
                      zoom = (zoom + 0.15).clamp(0.8, 1.6).toDouble();
                    });
                  }),
                  mapControl(Icons.remove, () {
                    setState(() {
                      zoom = (zoom - 0.15).clamp(0.8, 1.6).toDouble();
                    });
                  }),
                  const SizedBox(height: 4),
                  mapControl(Icons.my_location, () {
                    setState(() => zoom = 1.0);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mapBadge(
    IconData icon,
    Color color,
    String label,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 9),
          const SizedBox(width: 3),
          Text(
            label,
            style: const TextStyle(
              fontSize: 7,
              fontWeight: FontWeight.w600,
              color: dark,
            ),
          ),
        ],
      ),
    );
  }

  Widget mapControl(IconData icon, VoidCallback action) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: action,
        borderRadius: BorderRadius.circular(5),
        child: SizedBox(
          width: 24,
          height: 23,
          child: Icon(icon, size: 15, color: dark),
        ),
      ),
    );
  }

  // KARTU KURIR
  Widget buildDriverCard() {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // FOTO PAK BUDI DARI PROFILE.PNG
              ClipOval(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: assetImage(
                    profileImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Pak Budi Santoso',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: dark,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.verified,
                          color: blue,
                          size: 11,
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 10,
                          color: Color(0xFFFFB52E),
                        ),
                        Text(
                          ' 4.9 • 1.4k+ antar galon',
                          style: TextStyle(
                            fontSize: 7,
                            color: dark,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.delivery_dining,
                          size: 10,
                          color: blue,
                        ),
                        SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            'Honda Beat Biru • B 4821 KOP',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 7,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              Expanded(
                child: driverButton(
                  Icons.call,
                  'Hubungi',
                  blue,
                  Colors.white,
                  showCall,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: driverButton(
                  Icons.chat_outlined,
                  'Chat Kurir',
                  cyan,
                  dark,
                  showChat,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget driverButton(
    IconData icon,
    String title,
    Color color,
    Color textColor,
    VoidCallback action,
  ) {
    return SizedBox(
      height: 32,
      child: ElevatedButton.icon(
        onPressed: action,
        icon: Icon(icon, size: 11),
        label: Text(
          title,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  // STATUS PENGIRIMAN
  Widget buildStatusCard() {
    final data = [
      {
        'title': 'Pesanan Diterima',
        'desc': 'Pembayaran QRIS terverifikasi otomatis',
        'time': '10:15 WIB',
      },
      {
        'title': 'Galon Disegel Higienis',
        'desc': 'Pembersihan dan tutup galon segel ganda',
        'time': '10:20 WIB',
      },
      {
        'title': 'Kurir Dalam Perjalanan',
        'desc': 'Pak Budi membawa 2 galon menuju Kost Anda',
        'time': '10:32 WIB',
      },
      {
        'title': 'Sampai di Lokasi',
        'desc': 'Harap siapkan 2 galon kosong untuk ditukar',
        'time': 'Est. 10:45 WIB',
      },
    ];

    const icons = [
      Icons.check,
      Icons.verified_user_outlined,
      Icons.delivery_dining,
      Icons.location_on_outlined,
    ];

    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Status Pengiriman',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: dark,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Refill Express',
                  style: TextStyle(
                    color: blue,
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          ...List.generate(data.length, (index) {
            final completed = index < 2;
            final active = index == 2;

            return InkWell(
              onTap: () => showStatusDetail(
                data[index]['title']!,
                data[index]['desc']!,
                data[index]['time']!,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 22,
                    child: Column(
                      children: [
                        Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: completed
                                ? const Color(0xFF087B46)
                                : active
                                    ? blue
                                    : const Color(0xFFE9EBF5),
                          ),
                          child: Icon(
                            icons[index],
                            color: completed || active
                                ? Colors.white
                                : Colors.grey,
                            size: 10,
                          ),
                        ),
                        if (index < 3)
                          Container(
                            width: 2,
                            height: 30,
                            color: completed
                                ? const Color(0xFF9CD7B9)
                                : const Color(0xFFDDE0EC),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  data[index]['title']!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: completed || active
                                        ? dark
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                data[index]['time']!,
                                style: const TextStyle(
                                  fontSize: 7,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            data[index]['desc']!,
                            style: const TextStyle(
                              fontSize: 7,
                              color: Color(0xFF818897),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // RINCIAN PENGIRIMAN
  Widget buildOrderCard() {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Rincian Pengiriman',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: dark,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9F5E7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Lunas',
                  style: TextStyle(
                    fontSize: 7,
                    color: Color(0xFF087B46),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // FOTO AQUA ASLI
          InkWell(
            onTap: showProductDetail,
            borderRadius: BorderRadius.circular(9),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2FC),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: assetImage(
                      aquaImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '2x Aqua Galon Isi Ulang 19L',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: dark,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Tukar Galon Kosong Siap di',
                          style: TextStyle(
                            fontSize: 7,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Kamar',
                          style: TextStyle(
                            fontSize: 7,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Rp 42.000',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: dark,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 9),

          InkWell(
            onTap: () => showMessage('Alamat penerima pesanan.'),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 12,
                  color: Color(0xFF168C91),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alamat Penerima',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: dark,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Kost Sakura, Kamar 204 (Lantai 2)\n'
                        'Jl. Melati No. 12, Sumbersari, Jakarta Selatan',
                        style: TextStyle(
                          fontSize: 7,
                          height: 1.4,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 14,
            color: Color(0xFFECECF3),
          ),
          InkWell(
            onTap: () => showMessage('Metode pembayaran: QRIS'),
            child: const Row(
              children: [
                Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 12,
                  color: Color(0xFF168C91),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'Metode Pembayaran',
                    style: TextStyle(
                      fontSize: 8,
                      color: dark,
                    ),
                  ),
                ),
                Text(
                  '▦ QRIS',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: dark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // BANTUAN
  Widget buildHelp() {
    return InkWell(
      onTap: showHelp,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.help_outline,
              color: blue,
              size: 12,
            ),
            SizedBox(width: 5),
            Text(
              'Butuh bantuan atau ubah instruksi antar?',
              style: TextStyle(
                fontSize: 8,
                color: blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // NAVIGASI BAWAH
  Widget buildBottomNavigation() {
    const items = [
      {'icon': Icons.home_outlined, 'label': 'Beranda'},
      {'icon': Icons.inventory_2_outlined, 'label': 'Produk'},
      {'icon': Icons.receipt_long_outlined, 'label': 'Riwayat'},
      {'icon': Icons.person_outline, 'label': 'Profil'},
    ];

    return Container(
      height: 51,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE8EAF2)),
        ),
      ),
      child: Row(
        children: List.generate(items.length, (index) {
          final active = selectedMenu == index;

          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() => selectedMenu = index);
                showMessage(
                  'Menu ${items[index]['label']} dipilih.',
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    items[index]['icon'] as IconData,
                    size: 17,
                    color: active ? blue : dark,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    items[index]['label'] as String,
                    style: TextStyle(
                      fontSize: 8,
                      color: active ? blue : dark,
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

  // HUBUNGI KURIR
  void showCall() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hubungi Kurir'),
        content: const Text(
          'Hubungi Pak Budi Santoso untuk informasi pesanan #GK-8821.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              showMessage(
                'Fitur telepon belum dihubungkan ke nomor kurir.',
              );
            },
            child: const Text('Lanjutkan'),
          ),
        ],
      ),
    );
  }

  // CHAT KURIR
  void showChat() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          'Chat Pak Budi Santoso',
          style: TextStyle(fontSize: 15),
        ),
        content: TextField(
          controller: controller,
          maxLines: 2,
          decoration: const InputDecoration(
            hintText: 'Tulis pesan untuk kurir...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final message = controller.text.trim();
              Navigator.pop(dialogContext);

              if (message.isNotEmpty) {
                showMessage('Pesan: $message');
              } else {
                showMessage('Silakan tulis pesan terlebih dahulu.');
              }
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    ).then((_) => controller.dispose());
  }

  // BANTUAN PESANAN
  void showHelp() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Bantuan Pesanan'),
        content: const Text(
          'Jika mengalami kendala pada pesanan #GK-8821, '
          'kamu dapat menghubungi kurir GalonKu.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              showCall();
            },
            child: const Text('Hubungi Kurir'),
          ),
        ],
      ),
    );
  }

  // DETAIL STATUS
  void showStatusDetail(
    String title,
    String description,
    String time,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text('$description\n\nWaktu: $time'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  // DETAIL PRODUK
  void showProductDetail() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Detail Produk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: assetImage(
                aquaImage,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Aqua Galon Isi Ulang 19 Liter\n'
              'Jumlah: 2 galon\n'
              'Total: Rp 42.000',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  // TAMPILAN UTAMA
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(),
            buildTitle(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildMap(),
                    const SizedBox(height: 8),
                    buildDriverCard(),
                    const SizedBox(height: 8),
                    buildStatusCard(),
                    const SizedBox(height: 8),
                    buildOrderCard(),
                    buildHelp(),
                  ],
                ),
              ),
            ),
            buildBottomNavigation(),
          ],
        ),
      ),
    );
  }
}

// GAMBAR PETA SIMULASI
class MapPainter extends CustomPainter {
  final double zoom;

  MapPainter({required this.zoom});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(
      const Color(0xFFEAF0F7),
      BlendMode.src,
    );

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(zoom);
    canvas.translate(-size.width / 2, -size.height / 2);

    final park = Paint()
      ..color = const Color(0xFFD9F0E3);

    final road = Paint()
      ..color = const Color(0xFFCFD9E3)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final smallRoad = Paint()
      ..color = const Color(0xFFDCE4EB)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.60,
          size.height * 0.05,
          size.width * 0.24,
          size.height * 0.30,
        ),
        const Radius.circular(6),
      ),
      park,
    );

    canvas.drawPath(
      Path()
        ..moveTo(-10, size.height * 0.45)
        ..lineTo(size.width + 10, size.height * 0.28),
      road,
    );

    canvas.drawPath(
      Path()
        ..moveTo(-10, size.height * 0.78)
        ..lineTo(size.width + 10, size.height * 0.60),
      road,
    );

    for (final x in [0.15, 0.40, 0.73]) {
      canvas.drawPath(
        Path()
          ..moveTo(size.width * x, -10)
          ..lineTo(size.width * x, size.height + 10),
        smallRoad,
      );
    }

    final routePaint = Paint()
      ..color = const Color(0xFF0064D8)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final route = Path()
      ..moveTo(size.width * 0.14, size.height * 0.10)
      ..lineTo(size.width * 0.29, size.height * 0.25)
      ..lineTo(size.width * 0.29, size.height * 0.70)
      ..lineTo(size.width * 0.72, size.height * 0.70)
      ..lineTo(size.width * 0.72, size.height * 0.32);

    canvas.drawPath(route, routePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant MapPainter oldDelegate) {
    return oldDelegate.zoom != zoom;
  }
}
