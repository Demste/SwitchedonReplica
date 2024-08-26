import 'package:flutter/material.dart';
import 'package:switchedon/pages/home_page.dart';

class DrillsPage extends StatefulWidget {
  const DrillsPage({super.key});

  @override
  State<DrillsPage> createState() => _DrillsPageState();
}

class _DrillsPageState extends State<DrillsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _getItemFav(),
          _getItem("Football", "lib/images/football.jpeg"),
          _getItem("Basketball", "lib/images/basketball.jpeg"),
          _getItem("Volleyball", null), // Resim yolu boş
          _getItem("Tennis", null), // Resim yolu boş
        ],
      ),
    );
  }  
  Widget _getItemFav() {
    return ElevatedButton(
      onPressed: () {
        final homePageState = HomePage.homePageKey.currentState;
        if (homePageState != null) {
          homePageState.openPageByName("Favorites");
        } else {
          print("HomePageState is null");
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black, // Buton arka plan rengi siyah
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Kenar yuvarlatma
        ),
        padding: EdgeInsets.zero, // İçerik etrafındaki boşlukları kaldır
        shadowColor: Colors.transparent, // Gölgeyi kaldır
      ).copyWith(
        // Üzerindeki renk efektlerini kaldırmak için
        overlayColor: WidgetStateProperty.all(Colors.transparent), // Tıklama efekti
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),

        height: 50, // Yükseklik
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Sol kısımda yıldız ikonu ve metin
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.orange, // Yıldız rengi
                ),
                SizedBox(width: 8), // Yıldız ve metin arasındaki boşluk
                Text(
                  "Favorites", // Texti name parametresine göre göster
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white, // Yazı rengi
                  ),
                ),
              ],
            ),
            // Sağ kısımda ikon
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white, // Sağ ok rengi
            ),
          ],
        ),
      ),
    );
  }


  Widget _getItem(String name, String? imagePath) {
    return GestureDetector(
      onTap: () {
        final homePageState = HomePage.homePageKey.currentState;
        if (homePageState != null) {
          homePageState.openPageByName(name);
        } else {
          print("HomePageState is null");
        }
      },
      child: Container(
        height: 200, // Yüksekliği arttırdık, böylece resim sığabilir
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10), // Kenar yuvarlatma
          image: imagePath != null
              ? DecorationImage(
                  image: AssetImage(imagePath), // Görselin yolu
                  fit: BoxFit.fill, // Görselin kutuya sığdırılması
                )
              : null,
        ),
        child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white, // Yazı rengi siyah
                      ),
                    ),
                  ),
                ],
              )
           
      ),
    );
  }
}
