import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switchedon/models/user.dart';
import 'package:switchedon/pages/login_page.dart';
import 'package:switchedon/services/drill_service.dart';
import 'package:switchedon/services/favorite_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            final drillService = DrillService();
            drillService.loadDrills(); // Verileri yükle
            return drillService;
          },
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteService()..loadFavorites(),
        ),
        ChangeNotifierProvider(
          create: (context) => User(
            firstName: '',
            lastName: '',
            email: '',
            password: '',
            age: 0,
            ),
        ),
        
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
