import 'package:fitbodys/onboarding/Onboarding_page4.dart'; // Bir sonraki sayfa
import 'package:flutter/material.dart';

// Onboarding'in 3. sayfası
class OnboardingPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Tüm ekranı kaplamasını sağladım
        children: [
          Image.asset(
            'images/Oboarding3.png',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          // Ortalanmış içerik: Yazı ve buton
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Yaşam Tarzına Uygun Beslenme Önerilerini Keşfet",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center, // Ortaya hizala
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB3A0FF),
                ),
                onPressed: () {
                  // 4. sayfaya geçiş
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OnboardingPage4()),
                  );
                },
                child: const Text(
                  "İleri",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
