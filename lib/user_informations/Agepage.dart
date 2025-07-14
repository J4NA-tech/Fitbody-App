// Gerekli paketlerin içe aktarımı
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore veritabanı için
import 'package:fitbodys/user_informations/goal_page.dart'; // Sonraki sayfa
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Supabase authentication için

// AgePage adlı bir StatefulWidget
class AgePage extends StatefulWidget {
  const AgePage({super.key});

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  final supabase = Supabase.instance.client; // Supabase istemcisine erişim
  int age = 25; // Başlangıçta seçilen yaş değeri

  // Yaş bilgisini Firestore'a kaydeder ve goal_page'e yönlendirir
  Future<void> _saveAgeAndNavigate() async {
    final user = supabase.auth.currentUser; // Şu anki kullanıcıyı al
    if (user == null) return; // Kullanıcı yoksa çık

    try {
      // Firestore'da "users" koleksiyonuna yaş bilgisi ekle/güncelle
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id) // Supabase UID'yi belge ID olarak kullan
          .set({'age': age}, SetOptions(merge: true)); // Diğer bilgiler silinmeden güncellenir

      // GoalPage'e geç
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GoalPage()),
      );
    } catch (e) {
      // Hata varsa Snackbar ile göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30), // Sayfa kenar boşlukları
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Sol hizalı içerik
          children: [
            const SizedBox(height: 60),
            // Başlık yazısı
            Text(
              'Yaş Sadece Bir Sayıdır!\nAma Mükemmel Planı\nOluşturmamıza Yardımcı Olur.',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4A6FF),
              ),
            ),
            const SizedBox(height: 50),
            // Yaş değerini büyük şekilde ekranda göster
            Center(
              child: Text(
                '$age',
                style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD4A6FF)),
              ),
            ),
            // Yaş ayarlama slider'ı
            Slider(
              value: age.toDouble(), // Slider'daki değer (double)
              min: 15, // En küçük yaş
              max: 100, // En büyük yaş
              divisions: 85, // Adet sayısı (15-100 arası)
              label: age.toString(), // Etiket olarak yaşı göster
              activeColor: Color(0xFFD4A6FF),
              inactiveColor: Color(0xFFD4A6FF).withOpacity(0.3),
              onChanged: (value) => setState(() => age = value.round()), // Değer değiştiğinde yaşı güncelle
            ),
            const Spacer(), // Geri kalan boşluğu alır, butonu alta iter
            // Devam butonu (yaşı kaydeder ve sonraki sayfaya geçer)
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: _saveAgeAndNavigate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD4A6FF),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Icon(Icons.arrow_forward,
                    size: 30, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
