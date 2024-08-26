import 'package:flutter/material.dart';
import 'package:switchedon/components/connect_page.dart';
import 'training_pages/drills_page.dart';
import 'training_pages/programs_page.dart';
import 'training_pages/sessions_page.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  int _selectedIndex = 0; // Track the selected icon index

  // Pages to display
  final List<Widget> _pages = const [
    DrillsPage(),
    SessionsPage(),
    ProgramsPage(),
  ];

  void _onIconTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // First button with icon and text
              ElevatedButton(
                onPressed: () => _onIconTapped(0),
                style: ElevatedButton.styleFrom(
                
                  backgroundColor: Colors.transparent, // Button background color
                  shadowColor: Colors.transparent, // Remove button shadow
                
                  padding: EdgeInsets.zero, // Remove padding
                  elevation: 0, // Remove elevation
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.play_circle,
                      size: 20, // Adjust the size of the icon
                      color: _selectedIndex == 0 ? Colors.orange : Colors.grey, // Change color based on selection
                    ),
                    const Text(
                      'Drills',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // Second button with icon and text
              ElevatedButton(
                onPressed: () => _onIconTapped(1),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Button background color
                  shadowColor: Colors.transparent, // Remove button shadow
                  padding: EdgeInsets.zero, // Remove padding
                  elevation: 0, // Remove elevation
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.edit_square,
                      size: 20, // Adjust the size of the icon
                      color: _selectedIndex == 1 ? Colors.orange : Colors.grey, // Change color based on selection
                    ),
                    const Text(
                      'Sessions',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // Third button with icon and text
              ElevatedButton(
                onPressed: () => _onIconTapped(2),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Button background color
                  shadowColor: Colors.transparent, // Remove button shadow
                  padding: EdgeInsets.zero, // Remove padding
                  elevation: 0, // Remove elevation
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.stacked_line_chart_rounded,
                      size: 20, // Adjust the size of the icon
                      color: _selectedIndex == 2 ? Colors.orange : Colors.grey, // Change color based on selection
                    ),
                    const Text(
                      'Programs',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          
        ),
        backgroundColor: Colors.white, // Change AppBar color to white
        elevation: 0, // Optional: Remove shadow
      ),


      body: _pages[_selectedIndex], // Display content based on selected index
      floatingActionButton: FloatingActionButton(
        onPressed:(){
           showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const ConnectPage(),
              );
        } ,
        backgroundColor: Colors.orange,
        // Position the button on the right side
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.bluetooth,color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Positions the button at the bottom-right corner
    );
  }
}
