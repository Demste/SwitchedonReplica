import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switchedon/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String? _selectedGender;
  String? _selectedFavoriteSport;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _favoriteSports = ['Football', 'Basketball', 'Tennis', 'Volleyball', 'Running'];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _postUserToApi(User user) async {
    const url = 'https://run.mocky.io/v3/6c8885a2-6cdc-4cbc-b1c8-41f4c1b7aac1'; // Mocky URL'nizi buraya ekleyin.

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'firstname': user.firstName,
        'lastname': user.lastName,
        'email': user.email,
        'password': user.password,
        'userId': user.age,
        'gender': user.gender,
        'height': user.height,
        'weight': user.weight,
        'favoriteSport': user.favoriteSport,
      }),
    );

    if (response.statusCode == 200) {
      print('Data posted successfully!');
    } else {
      print('Failed to post data.');
    }
  }


  void _createUser() async {
    if (_firstNameController.text.isEmpty || 
        _lastNameController.text.isEmpty || 
        _emailController.text.isEmpty || 
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showErrorDialog('Please fill in all the required fields.');
      return;
    }

    if (!_isValidEmail(_emailController.text)) {
      _showErrorDialog('Please enter a valid email address.');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog('Passwords do not match.');
      return;
    }

    final age = int.tryParse(_ageController.text) ?? 0; // Null ise varsayılan değer 0

    final user = Provider.of<User>(context, listen: false);
    user.updateUser(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      age: age,
      gender: _selectedGender,
      height: double.tryParse(_heightController.text),
      weight: double.tryParse(_weightController.text),
      favoriteSport: _selectedFavoriteSport,
    );

    // API'ye kullanıcıyı gönder
    await _postUserToApi(user);

    Navigator.pop(context); // Kullanıcı oluşturulduktan sonra önceki sayfaya dön
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@(gmail|yahoo|outlook)\.com$'
    );
    return emailRegex.hasMatch(email);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Okay'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(71, 57, 85, 0.8),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField(_firstNameController, 'First Name', required: true),
            _buildTextField(_lastNameController, 'Last Name', required: true),
            _buildTextField(_emailController, 'Email', required: true),
            _buildTextField(_passwordController, 'Password', isPassword: true, required: true),
            _buildTextField(_confirmPasswordController, 'Confirm Password', isPassword: true, required: true),
            _buildTextField(_ageController, 'Age', isNumber: true),
            _buildDropdownButton('Gender', _genders, _selectedGender, (String? newValue) {
              setState(() {
                _selectedGender = newValue;
              });
            }),
            _buildTextField(_heightController, 'Height (m)', isNumber: true),
            _buildTextField(_weightController, 'Weight (kg)', isNumber: true),
            _buildDropdownButton('Favorite Sport', _favoriteSports, _selectedFavoriteSport, (String? newValue) {
              setState(() {
                _selectedFavoriteSport = newValue;
              });
            }),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _createUser,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, 
                backgroundColor: const Color.fromRGBO(57, 170, 94, 0.67), // Arka plan rengi
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // İç boşluk
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Köşe yuvarlama
                ),
              ),
              child: const Text('Create Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {bool isNumber = false, bool isPassword = false, bool required = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        cursorColor: Colors.white,
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white), // Metin rengi
        decoration: InputDecoration(
          labelText: required ? '$labelText *' : labelText,
          labelStyle: const TextStyle(color: Colors.white), // Label metin rengi
          hintStyle: const TextStyle(color: Colors.white54), // İpucu metin rengi
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Kenar rengi
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Odaklanmış kenar rengi
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownButton(String labelText, List<String> items, String? selectedItem, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white), // Label metin rengi
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Kenar rengi
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Odaklanmış kenar rengi
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedItem,
            isDense: true,
            dropdownColor: const Color.fromRGBO(71, 57, 85,1), // Dropdown arka plan rengi
            style: const TextStyle(color: Colors.white), // Dropdown metin rengi
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
