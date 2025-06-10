import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/region_select_page.dart';

void main() { 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SvitloYe',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/region': (context) => const RegionSelectPage(),
      },
    );
  }
}
