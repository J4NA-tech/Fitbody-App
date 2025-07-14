import 'package:flutter/material.dart';
import 'ExercisePlanDetailPage.dart';

class PlansPage extends StatefulWidget {
  const PlansPage({super.key});

  @override
  State<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedDifficulty = 'Başlangıç';
  final Color _primaryColor = const Color(0xFFB3A0FF);
  final Color _backgroundColor = const Color(0xFF0A0A0A);
  final Color _cardColor = const Color(0xFF1A1A1A);
  final Color _textColor = Colors.white;
// Tüm egzersiz planlarını saklayan yapı (kategori > seviye > plan listesi)
  final Map<String, Map<String, List<ExercisePlan>>> _allPlans = {
    'Güç': {
      'Başlangıç': [
        ExercisePlan(
          name: "Temel Vücut Geliştirme",
          duration: "45 Dakika",
          difficulty: "Başlangıç",
          youtubeId: "Z5DX8MYcl00",
          exercises: [
            Exercise(name: "Bodyweight Squat", sets: "3x10", rest: "60s"),
            Exercise(name: "Incline Push Up", sets: "3x8", rest: "60s"),
          ],
        ),
      ],
      'Orta': [
        ExercisePlan(
          name: "Intermediate Strength",
          duration: "1 Saat",
          difficulty: "Orta",
          youtubeId: "-2DkbkIyq5c",
          exercises: [
            Exercise(name: "Barbell Squat", sets: "4x8", rest: "90s"),
            Exercise(name: "Bench Press", sets: "4x10", rest: "60s"),
          ],
        ),
      ],
      'İleri': [
        ExercisePlan(
          name: "Advanced Powerlifting",
          duration: "1.5 Saat",
          difficulty: "İleri",
          youtubeId: "n_cIBBDb9JA",
          exercises: [
            Exercise(name: "Deadlift", sets: "5x5", rest: "120s"),
            Exercise(name: "Overhead Press", sets: "5x5", rest: "120s"),
          ],
        ),
      ],
    },
    'Dayanıklılık': {
      'Başlangıç': [
        ExercisePlan(
          name: "Temel Kardiyo",
          duration: "20 Dakika",
          difficulty: "Başlangıç",
          youtubeId: "sTANio_2E0Q",
          exercises: [
            Exercise(name: "Jumping Jacks", sets: "3x30s", rest: "30s"),
          ],
        ),
      ],
      'Orta': [
        ExercisePlan(
          name: "Orta Seviye HIIT",
          duration: "30 Dakika",
          difficulty: "Orta",
          youtubeId: "n_cIBBDb9JA",
          exercises: [
            Exercise(name: "Burpees", sets: "4x10", rest: "45s"),
          ],
        ),
      ],
      'İleri': [
        ExercisePlan(
          name: "Maraton Hazırlık",
          duration: "1 Saat",
          difficulty: "İleri",
          youtubeId: "n_cIBBDb9JA",
          exercises: [
            Exercise(name: "Long Distance Run", sets: "1x10km", rest: "-"),
          ],
        ),
      ],
    },
    'Esneklik': {
      'Başlangıç': [
        ExercisePlan(
          name: "Temel Esneme",
          duration: "15 Dakika",
          difficulty: "Başlangıç",
          youtubeId: "sTANio_2E0Q",
          exercises: [
            Exercise(name: "Cat-Cow Stretch", sets: "3x10", rest: "20s"),
          ],
        ),
      ],
      'Orta': [
        ExercisePlan(
          name: "Orta Seviye Yoga",
          duration: "30 Dakika",
          difficulty: "Orta",
          youtubeId: "sTANio_2E0Q",
          exercises: [
            Exercise(name: "Sun Salutations", sets: "5x", rest: "30s"),
          ],
        ),
      ],
      'İleri': [
        ExercisePlan(
          name: "Advanced Flexibility",
          duration: "45 Dakika",
          difficulty: "İleri",
          youtubeId: "sTANio_2E0Q",
          exercises: [
            Exercise(name: "Full Splits Practice", sets: "3x1m", rest: "1m"),
          ],
        ),
      ],
    },
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initializeDifficulty();
  }
  // İlk açılışta zorluk seviyesini belirler
  void _initializeDifficulty() {
    final firstCategory = _allPlans.keys.firstOrNull ?? 'Güç';
    _selectedDifficulty = _allPlans[firstCategory]?.keys.firstOrNull ?? 'Başlangıç';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Text(
          'Egzersiz Planları',
          style: TextStyle(color: _textColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _backgroundColor,
        bottom: _buildTabBar(),
        iconTheme: IconThemeData(color: _textColor),
      ),
      body: _buildTabBarView(),
    );
  }
  // Sekmeler (kategori başlıkları)
  TabBar _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: _primaryColor,
      labelColor: _primaryColor,
      unselectedLabelColor: Colors.grey[600],
      tabs: const [
        Tab(icon: Icon(Icons.fitness_center), text: "Güç"),
        Tab(icon: Icon(Icons.directions_run), text: "Dayanıklılık"),
        Tab(icon: Icon(Icons.self_improvement), text: "Esneklik"),
      ],
    );
  }

  TabBarView _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: ['Güç', 'Dayanıklılık', 'Esneklik']
          .map((category) => _buildCategoryPage(category))
          .toList(),
    );
  }
  // Kategoriye özel zorluk filtresi ve planlar
  Widget _buildCategoryPage(String category) {
    final categoryData = _allPlans[category] ?? {};
    final difficulties = categoryData.keys.toList();
    final currentPlans = categoryData[_selectedDifficulty] ?? [];

    return Column(
      children: [
        _buildDifficultyFilter(difficulties),
        Expanded(
          child: currentPlans.isEmpty
              ? Center(
            child: Text(
              'Henüz plan eklenmedi 🤷♂️',
              style: TextStyle(color: _primaryColor),
            ),
          )
              : _buildPlanList(currentPlans),
        ),
      ],
    );
  }

  Widget _buildDifficultyFilter(List<String> difficulties) {
    if (difficulties.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: difficulties.map((difficulty) {
          return ChoiceChip(
            label: Text(difficulty),
            selected: _selectedDifficulty == difficulty,
            onSelected: (selected) => setState(() => _selectedDifficulty = difficulty),
            labelStyle: TextStyle(
              color: _selectedDifficulty == difficulty ? _backgroundColor : _textColor,
            ),
            selectedColor: _primaryColor,
            backgroundColor: _cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: _primaryColor.withOpacity(0.3)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPlanList(List<ExercisePlan> plans) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: plans.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final plan = plans[index];
        return _buildPlanCard(plan);
      },
    );
  }

  Widget _buildPlanCard(ExercisePlan plan) {
    return Container(
      decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
      BoxShadow(
      color: _primaryColor.withOpacity(0.1),
      spreadRadius: 1,
      blurRadius: 8,
      offset: const Offset(0, 2),
      )],
    ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _navigateToDetail(plan),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      plan.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: _textColor,
                      ),
                    ),
                  ),
                  _buildDifficultyBadge(plan.difficulty),
                ],
              ),
              const SizedBox(height: 12),
              _buildPlanInfo(plan),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: 0.7,
                backgroundColor: _backgroundColor,
                valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyBadge(String difficulty) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _primaryColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        difficulty,
        style: TextStyle(
          color: _backgroundColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPlanInfo(ExercisePlan plan) {
    return Row(
      children: [
        Icon(Icons.timer_outlined, size: 20, color: _primaryColor),
        const SizedBox(width: 4),
        Text(plan.duration, style: TextStyle(color: _primaryColor)),
        const SizedBox(width: 20),
        Icon(Icons.fitness_center, size: 18, color: _primaryColor),
        const SizedBox(width: 4),
        Text(
            '${plan.exercises.length} Egzersiz',
            style: TextStyle(color: _primaryColor)),
      ],
    );
  }

  void _navigateToDetail(ExercisePlan plan) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ExercisePlanDetailPage(plan: plan),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut)),
              child: child,
            ),
          );
        },
      ),
    );
  }
}