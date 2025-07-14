import 'package:fitbodys/onboarding/Onboarding_page2.dart';
import 'package:flutter/material.dart';

// Bu sınıf onboarding'in ilk sayfasını temsil eder
class OnboardingPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Arka plan ve katmanlar için Stack kullanıldı
      body: Stack(
        fit: StackFit.expand, // Tüm ekranı kaplamasını sağlandı
        children: [
          // Arka planda tam ekran bir görsel gösterilidi
          Image.asset(
            'images/Oboarding1.png',
            fit: BoxFit.cover,
          ),
          //   (görseli karartır, yazıları öne çıkarır)
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          // Başlık, alt başlık ve buton ortalandı
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "FitBody",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              const Text(
                "Hoş Geldiniz",
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xFFE2F163),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20), // Buton ile yazı arasında boşluk var
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB3A0FF),
                  /*
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),// Oval
                   */
                ),
                onPressed: () {
                  // İleri butonuna tıklanınca 2. onboarding sayfasına geçiş yapıldı
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OnboardingPage2()),
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
