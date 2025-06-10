import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/region');
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Адаптивний логотип
            Image.asset(
              'assets/logo1.png',
              width: screenWidth * 0.6, // 60% ширини екрана
              height: screenWidth * 0.6, // Зберігаємо квадратну форму
              fit: BoxFit.contain,
            ),
            SizedBox(height: screenHeight * 0.05), // 5% від висоти екрана

            // Адаптивний індикатор завантаження
            SizedBox(
              width: screenWidth * 0.1,
              height: screenWidth * 0.1,
              child: const CircularProgressIndicator(color: Colors.yellow),
            ),
          ],
        ),
      ),
    );
  }
}
