import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordScreen extends StatelessWidget {
  final _emailController = TextEditingController();  // Email kontrolörü
  final _formKey = GlobalKey<FormState>();  // Form için anahtar

  // Şifre sıfırlama fonksiyonu
  Future<void> _resetPassword(BuildContext context) async {
    final supabase = Supabase.instance.client;  // Supabase istemcisi
    final email = _emailController.text.trim();  // Girilen email

    // Eğer email boşsa hata mesajı göster
    if (email.isEmpty) {
      Fluttertoast.showToast(msg: "Lütfen email adresinizi girin");
      return;
    }

    try {
      // Supabase üzerinden şifre sıfırlama işlemi
      await supabase.auth.resetPasswordForEmail(email);
      Fluttertoast.showToast(msg: "$email adresine şifre sıfırlama bağlantısı gönderildi");
      Navigator.pop(context);  // Önceki ekrana geri dön
    } catch (e) {
      // Hata durumunda mesaj göster
      Fluttertoast.showToast(msg: "Hata: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Şifreyi Sıfırla'),  // Başlık
        backgroundColor: Color(0xFFB3A0FF),  // Başlık rengi
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Şifre sıfırlama talimatlarını almak için email adresinizi girin',
                style: TextStyle(fontSize: 16, color: Color(0xFFB3A0FF)),  // Açıklama metni
              ),
              SizedBox(height: 30),
              TextFormField(

                controller: _emailController,  // Email
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Color(0xFFB3A0FF)),  // Email ikon rengi
                  labelText: 'Email', // Email etiketi
                  hintText: 'örnek@example.com',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black),  // Etiket rengi
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen email adresinizi girin';  // Email kontrolü
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Lütfen geçerli bir email adresi girin';  // Geçerli email kontrolü
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _resetPassword(context);  // Şifre sıfırlama işlemi
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Color(0xFFB3A0FF),
                  ),
                  child: Text('Talimatları Gönder',
                      style: TextStyle(fontSize: 16, color: Colors.white)),  // Buton metni
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
