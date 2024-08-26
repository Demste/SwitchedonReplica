import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switchedon/components/connect_page.dart';
import 'package:switchedon/components/drill_cart.dart';
import 'package:switchedon/components/info_page.dart';
import 'package:switchedon/models/drill.dart';
import 'package:switchedon/services/favorite_service.dart';
import 'package:switchedon/pages/home_page.dart';

class FootballPage extends StatefulWidget {
  const FootballPage({super.key});

  @override
  FootballPageState createState() => FootballPageState();
}

class FootballPageState extends State<FootballPage> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late FavoriteService _favoriteService;
  late Future<Set<int>> _favoritesFuture;

  // Drills listini buraya taşıdık
  final List<Drill> _drills = [
    Drill(
      id: 36,
      sport: "Football",
      type: 'Dribbling',
      level: 'Intermediate',
      name: 'Cone Dribbling',
      tags: ['Dribbling', 'Running', 'Sprint', 'Goal', 'Shoot'],
      banner: "New",
      directions: "Böyle yapcan böyle koşcan",
    ),
    Drill(
      id: 35,
      sport: "Football",
      type: 'Passing',
      level: 'Advanced',
      name: 'Short Passing',
      tags: ['Passing'],
      banner: "Popular",
    ),
    Drill(
      id: 34,
      sport: "Football",
      type: 'Throw In',
      level: 'Advanced',
      name: 'Throw In',
      tags: ['Passing'],
    ),
    Drill(
      id: 33,
      sport: "Football",
      type: 'Passing',
      level: 'Advanced',
      name: 'Long Passing',
      tags: ['Passing'],
    ),
    Drill(
      id: 32,
      sport: "Football",
      type: 'Corner',
      level: 'Advanced',
      name: 'Corner Kicking',
      tags: ['Passing'],
    ),
    Drill(
      id: 31,
      sport: "Football",
      type: 'Freekick',
      level: 'Advanced',
      name: 'Free Kick',
      tags: ['Passing'],
    ),
    Drill(
      id: 30,
      sport: "Football",
      type: 'Finishing',
      level: 'Advanced',
      name: 'Long Shot',
      tags: ['Passing'],
    ),
    // Diğer drill'ler ekleyebilirsiniz
  ];

  @override
  void initState() {
    super.initState();
    _favoritesFuture = _loadFavorites();
  }

  Future<Set<int>> _loadFavorites() async {
    _favoriteService = Provider.of<FavoriteService>(context, listen: false);
    return _favoriteService.getFavorites();
  }

  void _toggleFavorite(Drill drill) async {
    final favorites = await _favoritesFuture;
    final favoriteIds = favorites.toSet();
    if (favoriteIds.contains(drill.id)) {
      favoriteIds.remove(drill.id);
    } else {
      favoriteIds.add(drill.id);
    }
    await _favoriteService.saveFavorites(favoriteIds);
    setState(() {
      _favoritesFuture = Future.value(favoriteIds); // Güncellenmiş favoriler
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final homePageState = HomePage.homePageKey.currentState;
            if (homePageState != null) {
              homePageState.openPageByName("Training");
            } else {
              print("HomePageState is null");
            }
          },
        ),
        title: const Text(
          'Football Drills',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.bluetooth),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const ConnectPage(),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                      onChanged: (query) {
                        setState(() {
                          _searchQuery = query;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_alt_rounded, color: Colors.black),
                    onPressed: () {
                      print("Filter icon pressed");
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: FutureBuilder<Set<int>>(
          future: _favoritesFuture,
          builder: (context, snapshot) {
            final favoriteIds = snapshot.data ?? {};

            final filteredDrills = _drills.where((drill) {
              final lowerCaseQuery = _searchQuery.toLowerCase();
              return drill.sport.toLowerCase() == 'football' &&
                  (drill.name.toLowerCase().contains(lowerCaseQuery) ||
                  drill.type.toLowerCase().contains(lowerCaseQuery) ||
                  drill.tags.any((tag) => tag.toLowerCase().contains(lowerCaseQuery)));
            }).toList();

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: filteredDrills.length,
              itemBuilder: (context, index) {
                final drill = filteredDrills[index];
                final isFavorite = favoriteIds.contains(drill.id);

                return DrillCard(
                  drill: drill,
                  isFavorite: isFavorite,
                  onFavoritePressed: () => _toggleFavorite(drill),
                  onDotPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => InfoPage(drill: drill),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
