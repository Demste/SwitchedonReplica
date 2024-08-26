import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:switchedon/pages/create_profile_page.dart';
import 'package:switchedon/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Color textColor = Colors.orange;
  bool _obscurePassword = true; // Şifreyi gizlemek için boolean değişkeni

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn() async {
    final email = _usernameController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('E-Posta ve şifre boş olamaz.');
      return;
    }

    try {
      final response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final users = responseData['data'] as List;

        bool userExists = users.any((user) =>
            user['first_name'] == email && user['last_name'] == password);

        if (userExists) {
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(key: HomePage.homePageKey),
            ),
          );
        } else {
          _showErrorDialog('E-Posta veya şifre hatalı.');
        }
      } else {
        _showErrorDialog('Kullanıcı verileri alınırken bir hata oluştu.');
      }
    } catch (e) {
      _showErrorDialog('Bir hata oluştu, lütfen tekrar deneyin.');
      print(e);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hata'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(71, 57, 85, 0.8),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100,),
              Image.asset(
                'lib/images/performanz.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              Text(
                'Başarı, tekrar tekrar denemekten gelir.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                cursorColor: Colors.white, // İmlecinin rengi beyaz
                style: const TextStyle(color: Colors.white), // Metin rengi beyaz
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.white), // Etiket rengi beyaz
                  hintText: 'E-Posta ya da kullanıcı adı',
                  hintStyle: const TextStyle(color: Colors.white70), // İpucu rengi beyaz
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // Köşe yuvarlaklığı
                    borderSide: const BorderSide(color: Colors.white), // Kenarlık rengi
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // Köşe yuvarlaklığı
                    borderSide: const BorderSide(color: Colors.white), // Odaklandığında kenarlık rengi
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // Köşe yuvarlaklığı
                    borderSide: const BorderSide(color: Colors.white), // Odaklanmadığında kenarlık rengi
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword, // Şifreyi gizle veya göster
                cursorColor: Colors.white, // İmlecinin rengi beyaz
                style: const TextStyle(color: Colors.white), // Metin rengi beyaz
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.white), // Etiket rengi beyaz
                  hintText: 'Şifre',
                  hintStyle: const TextStyle(color: Colors.white70), // İpucu rengi beyaz
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // Köşe yuvarlaklığı
                    borderSide: const BorderSide(color: Colors.white), // Kenarlık rengi
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // Köşe yuvarlaklığı
                    borderSide: const BorderSide(color: Colors.white), // Odaklandığında kenarlık rengi
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // Köşe yuvarlaklığı
                    borderSide: const BorderSide(color: Colors.white), // Odaklanmadığında kenarlık rengi
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Şifremi unuttum işlemi
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10), // İç boşluk
                      textStyle: const TextStyle(
                      ),
                    ),
                    child: Text(
                      'Şifremi Unuttum',
                      style: TextStyle(color: textColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                        onPressed: _signIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(57, 170, 94, 0.67), // Butonun arka plan rengi
                          padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 5), // İç boşluk
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Köşe yuvarlaklığı
                          ),
                        ),
                        child: const Text(
                          'Giriş Yap',
                          style: TextStyle(
                            color: Colors.white, // Buton üzerindeki metnin rengi
                          ),
                        ),
                      ),
                ],
              ),
              const SizedBox(height: 20),

              Row(
              children: [
                Expanded(child: Divider(color: textColor)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'ya da şunla devam et',
                    style: TextStyle(color: textColor),
                  ),
                ),
                Expanded(child: Divider(color: textColor)),
              ],
            ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {print("bastım google");},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Arka plan rengini şeffaf yapar
                  shadowColor: Colors.transparent, // Gölgeyi kaldırır
                  //padding: EdgeInsets.all(0), // İç boşlukları sıfırlar
                  shape: const CircleBorder(), // Daire şeklinde yapar
                ),
                child: Image.asset(
                  'lib/images/google.png', // Burada kendi resim yolunuzu kullanın
                  width: 40, // Resmin genişliği
                  height: 40, // Resmin yüksekliği
                  fit: BoxFit.cover, // Resmin butona tam olarak uyacak şekilde kesilmesini sağlar
                ),
              ),

                const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateProfilePage()),
                    );
                },
                child: Text(
                  'Hesap Oluştur',
                  style: TextStyle(color: textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
