
import 'package:flutter/material.dart';

import 'features/onboarding/presentation/screens/onboarding_screen.dart';
import 'features/delivery_schedule/presentation/screens/delivery_schedule_screen.dart';
import 'features/order_tracking/presentation/screens/order_tracking_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GalonKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0061D5),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FE),
      ),
      initialRoute: '/order-tracking',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/delivery-schedule': (context) =>
            const DeliveryScheduleScreen(),
        '/order-tracking': (context) =>
            const OrderTrackingScreen(),
      },
    );
  }
}
