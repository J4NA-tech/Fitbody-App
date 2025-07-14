import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitbodys/homepage/HomeScreen.dart';
import 'package:fitbodys/login_pages/reset_password_screen.dart';
import 'package:fitbodys/login_pages/signup.dart';
import 'package:fitbodys/user_informations/OnboardingStartPage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final response = await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final user = response.user;

      if (user != null) {
        final firestore = FirebaseFirestore.instance;
        final userDoc = await firestore.collection('users').doc(user.id).get();

        if (userDoc.exists) {
          final data = userDoc.data();

          if (data != null &&
              data['gender']?.toString().isNotEmpty == true &&
              data['goal']?.toString().isNotEmpty == true &&
              data['activity_level']?.toString().isNotEmpty == true &&
              data['age'] != null) {
            Fluttertoast.showToast(msg: "Giriş başarılı!");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else {
            Fluttertoast.showToast(msg: "Giriş başarılı! Bilgilerinizi tamamlayın.");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OnboardingStartPage()),
            );
          }
        } else {
          Fluttertoast.showToast(msg: "Giriş başarılı! Bilgilerinizi tamamlayın.");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OnboardingStartPage()),
          );
        }
      } else {
        Fluttertoast.showToast(msg: "Giriş başarısız. Lütfen tekrar deneyin.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Hata: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB3A0FF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFFB3A0FF),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Icon(Icons.fitness_center, size: 80, color: Colors.white),
                SizedBox(height: 20),
                Text(
                  'fitbody',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 50),
                TextFormField(
                  controller: _emailController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen email adresinizi girin';
                    }
                    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                      return 'Lütfen geçerli bir email adresi girin';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  style: TextStyle(color: Colors.black),
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Şifre',
                    labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen şifrenizi girin';
                    }
                    if (value.length < 6) {
                      return 'Şifre en az 6 karakter olmalıdır';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                      );
                    },
                    child: Text('Şifremi unuttum?', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Color(0xFFB3A0FF),
                    ),
                    child: Text(
                      'GİRİŞ YAP',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hesap oluşturun ",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                      },
                      child: Text('Kayıt Ol', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
