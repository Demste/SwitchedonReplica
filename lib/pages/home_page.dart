import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:switchedon/components/custom_bottom_appbar.dart';
import 'package:switchedon/pages/account_page.dart';
import 'package:switchedon/pages/training_pages/drills_pages/basketball_page.dart';
import 'package:switchedon/pages/training_pages/drills_pages/favorites_page.dart';
import 'package:switchedon/pages/training_pages/drills_pages/football_page.dart';
import 'package:switchedon/pages/performance_page.dart';
import 'package:switchedon/pages/teams_page.dart';
import 'package:switchedon/pages/training_page.dart';
import 'package:switchedon/pages/training_pages/drills_pages/volleyball_page.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatefulWidget {

  const HomePage({super.key});
  //HomePage({Key? key}) : super(key: key);
  static final GlobalKey<HomePageState> homePageKey = GlobalKey<HomePageState>();




  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const TrainingPage(),
    const TeamsPage(),
    PerformancePage(),
    const AccountPage(),
    const FootballPage(),
    const BasketballPage(),
    const VolleyballPage(),
    const FavoritesPage(),
    
  ];

  final Map<String, int> _pageIndexMap = {
    "Training": 0,
    "Teams": 1,
    "Performance": 2,
    "Account": 3,
    "Football": 4,
    "Basketball":5,
    "Volleyball":6,
    "Favorites":7,
  };
  void openVideo(String link){
    Uri url = Uri.parse(link);
    launchUrl(url);
  }

  void openPageByName(String pageName) {
    if (_pageIndexMap.containsKey(pageName)) {
      setState(() {
        _selectedIndex = _pageIndexMap[pageName]!;
        
      });
    } else {
      log("Page not found: $pageName");
    }
  }

  void showCreatePage() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Create',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                children: <Widget>[
                  _buildListItem(
                    icon: Icons.play_circle_fill,
                    title: 'Create Drill',
                    description: 'Customize and save drill',
                    onTap: () {
                      log("tıkladım create dril");
                    },
                  ),
                  _buildListItem(
                    icon: Icons.create,
                    title: 'Create Session',
                    description: 'Combine multiple drill to create full training session',
                    onTap: () {
                      log("tıkladım create ses");
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 50,
              color: Colors.black,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: _selectedIndex,
        onPageSelected: openPageByName,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 62,
        width: 62,
        child: FloatingActionButton(
          onPressed: showCreatePage,
          backgroundColor: Colors.orange,
          elevation: 8.0,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 39,
          ),
        ),
      ),
    );
  }
}
