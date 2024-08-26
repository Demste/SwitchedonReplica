import 'package:flutter/material.dart';
import 'package:switchedon/pages/guest_page.dart';
import 'package:switchedon/pages/host_page.dart';
import 'package:url_launcher/url_launcher.dart';


class ConnectPage extends StatelessWidget {
    void openVideo(String link){
    Uri url = Uri.parse(link);
    launchUrl(url);
  }

  const ConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Expanded(
                child: Text(
                  'Connect',
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
                  Icons.question_mark_rounded,
                  color: Colors.black,
                ),
                onPressed: () {
                  print("Help Sayfasi");
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: DefaultTabController(
              length: 2, // Sekme sayısı
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false, // Geri ok tuşunu kaldır
                  title: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent), // Arka plan rengini şeffaf yap
                      elevation: WidgetStateProperty.all<double>(0), // Gölgeyi kaldır
                    ),
                    onPressed: () => openVideo("https://www.youtube.com/watch?v=dQw4w9WgXcQ"),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Başlığı ortala
                      children: [
                        Icon(
                          Icons.play_circle_fill_rounded, // İkonu ekle
                          color: Colors.orange,
                          size: 24.0,
                        ),
                        SizedBox(width: 8), // İkon ve yazı arasında boşluk
                        Text(
                          'How to Connect Devices',
                          style: TextStyle(
                            fontSize: 15, // Yazı boyutu
                            color: Colors.orange, // Yazı rengi
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottom: TabBar(
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), // İndikatörün köşe yuvarlatması
                      color: Colors.black, // İndikatörün rengi
                    ),
                    labelColor: Colors.white, // Seçili tab yazı rengi
                    unselectedLabelColor: Colors.black, // Seçili olmayan tab yazı rengi
                    labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Seçili tab yazı stili
                    tabs: const [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person, color: Colors.orange), // Host sekmesi ikonu
                            SizedBox(width: 8),
                            Text('Host'),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.group, color: Colors.orange), // Guest sekmesi ikonu
                            SizedBox(width: 8),
                            Text('Guest'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                body: const TabBarView(
                  children: [
                    HostPage(), // "Host" sekmesinin içeriği
                    GuestPage(), // "Guest" sekmesinin içeriği
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
