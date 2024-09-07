import 'package:flutter/material.dart';
import 'package:water_glass/home_screen.dart';

class WaterGlassApp extends StatelessWidget {
  const WaterGlassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
