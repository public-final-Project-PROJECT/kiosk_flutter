import 'package:flutter/material.dart';
import 'package:kiosk_flutter/screen/main_screen.dart';
import 'package:kiosk_flutter/screen/menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Home(),
    MenuScreen()
  ];

  void _onTapped(int index){
    setState(() {
      _selectedIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("라멘 키오스크"),
        backgroundColor: Colors.brown,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),
            label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.insert_chart),
              label: "메뉴")
        ],

      ),
    );
  }
}
