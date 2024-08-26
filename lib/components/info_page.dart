import 'package:flutter/material.dart';
import 'package:switchedon/models/drill.dart'; // Drill sınıfını buradan içe aktarın

class InfoPage extends StatelessWidget {
  final Drill drill;

  const InfoPage({required this.drill, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // İçeriğe göre otomatik boyutlandırma
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Close icon
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context); // Close the modal bottom sheet
                },
              ),
            ],
          ),
          const SizedBox(height: 8), // Spacing between close icon and next content
          // Drill name
          Text(
            drill.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.3, // Divider thickness
          ),          ElevatedButton.icon(
            onPressed: () {
              // First button action
            },
            icon: const Icon(Icons.star, color: Colors.white), // Icon for the button
            label: const Text('Save'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange, // Button background color
            ),
          ),
          // Divider
          const Divider(
            color: Colors.black,
            thickness: 0.3, // Divider thickness
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Second button action
            },
            icon: const Icon(Icons.add_circle_rounded, color: Colors.white), // Icon for the button
            label: const Text('Add to Session'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange, // Button background color
            ),
          ),
          // Divider
          const Divider(
            color: Colors.black,
            thickness: 0.3, // Divider thickness
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Third button action
            },
            icon: const Icon(Icons.share_rounded, color: Colors.white), // Icon for the button
            label: const Text('Share'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange, // Button background color
            ),
            
          ),
        ],
      ),
    );
  }
}
