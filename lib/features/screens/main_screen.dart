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
        type: BottomNavigationBarType.fixed, // 애니메이션 및 크기 변화 제거
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF0DC577),
        unselectedItemColor: Color(0xFF9DC8B6),
        unselectedIconTheme: IconThemeData(color: Color(0xFF9DC8B6), size: 24),
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        selectedIconTheme: IconThemeData(color: Color(0xFF0DC577), size: 24),
        onTap: _onItemTapped,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          const BottomNavigationBarItem(icon: Icon(Icons.sticky_note_2), label: '컨설팅'),
          BottomNavigationBarItem(
            icon: Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? const Color(0xFF0DC577) : const Color(0xFF9DC8B6),
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  'asset/img/robot.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            label: '챗봇',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
        ],
      ),
    );
  }
}
