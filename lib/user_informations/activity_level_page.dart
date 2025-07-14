import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitbodys/user_informations/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Aktivite seviyesini seçmek için sayfa
class ActivityLevelPage extends StatefulWidget {
  const ActivityLevelPage({super.key});

  @override
  State<ActivityLevelPage> createState() => _ActivityLevelPageState();
}

class _ActivityLevelPageState extends State<ActivityLevelPage> {
  // Supabase client'a erişim
  final supabase = Supabase.instance.client;

  // Kullanıcının seçtiği aktivite seviyesi
  String? selectedLevel;

  // Kullanıcıya sunulan 3 aktivite seviyesi ve açıklamaları
  final List<Map<String, String>> levels = [
    {'title': 'Başlangıç', 'desc': 'Spora yeni başlıyorum'},
    {'title': 'Orta Seviye', 'desc': 'Düzenli egzersiz yapıyorum'},
    {'title': 'İleri Seviye', 'desc': 'Atlet seviyesindeyim'},
  ];

  // Aktivite seviyesi Firestore'a kaydedilir ve profile sayfasına yönlendirilir
  Future<void> _saveActivityLevelAndNavigate() async {
    if (selectedLevel == null) return;

    final user = supabase.auth.currentUser;
    if (user == null) return;

    try {
      // Firestore'a kaydet (merge = sadece bu alanı günceller)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set({'activity_level': selectedLevel}, SetOptions(merge: true));

      // Profil sayfasına geç
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    } catch (e) {
      // Hata olursa kullanıcıya bildir
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            // Başlık yazısı
            Text(
              'Mevcut\nAktivite Seviyeniz',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4A6FF),
              ),
            ),
            const SizedBox(height: 30),
            // Aktivite kartlarını ekrana bas
            ...levels.map((level) => ActivityLevelCard(
              title: level['title']!,
              desc: level['desc']!,
              isSelected: selectedLevel == level['title'],
              onTap: () => setState(() => selectedLevel = level['title']),
            )),
            const Spacer(),
            // İleri butonu
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                // Sadece seçim yapıldıysa çalışır
                onPressed: selectedLevel != null
                    ? _saveActivityLevelAndNavigate
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD4A6FF),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child:
                const Icon(Icons.arrow_forward, size: 30, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Aktivite seviyesi seçimi için özel kart bileşeni
class ActivityLevelCard extends StatelessWidget {
  final String title; // Seviye başlığı
  final String desc; // Açıklama
  final bool isSelected; // Seçili mi kontrolü
  final VoidCallback onTap; // Tıklama olayı

  const ActivityLevelCard({
    super.key,
    required this.title,
    required this.desc,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Seçili kartın arka plan rengi
      color: isSelected ? Color(0xFFD4A6FF).withOpacity(0.1) : null,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: isSelected ? Color(0xFFD4A6FF) : Colors.grey[300]!,
          width: 2,
        ),
      ),
      // Kart içeriği
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 20)),
        subtitle: Text(desc),
        trailing:
        isSelected ? const Icon(Icons.check, color: Color(0xFFD4A6FF)) : null,
        onTap: onTap, // Tıklama tetiklenir
      ),
    );
  }
}
