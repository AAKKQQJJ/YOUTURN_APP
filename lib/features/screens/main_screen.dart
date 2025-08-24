import 'package:flutter/material.dart';
import 'package:youturn/features/chatbot/screen/chatbot_starting_screen.dart';

import '../consulting/screen/consulting_screen.dart';
import 'home_screen.dart';
import 'myprofile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _Tap = [
    /// 홈 탭
    HomeScreen(),

    /// 컨설팅 탭
    ConsultingScreen(),

    /// 쳇봇 탭
    ChatbotStartingScreen(),

    /// 내 정보 탭
    MyprofileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _Tap,
      ),
      bottomNavigationBar: BottomNavigationBar(
        /// 바텀 탭바 스타일 ///
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        selectedIconTheme: IconThemeData(color: Colors.blueAccent),
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.person_add_alt_1_sharp), label: '컨설팅'),
          BottomNavigationBarItem(icon: Icon(Icons.bedtime_sharp), label: '챗봇'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
        ],
      ),
    );
  }
}
