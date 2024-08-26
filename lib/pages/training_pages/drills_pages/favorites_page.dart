import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switchedon/components/connect_page.dart';
import 'package:switchedon/components/drill_cart.dart';
import 'package:switchedon/components/info_page.dart';
import 'package:switchedon/globals.dart';
import 'package:switchedon/models/drill.dart';
import 'package:switchedon/pages/home_page.dart';
import 'package:switchedon/services/favorite_service.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late FavoriteService _favoriteService;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load favorites from the FavoriteService
    _favoriteService = Provider.of<FavoriteService>(context);
  }

  void _toggleFavorite(Drill drill) async {
    _favoriteService.toggleFavorite(drill);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final homePageState = HomePage.homePageKey.currentState;
            if (homePageState != null) {
              homePageState.openPageByName("Training");
            } else {
              print("HomePageState is null");
            }          },
        ),
        title: const Text(
          'Favorite Drills',
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
      body: Consumer<FavoriteService>(
        builder: (context, favoriteService, child) {
          final drills = favDrills; // Use global list
          final filteredDrills = drills.where((drill) {
            final lowerCaseQuery = _searchQuery.toLowerCase();
            return(drill.name.toLowerCase().contains(lowerCaseQuery) ||
                drill.type.toLowerCase().contains(lowerCaseQuery) ||
                drill.tags.any((tag) => tag.toLowerCase().contains(lowerCaseQuery)));
          }).toList();

          if (filteredDrills.isEmpty) {
            return const Center(
              child: Text("No favorite drills found"), // No favorites message
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: filteredDrills.length,
            itemBuilder: (context, index) {
              final drill = filteredDrills[index];
              final isFavorite = favoriteService.getFavorites().contains(drill.id);

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
    );
  }
}
