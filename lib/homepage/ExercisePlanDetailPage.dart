// Gerekli paketler içe aktarılıyor
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbodys/workoutlog.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ WorkoutLogManager.dart';

// Egzersiz planı modeli
class ExercisePlan {
  final String name;
  final String duration;
  final List<Exercise> exercises;
  final String difficulty;
  final String youtubeId;

  ExercisePlan({
    required this.name,
    required this.duration,
    required this.difficulty,
    required this.exercises,
    required this.youtubeId,
  });
}

// Tek bir egzersizi temsil eden sınıf
class Exercise {
  final String name;
  final String sets;
  final String rest;

  Exercise({
    required this.name,
    required this.sets,
    required this.rest,
  });
}

// Detay sayfası Stateful çünkü video oynatıcı gibi etkileşimli widget'lar var
class ExercisePlanDetailPage extends StatefulWidget {
  final ExercisePlan plan;

  const ExercisePlanDetailPage({super.key, required this.plan});

  @override
  State<ExercisePlanDetailPage> createState() => _ExercisePlanDetailPageState();
}

class _ExercisePlanDetailPageState extends State<ExercisePlanDetailPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Youtube oynatıcı başlatılıyor
    _controller = YoutubePlayerController(
      initialVideoId: widget.plan.youtubeId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Bellek sızıntısını önlemek için controller kapatılır
    super.dispose();
  }

  // Egzersiz tamamlandığında günlük kaydı oluşturulur
  void _markAsCompleted() {
    final durationMatch = RegExp(r'\d+').firstMatch(widget.plan.duration);
    final duration = durationMatch != null ? int.parse(durationMatch.group(0)!) : 0;
    final calories = duration * 5; // Kalori hesabı basit bir çarpanla yapılmış

    WorkoutLog log = WorkoutLog(
      name: widget.plan.name,
      difficulty: widget.plan.difficulty,
      duration: duration,
      calories: calories,
      exerciseCount: widget.plan.exercises.length,
      date: DateTime.now(),
    );

    WorkoutLogManager().addLog(log); // Hafızada tutulan günlük listesine ekleniyor

    if (mounted) {
      Navigator.pop(context); // Sayfadan çık
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plan.name),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVideoPlayer(),
              const SizedBox(height: 24),
              _buildPlanInfo(),
              const SizedBox(height: 24),
              _buildExerciseList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _markAsCompleted,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Tamamlandı',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  // Youtube oynatıcı widget
  Widget _buildVideoPlayer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.deepPurple,
        ),
      ),
    );
  }

  // Planın süre bilgisi
  Widget _buildPlanInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Plan Detayları',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple[800],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.access_time, color: Colors.deepPurple[300], size: 18),
            const SizedBox(width: 8),
            Text(
              'Toplam Süre: ${widget.plan.duration}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ],
    );
  }

  // Egzersiz listesi başlığı ve her egzersiz için item
  Widget _buildExerciseList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Egzersizler',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple[800],
          ),
        ),
        const SizedBox(height: 12),
        ...widget.plan.exercises.map((exercise) => _buildExerciseItem(exercise)),
      ],
    );
  }

  // Her egzersiz için ayrı kart widget
  Widget _buildExerciseItem(Exercise exercise) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.fitness_center, color: Colors.deepPurple[300]),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _buildExerciseDetail(Icons.repeat, exercise.sets),
                      const SizedBox(width: 16),
                      _buildExerciseDetail(Icons.timer, exercise.rest),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Set ve dinlenme süresi için mini bilgi satırı
  Widget _buildExerciseDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }
}
