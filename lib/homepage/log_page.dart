import 'package:fitbodys/%20WorkoutLogManager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Kullanıcının tamamladığı antrenmanları ve toplam ilerlemesini gösteren sayfa
class LogPage extends StatelessWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser; // Şu an giriş yapmış kullanıcıyı alır (kullanılmamış)

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Üstteki görsel AppBar
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: _buildAppBar(),
          ),
          // Sayfa içeriği padding ile beraber
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildStatsSection(),          // Toplam kalori, süre ve egzersiz sayısı
                const SizedBox(height: 24),
                _buildWorkoutHistorySection(), // Geçmiş antrenmanlar listesi
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // Uygulamanın üst kısmındaki renkli başlık alanı
  Widget _buildAppBar() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6E48AA), Color(0xFFD53A9D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Text(
          'Senin İlerlemen',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Genel istatistikler kartı: toplam kalori, toplam süre ve egzersiz sayısı
  Widget _buildStatsSection() {
    final logs = WorkoutLogManager().getLogs(); // Local (Hive ya da memory) verileri getirir
    int totalDuration = 0;
    int totalCalories = 0;

    for (var log in logs) {
      totalDuration += log.duration;
      totalCalories += log.calories;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(Icons.local_fire_department, '$totalCalories', 'Toplam Kalori'),
            _buildStatItem(Icons.timer, '$totalDuration', 'Toplam Dakika'),
            _buildStatItem(Icons.fitness_center, '${logs.length}', 'Tamamlanan Antrenman'),
          ],
        ),
      ),
    );
  }

  // Kullanıcının yaptığı antrenmanları listeleyen bölüm
  Widget _buildWorkoutHistorySection() {
    final logs = WorkoutLogManager().getLogs();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Egzersiz Geçmişi',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Scroll çakışmasın diye
          itemCount: logs.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final log = logs[index];

            return ListTile(
              leading: const Icon(Icons.fitness_center, color: Colors.deepPurple),
              title: Text(log.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${log.date.day}/${log.date.month}/${log.date.year}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text('${log.duration} Dakika • ${log.calories} Kalori'),
                  Text('${log.exerciseCount} Egzersiz • ${log.difficulty}'),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // Tek bir istatistik kutucuğu (ikon, değer ve açıklama)
  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.deepPurple),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
