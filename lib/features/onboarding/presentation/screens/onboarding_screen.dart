
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  static const Color primaryBlue = Color(0xFF0756C9);
  static const Color darkBlue = Color(0xFF172337);
  static const Color backgroundColor = Color(0xFFF8F8FF);

  final List<Map<String, dynamic>> pages = [
    {
      'title': 'Air Galon Bersih Langsung Sampai Pintu',
      'description':
          'Layanan antar galon resmi, higienis, dan terjadwal langsung ke depan pintu kamar atau rumah Anda.',
      'features': [
        {'icon': Icons.local_shipping_outlined, 'text': 'Antar Cepat'},
        {'icon': Icons.verified_user_outlined, 'text': 'Tutup Segel'},
        {'icon': Icons.stairs_outlined, 'text': 'Naik Lantai'},
      ],
    },
    {
      'title': 'Pesan Galon Lebih Mudah',
      'description':
          'Pesan air galon kapan saja melalui aplikasi GalonKu dengan proses yang praktis dan cepat.',
      'features': [
        {'icon': Icons.touch_app_outlined, 'text': 'Mudah Pesan'},
        {'icon': Icons.schedule_outlined, 'text': 'Hemat Waktu'},
        {'icon': Icons.phone_android, 'text': 'Lewat Aplikasi'},
      ],
    },
    {
      'title': 'Air Bersih, Aman, dan Terpercaya',
      'description':
          'Nikmati layanan pengantaran galon yang mengutamakan kebersihan, keamanan, dan kenyamanan Anda.',
      'features': [
        {'icon': Icons.verified_outlined, 'text': 'Terpercaya'},
        {'icon': Icons.water_drop_outlined, 'text': 'Air Bersih'},
        {'icon': Icons.favorite_border, 'text': 'Nyaman'},
      ],
    },
  ];

  // NAVIGASI HALAMAN
  void _nextPage() {
    if (currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _showMessage(
        'Onboarding selesai. Hubungkan ke halaman Login atau Register.',
      );
    }
  }

  void _skipPage() {
    _pageController.animateToPage(
      pages.length - 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // LOGO GALONKU
  Widget _buildLogo() {
    return Row(
      children: [
        SizedBox(
          width: 27,
          height: 27,
          child: Image.asset(
            'assets/images/kurir_galonku.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.water_drop_rounded,
                color: primaryBlue,
                size: 27,
              );
            },
          ),
        ),
        const SizedBox(width: 7),
        const Text(
          'GalonKu',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
      ],
    );
  }

  // BADGE INFORMASI
  Widget _buildBadge({
    required IconData icon,
    required String text,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: iconColor,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: darkBlue,
            ),
          ),
        ],
      ),
    );
  }

  // GAMBAR KURIR DI DALAM LINGKARAN
  Widget _buildHero(double screenWidth) {
    final double circleSize =
        (screenWidth * 0.57).clamp(195.0, 235.0);

    // GAMBAR DIPERKECIL AGAR TIDAK TERLALU ZOOM
    final double imageSize = circleSize - 42;

    return SizedBox(
      width: double.infinity,
      height: circleSize + 35,
      child: Center(
        child: SizedBox(
          width: circleSize + 30,
          height: circleSize + 30,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // LINGKARAN PUTIH UTAMA
              Container(
                width: circleSize,
                height: circleSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFF0F1FC),
                    width: 7,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x18000000),
                      blurRadius: 14,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
              ),

              // ILUSTRASI KURIR
              // AREA GAMBAR DIBATASI LINGKARAN
              ClipOval(
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  width: imageSize,
                  height: imageSize,
                  child: ColoredBox(
                    color: Colors.white,
                    child: Image.asset(
                      'assets/images/kurir_galon.png',
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.delivery_dining,
                            size: 90,
                            color: primaryBlue,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // BADGE WAKTU PENGANTARAN
              Positioned(
                top: 0,
                right: 0,
                child: _buildBadge(
                  icon: Icons.bolt,
                  text: '15–30 Menit',
                  iconColor: Colors.teal,
                ),
              ),

              // BADGE HIGIENIS
              Positioned(
                bottom: 0,
                left: 0,
                child: _buildBadge(
                  icon: Icons.verified,
                  text: '100% Higienis',
                  iconColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // INDIKATOR HALAMAN
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pages.length,
        (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: currentPage == index ? 22 : 7,
            height: 6,
            decoration: BoxDecoration(
              color: currentPage == index
                  ? primaryBlue
                  : const Color(0xFFD5D9E8),
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }

  // FITUR ONBOARDING
  Widget _buildFeature(IconData icon, String text) {
    return Expanded(
      child: Container(
        height: 47,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F2FC),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: primaryBlue,
              size: 18,
            ),
            const SizedBox(height: 3),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: darkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // KONTEN SETIAP HALAMAN
  Widget _buildPageContent(
    int index,
    double screenWidth,
  ) {
    final data = pages[index];

    final features =
        data['features'] as List<Map<String, dynamic>>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHero(screenWidth),

          const SizedBox(height: 13),

          _buildPageIndicator(),

          // JARAK JUDUL DITAMBAH MENJADI 31 PX
          const SizedBox(height: 31),

          // JUDUL
          Text(
            data['title'] as String,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 19,
              height: 1.35,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              color: darkBlue,
            ),
          ),

          const SizedBox(height: 9),

          // DESKRIPSI
          Text(
            data['description'] as String,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11.5,
              height: 1.6,
              color: Color(0xFF737887),
            ),
          ),

          const SizedBox(height: 15),

          // TIGA FITUR
          Row(
            children: features.map((feature) {
              return _buildFeature(
                feature['icon'] as IconData,
                feature['text'] as String,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // TAMPILAN UTAMA
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFD9F4FF),
                Color(0xFFF8F8FF),
                Color(0xFFF8F8FF),
              ],
              stops: [0.0, 0.27, 1.0],
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  // HEADER LOGO
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20, 15, 20, 5,
                    ),
                    child: Row(
                      children: [
                        _buildLogo(),
                        const Spacer(),
                        if (currentPage < pages.length - 1)
                          TextButton(
                            onPressed: _skipPage,
                            child: const Text(
                              'Lewati',
                              style: TextStyle(
                                fontSize: 11,
                                color: primaryBlue,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // HALAMAN ONBOARDING
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: pages.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return LayoutBuilder(
                          builder: (context, pageConstraints) {
                            return SingleChildScrollView(
                              physics:
                                  const BouncingScrollPhysics(),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight:
                                      pageConstraints.maxHeight,
                                ),
                                child: Center(
                                  child: _buildPageContent(
                                    index,
                                    constraints.maxWidth,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // TOMBOL BAWAH
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20, 10, 20, 18,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _nextPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Mulai Sekarang',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 11),

                        // MASUK
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Sudah punya akun? ',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF858895),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _showMessage(
                                  'Hubungkan ke halaman Login GalonKu.',
                                );
                              },
                              child: const Text(
                                'Masuk',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: primaryBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
