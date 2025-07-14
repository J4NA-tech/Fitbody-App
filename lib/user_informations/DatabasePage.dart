import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../homepage/HomeScreen.dart';

class DatabasePage extends StatefulWidget {
  // Kullanıcıdan alınan tüm bilgiler constructor üzerinden aktarılıyor
  final String fullName;
  final String gender;
  final int age;
  final String goal;
  final String activityLevel;

  const DatabasePage({
    super.key,
    required this.fullName,
    required this.gender,
    required this.age,
    required this.goal,
    required this.activityLevel,
  });

  @override
  _DatabasePageState createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  // Supabase istemcisi
  final supabase = Supabase.instance.client;

  // Veritabanına kullanıcı bilgilerini kaydeden fonksiyon
  Future<void> saveUserData() async {
    try {
      final user = supabase.auth.currentUser; // Giriş yapmış kullanıcıyı al
      if (user == null) return; // Kullanıcı null ise hiçbir işlem yapma

      // Supabase'de 'users' tablosuna upsert (ekle veya güncelle) işlemi yapılır
      await supabase.from('users').upsert({
        'id': user.id, // Upsert işlemi için benzersiz kullanıcı ID gerekli
        'full_name': widget.fullName,
        'gender': widget.gender,
        'age': widget.age,
        'goal': widget.goal,
        'activity_level': widget.activityLevel,
      });
    } catch (error) {
      // Hata olursa consola yazdırılır
      print("Error saving user data: $error");
      rethrow;
    }
  }

  // Sayfa ilk yüklendiğinde kullanıcı bilgisi kaydedilir
  @override
  void initState() {
    super.initState();
    saveUserData(); // Sayfa açılır açılmaz bu fonksiyon çalışır
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Oluşturuldu!'),
        backgroundColor: const Color(0xFFD4A6FF),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Başarılı ikon
            Icon(Icons.check_circle, size: 80, color: const Color(0xFFD4A6FF)),
            const SizedBox(height: 20),

            // Başlık
            const Text(
              'Profil Başarıyla Oluşturuldu!\n',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFD4A6FF)),
            ),

            // Açıklama
            const Text(
              'Fitness yolculuğuna başlamak için hazırsın\n Tutarlı ol ve sürece güven 💪',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),

            const SizedBox(height: 40),

            // Ana sayfaya yönlendiren buton
            ElevatedButton(
              onPressed: () {
                // pushReplacement: önceki sayfayı stack'ten çıkarır
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A6FF),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Hadi Başlayalım!',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
