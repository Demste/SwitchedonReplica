import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switchedon/models/user.dart';
import 'package:switchedon/pages/aboutme_page.dart';
import 'package:switchedon/pages/login_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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




  void _onUpgradeToProPressed() {
    print("Upgrade to SO PRO pressed");
  }

  void _onSubscriptionPressed() {
    print("Subscription pressed");
  }

  void _onAboutMePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutmePage()),
    );
  }

  void _onTutorialsPressed() {
    print("Tutorials pressed");
  }

  void _onReportAProblemPressed() {
    print("Report a problem pressed");
  }

  void _onScienceBehindTrainingPressed() {
    print("The Science behind our Training pressed");
  }

  void _onCertificationCoursePressed() {
    print("SwitchedOn Certification Course pressed");
  }

  void _onShopEquipmentPressed() {
    print("Shop Equipment pressed");
  }

  void _onContactUsPressed() {
    print("Contact Us pressed");
  }

  void _onInviteFriendsPressed() {
    print("Invite Your Friends pressed");
  }

  void _onRateOurAppPressed() {
    print("Rate Our App pressed");
  }

  void _onRequestMoreTrainingContentPressed() {
    print("Request More Training Content pressed");
  }

  void _onNotificationsPressed() {
    print("Notifications pressed");
  }

  void _onDeleteAccountPressed() {
    print("Delete Account pressed");
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(

      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profil ikonu ve altındaki buton ve metin
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: GestureDetector(
                  onTap: _onAboutMePressed,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: user.profileImage != null
                    ? FileImage(user.profileImage!)
                    : null,
                    child: user.profileImage == null
                    ? const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.black,
                      )
                      : null,
                      )
                ),
              ),
              TextButton(
                onPressed: _onAboutMePressed,
                child: Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                user.email,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Butonlar
          _buildElevatedButton("Upgrade to SO PRO", _onUpgradeToProPressed),
          const Text(
            "My info",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _buildElevatedButton("Subscription", _onSubscriptionPressed),
          _buildElevatedButton("About me", _onAboutMePressed),
          const Text(
            "Resources",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _buildElevatedButton("Tutorials", _onTutorialsPressed),
          _buildElevatedButton("Report a problem", _onReportAProblemPressed),
          _buildElevatedButton(
              "The Science behind our Training", _onScienceBehindTrainingPressed),
          _buildElevatedButton("SwitchedOn Certification Course", _onCertificationCoursePressed),
          _buildElevatedButton("Shop Equipment", _onShopEquipmentPressed),
          const Text(
            "Connect and Share",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _buildElevatedButton("Contact Us", _onContactUsPressed),
          _buildElevatedButton("Invite Your Friends", _onInviteFriendsPressed),
          _buildElevatedButton("Rate Our App", _onRateOurAppPressed),
          _buildElevatedButton("Request More Training Content", _onRequestMoreTrainingContentPressed),
          _buildElevatedButton("Notifications", _onNotificationsPressed),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.camera_alt_outlined),
                onPressed: () {
                  print("Instagram icon pressed");
                },
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow_rounded),
                onPressed: () {
                  print("Play icon pressed");
                },
              ),
              IconButton(
                icon: const Icon(Icons.tiktok),
                onPressed: () {
                  print("TikTok icon pressed");
                },
              ),
              IconButton(
                icon: const Icon(Icons.facebook),
                onPressed: () {
                  print("Facebook icon pressed");
                },
              ),
            ],
          ),
          // Logout ve Delete Account
          Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: _onDeleteAccountPressed,
                child: const Text(
                  "Delete Account",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20.0), // Boşluk ekler
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildElevatedButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.grey),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Kenar köşe yuvarlatma
            ),
          ),
          padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.all(16.0)), // Padding
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16, // Yazı boyutu
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white, // İkon rengi
            ),
          ],
        ),
      ),
    );
  }
}
