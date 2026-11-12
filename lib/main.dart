
import 'package:flutter/material.dart';

// ==========================================
// ONBOARDING
// ==========================================
import 'features/onboarding/presentation/screens/onboarding_screen.dart';

// ==========================================
// DELIVERY SCHEDULE 
// ==========================================
import 'features/delivery_schedule/presentation/screens/delivery_schedule_screen.dart';

// ==========================================
// ORDER TRACKING
// ==========================================
import 'features/order_tracking/presentation/screens/order_tracking_screen.dart';

// ==========================================
// PRODUCT
// ==========================================
import 'features/product/presentation/screens/product_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ======================================
      // APP CONFIGURATION
      // ======================================
      title: 'GalonKu',
      debugShowCheckedModeBanner: false,

      // ======================================
      // THEME
      // ======================================
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0756C9),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FE),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF172337),
          elevation: 0,
          centerTitle: true,
        ),
      ),

      // ======================================
      // INITIAL ROUTE
      // Untuk sementara membuka halaman Product
      // ======================================
      initialRoute: '/product',

      // ======================================
      // APP ROUTES
      // ======================================
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/delivery-schedule': (context) => const DeliveryScheduleScreen(),
        '/order-tracking': (context) => const OrderTrackingScreen(),
        '/product': (context) => const ProductListScreen(),
      },
    );
  }
}
