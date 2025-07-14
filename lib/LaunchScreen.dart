import 'package:flutter/material.dart';

// Uygulama açıldığında gösterilen 5 saniyelik tanıtım ekranı (launch screen)
class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ekran çizildikten sonra 5 saniye bekleyip onboarding ekranına geçiş yapılır
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 5), () {
        // '/onboarding1' rotasına geçilir ve bu ekran hafızadan silinir
        Navigator.pushReplacementNamed(context, '/onboarding1');
      });
    });

    return Scaffold(
      backgroundColor: const Color(0xFF232323),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Ortaya hizalama
          children: [
            // Uygulama logosu
            Image.asset(
              'images/log.png',
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20), // Logo ile yazı arasında boşluk
            const Text(
              'fitbody',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
