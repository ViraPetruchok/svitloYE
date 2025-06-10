import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svitlo_ye/screens/info_page.dart';
import 'package:svitlo_ye/screens/map_page.dart';
import 'package:svitlo_ye/screens/news_page.dart';
import 'package:svitlo_ye/screens/power_outage_page.dart';  // Імпортуємо NewsPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const PowerOutagePage(),
    const MapPage(),
    const NewsPage(),
    const InfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'Відключення',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Карта',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Новини',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Інформація',
          ),  
        ],
      ),
    );
  }
}
