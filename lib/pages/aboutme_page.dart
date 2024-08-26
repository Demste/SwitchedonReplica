import 'dart:io'; // Dart package for File

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switchedon/models/user.dart';
import 'package:image_picker/image_picker.dart';

class AboutmePage extends StatefulWidget {
  const AboutmePage({super.key});

  @override
  State<AboutmePage> createState() => _AboutmePageState();
}

class _AboutmePageState extends State<AboutmePage> {
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = Provider.of<User>(context, listen: false);
    await user.loadFromSharedPreferences(); // Burada metod çağrısı yapılır
    setState(() {}); // Verileri yükledikten sonra sayfayı yeniden oluştur
  }

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();

  File? _profileImage;

  String? _selectedGender;
  String? _selectedFavoriteSport;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _favoriteSports = ['Football', 'Basketball', 'Tennis', 'Volleyball', 'Running'];

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _age.dispose();
    _height.dispose();
    _weight.dispose();
    super.dispose();
  }

  void _saveUser() async {

    if (_email.text.isNotEmpty && !_isValidEmail(_email.text)) {
      _showErrorDialog('Please enter a valid email address.');
      return;
    }

    if (_password.text != _confirmPassword.text) {
      _showErrorDialog('Passwords do not match.');
      return;
    }

    final age = int.tryParse(_age.text); // Null ise varsayılan değer 0

    final user = Provider.of<User>(context, listen: false);
    user.updateUser(
      firstName: _firstName.text.isNotEmpty ? _firstName.text : user.firstName,
      lastName: _lastName.text.isNotEmpty ? _lastName.text : user.lastName,
      email: _email.text.isNotEmpty ? _email.text : user.email,
      password: _password.text,
      age: age??user.age,
      gender: _selectedGender??user.gender,
      height: double.tryParse(_height.text)??user.height,
      weight: double.tryParse(_weight.text)??user.weight,
      favoriteSport: _selectedFavoriteSport??user.favoriteSport,
      profileImage: _profileImage??user.profileImage,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Veriler başarıyla kaydedildi.'),
      ),
    );
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

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(71, 57, 85, 0.8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "About Me",
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          
          ),
          centerTitle: true,
      ),
      body: ListView(
        
        padding: const EdgeInsets.all(16.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!) // _profileImage varsa bunu kullan
                    : user.profileImage != null
                    ? FileImage(user.profileImage!) // _profileImage yoksa ama user.profileImage varsa bunu kullan
                    : null, // Her iki resim de yoksa backgroundImage null olur
                    child: _profileImage == null && user.profileImage == null
                    ? const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.black,
                      ) // Her iki resim de yoksa varsayılan ikon
                      : null,
                  )

                ),
              ),
              Text(
                '${user.firstName} ${user.lastName}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  controller: _firstName,
                  labelText: user.firstName,
                  hintText: 'First Name',
                ),
                _buildTextField(
                  controller: _lastName,
                  labelText: user.lastName,
                  hintText: "Last Name",
                ),
                _buildTextField(
                  controller: _email,
                  labelText: user.email,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),

                _buildTextField(
                  controller: _age,
                  labelText: user.age.toString(),
                  hintText: "Age",
                  keyboardType: TextInputType.number,
                ),
                _buildTextField(
                  controller: _height,
                  labelText: user.height?.toString()??"Height",
                  hintText: "Height",
                  keyboardType: TextInputType.number,
                ),
                _buildTextField(
                  controller: _weight,
                  labelText: user.weight?.toString() ?? 'Weight',
                  hintText:"Weight",
                  keyboardType: TextInputType.number,
                ),
                _buildDropdownButton("Favorite Sport", _favoriteSports, _selectedFavoriteSport??user.favoriteSport, (String? newValue) {
                  setState(() {
                    _selectedFavoriteSport = newValue;
                  });
                }),
                _buildDropdownButton("Gender", _genders, _selectedGender??user.gender, (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                }),
                const Divider(
                  color: Colors.orange, // Divider'ın rengi
                  thickness: 5.0, // Divider'ın kalınlığı
                ),
                _buildTextField(
                  controller: _password,
                  labelText: 'Password',
                  hintText: '',
                  obscureText: true,
                ),
                _buildTextField(
                  controller: _confirmPassword,
                  labelText: 'Confirm Password',
                  hintText: '',
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(244, 67, 54, 0.8),
                      ),
                      child: const Text(
                        "Reset",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _saveUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:const Color.fromRGBO(57, 170, 94, 0.8),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(color:Colors.white),
                        ),
                    ),
                    const SizedBox(width: 8.0),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.camera_alt_outlined,color: Colors.white,),
                onPressed: () {
                  print("Instagram icon pressed");
                },
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow_rounded,color: Colors.white,),
                onPressed: () {
                  print("Play icon pressed");
                },
              ),
              IconButton(
                icon: const Icon(Icons.tiktok,color: Colors.white,),
                onPressed: () {
                  print("TikTok icon pressed");
                },
              ),
              IconButton(
                icon: const Icon(Icons.facebook,color: Colors.white,),
                onPressed: () {
                  print("Facebook icon pressed");
                },
              ),
            ],
          ),

        ],
      ),
    );
  }

Widget _buildTextField({
  required TextEditingController controller,
  required String labelText,
  String hintText = '',
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.white), // Label metin rengi
        hintStyle: const TextStyle(color: Colors.white), // Hint metin rengi
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Enabled durumunda kenarlık rengi
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Focused durumunda kenarlık rengi
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Default kenarlık rengi
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white), // Metin rengi
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
            dropdownColor: const Color.fromRGBO(71, 57, 85, 1), // Dropdown arka plan rengi
            style: const TextStyle(color: Colors.white), // Dropdown metin rengi
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.white, // Aşağı ok rengini beyaz yapar
            ),
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
