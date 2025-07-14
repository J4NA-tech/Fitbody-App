// Gerekli paketlerin içe aktarımı
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Agepage.dart';

// GenderPage adında bir StatefulWidget
class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  final supabase = Supabase.instance.client; // Supabase erişim nesnesi
  String? selectedGender; // Kullanıcının seçtiği cinsiyet

  // Cinsiyeti Firestore'a kaydeden ve bir sonraki sayfaya yönlendiren fonksiyon
  Future<void> _saveGenderAndNavigate() async {
    if (selectedGender == null) return; // Cinsiyet seçilmemişse çık

    final user = supabase.auth.currentUser; // Şu anki kullanıcıyı al
    if (user == null) return; // Kullanıcı null ise çık

    try {
      // Firestore'daki 'users' koleksiyonunda, kullanıcıya ait belgeyi güncelle
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id) // Supabase kullanıcı ID’sini belge ID olarak kullan
          .set({'gender': selectedGender}, SetOptions(merge: true)); // Cinsiyeti kaydet (diğer alanlar silinmez)

      // Başarılıysa yaş sayfasına yönlendir
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AgePage()),
      );
    } catch (e) {
      // Hata oluşursa Snackbar ile mesaj göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30), // Sayfanın kenar boşlukları
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60), // Üstten boşluk
            // Başlık yazısı
            Text(
              'seni daha iyi\n tanıyalım',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4A6FF),
              ),
            ),
            const SizedBox(height: 20),
            // Açıklayıcı yazı
            Text(
              'Fitness yolculuğunu sana özel hale getirmemize yardımcı ol.',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 50),
            // Cinsiyet seçim kartları
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GenderCard(
                    icon: Icons.male,
                    label: 'Erkek',
                    isSelected: selectedGender == 'Erkek',
                    onTap: () => setState(() => selectedGender = 'Erkek'), // Seçim yapıldığında UI güncellenir
                  ),
                  const SizedBox(width: 30),
                  GenderCard(
                    icon: Icons.female,
                    label: 'Kadın',
                    isSelected: selectedGender == 'Kadın',
                    onTap: () => setState(() => selectedGender = 'Kadın'),
                  ),
                ],
              ),
            ),
            const Spacer(), // Kalan boşluğu alarak en altta buton olmasını sağlar
            // Devam butonu
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: selectedGender != null ? _saveGenderAndNavigate : null, // Seçim yoksa buton pasif
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD4A6FF),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Icon(Icons.arrow_forward, size: 30, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Cinsiyet kartı bileşeni
class GenderCard extends StatelessWidget {
  final IconData icon; // Erkek/Kadın ikonu
  final String label; // Etiket (Erkek/Kadın)
  final bool isSelected; // Seçili mi?
  final VoidCallback onTap; // Tıklanma fonksiyonu

  const GenderCard({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Kart tıklandığında çalışacak
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFD4A6FF).withOpacity(0.2) : Colors.grey[200], // Seçiliyse arkaplan açık mor
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Color(0xFFD4A6FF) : Colors.transparent, // Seçiliyse çerçeve mor
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 60, color: Color(0xFFD4A6FF)), // Cinsiyet ikonu
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontSize: 18)), // Cinsiyet metni
          ],
        ),
      ),
    );
  }
}
