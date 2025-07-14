import 'package:flutter/material.dart';
import 'DatabasePage.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>(); // Form doğrulama için anahtar
  final TextEditingController _nameController = TextEditingController(); // Ad-soyad girişi için kontrolcü

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey, // Formun doğrulama işlemleri burada tanımlanır
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Başlık
              const Text(
                'Yolculuğun Şimdi Başlıyor!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD4A6FF), // Ana tema rengi: lavanta
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),


              const Text(
                'Attığın her adım seni hedeflerine daha da yaklaştırır.'
                    'Kararlı ol ve harika sonuçlar seni takip etsin! 💪',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Ad Soyad giriş alanı
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'adınız soyadınız',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (value) =>
                value!.isEmpty ? 'Lütfen adınızı girin' : null,
              ),

              const SizedBox(height: 20),

              const Spacer(),

              // Kurulumu Tamamla Butonu
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Form geçerli mi kontrol edilir
                    if (_formKey.currentState!.validate()) {
                      String fullName = _nameController.text;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DatabasePage(
                            fullName: fullName,
                            gender: '',
                            age: 0,
                            goal: '',
                            activityLevel: '',
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD4A6FF), // Buton rengi
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Kurulumu Tamamla',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
