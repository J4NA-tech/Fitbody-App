import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>(); // Form doğrulama anahtarı
  final supabase = Supabase.instance.client; // Supabase bağlantısı

  String _selectedLanguage = 'English'; // Dil seçimi
  bool _darkMode = false; // Tema seçimi

  final TextEditingController _nameController = TextEditingController(); // Ad
  final TextEditingController _emailController = TextEditingController(); // E-posta

  @override
  void initState() {
    super.initState();
    _fetchUserProfile(); // Sayfa açılırken kullanıcı profili getirir
  }

  /// Kullanıcının adını Supabase veritabanından alır
  Future<void> _fetchUserProfile() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      try {
        final response = await supabase
            .from('users')
            .select('full_name')
            .eq('id', user.id)
            .maybeSingle(); // Tek kayıt getir

        if (response != null) {
          setState(() {
            _nameController.text = response['full_name'] ?? '';
            _emailController.text = user.email ?? '';
          });
        } else {
          // Kullanıcı yoksa ilk kez oluştur
          await supabase.from('users').insert({
            'id': user.id,
            'full_name': 'New User',
          });
          _fetchUserProfile(); // Tekrar dene
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  /// Kullanıcının adını günceller
  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final user = supabase.auth.currentUser;
      if (user != null) {
        try {
          await supabase.from('users').update({
            'full_name': _nameController.text,
          }).eq('id', user.id);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating profile: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ayarlar')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileSection(),
            const SizedBox(height: 24),
            _buildPreferencesSection(),
            const SizedBox(height: 24),
            _buildAccountSection(),
          ],
        ),
      ),
    );
  }

  /// Profil resmi + isim düzenleme bölümü
  Widget _buildProfileSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile_placeholder.png'),
                ),
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.edit, color: Colors.white, size: 20),
                  ),
                  onPressed: _changeProfilePicture, // (henüz yapılmadı)
                ),
              ],
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Adınız soyadınız',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Dil ve tema ayarları
  Widget _buildPreferencesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tercihler', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            // Dil seçimi
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Uygulama Dili'),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                  });
                },
                items: ['English', 'Türkçe (Turkish)', 'العربية (Arabic)', 'Español (Spanish)', 'Français (French)']
                    .map((language) => DropdownMenuItem(value: language, child: Text(language)))
                    .toList(),
              ),
            ),
            // Tema seçimi
            SwitchListTile(
              title: const Text('Karanlık Mod'),
              value: _darkMode,
              onChanged: (bool value) {
                setState(() {
                  _darkMode = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Hesap işlemleri: çıkış yap
  Widget _buildAccountSection() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Çıkış Yap'),
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: _confirmLogout,
          ),
        ],
      ),
    );
  }

  /// Profil resmi değiştirme seçenekleri (kamera/galeri)
  void _changeProfilePicture() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profil Resmini Değiştir'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Fotoğraf Çek'),
              onTap: () {
                Navigator.pop(context);

              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeriden Seç'),
              onTap: () {
                Navigator.pop(context);

              },
            ),
          ],
        ),
      ),
    );
  }

  /// Çıkış yapma işlemi
  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkış yap'),
        content: const Text('Çıkış yapmak istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await supabase.auth.signOut();
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              }
            },
            child: const Text('Çıkış yap', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
