import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<String> onPageSelected;

  const CustomBottomAppBar({
    super.key,
    required this.selectedIndex,
    required this.onPageSelected,
  });

  @override
  CustomBottomAppBarState createState() => CustomBottomAppBarState();
}

class CustomBottomAppBarState extends State<CustomBottomAppBar> {
  // En son basılan butonun indexini saklayacağız
  int _lastSelectedIndex = -1;

  @override
  void initState() {
    super.initState();
    // İlk başta `_lastSelectedIndex`'i widget'ın `selectedIndex`'i ile güncelleyelim
    _lastSelectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.run_circle_outlined,
                    color: _lastSelectedIndex == 0 ? Colors.orange : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _lastSelectedIndex = 0;  // En son basılan butonun indexini güncelle
                    });
                    widget.onPageSelected("Training");
                  },
                ),
                const Text(
                  'Training',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.groups,
                    color: _lastSelectedIndex == 1 ? Colors.orange : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _lastSelectedIndex = 1;  // En son basılan butonun indexini güncelle
                    });
                    widget.onPageSelected("Teams");
                  },
                ),
                const Text(
                  'Teams',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.bar_chart,
                    color: _lastSelectedIndex == 2 ? Colors.orange : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _lastSelectedIndex = 2;  // En son basılan butonun indexini güncelle
                    });
                    widget.onPageSelected("Performance");
                  },
                ),
                const Text(
                  'Performance',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: _lastSelectedIndex == 3 ? Colors.orange : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _lastSelectedIndex = 3;  // En son basılan butonun indexini güncelle
                    });
                    widget.onPageSelected("Account");
                  },
                ),
                const Text(
                  'Account',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
