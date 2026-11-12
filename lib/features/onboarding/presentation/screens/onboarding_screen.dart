
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const Color primaryBlue = Color(0xFF0756C9);
  static const Color darkText = Color(0xFF172337);
  static const Color secondaryText = Color(0xFF596273);
  static const Color lightBackground = Color(0xFFFAF9FF);

  // ==========================================
  // LOGO GALONKU
  // ==========================================

  Widget buildLogo() {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/kurir_galon.png',
            width: 34,
            height: 34,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const CircleAvatar(
                radius: 17,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.water_drop,
                  color: primaryBlue,
                  size: 21,
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 7),
        const Text(
          'GalonKu',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            color: primaryBlue,
          ),
        ),
      ],
    );
  }

  // ==========================================
  // HEADER
  // ==========================================

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: buildLogo(),
      ),
    );
  }

  // ==========================================
  // MAIN COURIER IMAGE
  // ==========================================

  Widget buildCourierImage() {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // OUTER CIRCLE
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFF0F1FC),
                width: 9,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF172337)
                      .withValues(alpha: 0.09),
                  blurRadius: 18,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/kurir_galon.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint(
                      'Gagal memuat kurir_galon.png: $error',
                    );

                    return const Icon(
                      Icons.delivery_dining,
                      size: 110,
                      color: primaryBlue,
                    );
                  },
                ),
              ),
            ),
          ),

          // BADGE 15-30 MENIT
          Positioned(
            top: 5,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.bolt,
                    size: 16,
                    color: Color(0xFF00A7A0),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '15–30 Menit',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: darkText,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // BADGE HIGIENIS
          Positioned(
            bottom: 9,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 9,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified,
                    size: 15,
                    color: Color(0xFF07863D),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '100% Higienis',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: darkText,
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

  // ==========================================
  // PAGE INDICATOR
  // ==========================================

  Widget buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 29,
          height: 7,
          decoration: BoxDecoration(
            color: primaryBlue,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 7),
        Container(
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            color: Color(0xFFD4D9F0),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 7),
        Container(
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            color: Color(0xFFD4D9F0),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  // ==========================================
  // TITLE AND DESCRIPTION
  // ==========================================

  Widget buildDescription() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            'Air Galon Bersih Langsung\nSampai Pintu',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              height: 1.35,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.7,
              color: darkText,
            ),
          ),

          SizedBox(height: 10),

          Text(
            'Layanan antar galon resmi, higienis, dan\n'
            'terjadwal langsung ke depan pintu kamar atau\n'
            'rumah Anda.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.65,
              color: secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // FEATURE CARD
  // ==========================================

  Widget buildFeature({
    required IconData icon,
    required String title,
  }) {
    return Expanded(
      child: Container(
        height: 49,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F1FC),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: primaryBlue,
              size: 19,
            ),
            const SizedBox(height: 3),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // FEATURES
  // ==========================================

  Widget buildFeatures() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          buildFeature(
            icon: Icons.local_shipping_outlined,
            title: 'Antar Cepat',
          ),
          buildFeature(
            icon: Icons.cleaning_services_outlined,
            title: 'Tutup Segel',
          ),
          buildFeature(
            icon: Icons.stairs_outlined,
            title: 'Naik Lantai',
          ),
        ],
      ),
    );
  }

  // ==========================================
  // START BUTTON
  // ==========================================

  Widget buildStartButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 49,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(
            context,
            '/product',
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 3,
          shadowColor: primaryBlue.withValues(alpha: 0.20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mulai Sekarang',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 9),
            Icon(
              Icons.arrow_forward,
              size: 19,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // LOGIN
  // ==========================================

  Widget buildLogin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sudah punya akun? ',
            style: TextStyle(
              fontSize: 12,
              color: secondaryText,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Halaman masuk belum tersedia.',
                    ),
                  ),
                );
              }
            },
            child: const Text(
              'Masuk',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // BOTTOM BUTTON SECTION
  // ==========================================

  Widget buildBottomSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 17),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildStartButton(context),
          buildLogin(context),
        ],
      ),
    );
  }

  // ==========================================
  // MAIN SCREEN
  // ==========================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFD8F3FF),
              Color(0xFFFAF9FF),
              Color(0xFFF9F8FF),
            ],
            stops: [0.0, 0.28, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // HEADER LOGO
              buildHeader(),

              // MAIN CONTENT
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              const SizedBox(height: 45),

                              // COURIER IMAGE
                              buildCourierImage(),

                              const SizedBox(height: 20),

                              // PAGE INDICATOR
                              buildPageIndicator(),

                              const SizedBox(height: 26),

                              // TITLE AND DESCRIPTION
                              buildDescription(),

                              const SizedBox(height: 19),

                              // FEATURE CARDS
                              buildFeatures(),

                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // BOTTOM BUTTONS
              buildBottomSection(context),
            ],
          ),
        ),
      ),
    );
  }
}
