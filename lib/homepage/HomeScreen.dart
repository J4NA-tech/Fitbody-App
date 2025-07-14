import 'package:fitbodys/homepage/log_page.dart';
import 'package:fitbodys/homepage/plans_page.dart';
import 'package:fitbodys/homepage/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math'; // random motivasyon için eklendi

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    LogPage(),
    PlansPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E1E1E),
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFB3A0FF),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Log'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Plans'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> motivationalQuotes = [
    '"Tek kötü antrenman, asla yapılmayan antrenmandır."',
    '"Bugün kendin için bir şey yap!"',
    '"Küçük adımlar büyük değişimlere yol açar."',
    '"Pes etme, yolun sonuna yaklaştın."',
    '"Süreklilik, başarıyı getirir."',
    '"Hedefine ulaşana kadar devam et."',
  ];

  final String focusText = "Süreklilik, Yoğunluktan Önemlidir";

  final int randomIndex = Random().nextInt(6); // rastgele motivasyon seçimi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 24),
                        _buildRecommendationsSection(context),
                        const SizedBox(height: 24),
                        _buildMotivationalSection(context, motivationalQuotes[randomIndex]),
                        const SizedBox(height: 24),
                        _buildArticleSection(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Merhaba, Şampiyon!',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          "Bugünün hedeflerini aşmaya hazır mısın?",
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildRecommendationsSection(BuildContext context) {
    return Column(
      children: [
        _buildSectionHeader('ÖNERİLER', 'Hepsini Gör›'),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) => _buildRecommendationCard(index),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationCard(int index) {
    final List<String> titles = ['Squat Exercise', 'Full Body Stretching'];
    final List<String> urls = [
      'https://youtu.be/p-R0HSfL6nw?si=-oA5OTCE3vJr3XDL',
      'https://youtu.be/cbKkB3POqaY?si=HZPlfQYmDWnWI2J7'
    ];
    final List<String> images = [
      'https://www.eatthis.com/wp-content/uploads/sites/4/2022/10/fitness-woman-performing-squats.jpg?quality=82&strip=1',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmCP0rd86oLgC5s2lm3hPX7797k9FXxRIpKA&s'
    ];

    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              images[index],
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: IconButton(
              icon: const Icon(Icons.play_circle_fill, color: Color(0xFFE2F163), size: 40),
              onPressed: () async {
                if (await canLaunchUrl(Uri.parse(urls[index]))) {
                  await launchUrl(Uri.parse(urls[index]));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titles[index],
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.timer_outlined, color: Colors.white70, size: 16),
                    SizedBox(width: 4),
                    Text('12 Minutes', style: TextStyle(color: Colors.white70)),
                    SizedBox(width: 12),
                    Icon(Icons.local_fire_department_outlined, color: Colors.white70, size: 16),
                    SizedBox(width: 4),
                    Text('120 Kcal', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMotivationalSection(BuildContext context, String quote) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          colors: [const Color(0xFFB3A0FF).withOpacity(0.9), const Color(0xFF9B89FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'GÜNLÜK MOTİVASYON',
                style: TextStyle(
                  color: Color(0xFFE2F163),
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                onPressed: () {
                  // Sayfayı yeniden oluşturmak için
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => HomeScreen(),
                      transitionDuration: Duration.zero,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            quote,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),
          _buildFocusWidget(),
        ],
      ),
    );
  }

  Widget _buildFocusWidget() {
    return Row(
      children: [
        Container(width: 4, height: 40, color: const Color(0xFFE2F163)),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Bugünün Odak Noktası',
              style: TextStyle( color: Colors.limeAccent, fontSize: 12),
            ),
            Text(
              'Süreklilik, Yoğunluktan Önemlidir',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArticleSection() {
    final List<Map<String, String>> articles = [
      {
        'title': 'Squat Hareketinin Faydaları',
        'subtitle': 'Squat nedir, nasıl yapılır?',
        'url': 'https://blog.supplementler.com/uzman-tavsiyeleri/antrenman/squat-egzersizinin-faydalari/',
        'image': 'https://images.squarespace-cdn.com/content/v1/5ee674043dc49f4def5b1f27/1718637218059-RGPA8TT2JZ1G38LQXD8A/Barbell+squat+pregnant_1.jpg',
      },
      {
        'title': 'Esneme Hareketlerinin Faydaları',
        'subtitle': 'Spor öncesi ve sonrası esneme neden önemlidir?',
        'url': 'https://nblturkiye.com/spor-oncesi-ve-sonrasi-esneme/',
        'image': 'https://nblturkiye.com/wp-content/uploads/Spor-%C3%96ncesi-esneme.jpg',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Sağlık Makaleleri', 'Hepsini Gör›'),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: articles.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) => _buildArticleCard(articles[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildArticleCard(Map<String, String> article) {
    return GestureDetector(
      onTap: () async {
        final url = Uri.parse(article['url']!);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        }
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  article['image']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['title']!,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article['subtitle']!,
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFE2F163),
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 1.1,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(actionText, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ],
    );
  }
}
