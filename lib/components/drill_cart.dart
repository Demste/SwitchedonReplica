import 'package:flutter/material.dart';
import 'package:switchedon/components/drills_details_page.dart';
import 'package:switchedon/models/drill.dart'; // Drill sınıfı buradan içe aktarılıyor

class DrillCard extends StatelessWidget {
  final Drill drill;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final VoidCallback? onDotPressed;
  
  const DrillCard({super.key, 
    required this.drill,
    required this.isFavorite,
    required this.onFavoritePressed,
    this.onDotPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: onFavoritePressed,
      onTap: () {
        // Kart tıklama işlevinde geçiş yap
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DrillsDetailsPage(drill: drill,),
          ),
        );
      },
      onLongPress: onDotPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300], // Card'ın arka plan rengi
          borderRadius: BorderRadius.circular(8.0), // Köşe yuvarlatma
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Tüm öğeleri yukarı hizala
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Fotoğraf ve Banner
            Column(
              mainAxisSize: MainAxisSize.max, // Column boyutunu minimumda tut
              crossAxisAlignment: CrossAxisAlignment.start, // Sol tarafta hizala
              children: [
                if (drill.banner != null) // Eğer banner null değilse
                  Container(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0), // Üstten biraz, soldan biraz, alttan az boşluk
                    decoration: const BoxDecoration(
                      color: Colors.orange, // Arka plan rengi
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0), // Sol üst köşe yuvarlatma
                        bottomLeft: Radius.circular(12.0), // Sol alt köşe yuvarlatma
                        bottomRight: Radius.circular(12.0), // Sağ alt köşe yuvarlatma
                        topRight: Radius.circular(0), // Sağ üst köşe yuvarlatma
                      ),
                    ),
                    child: Text(
                      drill.banner!, // Banner null değilse text'i göster
                      style: const TextStyle(
                        fontSize: 14, // Font boyutunu küçült
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Metin rengi
                      ),
                    ),
                  ),
                if (drill.banner != null) // Eğer banner null değilse
                  const SizedBox(height: 4), // Text ve Icon arasında az boşluk
                const Icon(
                  Icons.image,
                  size: 40, // İkon boyutunu küçült
                  color: Colors.black, // Icon rengi
                ),
              ],
            ),
            // İkinci sütun: Başlık ve Tag'ler
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Başlık
                    Text(
                      drill.name,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    // Tag'ler
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0, // Tag'ler arası yatay boşluk
                      runSpacing: 4.0, // Tag'ler arası dikey boşluk
                      children: drill.tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[600]!), // Çerçeve rengi
                            borderRadius: BorderRadius.circular(8.0), // Köşe yuvarlatma
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            // Üçüncü sütun: İkonlar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: isFavorite ? Colors.yellow : Colors.grey,
                    ),
                    onPressed: onFavoritePressed,
                  ),
                  const SizedBox(height: 8),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: onDotPressed,

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
