import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'activity_level_page.dart'; // Sonraki sayfa: Aktivite seviyesi

// StatefulWidget çünkü kullanıcı seçim yapacak
class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  final supabase = Supabase.instance.client; // Supabase oturum yönetimi
  String? selectedGoal; // Seçilen hedef

  // Kullanıcının seçebileceği fitness hedefleri (ikon ve başlıkla)
  final List<Map<String, dynamic>> goals = [
    {'title': 'Kilo Ver', 'icon': Icons.favorite},
    {'title': 'Kas Yap', 'icon': Icons.fitness_center},
    {'title': 'Formda Kal', 'icon': Icons.directions_run},
  ];

  // Seçilen hedefi Firestore’a kaydeder ve sonraki sayfaya geçer
  Future<void> _saveGoalAndNavigate() async {
    if (selectedGoal == null) return;

    final user = supabase.auth.currentUser;
    if (user == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id) // Supabase UID ile eşleşen kullanıcı dökümanı
          .set({'goal': selectedGoal}, SetOptions(merge: true)); // Sadece goal alanını ekle/güncelle

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ActivityLevelPage()), // Sonraki sayfa
      );
    } catch (e) {
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
            Text(
              'Temel Hedefin\nNedir?',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4A6FF),
              ),
            ),
            const SizedBox(height: 30),

            // Kullanıcıya hedef kartlarını sırayla göster
            ...goals.map((goal) => GoalTile(
              title: goal['title'] as String,
              icon: goal['icon'] as IconData,
              isSelected: selectedGoal == goal['title'],
              onTap: () => setState(() => selectedGoal = goal['title'] as String),
            )),

            const Spacer(),

            // İleri gitme butonu
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: selectedGoal != null ? _saveGoalAndNavigate : null, // Sadece seçim varsa aktif
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedGoal != null
                      ? Color(0xFFD4A6FF)
                      : Color(0xFFD4A6FF).withOpacity(0.3), // Pasifken soluk renk
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

// Hedef kartlarını temsil eden özel bileşen
class GoalTile extends StatelessWidget {
  final String title; // Başlık
  final IconData icon; // İkon
  final bool isSelected; // Seçili mi?
  final VoidCallback onTap; // Tıklanınca ne olacak?

  const GoalTile({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 4 : 0, // Seçiliyse biraz gölgeli
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: isSelected ? Color(0xFFD4A6FF) : Colors.grey[300]!, // Seçili değilse gri çerçeve
          width: 2,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        leading: Icon(icon, size: 35, color: Color(0xFFD4A6FF)),
        title: Text(title, style: const TextStyle(fontSize: 20)),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Color(0xFFD4A6FF))
            : null, // Seçiliyse tik göster
        onTap: onTap, // Seçimi tetikler
      ),
    );
  }
}
