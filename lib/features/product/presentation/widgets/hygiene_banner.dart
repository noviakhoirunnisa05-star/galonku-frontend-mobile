
import 'package:flutter/material.dart';

class HygieneBanner extends StatelessWidget {
  const HygieneBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 9),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFE1F5FC),
        borderRadius: BorderRadius.circular(11),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: Color(0xFFB7EAF8),
            child: Icon(
              Icons.health_and_safety_outlined,
              color: Color(0xFF07869D),
              size: 19,
            ),
          ),
          SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jaminan Higienis & Tersegel',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF087B91),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Semua galon dicuci bersih & tutup segel ganda resmi.',
                  style: TextStyle(
                    fontSize: 8,
                    color: Color(0xFF387B8B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
