import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  String firstName;
  String lastName;
  String email;
  String password;
  int age;
  String? gender;
  double? height;
  double? weight;
  String? favoriteSport;
  File? profileImage;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.age,
    this.gender,
    this.height,
    this.weight,
    this.favoriteSport,
    this.profileImage,
  });

  Future<void> _saveToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastName);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setInt('age', age);
    await prefs.setString('gender', gender ?? '');
    await prefs.setDouble('height', height ?? 0.0);
    await prefs.setDouble('weight', weight ?? 0.0);
    await prefs.setString('favoriteSport', favoriteSport ?? '');
    if (profileImage != null) {
      await prefs.setString('profileImage', profileImage!.path);
    }
  }

  Future<void> loadFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    firstName = prefs.getString('firstName') ?? '';
    lastName = prefs.getString('lastName') ?? '';
    email = prefs.getString('email') ?? '';
    password = prefs.getString('password') ?? '';
    age = prefs.getInt('age') ?? 0;
    gender = prefs.getString('gender');
    height = prefs.getDouble('height');
    weight = prefs.getDouble('weight');
    favoriteSport = prefs.getString('favoriteSport');
    final profileImagePath = prefs.getString('profileImage');
    if (profileImagePath != null) {
      profileImage = File(profileImagePath);
    }
  }

  void updateUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required int age,
    String? gender,
    double? height,
    double? weight,
    String? favoriteSport,
    File? profileImage,
  }) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.password = password;
    this.age = age;
    this.gender = gender;
    this.height = height;
    this.weight = weight;
    this.favoriteSport = favoriteSport;
    this.profileImage = profileImage;
    _saveToSharedPreferences();
    notifyListeners();
  }

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, email: $email)';
  }
}
