import 'package:fitbodys/onboarding/Onboarding_page3.dart'; // 3. sayfa için gerekli import
import 'package:flutter/material.dart';

// Onboarding'in 2. sayfası
class OnboardingPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // Arka plan görseli + karartma + içerik için üst üste bileşenler
        fit: StackFit.expand, // Ekranı tamamen kaplasın
        children: [

          Image.asset(
            'images/Oboarding2.png',
            fit: BoxFit.cover, // Görsel ekranı tamamen kaplasın, taşmasın sağlandı
          ),

          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Daha Aktif Bir Yaşama Doğru Yolculuğuna Başla",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20), // Butonla yazı arası boşluk
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB3A0FF),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OnboardingPage3()),
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
