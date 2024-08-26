import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switchedon/components/connect_page.dart';
import 'package:switchedon/models/drill.dart';
import 'package:switchedon/services/favorite_service.dart';
import  'package:url_launcher/url_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DrillsDetailsPage extends StatefulWidget {
  final Drill drill;
  const DrillsDetailsPage({required this.drill, super.key});

  @override
  State<DrillsDetailsPage> createState() => _DrillsDetailsPageState();
}

class _DrillsDetailsPageState extends State<DrillsDetailsPage> {
  final PageController _pageController = PageController();
  late FavoriteService _favoriteService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Bu noktada context üzerinden Provider'ı alabiliriz
    _favoriteService = Provider.of<FavoriteService>(context);
  }

  void openVideo(String link) async {
    Uri url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {

    }
  }

  void _toggleFavorite(Drill drill) async {
    _favoriteService.toggleFavorite(drill);
    setState(() {}); // Rebuild to reflect changes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Geri git
          },
        ),
        title: Text(
          widget.drill.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
        FutureBuilder<bool>(
          future: _favoriteService.isFavorite(widget.drill),
          builder: (context, snapshot) {
            final isFavorite = snapshot.data ?? false;
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite ? Colors.yellow : Colors.grey,
              ),
              onPressed: () => _toggleFavorite(widget.drill),
            );
          },
        )
        ],
      ),
      body:  ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: 1, // Sadece bir item olduğunu belirtiyoruz
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150, // Video veya resimlerin bulunduğu alanın yüksekliği
                child: PageView(
                  controller: _pageController,
                  children: [
                    Container(
                      color: Colors.blue,
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            openVideo('https://www.youtube.com/watch?v=iLnmTe5Q2Qw');
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.transparent),
                            foregroundColor: WidgetStateProperty.all(Colors.white),
                            overlayColor: WidgetStateProperty.all(Colors.transparent), // Renk değişimini engelle
                            shadowColor: WidgetStateProperty.all(Colors.transparent),
                            elevation: WidgetStateProperty.all(0),
                          ),
                          child: const Text(
                            'Video',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.red,
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 2,
                  effect: const WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.grey),
                      onPressed: () {
                        // Paylaşma işlemi
                        print("Share func");
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.sticky_note_2_rounded, color: Colors.grey),
                      onPressed: () {
                        // Not ekleme işlemi
                        print("Create Session Func");
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.bluetooth, color: Colors.grey),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => ConnectPage(),
                        );
                      }
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.timelapse_rounded, color: Colors.grey),
                        SizedBox(width: 4), // İkon ile metin arasında minimum boşluk
                        Text(
                          //widget.drill.duration olcak
                          "1min",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.filter_vintage_outlined, color: Colors.grey),
                        const SizedBox(width: 4), // İkon ile metin arasında minimum boşluk
                        Text(
                          widget.drill.level,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(Icons.group, color: Colors.grey),
                        SizedBox(width: 4), // İkon ile metin arasında minimum boşluk
                        Text(
                          '1 person',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Directions", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 4), // Başlık ve açıklama arasında boşluk
                          Text(
                            widget.drill.directions?.isNotEmpty ?? false 
                                ? widget.drill.directions! 
                                : 'No directions',
                            style: const TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Main Benefits", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 4), // Başlık ve açıklama arasında boşluk
                          Text(widget.drill.tags.join(', '), style: const TextStyle(color: Colors.grey, fontSize: 16)),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Equipment Used', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 4), // Başlık ve açıklama arasında boşluk
                          Text('Futbol Topu', style: TextStyle(color: Colors.grey, fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: SizedBox(
        //width: MediaQuery.of(context).size.width - 32, // Ekranın genişliği - padding (örneğin 16 + 16)
        width: 450,
        height: 40, // Butonun yüksekliği
        child: FloatingActionButton.extended(
          onPressed: () {
            // Sabit butona tıklama işlemi
            print("Training Page olcak");
          },
          label: const Text(
            'Begin Training',
            style: TextStyle(color: Colors.white), // Metin rengi beyaz
          ),
          backgroundColor: Colors.orange, // Butonun arka plan rengi
          elevation: 0, // Gölgesiz
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Butonu ekranın alt ortasına yerleştirir
    );
  }
}
