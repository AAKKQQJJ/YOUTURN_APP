import 'package:flutter/material.dart';

class CunsultingScreen extends StatelessWidget {
  const CunsultingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("You Turn_컨설팅"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("컨설팅 탭")],
      ),
    );
  }
}
